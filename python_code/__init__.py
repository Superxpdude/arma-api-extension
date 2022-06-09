from typing import List
import requests
import threading
import configparser
import os


def get_config() -> configparser.ConfigParser:
	config = configparser.ConfigParser()
	config.read('userconfig/sxp_arma_api.ini')

	return config


def start_mission(mission_name: str):
	"""Makes an API request to the FastAPI server to start the mission

	Runs synchronously. Waits for a response for the API server before returning.

	Parameters
	----------
	api_key : str
		API Key for the FastAPI server
	mission_name : str
		File name of the mission

	Returns
	-------
	int
		Database ID of the mission on the FastAPI server
	"""

	config = get_config()

	api_key = config.get("SXP_ARMA_API", "api_key", fallback="example_api_key")
	api_server = config.get(
		"SXP_ARMA_API", "api_server", fallback="localhost:8000"
	)

	payload = {"file_name": mission_name}
	headers = {"X-Api-Token": api_key}

	request = requests.post(
		f"http://{api_server}/mission",
		headers=headers,
		json=payload,
		timeout=1
	)

	mission_id = -1

	# Make sure that our mission ID actually exists
	if request.status_code == 201:
		data = request.json()
		if "id" in data:
			mission_id = data["id"]

	return mission_id


def update_mission_thread(mission_id: int, players: List[str]):

	config = get_config()

	api_key = config.get("SXP_ARMA_API", "api_key", fallback="example_api_key")
	api_server = config.get(
		"SXP_ARMA_API", "api_server", fallback="localhost:8000"
	)

	headers = {"X-Api-Token": api_key}
	payload = {"players": players}

	request = requests.patch(
		f"http://{api_server}/mission/{mission_id}",
		headers=headers,
		json=payload,
		timeout=10
	)


def update_mission(mission_id: int, players: List[str]):
	thread = threading.Thread(
		target=update_mission_thread, args=(mission_id, players)
	)
	thread.start()

	return 1
