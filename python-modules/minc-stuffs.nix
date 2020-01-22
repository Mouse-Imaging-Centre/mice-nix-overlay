{ buildPythonPackage, fetchFromGitHub, stdenv, cmake,
  minc_tools, mni_autoreg, pyminc, netcdf, zlib, hdf5, bicpl,
  numpy, scipy, pytest, m4, autoconf, automake }:

buildPythonPackage rec {
  pname   = "minc-stuffs";
  version = "0.1.25";

  src = fetchFromGitHub {
    owner = "Mouse-Imaging-Centre";
    repo  = pname;
    rev   = "v${version}";
    sha256 = "00dkd8sf5gr5fwzbjrmw0fc0lyvhdb4n9mmrhmfdm6ss0fbznalj";
  };

  # not sure if there's a better way to do this ...
  preConfigure = "./autogen.sh";
  preBuild = "make";
  postInstall = "make install";

  nativeBuildInputs = [ m4 automake autoconf ];
  buildInputs = [ netcdf hdf5 bicpl zlib ];
  propagatedBuildInputs = [ numpy scipy pyminc ];

  doCheck = false;  # no tests?!

  meta = with stdenv.lib; {
    homepage = "https://github.com/Mouse-Imaging-Centre/minc-stuffs";
    description = "Various MINC programs and scripts";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.linux;
    license   = licenses.bsd3;
  };
}
