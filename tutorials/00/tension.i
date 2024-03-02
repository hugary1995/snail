[Mesh]
  [sample]
    type = FileMeshGenerator
    file = 'gold/sample.msh'
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
        generate_output = "cauchy_stress_xx cauchy_stress_yy cauchy_stress_zz
                           cauchy_stress_xy cauchy_stress_xz cauchy_stress_yz
                           mechanical_strain_xx mechanical_strain_yy mechanical_strain_zz
                           mechanical_strain_xy mechanical_strain_xz mechanical_strain_yz"
      []
    []
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
  []
[]

[Materials]
  [neo_hookean]
    type = ComputeNeoHookeanStress
    lambda = 4000
    mu = 6700
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  automatic_scaling = true
  end_time = 1
  dt = 0.02
[]

[Outputs]
  exodus = true
[]
