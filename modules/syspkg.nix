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

    #Graphical
    qbittorrent
    krita
    backintime
    firefox
    brave
    vscode-fhs
    haruna

    # programming #MORE LIKE LEARN HOW TO USE COOL SHIT LIKE FLAKES
    zig
    go
    gopls

  ];
}