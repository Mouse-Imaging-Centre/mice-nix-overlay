{ lib, rPackages, fetchFromGitHub, fetchzip
, zlib, hdf5, libminc, conglomerate, minc_tools, minc_stuffs }:

rPackages.buildRPackage rec {
  pname   = "RMINC";
  version = "1.5.2.3";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "Mouse-Imaging-Centre";
    repo = pname;
    rev = "v${version}";
    sha256 = "0vl5yk48c1fm8szxvpbaqy8q2qwcllksq4zvb7rcn2dw8g6nbg63";
  };

  test_data = fetchzip {
    url = "https://wiki.mouseimaging.ca/download/attachments/1654/rminctestdata.tar.gz";
    sha256 = "1a51s3zp5arh0qljhsdn8jc0sk1xiy2h0sispnr1qm0bkrbazdy3";
  };

  propagatedBuildInputs = [ zlib hdf5 libminc minc_tools minc_stuffs conglomerate ] ++
  (with rPackages; [
    tidyverse lme4 batchtools Rcpp
    shiny gridBase data_tree visNetwork rjson DT
    rgl igraph qvalue lmerTest bigstatsr
  ]);

  installCheckInputs = [ rPackages.testthat ];

  installCheckPhase = ''
    R CMD build .
    (mkdir build_tmp  
     cd build_tmp
     cp -r ${test_data} rminctestdata
     chmod -R +w rminctestdata
     tar -czf rminctestdata.tar.gz rminctestdata
     cp rminctestdata.tar.gz ..
    )
    export TEST_Q_MINC="no"
    export RMINC_DATA_DIR=$(pwd)
    R CMD check --as-cran --no-install RMINC*.tar.gz
    cat RMINC.Rcheck/00check.log         
    Rscript -e "\
    testr <- devtools::test(); \
    testr <- as.data.frame(testr); \
    if(any(testr\$error) || any(testr\$warning > 0)) \
      stop('Found failing tests') \
    "
    pass=$?
    if [[ $pass -ne 0 || $(grep "WARNING\|ERROR" RMINC.Rcheck/00check.log) != "" ]]; then
      (exit 1)
    else
      (exit 0)
    fi
  '';
  # not the usual way to test packages, but `R CMD check .` by itself fails on the DESCRIPTION file,
  # and `R CMD build .; R CMD check ./RMINC_1.5.2.2.tar.gz` triggers a rebuild from the tarball

  #doInstallCheck = true;

  meta = with lib; {
    homepage = "https://github.com/Mouse-Imaging-Centre/RMINC";
    description = "R interface to the MINC 2 library";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.linux;
    license   = licenses.bsd3;
  };
}
