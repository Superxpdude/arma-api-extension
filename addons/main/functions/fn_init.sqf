// sxp_arma_api_fnc_init
// Initializes the arma API addon

// Only run if we're playing in multiplayer
if (!isMultiplayer) exitWith {};

// Check if the config file exists
private _fileExists = ["sxp_arma_api.check_config"] call py3_fnc_callExtension;

if !(_fileExists) exitWith {
	diag_log (text "[SXP_ARMA_API] Missing or invalid config file. Exiting");
};

// Get a mission ID from the API server
sxp_arma_api_mission_id = ["sxp_arma_api.start_mission",[briefingName]] call py3_fnc_callExtension;

if (sxp_arma_api_mission_id < 0) exitWith {
	diag_log (text "[SXP_ARMA_API] Unable to get mission ID from API Server. Exiting");
};

// Start our loop with our mission ID
[sxp_arma_api_mission_id] spawn sxp_arma_api_fnc_main;
