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
  [strain_zz]
  []
[]

[Kernels]
  [momentum_x]
    type = TotalLagrangianStressDivergence
    variable = disp_x
    out_of_plane_strain = strain_zz
    component = 0
    save_in = 'r_x'
  []
  [momentum_y]
    type = TotalLagrangianStressDivergence
    variable = disp_y
    out_of_plane_strain = strain_zz
    component = 1
    save_in = 'r_y'
  []
  [wps]
    type = TotalLagrangianWeakPlaneStress
    variable = strain_zz
  []
[]

[Materials]
  [elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    lambda = 4000
    shear_modulus = 6700
  []
  [strain]
    type = ComputeLagrangianWPSStrain
    out_of_plane_strain = strain_zz
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
  file_base = 'cartesian_2D_weak_plane_stress'
  csv = true
[]
