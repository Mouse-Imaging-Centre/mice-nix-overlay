{ lib, buildPythonPackage, fetchFromGitHub, python,
  libminc, minc_tools, conglomerate, mni_autoreg,
  cffi, numpy, pytestCheckHook }:

buildPythonPackage rec {
  pname   = "pyminc";
  version = "0.53.3";

  src = fetchFromGitHub {
    owner  = "Mouse-Imaging-Centre";
    repo   = pname;
    rev    = "v${version}";
    sha256 = "0wvq51qyzc52mxyrhmqqzyvwgldf513fypipjzh06rf6nfqddggs";
  };

  propagatedBuildInputs = [ cffi numpy libminc ];
  checkInputs = [ pytestCheckHook minc_tools conglomerate mni_autoreg ];

  postPatch = ''
    substituteInPlace pyminc/volumes/libpyminc2.py --replace 'LoadLibrary("' 'LoadLibrary("${libminc}/lib/'
  '';

  pytestFlagsArray = [ "test/generatorTests.py" ];

  meta = with lib; {
    homepage = "https://github.com/Mouse-Imaging-Centre/pyminc";
    description = "Python interface to the MINC 2 library";
    maintainers = with maintainers; [ bcdarwin ];
    license   = licenses.bsd3;
  };
}
