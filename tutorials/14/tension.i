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
        strain = SMALL
        formulation = TOTAL
        volumetric_locking_correction = true
        generate_output = "cauchy_stress_xx cauchy_stress_yy cauchy_stress_zz
                           cauchy_stress_xy cauchy_stress_xz cauchy_stress_yz
                           mechanical_strain_xx mechanical_strain_yy mechanical_strain_zz
                           mechanical_strain_xy mechanical_strain_xz mechanical_strain_yz"
        additional_generate_output = 'vonmises_cauchy_stress'
      []
    []
  []
[]

# REMOVE_BEGIN
[AuxVariables]
  [T]
  []
[]

[NEML2]
  input = 'viscoplasticity_isoharden.i'
  model = 'model'
  temperature = 'T'
  verbose = true
  mode = ELEMENT
  device = 'cpu'
[]
# REMOVE_END

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
  end_time = 0.02
  dt = 0.01
  residual_and_jacobian_together = true
  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-10
[]

[Outputs]
  exodus = true
[]
