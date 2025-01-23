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
      theme = {
        mode = "system";
        dark = "Catpuccin Mocha";
      };
      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };
      lsp = {
        rust-analyzer = {
          binary = {
            path_lookup = true;
          };
        };
        nix = {
          binary = {
            path_lookup = true;
          };
        };
        json-language-server = {
          binary = {
            path = lib.getExe pkgs.nodePackages.vscode-json-languageserver;
            arguments = "--stdio";
          };
        };
      };
      vim_mode = true;
      load_direnv = "shell_hook";
    };
  };
}
