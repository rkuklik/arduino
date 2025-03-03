{
  pkgs ? import <nixpkgs>,
}:
let
  flags = flag: values: map (val: flag + val) values;
  includes = map (path: "${pkgs.arduino-core-unwrapped}/share/arduino/hardware/${path}") [
    "tools/avr/avr/include"
    "arduino/avr/cores/arduino"
    "arduino/avr/variants/standard"
  ];
  warnings = [
    "all"
  ];
  cdefines = [
    "RECODEX_ARDUINO_DEV"
    "UBRRH"
  ];
  baseflag = builtins.concatLists [
    (flags "-I" includes)
    (flags "-W" warnings)
    (flags "-D" cdefines)
  ];
  commands = builtins.concatStringsSep "\n" (
    [
      "-nostdlibinc"
      "-nostdinc++"
      "-xc++"
      "-std=c++17"
    ]
    ++ baseflag
  );
in
pkgs.mkShell {
  packages = with pkgs; [
    arduino-cli
    clang
    clang-tools
    just
    skim
  ];
  shellHook = ''
    arduino-cli core install "arduino:avr"
    echo '${commands}' > 'compile_flags.txt'
  '';
}
