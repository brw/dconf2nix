{
  pkgs ? import <nixpkgs> { },
  compiler ? "ghc912",
}:
let
  hp = pkgs.haskell.packages.${compiler}.override {
    overrides = newPkgs: oldPkgs: { };
  };
  drv = import ./default.nix { inherit pkgs compiler; };
  update-toc = pkgs.writeShellScriptBin "update-toc" ''
    ${pkgs.lib.getExe pkgs.python314Packages.md-toc} -p -s1 github README.md
  '';
in
hp.shellFor {
  name = "ghc-shell-for-dconf2nix";
  packages = p: [ drv ];
  buildInputs = with hp; [
    cabal-install
    haskell-language-server
    hlint
    update-toc
  ];
  shellHook = ''
    export NIX_GHC="$(which ghc)"
    export NIX_GHCPKG="$(which ghc-pkg)"
    export NIX_GHC_DOCDIR="$NIX_GHC/../../share/doc/ghc/html"
    export NIX_GHC_LIBDIR="$(ghc --print-libdir)"
  '';
}
