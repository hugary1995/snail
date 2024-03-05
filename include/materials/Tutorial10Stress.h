#pragma once

#include "Material.h"
#include "RankTwoTensor.h"

class Tutorial10Stress : public Material
{
public:
  static InputParameters validParams();

  Tutorial10Stress(const InputParameters &);

  virtual void computeProperties() override;

protected:
  virtual void computeQpProperties() override;

  const ADMaterialProperty<RankTwoTensor> & _F;
  const ADMaterialProperty<Real> & _K;
  const ADMaterialProperty<Real> & _mu1;
  const ADMaterialProperty<Real> & _mu2;
  const Real _beta;

  ADMaterialProperty<Real> & _p;
  ADMaterialProperty<RankTwoTensor> & _P;

private:
  ADRankTwoTensor isochoricStress(const ADReal & J, const ADRankTwoTensor & C) const;
};
