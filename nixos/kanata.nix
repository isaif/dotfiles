{ ... }:

{
  services.kanata = {
    enable = true;
    keyboards.default.devices = [ ];
    keyboards.default.configFile = ./kanata.kbd;
  };
}
