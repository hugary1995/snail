#include "Tutorial11Kernel.h"

// REMOVE_BEGIN
registerMooseObject("snailApp", Tutorial11Kernel);
// REMOVE_END

InputParameters
Tutorial11Kernel::validParams()
{
  auto params = ADKernel::validParams();
  params.addClassDescription("Solve the fracture propagation envelope");
  params.addParam<MaterialPropertyName>(
      "crit_energy_rel_rate", "Gc", "The critical energy release rate");
  params.addRequiredParam<Real>("reg_length", "The phase field regularization length");
  params.addParam<MaterialPropertyName>(
      "strain_energy_density", "w", "The strain energy density driving fracture propagation");
  return params;
}

Tutorial11Kernel::Tutorial11Kernel(const InputParameters & params)
  : DerivativeMaterialInterface<ADKernel>(params),
    _Gc(getADMaterialProperty<Real>("crit_energy_rel_rate")),
    _ell(getParam<Real>("reg_length")),
    _dw(getMaterialPropertyDerivative<Real, true>(
        getParam<MaterialPropertyName>("strain_energy_density"), _var.name()))
{
}

// REMOVE_BEGIN
ADReal
Tutorial11Kernel::computeQpResidual()
{
  // Fracture geometric function
  auto r_g = _test[_i][_qp] * 0.375 * _Gc[_qp] / _ell;

  // Fracture regularization
  auto grad_d = _grad_u[_qp];
  auto r_r = _grad_test[_i][_qp] * 0.75 * _Gc[_qp] * _ell * grad_d;

  // Fracture driving force
  auto r_d = _test[_i][_qp] * _dw[_qp];

  return r_g + r_r + r_d;
}
// REMOVE_END
