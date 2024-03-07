#include "Tutorial11Stress.h"

registerMooseObject("snailApp", Tutorial11Stress);

InputParameters
Tutorial11Stress::validParams()
{
  auto params = Tutorial10Stress::validParams();
  params.addClassDescription(
      "Calculate stress for a Neo-Hookean type material with three-field stabilization. The "
      "material is degraded based on the current damage.");
  params.addRequiredCoupledVar("damage", "The damage variable");
  params.addParam<MaterialPropertyName>("degradation", "g", "The fracture degradation function");
  params.addParam<MaterialPropertyName>(
      "strain_energy_density", "w", "Name of the strain energy density");
  return params;
}

Tutorial11Stress::Tutorial11Stress(const InputParameters & params)
  : DerivativeMaterialInterface<Tutorial10Stress>(params),
    _d(coupledName("damage")),
    _g(getADMaterialProperty<Real>("degradation")),
    _dg(getMaterialPropertyDerivative<Real, true>(getParam<MaterialPropertyName>("degradation"),
                                                  _d)),
    _w(declareADProperty<Real>("strain_energy_density")),
    _dw(declarePropertyDerivative<Real, true>(
        getParam<MaterialPropertyName>("strain_energy_density"), _d))
{
}

void
Tutorial11Stress::computeQpProperties()
{
  // REMOVE_BEGIN
  // Second invariant of the deviatoric right Cauchy Green strain
  const auto J = _F[_qp].det();
  const auto C = _F[_qp].transpose() * _F[_qp];
  const auto C_bar = std::pow(J, -2.0 / 3.0) * C;
  const auto C_bar_inv = C_bar.inverse();
  const auto C_bar_cof = C_bar.det() * C_bar_inv;
  const auto I2_bar = std::sqrt(C_bar_cof.tr());

  // Strain energy density
  const auto w_vol = _K[_qp] * (h(_Theta[_qp]) - 2);
  const auto w_isc_1 = _mu1[_qp] * (C_bar.tr() - 3);
  const auto w_isc_2 = _mu2[_qp] * (std::pow(I2_bar, 3.0) - std::pow(3.0, 1.5));
  _w[_qp] = _g[_qp] * (w_vol + w_isc_1 + w_isc_2);

  // Derivative of the strain energy density w.r.t. damage
  _dw[_qp] = _dg[_qp] * (w_vol + w_isc_1 + w_isc_2);

  // Apply degradation
  _p[_qp] *= _g[_qp];

  Tutorial10Stress::computeQpProperties();
  // REMOVE_END
}

ADRankTwoTensor
Tutorial11Stress::isochoricStress(const ADReal & J, const ADRankTwoTensor & C) const
{
  // REMOVE_BEGIN
  return _g[_qp] * Tutorial10Stress::isochoricStress(J, C);
  // REMOVE_END
}
