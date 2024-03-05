#pragma once

#include "Material.h"
#include "RankTwoTensor.h"

class Tutorial02Strain : public Material
{
public:
  static InputParameters validParams();

  Tutorial02Strain(const InputParameters &);

protected:
  virtual void computeQpProperties() override;

  std::vector<const ADVariableGradient *> _grad_u;

  ADMaterialProperty<RankTwoTensor> & _e;
};
