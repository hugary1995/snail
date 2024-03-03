[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Mesh]
  [sample]
    type = FileMeshGenerator
    file = '../gold/sample.msh'
  []
[]

[Physics]
  [SolidMechanics]
    [QuasiStatic]
      [sample]
        new_system = true
        add_variables = true
        strain = ${strain}
        formulation = TOTAL
        save_in = 'r_x r_y'
      []
    []
  []
[]

[BCs]
  [fix_x]
    type = DirichletBC
    variable = disp_x
    value = 0
    boundary = 'bottom'
  []
  [bottom_fix_y]
    type = DirichletBC
    variable = disp_y
    value = 0
    boundary = 'bottom'
  []
  [top_shear_x]
    type = FunctionDirichletBC
    variable = disp_x
    function = 't'
    boundary = 'top'
    preset = false
  []
  [top_pull_y]
    type = FunctionDirichletBC
    variable = disp_y
    function = 't'
    boundary = 'top'
    preset = false
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  automatic_scaling = true
  end_time = 5
  dt = 0.2
[]

[AuxVariables]
  [r_x]
  []
  [r_y]
  []
[]

[Postprocessors]
  [displacement]
    type = SideAverageValue
    variable = disp_x
    boundary = 'top'
  []
  [force_x]
    type = NodalSum
    variable = r_x
    boundary = 'top'
  []
  [force_y]
    type = NodalSum
    variable = r_y
    boundary = 'top'
  []
[]

[Outputs]
  exodus = true
  csv = true
[]
