{ ... }: {
  programs.git = {
    enable = true;
    userName = "Alexander Davidson Bryan";
    userEmail = "alxdb@pm.me";
    extraConfig = {
      init.defaultBranch = "main";
      diff.tool = "nvimdiff";
      safe.directory = "*";
    };
    ignores = [ ".envrc" ".direnv" ];
  };
  programs.gh = {
    enable = true;
    settings = { git_protocol = "ssh"; };
  };
  programs.ssh.enable = true;
  services.ssh-agent.enable = true;
}
