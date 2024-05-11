{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell rec {
    nativeBuildInputs = with pkgs; [
      clang
      gcc
      llvmPackages_latest.bintools
      pkg-config
      odin
    ];

    buildInputs = with pkgs; [
#      libffi
#      libGL

      libxkbcommon
      fontconfig
      wayland
      xwayland
    ];


    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${
      with pkgs; lib.makeLibraryPath buildInputs
    }";

    LIBCLANG_PATH = pkgs.lib.makeLibraryPath [
      pkgs.llvmPackages_latest.libclang.lib
    ];
  }
