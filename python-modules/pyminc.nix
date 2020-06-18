{ lib, buildPythonPackage, fetchFromGitHub, python,
  libminc, minc_tools, conglomerate, mni_autoreg,
  cffi, numpy, pytest }:

buildPythonPackage rec {
  pname   = "pyminc";
  version = "0.53";

  src = fetchFromGitHub {
    owner  = "Mouse-Imaging-Centre";
    repo   = pname;
    rev    = "v${version}";
    sha256 = "1alqmzlbcq7imz7vyslk395pn3i7z6pyli64fpxcifwps97999kf";
  };

  propagatedBuildInputs = [ cffi numpy libminc ];
  checkInputs = [ pytest minc_tools conglomerate mni_autoreg ];

  postPatch = ''
    substituteInPlace pyminc/volumes/libpyminc2.py --replace 'LoadLibrary("' 'LoadLibrary("${libminc}/lib/'
  '';

  checkPhase = ''
    pytest test/generatorTests.py
  '';  # some flakiness, e.g. testReadWrite sometimes fails with a 'Hyperslab doesn't define __round__' error

  meta = with lib; {
    homepage = "https://github.com/Mouse-Imaging-Centre/pyminc";
    description = "Python interface to the MINC 2 library";
    maintainers = with maintainers; [ bcdarwin ];
    license   = licenses.bsd3;
  };
}
