#include "snailApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
snailApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  return params;
}

snailApp::snailApp(InputParameters parameters) : MooseApp(parameters)
{
  snailApp::registerAll(_factory, _action_factory, _syntax);
}

snailApp::~snailApp() {}

void 
snailApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAllObjects<snailApp>(f, af, s);
  Registry::registerObjectsTo(f, {"snailApp"});
  Registry::registerActionsTo(af, {"snailApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
snailApp::registerApps()
{
  registerApp(snailApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
snailApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  snailApp::registerAll(f, af, s);
}
extern "C" void
snailApp__registerApps()
{
  snailApp::registerApps();
}
