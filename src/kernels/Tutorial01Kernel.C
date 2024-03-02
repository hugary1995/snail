#include "Tutorial01Kernel.h"

registerMooseObject("snailApp", Tutorial01Kernel);

InputParameters
Tutorial01Kernel::validParams()
{
  auto params = ADKernel::validParams();
  params.addClassDescription("Solve the linear momentum balance for a linear elastic material");
  params.addRequiredCoupledVar("displacements", "Displacement variables");
  params.addRequiredParam<MaterialPropertyName>("lambda", "Lame's first parameter");
  params.addRequiredParam<MaterialPropertyName>("mu", "Shear modulus");
  params.addRequiredParam<unsigned int>("component", "The residual component");
  return params;
}

Tutorial01Kernel::Tutorial01Kernel(const InputParameters & params)
  : ADKernel(params),
    _grad_u(adCoupledGradients("displacements")),
    _lambda(getADMaterialProperty<Real>("lambda")),
    _mu(getADMaterialProperty<Real>("mu")),
    _component(getParam<unsigned int>("component"))
{
  _grad_u.resize(3, &_ad_grad_zero);
}

ADReal
Tutorial01Kernel::computeQpResidual()
{
  using SR2 = ADSymmetricRankTwoTensor;

  // Calculate strain from displacement gradients
  auto e = SR2::initializeSymmetric((*_grad_u[0])[_qp], (*_grad_u[1])[_qp], (*_grad_u[2])[_qp]);

  // Calculate stress from strain and material constants
  auto s = _lambda[_qp] * e.trace() * SR2::identity() + 2 * _mu[_qp] * e;

  // Calculate residual
  auto r = _grad_test[_i][_qp] * s.row(_component);

  return r;
}
