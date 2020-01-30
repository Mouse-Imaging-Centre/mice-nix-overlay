{ lib, buildPythonPackage, fetchFromGitHub,
  minc_tools, minc_widgets, minc_stuffs, mni_autoreg, ants, minc2_simple, n3, inormalize, qbatch,
  Pyro4, ordered-set, ConfigArgParse, numpy, networkx, pandas, pyminc, pytest }:

buildPythonPackage rec {
  pname   = "pydpiper";
  version = "2.0.14";

  src = fetchFromGitHub {
    owner = "Mouse-Imaging-Centre";
    repo  = pname;
    rev   = "v${version}";
    sha256 = "1r4s7v3fj36jpn1ixsf8jhh2ww5s0ymk2sjb1vqysbn2k3dk80ad";
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
    homepage = "https://github.com/Mouse-Imaging-Centre/pyminc";
    description = "Python interface to the MINC 2 library";
    maintainers = with maintainers; [ bcdarwin ];
    license   = licenses.free;
  };
}
