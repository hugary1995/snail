#include "ADComputeDeformationGradient.h"

registerADMooseObject("snailApp", ADComputeDeformationGradient);

InputParameters
ADComputeDeformationGradient::validParams()
{
  InputParameters params = Material::validParams();
  params.addClassDescription("Compute the deformation gradient");
  params.addParam<MaterialPropertyName>(
      "deformation_gradient", "F", "Name of the deformation gradient");
  params.addRequiredCoupledVar(
      "displacements",
      "The displacements appropriate for the simulation geometry and coordinate system");
  params.suppressParameter<bool>("use_displaced_mesh");
  return params;
}

ADComputeDeformationGradient::ADComputeDeformationGradient(const InputParameters & parameters)
  : Material(parameters),
    _grad_disp(adCoupledGradients("displacements")),
    _F(declareADProperty<RankTwoTensor>("deformation_gradient"))
{
  _grad_disp.resize(3, &_ad_grad_zero);
}

void
ADComputeDeformationGradient::initQpStatefulProperties()
{
  _F[_qp].setToIdentity();
}

void
ADComputeDeformationGradient::computeQpProperties()
{
  using R2 = ADRankTwoTensor;

  _F[_qp] =
      R2::Identity() +
      R2::initializeFromRows((*_grad_disp[0])[_qp], (*_grad_disp[1])[_qp], (*_grad_disp[2])[_qp]);
}
