{ buildPythonPackage, fetchFromGitHub, stdenv, cmake,
  hdf5_1_8, libminc, minc2_simple, minc_tools, mni_autoreg,
  cffi, six, numpy, scipy, pytest }:

buildPythonPackage {
  pname   = "minc2-simple";

  version = "unstable-2019-11-12";
  src = fetchFromGitHub {
    owner  = "vfonov";
    repo   = "minc2-simple";
    rev    = "5cb5c0e8242885f6f6866cbfa9e1a16de5a9e6b6";
    sha256 = "sha256:1fmj237mq1vzbn8px4x9ddv9fspzff11na9ird9gaynhp0k9w9s5";
  };

  cmakeFlags = [ "-DBUILD_TESTING=OFF" "-DLIBMINC_DIR=${libminc}/lib/" ];

  # a bit of a hack to build both C and Python libs:
  preBuild = ''
    cd ../python
  '';

  # note the C tests currently do not run (and would fail due to missing data)

  nativeBuildInputs = [ cmake ];
  propagatedBuildInputs = [ cffi six numpy scipy hdf5_1_8 libminc ];
  checkInputs = [ pytest minc_tools mni_autoreg ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/vfonov/minc2-simple";
    description = "Simple interface to the libminc medical imaging library";
    maintainers = with maintainers; [ bcdarwin ];
    license = licenses.free;
  };
}
