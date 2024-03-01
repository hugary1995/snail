## Framework overview

- <span style="color: coral">All modules and apps</span> are built upon the MOOSE <span style="color: coral">framework level capabilities</span>.
- The solid mechanics module is no exception.
- Here, we will only go over a <span style="color: coral">bare minimum</span> amount of framework level capabilities.

| System/Syntax                                                                                                                   | Description                                                                      |
| ------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| [`[Mesh]`](https://mooseframework.inl.gov/syntax/Mesh/index.html)                                                               | Defines the partition of the physical domain where the problem is defined        |
| [`[Variables]`](https://mooseframework.inl.gov/syntax/Variables/index.html)                                                     | Declares unknown variables and their corresponding function spaces               |
| [`[Kernels]`](https://mooseframework.inl.gov/syntax/Kernels/index.html)                                                         | Defines the partial differential equations that describe the problem of interest |
| [`[BCs]`](https://mooseframework.inl.gov/syntax/BCs/index.html) [`[ICs]`](https://mooseframework.inl.gov/syntax/ICs/index.html) | Defines boundary/initial conditions of the problem                               |
| [`[Executioner]`](https://mooseframework.inl.gov/syntax/Executioner/index.html)                                                 | Configures how the problem is solved                                             |
| [`[Outputs]`](https://mooseframework.inl.gov/syntax/Outputs/index.html)                                                         | Informs MOOSE what, where, when, and how to output                               |

---

## Tutorial 0: How MOOSE works

<div class="container" style="grid-template-columns: 30% 30% 40%;">
	<div class="col">
    <h4 style="text-align: left">Plain language</h4>
    <p style="text-align: left; font-size: 0.4em">
      The problem is defined on a <span style="color: coral">two dimensional square</span> with side length 1.
      <br><br>
      I am interested in the evolution of the species <span style="color: coral">concentration $c$</span>.
      <br><br>
      Some chemical <span style="color: coral">reaction</span> produces this species with a constant rate of $1$,
      and the species is <span style="color: coral">consumed</span> at a constant rate of $1$.
      The species also <span style="color: coral">diffuses</span> over time with a diffusion coefficient of $0.01$.
      <br><br>
      I know the <span style="color: coral">initial distribution</span> of the species concentration $c_0$.
      How does the species concentration <span style="color: coral">evolve</span> over $1$ seconds?
    </p>
  </div>
	<div class="col">
    <h4 style="text-align: left">MOOSE</h4>
    <pre class="python" style="width: 60%; margin-left: 0;"><code data-trim data-noescape>
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
    </code></pre>
  </div>
	<div class="col">
    <h4 style="text-align: left">Result</h4>
    <img data-src="assets/tutorial00.gif" style="height: 500px; margin: auto; display: inline-block;"></img>
  </div>
</div>
