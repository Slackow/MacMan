import tomllib
from pathlib import Path

config = tomllib.loads(Path("Resources/config.toml").read_bytes().decode())

for command, value in config["commands"].items():
    print(command)
    print(value["message"])