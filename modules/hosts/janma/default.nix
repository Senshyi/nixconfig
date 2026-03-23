{ self, inputs, ...}: {

  flake.nixosConfigurations.janma = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nixosConfiguration
    ];
  };

}
