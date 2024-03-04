alpha = 0.1
beta = '${fparse (1+alpha)^2/4}'
gamma = '${fparse 0.5+alpha}'

interval = 1

[Physics]
  [SolidMechanics]
    [Dynamic]
      [all]
        add_variables = true
        newmark_beta = ${beta}
        newmark_gamma = ${gamma}
        hht_alpha = ${alpha}
        density = 7.75e3
      []
    []
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  automatic_scaling = true
  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-10
  end_time = 5
  dt = 0.01
[]
