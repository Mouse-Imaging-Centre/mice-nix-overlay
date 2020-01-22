{ lib, buildPythonPackage, fetchFromGitHub,
  libminc, minc_tools, conglomerate, mni_autoreg,
  cffi, numpy, pytest }:

buildPythonPackage rec {
  pname   = "pyminc";
  version = "0.52";

  src = fetchFromGitHub {
    owner = "Mouse-Imaging-Centre";
    repo  = pname;
    rev   = "v${version}";
    sha256 = "1cls58cnjbrlyq2yygz3kyrzkinkkrs8fa83d02sbwg7ymyyqr27";
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
    platforms = platforms.linux;
    license   = licenses.free;
  };
}
