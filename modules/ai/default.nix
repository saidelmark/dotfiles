{
  config,
  pkgs,
  nixgl,
  ...
}:
let
  llama = config.lib.nixGL.wrap (pkgs.llama-cpp.override { vulkanSupport = true; });

  model = "${config.home.homeDirectory}/models/gpt-oss-20b-mxfp4.gguf";
in
{
  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa"; # AMD идёт через Mesa (RADV)
  nixGL.vulkan.enable = true; # по умолчанию выключено
  nixGL.installScripts = [ "mesa" ]; # даёт команду nixGLMesa для ручных запусков
  targets.genericLinux.gpu.enable = true;
  targets.genericLinux.nixGL.vulkan.enable = true;

  home = {
    services.ollama = {
      enable = true;
      acceleration = "vulkan";
    };
    programs.opencode.enable = true;
  };
}
