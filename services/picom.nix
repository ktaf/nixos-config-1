{
  config,
  lib,
  pkgs,
  ...
}: {
  services.picom = {
    enable = true;
    fade = true;
    backend = "glx";
    blur = true;
    blurExclude = ["class_g = 'dwmsystray'" "class_g = 'conky'" "class_g = 'firefox'"];
    opacityRule = ["100:class_g = 'dwm'"];
    shadow = true;
    shadowOpacity = "0.6";
    shadowExclude = ["class_g = 'dwmsystray'" "class_g = 'conky'"];
    shadowOffsets = [(-17) (-17)];
    inactiveOpacity = "0.95";
    experimentalBackends = true;

    extraOptions = ''
      corner-radius = 9.0;
      rounded-corners-exclude = [
      "class_g = 'dwm'"
      ];
      shadow-radius = 17;
      frame-opacity = 0.7;
      blur-strength = 5;
      blur-method = "kawase";
      blur-kern = "3x3box";
    '';
  };
}
