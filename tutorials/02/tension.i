[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Mesh]
  [sample]
    type = FileMeshGenerator
    file = '../gold/sample.msh'
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
  []
  [momentum_balance_y]
    type = Tutorial02Kernel
    variable = disp_y
    component = 1
  []
[]

[Materials]
  [strain]
    type = Tutorial02Strain
  []
  [stress]
    type = Tutorial02Stress
    lambda = 4000
    mu = 6700
  []
[]

[BCs]
  [fix_x]
    type = DirichletBC
    variable = disp_x
    value = 0
    boundary = 'top bottom'
  []
  [bottom_fix_y]
    type = DirichletBC
    variable = disp_y
    value = 0
    boundary = 'bottom'
  []
  [top_pull_y]
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
  end_time = 2
  dt = 0.2
[]

[Outputs]
  exodus = true
[]
