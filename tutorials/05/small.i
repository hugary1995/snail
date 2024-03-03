strain = SMALL

[Materials]
  [elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    lambda = 4000
    shear_modulus = 6700
  []
  [small]
    type = ComputeLagrangianLinearElasticStress
    large_kinematics = false
  []
[]
