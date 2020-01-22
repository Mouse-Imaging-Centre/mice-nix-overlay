self: super:

let
  callPackage = super.callPackage;
in
{
  minc_stuffs = callPackage python-modules/minc-stuffs.nix { };

  pyminc = callPackage python-modules/pyminc.nix { };

  qbatch = callPackage python-modules/qbatch.nix { };
}
