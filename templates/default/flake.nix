{
  description = "my flake";

  # Add all your dependencies here
  inputs = {
    blueprint.url = "path:../..";
  };

  # Keep the magic invocations to minimum.
  outputs = inputs: inputs.blueprint { inherit inputs; };
}
