[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[MultiApps]
  [fracture]
    type = TransientMultiApp
    input_files = 'tear_fracture.i'
  []
[]

[Transfers]
  [to_fracture]
    type = MultiAppCopyTransfer
    to_multi_app = fracture
    source_variable = 'disp_x disp_y'
    variable = 'disp_x disp_y'
  []
  [from_fracture]
    type = MultiAppCopyTransfer
    from_multi_app = fracture
    source_variable = 'd'
    variable = 'd'
  []
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
[]

[AuxVariables]
  [r_x]
  []
  [r_y]
  []
  [d]
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
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  automatic_scaling = true
  end_time = 0.45
  dt = 1e-3
  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-10

  reuse_preconditioner = true
  reuse_preconditioner_max_linear_its = 25

  fixed_point_algorithm = picard
  fixed_point_max_its = 100
  fixed_point_abs_tol = 1e-8
  fixed_point_rel_tol = 1e-6
  accept_on_max_fixed_point_iteration = true
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
