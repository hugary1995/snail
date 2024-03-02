#pragma once

#include "ADKernel.h"
#include "SymmetricRankTwoTensor.h"

class Tutorial02Kernel : public ADKernel
{
public:
  static InputParameters validParams();

  Tutorial02Kernel(const InputParameters &);

protected:
  virtual ADReal computeQpResidual() override;

  const ADMaterialProperty<SymmetricRankTwoTensor> & _s;

  const unsigned int _component;
};
