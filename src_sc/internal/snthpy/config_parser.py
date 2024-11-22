""" Parses config files for 381 toolflow.

This parser works by parsing both the internal/.config.ini file and 
an optional user file "config.ini". The custom ini files consists of or more
sections. To use these sections, the command line option -c <config> must be passed to
both the test and synthesis framework.

Author:
    Braedon Giblin

Date:
    2022.03.07

File.
    config_parser.py
"""

from configparser import ConfigParser
from collections import namedtuple
from pathlib import Path
import os
import json


CONFIG = namedtuple("CONFIG", "modelsim quartus license mars_tok tf_tok mars_id tf_id mars_path")

def read_config(config="Lab"):
    """
    Reads both the default config (internal/.config.ini) and the optional
    custom config, returning a named tuple with the specified options.

    Args:
        config: Optional configuration file to use

    Returns:
        tuple

    """
    
    def_config = Path("internal/.config.ini").resolve()
    opt_config = Path("config.ini").resolve()
    cus_config = Path(config).resolve()

    c = ConfigParser()

    if not def_config.is_file():
        print("Default configuration file internal/.config.ini not found."
               "Please re-install toolflow or replace the file")

    c.read(def_config)

    if opt_config.is_file():
        print("Using optional config config.ini")
        c.read(opt_config)

    if not c.has_section(config):
        print(f"Error. Section {config} does not exists")
        exit(1)

    modelsim = resolve_paths(json.loads(c.get(config, "modelsim_paths")))
    if modelsim is None:
        print("WARN: Modelsim is not found with any of the provided paths. "
              "Please check your config file, or specify a new config")
    quartus = resolve_paths(json.loads(c.get(config, "quartus_paths")))
    if quartus is None:
        print("WARN: Quartus is not found with any of the provided paths. "
              "Please check your config file, or specify a new config")
    license = json.loads(c.get(config, "lm_license_file"))
    mars_tok = json.loads(c.get(config, "mars_token"))
    tf_tok = json.loads(c.get(config, "toolflow_token"))
    mars_id = json.loads(c.get(config, "mars_prj_id"))
    tf_id = json.loads(c.get(config, "toolflow_prj_id"))
    mars_path = json.loads(c.get(config, "mars_path"))
    ret = CONFIG(modelsim, quartus, license, mars_tok, tf_tok, mars_id, tf_id, mars_path)

    # After we have parsed the config, update the environmental variables.

    env = os.environ.copy()
    if (json.loads(c.get(config, "needs_license"))):
        env["LM_LICENSE_FILE"] = os.pathsep.join(license) + os.pathsep + env.get("lm_license_file", "")

    return ret, env

def resolve_paths(path_list):
    """ Takes a list of paths, and returns the one that actually exists

    Args:
        List of path strings

    Returns:
        Patht that exists
    """
    for path in path_list:
        if Path(path).resolve().exists():
            return path
    
    return None

if __name__ == "__main__":
    from pprint import pprint
    con, env = read_config("CICD")
    
    pprint(con)
    pprint(env["lm_license_file"])

