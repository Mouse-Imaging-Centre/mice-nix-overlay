self: super:

let
  callPackage = self.callPackage;
in
{
  minc2_simple = callPackage python-modules/minc2-simple.nix { };

  # minc_stuffs is now in default.nix since it's an application

  pydpiper = callPackage python-modules/pydpiper.nix { };

  pyminc = callPackage python-modules/pyminc.nix { };

  qbatch = callPackage python-modules/qbatch.nix { };
}
