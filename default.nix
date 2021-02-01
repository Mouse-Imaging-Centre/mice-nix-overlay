self: super:

let
  callPackage = self.callPackage;
in
rec {

  python37 = super.python37.override { packageOverrides = import ./python-packages.nix; };
  python38 = super.python38.override { packageOverrides = import ./python-packages.nix; };
  python39 = super.python39.override { packageOverrides = import ./python-packages.nix; };
  python3 = python38;

  # can we define python3Packages to refer to the version defined in Nixpkgs?
  python37Packages = super.recurseIntoAttrs python37.pkgs;
  python38Packages = super.recurseIntoAttrs python38.pkgs;
  python39Packages = super.recurseIntoAttrs python39.pkgs;
  python3Packages = python38Packages;

  # should this be wrapped in toPythonApplication?
  minc_stuffs = callPackage ./pkgs/minc-stuffs.nix {
    inherit (python3Packages) buildPythonPackage numpy scipy pyminc pytest;
  };

  RMINC = callPackage ./pkgs/RMINC.nix { };

  MRIcrotome = callPackage ./pkgs/MRIcrotome.nix { };
}
