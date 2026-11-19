{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        opacity = 0.70;
        padding = {
          x = 10;
          y = 10;
        };
      };

      cursor = {
        style = "Block";
      };

      scrolling = {
        history = 10000;
      };

      colors = {
        primary = {
          background = "#161616";
          foreground = "#f2f4f8";
	  dim_foreground = "#b6b8bb";
	  bright_foreground = "#f9fbff";
       };
	normal = {
        black = "#282828";
        red = "#ee5396";
        green = "#25be6a";
        yellow = "#08bdba";
        blue = "#78a9ff";
        magenta = "#be95ff";
        cyan = "#33b1ff";
        white = "#dfdfe0";
      };
    };
  };
};
}

