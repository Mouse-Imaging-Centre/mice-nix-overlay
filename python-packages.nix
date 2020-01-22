self: super:

let
  callPackage = super.callPackage;
in
{
  minc2_simple = callPackage python-modules/minc2-simple.nix { };

  minc_stuffs = callPackage python-modules/minc-stuffs.nix { };

  pydpiper = callPackage python-modules/pydpiper.nix { };

  pyminc = callPackage python-modules/pyminc.nix { };

  qbatch = callPackage python-modules/qbatch.nix { };
}
