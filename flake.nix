{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      packages.${system} = {
        blender = pkgs.blender.override {
          cudaSupport = true;
        };
        obs-studio = pkgs.obs-studio.override {
          cudaSupport = true;
        };
      };
    };
}
