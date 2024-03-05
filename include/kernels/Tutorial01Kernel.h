#pragma once

#include "ADKernel.h"
#include "RankTwoTensor.h"

class Tutorial01Kernel : public ADKernel
{
public:
  static InputParameters validParams();

  Tutorial01Kernel(const InputParameters &);

protected:
  virtual ADReal computeQpResidual() override;

  std::vector<const ADVariableGradient *> _grad_u;

  const ADMaterialProperty<Real> & _lambda;

  const ADMaterialProperty<Real> & _mu;

  const unsigned int _component;
};
