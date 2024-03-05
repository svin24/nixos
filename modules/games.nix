{config, pkgs, ...}:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    prismlauncher
    bottles
    pcsx2
    #ryujinx #installs a bunch of crap so don't bother use nix-ld
  ];

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; 
  dedicatedServer.openFirewall = true; 
  gamescopeSession.enable = true;
  };
}