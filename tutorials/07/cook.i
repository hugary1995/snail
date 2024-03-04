[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Mesh]
  [fmg]
    type = FileMeshGenerator
    file = 'membrane.msh'
  []
[]

[Physics]
  [SolidMechanics]
    [QuasiStatic]
      [sample]
        new_system = true
        add_variables = true
        strain = FINITE
        formulation = TOTAL
        volumetric_locking_correction = ${vlc}
      []
    []
  []
[]

[Materials]
  [stress]
    type = ComputeNeoHookeanStress
    lambda = 416666611.0991259
    mu = 8300.33333888888926
    large_kinematics = true
  []
[]

[BCs]
  [fix_x]
    type = DirichletBC
    variable = disp_x
    boundary = left
    value = 0.0
  []
  [fix_y]
    type = DirichletBC
    variable = disp_y
    boundary = left
    value = 0.0
  []
  [pull]
    type = FunctionNeumannBC
    variable = disp_y
    boundary = right
    function = 't'
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  automatic_scaling = true
  line_search = none
  end_time = 100
  dt = 5
  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-10
[]

[Postprocessors]
  [value]
    type = PointValue
    variable = disp_y
    point = '48 60 0'
  []
[]

[Outputs]
  csv = true
  exodus = true
[]
