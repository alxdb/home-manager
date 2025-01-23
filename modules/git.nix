{ ... }:
{
  programs.git = {
    enable = true;
    userName = "alxdb";
    userEmail = "alxdb@pm.me";
    extraConfig = {
      init.defaultBranch = "main";
      diff.tool = "nvimdiff";
      safe.directory = "*";
    };
    ignores = [
      ".envrc"
      ".direnv"
    ];
  };
}
