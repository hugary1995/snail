#include "Tutorial10Stress.h"
#include "StabilizationUtils.h"

registerMooseObject("snailApp", Tutorial10Stress);

InputParameters
Tutorial10Stress::validParams()
{
  auto params = Material::validParams();
  params.addClassDescription(
      "Calculate stress for a Neo-Hookean type material with three-field stabilization");
  params.addRequiredParam<MaterialPropertyName>("bulk_modulus", "Lame's first parameter");
  params.addRequiredParam<MaterialPropertyName>("shear_modulus_1", "Shear modulus");
  params.addRequiredParam<MaterialPropertyName>("shear_modulus_2", "Shear modulus");
  params.addRequiredParam<Real>("beta", "Incompressibility exponent");
  params.addParam<MaterialPropertyName>(
      "hydrostatic_pressure", "p", "Name of the element hydrostatic pressure");
  return params;
}

Tutorial10Stress::Tutorial10Stress(const InputParameters & params)
  : Material(params),
    _F(getADMaterialProperty<RankTwoTensor>("deformation_gradient")),
    _K(getADMaterialProperty<Real>("bulk_modulus")),
    _mu1(getADMaterialProperty<Real>("shear_modulus_1")),
    _mu2(getADMaterialProperty<Real>("shear_modulus_2")),
    _beta(getParam<Real>("beta")),
    _p(declareADProperty<Real>("hydrostatic_pressure")),
    _P(declareADProperty<RankTwoTensor>("pk1_stress"))
{
}

void
Tutorial10Stress::computeProperties()
{
  // Calculate the average dilation over the element
  const auto Theta_avg = StabilizationUtils::elementAverage(
      [this](unsigned int qp) { return _F[_qp].det(); }, _JxW, _coord);

  // Calculate the average hydrostatic pressure over the element
  const auto p_avg = StabilizationUtils::elementAverage(
      [&, this](unsigned int qp) {
        return _K[qp] * _beta * (std::pow(Theta_avg, _beta - 1) - std::pow(Theta_avg, -_beta - 1));
      },
      _JxW,
      _coord);

  // All quadrature points have the same hydrostatic pressure
  _p.set().setAllValues(p_avg);

  // Call the base class method
  Material::computeProperties();
}

void
Tutorial10Stress::computeQpProperties()
{
  // Element Jacobian
  const auto J = _F[_qp].det();

  // Right Cauchy Green strain
  const auto C = _F[_qp].transpose() * _F[_qp];

  // Isochoric stress
  const auto S_isc = isochoricStress(J, C);

  // Volumetric stress
  const auto S_vol = _p[_qp] * J * C.inverse();

  // PK1 stress
  _P[_qp] = _F[_qp] * (S_vol + S_isc);
}

ADRankTwoTensor
Tutorial10Stress::isochoricStress(const ADReal & J, const ADRankTwoTensor & C) const
{
  usingTensorIndices(i, j, k, l);

  const auto I2 = ADRankTwoTensor::Identity();
  const auto C_bar = std::pow(J, -2.0 / 3.0) * C;
  const auto C_bar_inv = C_bar.inverse();
  const auto C_bar_cof = C_bar.det() * C_bar_inv;
  const auto S_bar = 2 * _mu1[_qp] * I2 + 3 * _mu2[_qp] * std::sqrt(C_bar_cof.tr()) *
                                              (C_bar_cof * C_bar_inv.tr() - C_bar_cof * C_bar_inv);
  const auto P_deviator =
      std::pow(J, -2.0 / 3.0) *
      ((I2.times<i, k, j, l>(I2) + I2.times<i, l, j, k>(I2)) / 2 - C.inverse().outerProduct(C) / 3);
  return P_deviator * S_bar;
}
