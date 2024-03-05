#pragma once

#include "ADKernel.h"
#include "DerivativeMaterialInterface.h"

class Tutorial11Kernel : public DerivativeMaterialInterface<ADKernel>
{
public:
  static InputParameters validParams();

  Tutorial11Kernel(const InputParameters &);

protected:
  virtual ADReal computeQpResidual() override;

  const ADMaterialProperty<Real> & _Gc;

  const Real _ell;

  const ADMaterialProperty<Real> & _dw;
};
