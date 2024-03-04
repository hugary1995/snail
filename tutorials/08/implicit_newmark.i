beta = 0.25
gamma = 0.5
alpha = 0

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
