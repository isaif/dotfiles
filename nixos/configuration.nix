# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  # .UTF-8 is required for glyphs support in nerdfonts
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.saif = {
    isNormalUser = true;
    description = "saif";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];     

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim-full
    pwvucontrol
    wget
    curl
    google-chrome
    kanata
    gnumake
    gcc
  ];

  environment.variables.EDITOR = "vim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.firefox.enable = true;

  environment.shells = with pkgs; [bash zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = ["git" "fzf"];
  };

  # List services that you want to enable:
  services.udisks2.enable = true;

  services.kanata = {
  enable = true;
  keyboards.default.devices = [ ];
  keyboards.default.config = ''
    (defsrc
      esc  1    2    3    4    5    6    7    8    9    0    -    =    bspc
      tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
      caps a    s    d    f    g    h    j    k    l    ;    '    ret
      lsft z    x    c    v    b    n    m    ,    .    /    rsft
      lctl lmet lalt           spc            ralt rmet rctl
    )


    ;; defvar can be used to declare commonly-used values
    (defvar
      tap-timeout   100
      hold-timeout  200
      tt $tap-timeout
      ht $hold-timeout
    )

    (defalias
      lay (layer-toggle layers)
      arrows (layer-toggle arrows)
      qwr (layer-switch qwerty)
      grl (tap-hold $tt $ht grv @lay) ;; tap: grave  hold: layers layer
      th1 (tap-hold $tt $ht esc lctl)
      th2 (tap-hold $tt $ht spc lsft)

      sSft (tap-hold-release $tt $ht s lsft)
      dMet (tap-hold-release $tt $ht d lmet)
      fCtl (tap-hold-release $tt $ht f lctl)
      jCtl (tap-hold-release $tt $ht j rctl)
      kMet (tap-hold-release $tt $ht k rmet)
      lSft (tap-hold-release $tt $ht l rsft)

      vAlt (tap-hold-release $tt $ht v lalt)
      nAlt (tap-hold-release $tt $ht n ralt)
      spcNum (tap-hold-release $tt $ht spc @arrows)
    )

    ;; The first layer defined is the layer that will be active by default when
    ;; kanata starts up. This layer is the standard QWERTY layout except for the
    ;; backtick/grave key (@grl) which is an alias for a tap-hold key.
    ;;
    ;; There are currently a maximum of 25 layers allowed.
    (deflayer qwerty
      @grl 1    2    3    4    5    6    7    8    9    0    -    =    bspc
      tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
      @th1 a    @sSft    @dMet    @fCtl    g    h    @jCtl    @kMet    @lSft    ;    '    ret
      lsft z    x    c    @vAlt    b    @nAlt    m    ,    .    /    rsft
      lctl lmet lalt           @spcNum            ralt rmet rctl
    )

    ;; The `lrld` action stands for "live reload". This will re-parse everything
    ;; except for linux-dev. So in Linux, you cannot live reload and switch keyboard
    ;; devices at the time of writing. The variants `lrpv` and `lrnx` will cycle
    ;; between multiple configuration files, if they are specified in the startup.
    ;; arguments.
    ;;
    ;; Upon a successful reload, the kanata state will begin on the default base layer
    ;; in the configuration. E.g. in this example configuration, you would start on
    ;; the qwerty layer.
    (deflayer layers
      _    @qwr    _   lrld  _    _    _    _    _    _    _    _    _    _
      _    _    _    _    _    _    _    _    _    _    _    _    _    _
      _    _    _    _    _    _    _    _    _    _    _    _    _
      _    _    _    _    _    _    _    _    _    _    _    _
      _    _    _              _              _    _    _
    )

    (deflayer arrows
      _    f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  _
      _    _    _    _    _    _    _    _ home   end _    _    _    _
      _    _    _    _    _    _    left down up rght _  del    _
      _    _    _    _    _    _    bspc    del    _    _    _    _
      _    _    _              _              _    _    _
    )

    '';
  };

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
