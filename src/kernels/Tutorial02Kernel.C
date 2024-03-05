#include "Tutorial02Kernel.h"

registerMooseObject("snailApp", Tutorial02Kernel);

InputParameters
Tutorial02Kernel::validParams()
{
  auto params = ADKernel::validParams();
  params.addClassDescription("Solve the linear momentum balance");
  params.addParam<MaterialPropertyName>("stress", "stress", "The stress to balance");
  params.addRequiredParam<unsigned int>("component", "The residual component");
  return params;
}

Tutorial02Kernel::Tutorial02Kernel(const InputParameters & params)
  : ADKernel(params),
    _s(getADMaterialProperty<RankTwoTensor>("stress")),
    _component(getParam<unsigned int>("component"))
{
}

ADReal
Tutorial02Kernel::computeQpResidual()
{
  return _grad_test[_i][_qp] * _s[_qp].row(_component);
}
