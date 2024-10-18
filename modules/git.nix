{ username, domain, ... }:
{
  programs.git = {
    enable = true;
    userName = "${username}";
    userEmail = "${username}@${domain}";
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
  programs.gh = {
    enable = username == "alxdb";
    settings = {
      git_protocol = "ssh";
    };
  };
}
