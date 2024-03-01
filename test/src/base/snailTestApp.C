//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "snailTestApp.h"
#include "snailApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"

InputParameters
snailTestApp::validParams()
{
  InputParameters params = snailApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  return params;
}

snailTestApp::snailTestApp(InputParameters parameters) : MooseApp(parameters)
{
  snailTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

snailTestApp::~snailTestApp() {}

void
snailTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  snailApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"snailTestApp"});
    Registry::registerActionsTo(af, {"snailTestApp"});
  }
}

void
snailTestApp::registerApps()
{
  registerApp(snailApp);
  registerApp(snailTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
snailTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  snailTestApp::registerAll(f, af, s);
}
extern "C" void
snailTestApp__registerApps()
{
  snailTestApp::registerApps();
}
