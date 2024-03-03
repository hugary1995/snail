strain = FINITE

[Materials]
  [elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    lambda = 4000
    shear_modulus = 6700
  []
  [st_venent_kirchhoff]
    type = ComputeStVenantKirchhoffStress
    large_kinematics = true
  []
[]
