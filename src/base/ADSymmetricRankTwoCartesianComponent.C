#include "ADSymmetricRankTwoCartesianComponent.h"

registerMooseObject("snailApp", ADSymmetricRankTwoCartesianComponent);

InputParameters
ADSymmetricRankTwoCartesianComponent::validParams()
{
  InputParameters params = Material::validParams();
  params.addClassDescription("Access a component of a SymmetricRankTwoTensor");
  params.addRequiredParam<MaterialPropertyName>("tensor",
                                                "The rank two material property tensor name");
  params.addRequiredParam<MaterialPropertyName>(
      "property_name", "Name of the material property computed by this model");
  params.addRequiredRangeCheckedParam<unsigned int>(
      "index_i",
      "index_i >= 0 & index_i <= 2",
      "The index i of ij for the tensor to output (0, 1, 2)");
  params.addRequiredRangeCheckedParam<unsigned int>(
      "index_j",
      "index_j >= 0 & index_j <= 2",
      "The index j of ij for the tensor to output (0, 1, 2)");
  return params;
}

ADSymmetricRankTwoCartesianComponent::ADSymmetricRankTwoCartesianComponent(
    const InputParameters & parameters)
  : Material(parameters),
    _tensor(getADMaterialProperty<SymmetricRankTwoTensor>("tensor")),
    _property(declareADProperty<Real>("property_name")),
    _i(getParam<unsigned int>("index_i")),
    _j(getParam<unsigned int>("index_j"))
{
}

void
ADSymmetricRankTwoCartesianComponent::computeQpProperties()
{
  _property[_qp] = _tensor[_qp](_i, _j);
}
