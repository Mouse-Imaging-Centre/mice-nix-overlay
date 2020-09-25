{ lib, stdenv, rPackages, fetchurl }:

let
  inlaDeps = with rPackages;
  [ Matrix
  sp
  Deriv
  devtools
  doParallel
  excursions
  fields
  foreach
  graph
  gridExtra
  HKprocess
  knitr
  markdown
  MatrixModels
  matrixStats
  mvtnorm
  numDeriv
  orthopolynom
  pixmap
  rgdal
  rgl
  Rgraphviz
  rmarkdown
  sn
  splancs
  spdep
  shiny
  ]; in

#inla_bin = fetchTarball {url = "https://inla.r-inla-download.org/Linux-builds/Ubuntu-18.04.3%20LTS%20(Bionic%20Beaver)/Version_19.09.03/64bit.tgz"; sha256 = "1cnv3z5w1n0lk2gani4xwf00h2g1b9z3gxrbpn4fn671kwck48i2";};

rPackages.buildRPackage rec {
  pname = "inla";
  version = "unstable-2019-09-03";
  name = "r-${pname}-${version}";

  # TODO now github.com/hrue/r-inla
  src = fetchurl {
    url = "https://inla.r-inla-download.org/R/testing/src/contrib/INLA_19.07.27.tar.gz";
    sha256 = "451f624571f63212be4ab188a5df1573a286ab9409d86658d47b3f3d3a3dc70f";
  };

  nativeBuildInputs = inlaDeps;
  propagatedBuildInputs = inlaDeps;

  postInstall = ''
    for file in $out/library/INLA/bin/linux/64bit/inla; do 
      chmod +rwx $file
      patchelf --set-interpreter ${stdenv.glibc}/lib/ld-linux-x86-64.so.2 $file
      patchelf --force-rpath --set-rpath $out/library/INLA/bin/linux/64bit $file
    done

    for file in $out/library/INLA/bin/linux/64bit/*.so*; do 
      chmod +rwx $file
      patchelf --force-rpath --set-rpath $out/library/INLA/bin/linux/64bit $file
    done
  '';

  meta = with lib; {
    homepage = "TODO";
    description = "TODO";
    maintainers = with maintainers; [ bcdarwin cfhammill ];
    platforms = platforms.linux;
    license   = licenses.gpl2Plus;  # ??
  };
}
