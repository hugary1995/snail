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
  [disp_x]
  []
  [disp_y]
  []
  [d]
  []
[]

[AuxVariables]
  [bound]
  []
  [r_x]
  []
  [r_y]
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
  [momentum_balance_x]
    type = Tutorial02Kernel
    variable = disp_x
    component = 0
    stress = pk1_stress
    save_in = 'r_x'
  []
  [momentum_balance_y]
    type = Tutorial02Kernel
    variable = disp_y
    component = 1
    stress = pk1_stress
    save_in = 'r_y'
  []
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
    prop_names = 'Gc psic'
    prop_values = '2000 10000'
  []
  [degradation]
    type = ADDerivativeParsedMaterial
    property_name = g
    coupled_variables = 'd'
    expression = '(1-d)^2/((1-d)^2+(3/8*Gc/psic/ell)*d*(1+d))*(1-eta)+eta'
    constant_names = 'ell eta'
    constant_expressions = '0.1 1e-6'
    material_property_names = 'Gc psic'
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
    output_properties = 'p Theta w'
    outputs = 'exodus'
  []
[]

[BCs]
  [fix_x]
    type = DirichletBC
    variable = disp_x
    value = 0
    boundary = 'top bottom'
  []
  [bottom_fix]
    type = DirichletBC
    variable = disp_y
    value = 0
    boundary = 'bottom'
  []
  [top_pull]
    type = FunctionDirichletBC
    variable = disp_y
    function = 't'
    boundary = 'top'
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
  nl_max_its = 200
[]

[Postprocessors]
  [force]
    type = NodalSum
    variable = r_y
    boundary = top
  []
  [displacement]
    type = SideAverageValue
    variable = disp_y
    boundary = top
  []
[]

[Outputs]
  exodus = true
  csv = true
  print_linear_residuals = false
[]
