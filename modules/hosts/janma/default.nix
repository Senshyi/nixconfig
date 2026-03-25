{ self, inputs, ...}: {

  flake.nixosConfigurations.janma = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nixosConfiguration
      self.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.janma = import ./_home/home.nix;
      }
    ];
  };

}
