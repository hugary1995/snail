strain = FINITE

[Materials]
  [elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    lambda = 4000
    shear_modulus = 6700
  []
  [green_naghdi]
    type = ComputeLagrangianLinearElasticStress
    large_kinematics = true
    objective_rate = green_naghdi
  []
[]
