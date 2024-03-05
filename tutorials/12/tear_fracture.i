[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Mesh]
  [paper]
    type = FileMeshGenerator
    file = '../gold/paper.msh'
  []
[]

[Variables]
  [d]
  []
[]

[AuxVariables]
  [disp_x]
  []
  [disp_y]
  []
  [bound]
  []
[]

[Bounds]
  [d_lower_bound]
    type = VariableOldValueBounds
    variable = bound
    bounded_variable = d
    bound_type = lower
  []
[]

[Kernels]
  [viscosity]
    type = CoefTimeDerivative
    variable = d
    Coefficient = 1e2
  []
  [fracture]
    type = Tutorial11Kernel
    variable = d
    reg_length = 0.1
  []
[]

[Materials]
  [props]
    type = ADGenericConstantMaterial
    prop_names = 'Gc wc'
    prop_values = '2000 10000'
  []
  [degradation]
    type = ADDerivativeParsedMaterial
    property_name = g
    coupled_variables = 'd'
    expression = '(1-d)^2/((1-d)^2+(3/8*Gc/wc/ell)*d*(1+d))*(1-eta)+eta'
    constant_names = 'ell eta'
    constant_expressions = '0.1 1e-6'
    material_property_names = 'Gc wc'
    derivative_order = 1
  []
  [strain]
    type = ADComputeDeformationGradient
  []
  [stress]
    type = Tutorial11Stress
    bulk_modulus = 4000
    shear_modulus_1 = 3000
    shear_modulus_2 = 3000
    beta = 2
    damage = d
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  petsc_options_iname = '-pc_type -snes_type'
  petsc_options_value = 'lu vinewtonrsls'
  automatic_scaling = true
  end_time = 0.45
  dt = 1e-3
  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-10
[]

[Outputs]
  print_linear_residuals = false
[]
