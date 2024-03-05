#include "Tutorial02Stress.h"

registerMooseObject("snailApp", Tutorial02Stress);

InputParameters
Tutorial02Stress::validParams()
{
  auto params = Material::validParams();
  params.addClassDescription("Calculate stress for a linear elastic material");
  params.addRequiredParam<MaterialPropertyName>("lambda", "Lame's first parameter");
  params.addRequiredParam<MaterialPropertyName>("mu", "Shear modulus");
  params.addParam<MaterialPropertyName>("strain", "strain", "Name of the strain");
  params.addParam<MaterialPropertyName>("stress", "stress", "Name of the stress");
  return params;
}

Tutorial02Stress::Tutorial02Stress(const InputParameters & params)
  : Material(params),
    _e(getADMaterialProperty<RankTwoTensor>("strain")),
    _lambda(getADMaterialProperty<Real>("lambda")),
    _mu(getADMaterialProperty<Real>("mu")),
    _s(declareADProperty<RankTwoTensor>("stress"))
{
}

void
Tutorial02Stress::computeQpProperties()
{
  using R2 = ADRankTwoTensor;

  _s[_qp] = _lambda[_qp] * _e[_qp].trace() * R2::Identity() + 2 * _mu[_qp] * _e[_qp];
}
