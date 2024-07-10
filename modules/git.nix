{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Alexander Davidson Bryan";
    userEmail = "alxdb@pm.me";
    aliases = {
      s = "status";
      c = "commit";
      ca = "commit -a";
      b = "checkout -b";
      d = "difftool";
      p = "push";
    };
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
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
  programs.ssh.enable = true;
  services.ssh-agent.enable = true;
  programs.lazygit = {
    enable = true;
    catppuccin.enable = true;
  };
}
