{
  pkgs ? import <nixpkgs> { },
  compiler ? "ghc912",
}:
let
  hp = pkgs.haskell.packages.${compiler}.override {
    overrides = newPkgs: oldPkgs: { };
  };
in
hp.callCabal2nix "dconf2nix" ./. { }
