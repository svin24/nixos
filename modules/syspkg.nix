{ config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    # General
    fastfetch
    wget
    ffmpeg
    yt-dlp
    psmisc
    htop
    direnv
    toybox
    busybox

    #Graphical
    qbittorrent
    krita
    backintime
    brave
    haruna
    nextcloud-client

    # programming #MORE LIKE LEARN HOW TO USE COOL SHIT LIKE FLAKES
    #zig
    #go
    #gopls

  ];
}
