{ lib, rPackages, fetchFromGitHub, RMINC }:

rPackages.buildRPackage rec {
  pname   = "MRIcrotome";
  version = "unstable-2018-06-03";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "Mouse-Imaging-Centre";
    repo  = pname;
    rev   = "c20fe274662fc665d229aee5f304cf84782d515f";
    sha256 = "1rq3yhb2i7mf326xclmhrlpmkjp98xm28xw44kiw6rwdrxgjqzm2";
  };

  propagatedBuildInputs = with rPackages; [ RMINC tidyverse ];

  meta = with lib; {
    homepage = "https://github.com/Mouse-Imaging-Centre/MRIcrotome";
    description = "R package for MRI data visualization";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.linux;
    license   = licenses.bsd3;
  };
}
