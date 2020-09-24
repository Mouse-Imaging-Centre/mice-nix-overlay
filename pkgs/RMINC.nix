{ lib, R, rPackages, fetchFromGitHub, fetchzip
  , zlib, hdf5, libminc, conglomerate, minc_tools, minc_stuffs
  , pandoc, checkbashisms
}:

rPackages.buildRPackage rec {
  pname   = "RMINC";
  version = "1.5.2.3";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "Mouse-Imaging-Centre";
    repo = pname;
    rev = "d1b5647d6c47a94b3e613292067e45fda732c259";
    sha256 = "1lqa7r0rlwwprpcxrwz7q1vcgy3s6bmmkim90khzd34lh3k9kgm5";
  };

  test_data = fetchzip {
    url = "https://wiki.mouseimaging.ca/download/attachments/1654/rminctestdata2.tar.gz";
    sha256 = "1nrz2aa4h8zc1iqxx4yjnnk9im4cvs5faglcnbrq6h3si8scfqkb";
  };

  propagatedBuildInputs = [ R zlib hdf5 libminc minc_tools minc_stuffs conglomerate pandoc ] ++
  (with rPackages; [
    tidyverse lme4 batchtools Rcpp
    shiny gridBase data_tree visNetwork rjson DT
    rgl igraph qvalue lmerTest bigstatsr
    devtools
  ]);

  installCheckInputs = [ checkbashisms rPackages.testthat ];

  installCheckPhase = ''
    R CMD build .
    R CMD check --no-manual --as-cran --no-install RMINC*.tar.gz
    cat RMINC.Rcheck/00check.log         

    # Set up test data
    (mkdir build_tmp  
     cd build_tmp
     cp -r ${test_data} rminctestdata
     chmod -R +w rminctestdata
     tar -czf rminctestdata.tar.gz rminctestdata
     cp rminctestdata.tar.gz ..
    )

    # Run the test bed
    export RMINC_DATA_DIR=$PWD
    Rscript -e "\
    library(RMINC); \
    options(stringsAsFactors = TRUE); \
    testr <- RMINC::runRMINCTestbed(test_q_minc = FALSE); \
    testr <- as.data.frame(testr); \
    if(any(testr\$error) || any(testr\$warning > 0)) \
      stop('Found failing tests') \
    "
    pass=$?

    # Report pass if all tests pass and no warnings or errors in check
    if [[ $pass -ne 0 || $(grep "WARNING\|ERROR" RMINC.Rcheck/00check.log) != "" ]]; then
      (exit 1)
    else
      (exit 0)
    fi
  '';
  # not the usual way to test packages, but `R CMD check .` by itself fails on the DESCRIPTION file,
  # and `R CMD build .; R CMD check ./RMINC_1.5.2.2.tar.gz` triggers a rebuild from the tarball

  doInstallCheck = true;

  meta = with lib; {
    homepage = "https://github.com/Mouse-Imaging-Centre/RMINC";
    description = "R interface to the MINC 2 library";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.linux;
    license   = licenses.bsd3;
  };
}
