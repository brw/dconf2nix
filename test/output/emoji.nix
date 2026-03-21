# Generated via dconf2nix: https://github.com/nix-community/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/Characters" = {
      emoji-in-double-quotes = [ "🔥" ];
      recent-characters = [ "💡" ];
      some-other-character = [ "🤓" ];
    };

  };
}
