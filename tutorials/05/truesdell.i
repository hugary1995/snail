strain = FINITE

[Materials]
  [elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    lambda = 4000
    shear_modulus = 6700
  []
  [truesdell]
    type = ComputeLagrangianLinearElasticStress
    large_kinematics = true
    objective_rate = truesdell
  []
[]
