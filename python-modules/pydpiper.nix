{ lib, buildPythonPackage, fetchFromGitHub,
  minc_tools, minc_widgets, minc_stuffs, mni_autoreg, ants, minc2_simple, n3, inormalize, qbatch,
  Pyro4, ordered-set, ConfigArgParse, numpy, networkx, pandas, pyminc, pytest }:

buildPythonPackage rec {
  pname   = "pydpiper";
  version = "2.0.15";

  src = fetchFromGitHub {
    owner = "Mouse-Imaging-Centre";
    repo  = pname;
    rev   = "v${version}";
    sha256 = "05nvjqpnpvrgmglp83sk7mfpipx88givfv3s09fznrn80lxv1fir";
  };

  propagatedBuildInputs = [
    ConfigArgParse
    Pyro4
    networkx
    ordered-set
    pandas
    pyminc
    qbatch
    ants
    minc_tools
    minc_widgets
    minc_stuffs
    minc2_simple
    mni_autoreg
    inormalize
    n3
  ];
  checkInputs = [ pytest ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/Mouse-Imaging-Centre/${pname}";
    description = "Python framework for constructing medical imaging pipelines";
    maintainers = with maintainers; [ bcdarwin ];
    license   = licenses.bsd3;
  };
}
