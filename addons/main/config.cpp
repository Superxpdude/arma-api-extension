#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"PY3_Pythia"};
		author = MOD_AUTHOR;
		url = MOD_URL;
		version = VERSION;
		versionStr = QUOTE(VERSION_STR);
		versionAr[] = {VERSION_AR};
	};
};
