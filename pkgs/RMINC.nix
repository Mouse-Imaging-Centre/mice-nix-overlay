{ lib, rPackages, fetchFromGitHub, zlib, hdf5, libminc, minc_stuffs}:

rPackages.buildRPackage rec {
  pname   = "RMINC";
  version = "1.5.2.2";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "Mouse-Imaging-Centre";
    repo  = pname;
    rev   = "v${version}";
    sha256 = "0yvdpb1nd6xw9q0m33d1ka6ncxrqy48vk0qn19bb6nkhczcd5wn4";
  };

  propagatedBuildInputs = [ zlib hdf5 libminc minc_stuffs ] ++ (with rPackages; [
    tidyverse lme4 batchtools Rcpp
    shiny gridBase data_tree visNetwork rjson DT
    rgl igraph qvalue lmerTest
  ]);

  meta = with lib; {
    homepage = "https://github.com/Mouse-Imaging-Centre/RMINC";
    description = "R interface to the MINC 2 library";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.linux;
    license   = licenses.bsd3;
  };
}
