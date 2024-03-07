#pragma once

#include "Material.h"
#include "RankTwoTensor.h"

class Tutorial02Strain : public Material
{
public:
  static InputParameters validParams();

  Tutorial02Strain(const InputParameters &);

protected:
  // REMOVE_BEGIN
  virtual void computeQpProperties() override;
  // REMOVE_END

  std::vector<const ADVariableGradient *> _grad_u;

  ADMaterialProperty<RankTwoTensor> & _e;
};
