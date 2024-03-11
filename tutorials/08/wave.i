[GlobalParams]
  displacements = 'disp_x'
[]

[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 1
    nx = 100
  []
[]

# REMOVE_BEGIN
[Functions]
  [pressure]
    type = PiecewiseLinear
    x = '0 0.05 0.1'
    y = '0 1e3 0'
  []
[]

[BCs]
  [fix]
    type = DirichletBC
    variable = disp_x
    boundary = right
    value = 0.0
  []
  [impact]
    type = Pressure
    variable = disp_x
    boundary = left
    function = pressure
    alpha = ${alpha}
  []
[]
# REMOVE_END

[Materials]
  [Elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2.1e5
    poissons_ratio = 0
  []
  [stress]
    type = ComputeLinearElasticStress
  []
[]

[Postprocessors]
  [displacement]
    type = PointValue
    variable = disp_x
    point = '0.5 0 0'
  []
[]

[Outputs]
  interval = ${interval}
  csv = true
  exodus = true
[]
