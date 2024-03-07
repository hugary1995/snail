[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Mesh]
  [RVE]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 20
    ny = 20
  []
  [A]
    type = SubdomainBoundingBoxGenerator
    input = RVE
    block_id = 1
    block_name = A
    bottom_left = '0 0.5 0'
    top_right = '0.5 1 0'
  []
  [B]
    type = SubdomainBoundingBoxGenerator
    input = A
    block_id = 2
    block_name = B
    bottom_left = '0.5 0.5 0'
    top_right = '1 1 0'
  []
  [C]
    type = SubdomainBoundingBoxGenerator
    input = B
    block_id = 3
    block_name = C
    bottom_left = '0 0 0'
    top_right = '0.5 0.5 0'
  []
  [D]
    type = SubdomainBoundingBoxGenerator
    input = C
    block_id = 4
    block_name = D
    bottom_left = '0.5 0 0'
    top_right = '1 0.5 0'
  []
  [fix1]
    type = ExtraNodesetGenerator
    input = D
    new_boundary = fix1
    coord = '0.5 0.5 0'
  []
  [fix2]
    type = ExtraNodesetGenerator
    input = fix1
    new_boundary = fix2
    coord = '0.55 0.5 0'
  []
[]

[Functions]
  [exx]
    type = ParsedFunction
    expression = '0.1*sin(20*t)+0.1*cos(15*t)'
  []
  [sxy]
    type = ParsedFunction
    expression = '100*sin(13*t)+150*cos(9*t)'
  []
  [eyx]
    type = ParsedFunction
    expression = '0'
  []
  [syy]
    type = ParsedFunction
    expression = '-70*sin(9*t)-130*cos(25*t)'
  []
[]

[Physics]
  [SolidMechanics]
    [QuasiStatic]
      [all]
        new_system = true
        add_variables = true
        strain = FINITE
        formulation = TOTAL
        volumetric_locking_correction = true
        additional_generate_output = 'vonmises_cauchy_stress'
        # REMOVE_BEGIN
        constraint_types = 'strain strain none stress stress none none none none'
        targets = 'exx eyx sxy syy'
        # REMOVE_END
      []
    []
  []
[]

[BCs]
  [Periodic]
    [x]
      variable = disp_x
      auto_direction = 'x y'
    []
    [y]
      variable = disp_y
      auto_direction = 'x y'
    []
  []
  [fix1_x]
    type = DirichletBC
    boundary = fix1
    variable = disp_x
    value = 0
  []
  [fix1_y]
    type = DirichletBC
    boundary = fix1
    variable = disp_y
    value = 0
  []
  [fix2_y]
    type = DirichletBC
    boundary = fix2
    variable = disp_y
    value = 0
  []
[]

[Materials]
  [A]
    type = ComputeNeoHookeanStress
    lambda = 4000
    mu = 2500
    large_kinematics = true
    block = A
  []
  [B]
    type = ComputeNeoHookeanStress
    lambda = 3000
    mu = 3000
    large_kinematics = true
    block = B
  []
  [C]
    type = ComputeNeoHookeanStress
    lambda = 5000
    mu = 5500
    large_kinematics = true
    block = C
  []
  [D]
    type = ComputeNeoHookeanStress
    lambda = 3500
    mu = 7500
    large_kinematics = true
    block = D
  []
  [Fxx]
    type = RankTwoCartesianComponent
    property_name = Fxx
    rank_two_tensor = 'deformation_gradient'
    index_i = 0
    index_j = 0
  []
  [Pxy]
    type = RankTwoCartesianComponent
    property_name = Pxy
    rank_two_tensor = 'pk1_stress'
    index_i = 0
    index_j = 1
  []
  [Fyx]
    type = RankTwoCartesianComponent
    property_name = Fyx
    rank_two_tensor = 'deformation_gradient'
    index_i = 1
    index_j = 0
  []
  [Pyy]
    type = RankTwoCartesianComponent
    property_name = Pyy
    rank_two_tensor = 'pk1_stress'
    index_i = 1
    index_j = 1
  []
[]

[Postprocessors]
  [Fxx]
    type = ElementAverageMaterialProperty
    mat_prop = Fxx
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Fxx_A]
    type = ElementAverageMaterialProperty
    mat_prop = Fxx
    block = A
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Fxx_B]
    type = ElementAverageMaterialProperty
    mat_prop = Fxx
    block = B
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Fxx_C]
    type = ElementAverageMaterialProperty
    mat_prop = Fxx
    block = C
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Fxx_D]
    type = ElementAverageMaterialProperty
    mat_prop = Fxx
    block = D
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [exx]
    type = FunctionValuePostprocessor
    function = 'exx'
    execute_on = 'INITIAL TIMESTEP_END'
  []
[]

[Postprocessors]
  [Pxy]
    type = ElementAverageMaterialProperty
    mat_prop = Pxy
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Pxy_A]
    type = ElementAverageMaterialProperty
    mat_prop = Pxy
    block = A
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Pxy_B]
    type = ElementAverageMaterialProperty
    mat_prop = Pxy
    block = B
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Pxy_C]
    type = ElementAverageMaterialProperty
    mat_prop = Pxy
    block = C
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Pxy_D]
    type = ElementAverageMaterialProperty
    mat_prop = Pxy
    block = D
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [sxy]
    type = FunctionValuePostprocessor
    function = 'sxy'
    execute_on = 'INITIAL TIMESTEP_END'
  []
[]

[Postprocessors]
  [Fyx]
    type = ElementAverageMaterialProperty
    mat_prop = Fyx
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Fyx_A]
    type = ElementAverageMaterialProperty
    mat_prop = Fyx
    block = A
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Fyx_B]
    type = ElementAverageMaterialProperty
    mat_prop = Fyx
    block = B
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Fyx_C]
    type = ElementAverageMaterialProperty
    mat_prop = Fyx
    block = C
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Fyx_D]
    type = ElementAverageMaterialProperty
    mat_prop = Fyx
    block = D
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [eyx]
    type = FunctionValuePostprocessor
    function = 'eyx'
    execute_on = 'INITIAL TIMESTEP_END'
  []
[]

[Postprocessors]
  [Pyy]
    type = ElementAverageMaterialProperty
    mat_prop = Pyy
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Pyy_A]
    type = ElementAverageMaterialProperty
    mat_prop = Pyy
    block = A
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Pyy_B]
    type = ElementAverageMaterialProperty
    mat_prop = Pyy
    block = B
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Pyy_C]
    type = ElementAverageMaterialProperty
    mat_prop = Pyy
    block = C
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [Pyy_D]
    type = ElementAverageMaterialProperty
    mat_prop = Pyy
    block = D
    execute_on = 'INITIAL TIMESTEP_END'
  []
  [syy]
    type = FunctionValuePostprocessor
    function = 'syy'
    execute_on = 'INITIAL TIMESTEP_END'
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  automatic_scaling = true
  end_time = 1
  dt = 0.01
[]

[Outputs]
  exodus = true
  csv = true
[]
