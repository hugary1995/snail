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

# Tutorial 6: Coordinate systems

# Tutorial 7: (Advanced) Volumetric locking correction (stablization)

# Tutorial 8: (Advanced) Plasticity

# Tutorial 9: (Advanced) Dynamics

# Tutorial 10: (Advanced) Homogenization

# Tutorial 11: (Advanced) Cohesive Zone Method

# Tutorial 12: Other advanced features

- Smeared cracking
- Fracture integrals
- Crystal plasticity
- C0 Timoshenko beam
- Shell elements
- Reduced order models
- Frequency domain analysis
- Isogeometric analysis

# Tutorial 13: Custom material model

This is mainly for developers to gain hands-on experience
I'll probably use the hyperelastic 3-field Hu-Washizu model as an example

- Theory
- Implementation

# Tutorial 14: Regression testing and Documentation

- Write a regression test for the custom material from tutorial 13
- Write a documentation page
- Build and serve the documentation website

# Wrapping up Day 1

- Summary
- Discussion forum
- Bug report, feature request
- How to contribute

=============================================================================
Day 2
=============================================================================

# Tutorial 14: Coupling with heat transfer

I'll use this as a general introduction.

- Theory
- Monolithic: Off-diagonal Jacobians
- Monolithic: input file example
- Picard: Briefly introduce MultiApps and Transfer
- Picard: input file example

# Tutorial 15: Coupling with other physics/systems

- More often then not, some MOOSE-based app out there already has the coupling you want.
- List of solid-mechanics related apps:
  - BISON
  - BlackBear
  - Grizzly
  - ...
- Requesting access for controlled apps

# Tutorial 16: Hands-on practice for developers

- Use phase-field fracture as an example (per our Duke host's request)
- Theory
- Implementation
- Advertise RACCOON

# Tutorial 17: Using external material models

- Abaqus UMAT
- NEML2
