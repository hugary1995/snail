#include "Tutorial02Strain.h"

registerMooseObject("snailApp", Tutorial02Strain);

InputParameters
Tutorial02Strain::validParams()
{
  auto params = Material::validParams();
  params.addClassDescription("Calculate strain as function of displacement gradients");
  params.addRequiredCoupledVar("displacements", "Displacement variables");
  params.addParam<MaterialPropertyName>("strain", "strain", "Name of the strain");
  return params;
}

Tutorial02Strain::Tutorial02Strain(const InputParameters & params)
  : Material(params),
    _grad_u(adCoupledGradients("displacements")),
    _e(declareADProperty<RankTwoTensor>("strain"))
{
  _grad_u.resize(3, &_ad_grad_zero);
}

void
Tutorial02Strain::computeQpProperties()
{
  using R2 = ADRankTwoTensor;

  auto G = R2((*_grad_u[0])[_qp], (*_grad_u[1])[_qp], (*_grad_u[2])[_qp]);
  _e[_qp] = (G.transpose() + G) / 2;
}
