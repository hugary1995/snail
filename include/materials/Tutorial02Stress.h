#pragma once

#include "Material.h"
#include "RankTwoTensor.h"

class Tutorial02Stress : public Material
{
public:
  static InputParameters validParams();

  Tutorial02Stress(const InputParameters &);

protected:
  virtual void computeQpProperties() override;

  const ADMaterialProperty<RankTwoTensor> & _e;

  const ADMaterialProperty<Real> & _lambda;

  const ADMaterialProperty<Real> & _mu;

  ADMaterialProperty<RankTwoTensor> & _s;
};
