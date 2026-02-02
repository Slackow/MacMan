import tomllib
from pathlib import Path

config = tomllib.loads(Path("Resources/config.toml").read_bytes().decode())

contents = """
# Mac FAQ, commands from MacMan bot
"""

for command, value in config["commands"].items():
    contents += f"## {command}\n"
    contents += f"{value["message"]}\n"

Path("guide.md").write_text(contents)