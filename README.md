A [Nix](https://github.com/NixOS/nix) overlay containing various medical imaging packages, mostly from MICe or BIC-MNI, which have not been merged to [Nixpkgs](https://github.com/NixOS/nixpkgs).
A Git commit of this repository and of the upstream package set gives you a declarative way to completely specify your software dependencies down to base C libraries.
Some HPC systems now provide Nix, and many others support Singularity containers, which you can build from a Nix derivation
(similar to the Docker instructions in the [manual](https://nixos.org/nixpkgs/manual/#sec-pkgs-dockerTools)).

A few things are missing, currently mostly visualization software such as Display, Register, ITK-snap, etc.

See [the manual](https://nixos.org/nixpkgs/manual/#chap-overlays) for usage instructions.

We may in future publish a recommended package set for medical imaging.

Of course, we welcome contributions including packages and bug reports.
