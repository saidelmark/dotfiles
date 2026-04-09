{ lib, ... }:
{
  options.nixfiles.programs.tmux = {
    enable = lib.mkEnableOption "tmux";
  };
}
