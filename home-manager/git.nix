{ ... }:

{
  programs.git = {
    enable = true;
    userName = "isaif";
    userEmail = "saif935775@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes"; # need to input passphrase only once
  };
  services.ssh-agent.enable = true;
}
