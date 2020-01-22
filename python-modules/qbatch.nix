{ lib, buildPythonPackage, fetchFromGitHub, nose, six, future, parallel, setuptools }:

buildPythonPackage rec {
  pname   = "qbatch";
  version = "2.1.5";

  src = fetchFromGitHub {
    owner = "pipitone";
    repo  = pname;
    rev   = "v${version}";
    sha256 = "0hi9qczgmwzs8hkf567wgp7fqni73f2qd0sv160a4w68yby0vq0r";
  };

  propagatedBuildInputs = [ six future parallel setuptools ];
  checkInputs = [ nose ];

  checkPhase = "nosetests test";

  doCheck = false;  # qbatch executable not on path/executable, should be easy to fix

  meta = with lib; {
    homepage = "https://github.com/pipitone/qbatch";
    description = "Python interface to HPC schedulers";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.linux;
    license   = licenses.unlicense;
  };
}
