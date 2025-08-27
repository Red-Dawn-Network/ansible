{
  description = "Development flake for red-dawn ansible";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          name = "default";
          buildInputs = with pkgs; [
            ansible-lint
          ];
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
