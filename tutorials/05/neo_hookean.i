strain = FINITE

[Materials]
  [neo_hookean]
    type = ComputeNeoHookeanStress
    lambda = 4000
    mu = 6700
    large_kinematics = true
  []
[]
