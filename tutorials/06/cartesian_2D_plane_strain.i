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
        strain = FINITE
        formulation = TOTAL
        volumetric_locking_correction = true
        save_in = 'r_x r_y'
      []
    []
  []
[]

[Materials]
  [elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    lambda = 4000
    shear_modulus = 6700
  []
  [stress]
    type = ComputeStVenantKirchhoffStress
    large_kinematics = true
  []
[]

[BCs]
  [bottom_fix_x]
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
  end_time = 2
  dt = 0.1
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
    variable = disp_y
    boundary = 'top'
  []
  [force]
    type = NodalSum
    variable = r_y
    boundary = 'top'
  []
[]

[Outputs]
  file_base = 'cartesian_2D_plane_strain'
  csv = true
[]
