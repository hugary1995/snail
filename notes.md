=============================================================================
Day 1
=============================================================================

# MOOSE overview

What is MOOSE?
What can MOOSE do?
Why MOOSE?

# Installation

# Framework overview

[Mesh]
[Variables]
[Kernels]
[BCs]
[Executioner]
[Outputs]

There are many other systems.

# Tutorial 1: Simple tension test

- Theory: strong form, weak form, constitutive model
- Translating the weak form to MOOSE code (Kernel)
- A complete example, e.g., tension test
- Parallel execution
- Common strategies to improve the solve
- Visualization

# Tutorial 2: Material model

- Separating out the constitutive model (Materials)
- Input file modification
- Automatic differentiation
- AD FAQ

# Tutorial 3: Postprocessing

- Visualizing results in Paraview
- Postprocessing: average displacement
- Postprocessing: reaction force
- Postprocessing: elemental stress/strain
- Postprocessing: average stress/strain

# Tutorial 4: The solid mechanics [Physics]

- What is "Physics"?
- Input file using [Physics]

# Tutorial 5: Large deformation

- `new_system = true`
- `new_system = false`

# Tutorial 6: Coordinate systems and planar formulations

# Tutorial 7: Volumetric locking correction (stablization)

# Tutorial 8: Dynamics

# Tutorial 9: Homogenization

# Other features

- Inelastic models: viscoplasticity, creep, crystal plasticity, etc.
- Cohesive Zone Method (CZM)
- Smeared cracking
- Fracture integrals
- C0 Timoshenko beam
- Shell elements
- Frequency domain analysis
- Isogeometric analysis

# Wrapping up Day 1

- Summary
- Tomorrow's agenda

=============================================================================
Day 2
=============================================================================

# Tutorial 10: Custom material model

This is mainly for developers to gain hands-on experience
I'll probably use the hyperelastic 3-field Hu-Washizu model as an example

- Theory
- Implementation

# Tutorial 11: Custom Multiphysics coupling

- Use phase-field fracture as an example (per our Duke host's request)
- Theory
- Implementation
- Monolithic: Off-diagonal Jacobians
- Monolithic: input file example

# Tutorial 12: Picard iterations

- Picard: Briefly introduce MultiApps and Transfer
- Picard: input file example

# Tutorial 13: Regression testing and Documentation

- Write a regression test for the custom material from tutorial 13
- Write a documentation page
- Build and serve the documentation website

# Tutorial 14: Using external material models

- Abaqus UMAT
- NEML2

# Wrapping up

- Summary
- Discussion forum
- Bug report / feature request
- How to contribute
