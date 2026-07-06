{
  description = "Convert dconf files (e.g. GNOME) to Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system: function nixpkgs.legacyPackages.${system}
        );
    in
    {
      packages = forAllSystems (pkgs: rec {
        default = import ./default.nix { inherit pkgs; };
        dconf2nix = default;
      });

      devShells = forAllSystems (pkgs: {
        default = import ./shell.nix { inherit pkgs; };
        ci = pkgs.mkShell {
          buildInputs = [ pkgs.nix-build-uncached ];
        };
      });
    };
}
