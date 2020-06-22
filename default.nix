self: super:

let
  callPackage = self.callPackage;
  hdf5 = super.hdf5_1_8;
in
rec {

  python37 = super.python37.override { packageOverrides = import ./python-packages.nix; };
  python38 = super.python38.override { packageOverrides = import ./python-packages.nix; };

  python37Packages = super.recurseIntoAttrs python37.pkgs;
  python38Packages = super.recurseIntoAttrs python38.pkgs;

  #hdf5 = super.hdf5_1_8;
  # this rebuilds *everything* using hdf5.
  # On one hand, we don't need to `inherit hdf5` in depending packages.
  # However, everything using hdf5 is rebuilt, including Octave.
  # That's probably not a problem for us but a bit of an invasive change to Nixpkgs ...
  # anyway, let's employ this trick for netcdf:
  netcdf = super.netcdf.override { inherit hdf5; };

  libminc = super.libminc.override { inherit hdf5 netcdf; };

  RMINC = callPackage ./pkgs/RMINC.nix {
    inherit hdf5;
    minc_stuffs = self.python3Packages.minc_stuffs;
    # texLive = super.pkgs.texlive.combine { inherit (super.pkgs.texlive) scheme-small; };
  };

  MRIcrotome = callPackage ./pkgs/MRIcrotome.nix { };
}
