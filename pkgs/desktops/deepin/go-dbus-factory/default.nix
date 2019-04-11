{ stdenv, fetchFromGitHub, deepin }:

stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "go-dbus-factory";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "linuxdeepin";
    repo = pname;
    rev = version;
    sha256 = "1i1ymi2qpcbf4d6rnfzrbq5n2vwnn8dvbq9xlw7jls3jpr3d5r00";
  };

  makeFlags = [ "PREFIX=${placeholder ''out''}" ];

  postPatch = ''
    sed -i -e 's:/share/gocode:/share/go:' Makefile
  '';

  passthru.updateScript = deepin.updateScript { inherit name; };

  meta = with stdenv.lib; {
    description = "GoLang DBus factory for the Deepin Desktop Environment";
    homepage = https://github.com/linuxdeepin/go-dbus-factory;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ romildo ];
  };
}
