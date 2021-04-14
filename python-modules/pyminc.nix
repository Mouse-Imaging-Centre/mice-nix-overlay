{ lib, buildPythonPackage, fetchFromGitHub, python,
  libminc, minc_tools, conglomerate, mni_autoreg,
  cffi, numpy, pytestCheckHook, parameterized }:

buildPythonPackage rec {
  pname   = "pyminc";
  version = "0.54";

  src = fetchFromGitHub {
    owner  = "Mouse-Imaging-Centre";
    repo   = pname;
    rev    = "v${version}";
    sha256 = "0cjn56cfd2dvgznl1c2m0br4rraxrg6jcknvg5cfxpjprg8hwnra";
  };

  propagatedBuildInputs = [ cffi numpy libminc ];
  checkInputs = [ pytestCheckHook parameterized minc_tools conglomerate mni_autoreg ];

  postPatch = ''
    substituteInPlace pyminc/volumes/libpyminc2.py --replace 'LoadLibrary("' 'LoadLibrary("${libminc}/lib/'
  '';

  meta = with lib; {
    homepage = "https://github.com/Mouse-Imaging-Centre/pyminc";
    description = "Python interface to the MINC 2 library";
    maintainers = with maintainers; [ bcdarwin ];
    license   = licenses.bsd3;
  };
}
