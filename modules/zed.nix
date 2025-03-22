{ pkgs, lib, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "make"
      "catpuccin"
    ];
    userSettings = {
      buffer_font_family = "Iosevka Comfy Wide Fixed";
      buffer_font_fallbacks = [ "Symbols Nerd Font Mono" ];
      ui_font_family = "Iosevka Comfy Wide Fixed";
      lsp = {
        rust-analyzer = {
          binary = {
            path_lookup = true;
          };
        };
        nil = {
          binary = {
            path = lib.getExe pkgs.nil;
          };
          settings = {
            formatting.command = [ (lib.getExe' pkgs.nixfmt-rfc-style "nixfmt") ];
          };
        };
        nixd = {
          binary = {
            path = lib.getExe pkgs.nixd;
          };
        };
      };
      vim_mode = true;
      load_direnv = "shell_hook";
    };
  };
}
