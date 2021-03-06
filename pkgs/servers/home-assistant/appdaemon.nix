{ lib, python3 }:

let
  python = python3.override {
    packageOverrides = self: super: {

      aiohttp = super.aiohttp.overridePythonAttrs (oldAttrs: rec {
        version = "2.3.10";
        src = oldAttrs.src.override {
          inherit version;
          sha256 = "8adda6583ba438a4c70693374e10b60168663ffa6564c5c75d3c7a9055290964";
        };
        # TODO: remove after pinning aiohttp to a newer version
        propagatedBuildInputs = with self; [ chardet multidict async-timeout yarl idna-ssl ];
        doCheck = false;
      });

      yarl = super.yarl.overridePythonAttrs (oldAttrs: rec {
        version = "1.1.0";
        src = oldAttrs.src.override {
          inherit version;
          sha256 = "6af895b45bd49254cc309ac0fe6e1595636a024953d710e01114257736184698";
        };
      });

      jinja2 = super.jinja2.overridePythonAttrs (oldAttrs: rec {
        version = "2.10";
        src = oldAttrs.src.override {
          inherit version;
          sha256 = "f84be1bb0040caca4cea721fcbbbbd61f9be9464ca236387158b0feea01914a4";
        };
      });

      aiohttp-jinja2 = super.aiohttp-jinja2.overridePythonAttrs (oldAttrs: rec {
        version = "0.15.0";
        src = oldAttrs.src.override {
          inherit version;
          sha256 = "0f390693f46173d8ffb95669acbb0e2a3ec54ecce676703510ad47f1a6d9dc83";
        };
      });

      pyyaml = super.pyyaml.overridePythonAttrs (oldAttrs: rec {
        version = "3.13";
        src = oldAttrs.src.override {
          inherit version;
          sha256 = "3ef3092145e9b70e3ddd2c7ad59bdd0252a94dfe3949721633e41344de00a6bf";
        };
      });

    };
  };

in python.pkgs.buildPythonApplication rec {
  pname = "appdaemon";
  version = "3.0.3";

  src = python.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "3e2f5184a51a3b2b473610704344d188226bd7e9a2c2fb762ee90621d38390c6";
  };

  propagatedBuildInputs = with python.pkgs; [
    daemonize astral requests sseclient websocket_client aiohttp yarl jinja2
    aiohttp-jinja2 pyyaml voluptuous feedparser iso8601 bcrypt paho-mqtt
  ];

  # no tests implemented
  doCheck = false;

  meta = with lib; {
    description = "Sandboxed python execution environment for writing automation apps for Home Assistant";
    homepage = https://github.com/home-assistant/appdaemon;
    license = licenses.mit;
    maintainers = with maintainers; [ peterhoeg dotlambda ];
  };
}
