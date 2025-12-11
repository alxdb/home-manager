{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "alxdb";
      user.email = "alxdb@pm.me";
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
