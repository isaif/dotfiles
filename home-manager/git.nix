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
}
