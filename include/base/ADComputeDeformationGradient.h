#pragma once

#include "Material.h"
#include "RankTwoTensor.h"

class ADComputeDeformationGradient : public Material
{
public:
  static InputParameters validParams();

  ADComputeDeformationGradient(const InputParameters & parameters);

protected:
  void initQpStatefulProperties() override;

  void computeQpProperties() override;

  /// Gradient of displacements
  std::vector<const ADVariableGradient *> _grad_disp;

  /// The deformation gradient
  ADMaterialProperty<RankTwoTensor> & _F;
};
