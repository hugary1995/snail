[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 2
    xmax = 1
    ymax = 1
    nx = 200
    ny = 200
  []
[]

[Variables]
  [c]
  []
[]

[Kernels]
  [transient]
    type = TimeDerivative
    variable = c
  []
  [consumption]
    type = BodyForce
    variable = c
    value = -1
  []
  [reaction]
    type = CoefReaction
    variable = c
    rate = -1
  []
  [diffusion]
    type = MatDiffusion
    variable = c
    diffusivity = 0.01
  []
[]

[Functions]
  [c0]
    type = ParsedFunction
    expression = 'sin(40*(x-0.2)*(y-0.3))*cos(20*(y-0.4)*(y-0.5))+1'
  []
[]

[ICs]
  [c0]
    type = FunctionIC
    variable = c
    function = c0
  []
[]

[Executioner]
  type = Transient
  end_time = 1
  dt = 0.02
[]

[Outputs]
  exodus = true
[]
