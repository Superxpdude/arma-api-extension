// sxp_arma_api_fnc_main
// Main function for the Arma API addon

sxp_arma_api_enabled = true;

sxp_arma_api_missionEndedEH = addMissionEventHandler ["MPEnded", {
		sxp_arma_api_enabled = false;
	}
];

private _sxp_arma_api_nextExecutionTime = cba_missionTime;

while {sxp_arma_api_enabled and (sxp_arma_api_mission_id >= 0)} do {
	private _playerIDList = allPlayers apply {getPlayerUID _x};
	["sxp_arma_api.update_mission",[sxp_arma_api_mission_id, _playerIDList]] call py3_fnc_callExtension;

	// Wait 15 seconds until next execution
	_sxp_arma_api_nextExecutionTime = cba_missionTime + 15;
	waitUntil {cba_missionTime >= _sxp_arma_api_nextExecutionTime};
};
