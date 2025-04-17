{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs =
    { self
    , flake-utils
    , nixpkgs
    , ...
    }: {
      devShells.x86_64-linux.default =
        let
          pkgs = import nixpkgs {
            system = "x86_64-linux";
          };
          pythonPackages =
            p: with p; [
              pip
              pip-tools
              numpy
              pytest
              boto3
            ];
        in
        pkgs.mkShell {
          packages = with pkgs; [
            (pkgs.wrapHelm pkgs.kubernetes-helm {
              plugins = [
                pkgs.kubernetes-helmPlugins.helm-diff
              ];
            })
            pur
            kubectl
            jq
            helmfile-wrapped
            (pkgs.python312.withPackages pythonPackages)
          ];
        };
    };
}
