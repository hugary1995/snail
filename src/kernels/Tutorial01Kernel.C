#include "Tutorial01Kernel.h"

// REMOVE_BEGIN
registerMooseObject("snailApp", Tutorial01Kernel);
// REMOVE_END

InputParameters
Tutorial01Kernel::validParams()
{
  auto params = ADKernel::validParams();
  // REMOVE_BEGIN
  params.addClassDescription("Solve the linear momentum balance for a linear elastic material");
  params.addRequiredCoupledVar("displacements", "Displacement variables");
  params.addRequiredParam<MaterialPropertyName>("lambda", "Lame's first parameter");
  params.addRequiredParam<MaterialPropertyName>("mu", "Shear modulus");
  params.addRequiredParam<unsigned int>("component", "The residual component");
  // REMOVE_END
  return params;
}

Tutorial01Kernel::Tutorial01Kernel(const InputParameters & params)
  : ADKernel(params)
    // REMOVE_BEGIN
    ,
    _grad_u(adCoupledGradients("displacements")),
    _lambda(getADMaterialProperty<Real>("lambda")),
    _mu(getADMaterialProperty<Real>("mu")),
    _component(getParam<unsigned int>("component"))
// REMOVE_END
{
  // REMOVE_BEGIN
  _grad_u.resize(3, &_ad_grad_zero);
  // REMOVE_END
}

// REMOVE_BEGIN
ADReal
Tutorial01Kernel::computeQpResidual()
{
  using R2 = ADRankTwoTensor;

  // Calculate strain from displacement gradients
  auto G = R2((*_grad_u[0])[_qp], (*_grad_u[1])[_qp], (*_grad_u[2])[_qp]);
  auto e = (G.transpose() + G) / 2;

  // Calculate stress from strain and material constants
  auto s = _lambda[_qp] * e.trace() * R2::Identity() + 2 * _mu[_qp] * e;

  // Calculate residual
  auto r = _grad_test[_i][_qp] * s.row(_component);

  return r;
}
// REMOVE_END
