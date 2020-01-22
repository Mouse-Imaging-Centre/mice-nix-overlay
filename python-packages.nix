self: super:

let
  callPackage = super.callPackage;
in
{
  pyminc = callPackage python-modules/pyminc.nix { };

  qbatch = callPackage python-modules/qbatch.nix { };
}
