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
[]

[Kernels]
  [momentum_balance_x]
    type = Tutorial02Kernel
    variable = disp_x
    component = 0
    stress = pk1_stress
  []
  [momentum_balance_y]
    type = Tutorial02Kernel
    variable = disp_y
    component = 1
    stress = pk1_stress
  []
[]

[Materials]
  [strain]
    type = ADComputeDeformationGradient
  []
  # REMOVE_BEGIN
  [stress]
    type = Tutorial10Stress
    bulk_modulus = 4000
    shear_modulus_1 = 3000
    shear_modulus_2 = 3000
    beta = 2
    output_properties = 'p Theta'
    outputs = 'exodus'
  []
  # REMOVE_END
[]

[BCs]
  [right_fix_x]
    type = DirichletBC
    variable = disp_x
    value = 0
    boundary = 'right'
  []
  [right_fix_y]
    type = DirichletBC
    variable = disp_y
    value = 0
    boundary = 'right'
  []
  [tear_upward]
    type = FunctionNeumannBC
    variable = disp_y
    function = 't'
    boundary = 'left_upper'
  []
  [tear_downward]
    type = FunctionNeumannBC
    variable = disp_y
    function = '-t'
    boundary = 'left_lower'
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  automatic_scaling = true
  end_time = 1000
  dt = 10
  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-10
[]

[Outputs]
  exodus = true
[]
