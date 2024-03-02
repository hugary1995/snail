#pragma once

#include "Material.h"
#include "SymmetricRankTwoTensor.h"

class ADSymmetricRankTwoCartesianComponent : public Material
{
public:
  static InputParameters validParams();

  ADSymmetricRankTwoCartesianComponent(const InputParameters & parameters);

protected:
  virtual void computeQpProperties() override;

private:
  const ADMaterialProperty<SymmetricRankTwoTensor> & _tensor;

  /// Stress/strain value returned from calculation
  ADMaterialProperty<Real> & _property;

  /// Tensor component
  const unsigned int _i;

  /// Tensor component
  const unsigned int _j;
};
