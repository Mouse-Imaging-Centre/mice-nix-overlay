self: super:

rec {

  python36 = super.python36.override { packageOverrides = import ./python-packages.nix; };
  python37 = super.python37.override { packageOverrides = import ./python-packages.nix; };
  python38 = super.python38.override { packageOverrides = import ./python-packages.nix; };
  python36Packages = python36.pkgs;
  python37Packages = super.recurseIntoAttrs python37.pkgs;
  python38Packages = super.recurseIntoAttrs python38.pkgs;

  RMINC = super.callPackage pkgs/RMINC.nix { minc_stuffs = python37Packages.minc_stuffs; };
}
