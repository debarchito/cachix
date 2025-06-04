## 1. What is this repo about?

This repo builds and caches these packages with custom overrides:

- **Blender** (CUDA support w/o breaking Vulkan experiments)
- **OBS Studio** (CUDA support for hardware encoding i.e. NVENC)

I only plan to support the latest version of these packages available in the
`nixos-unstable` channel for `x86_64-linux`. I will not guarantee caches for any
old versions.

## 2. Can I use it?

Yes, you can, given you trust me enough.

## 3. Cachix

Add the Cachix substituter for binary caches:

```nix
# configuration.nix
nix.settings = {
  substituters = [ "https://debarchito.cachix.org" ];
  trusted-public-keys = [ "debarchito.cachix.org-1:b9I9LSdMFockuXyfljPeoIcJtIVopf9rVkvkIG20PGg=" ];
};
```

## 4. Flakes

Here is an example `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    dcachix.url = "github:debarchito/dcachix";
  };
  outputs = { nixpkgs, dcachix, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ dcachix.overlays.default ]
    };
  in
    {
      # Use "pkgs.blender" or "pkgs.obs-studio" as you usually would.
      # If you don't want to use the overlay, you can always:
      # dcachix.packages.${system}.<pkg-name>
    };
}
```

## 5. License

[MIT](/LICENSE)
