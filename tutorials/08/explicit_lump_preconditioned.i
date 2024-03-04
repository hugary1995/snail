alpha = 1

interval = 10

[Physics]
  [SolidMechanics]
    [QuasiStatic]
      [all]
        add_variables = true
      []
    []
  []
[]

[Kernels]
  [inertia]
    type = InertialForce
    variable = disp_x
    density = 7.75e3
  []
[]

[Executioner]
  type = Transient
  automatic_scaling = true
  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-10
  end_time = 5
  dt = 0.001

  [TimeIntegrator]
    type = CentralDifference
    solve_type = lump_preconditioned
  []
[]
