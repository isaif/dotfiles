{ pkgs, ... }:
let
  awesome = pkgs.awesome.overrideAttrs (oa: {
    version = "ad0290bc1aac3ec2391aa14784146a53ebf9d1f0";
    src = pkgs.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "ad0290bc1aac3ec2391aa14784146a53ebf9d1f0";
      #hash = "sha256-zCxghNGk/GsSt2+9JK8eXRySn9pHXaFhrRU3OtFrDoA=";
      hash = "sha256-uaskBbnX8NgxrprI4UbPfb5cRqdRsJZv0YXXshfsxFU=";
    };

    patches = [ ];

    postPatch = ''
      patchShebangs tests/examples/_postprocess.lua
    '';
  });
in
{
  services.xserver = {
    enable = true;
    autorun = false;
    displayManager = {
      defaultSession = "none+awesome";
      startx.enable = true;
    };
    windowManager.awesome = {
      enable = true;
      package = awesome;
    };
  };

}
