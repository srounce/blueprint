# Blueprint

## Introduction

Blueprint aims to ease creation and maintenance of Nix flakes by reducing
boilerplate and the mental overhead involved. It comes with 'batteries included'
so you can focus on *your* configs, rather than all the stuff tying them
together. There are also a few opinions included too but they're widely held
and unobtrusive, and are a good fit [for most common use
cases](https://www.youtube.com/watch?v=k8djas5pIvk).

## How to get started

To get up and running it takes is one command:

```shell
nix flake init -t github:numtide/blueprint
```

This will use our simple template to create a `flake.nix` with the following
contents:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    blueprint.url = "github:numtide/blueprint";
  };
  
  outputs = inputs: inputs.blueprint { inherit inputs; };
}
```

And that's it! Now you've created a flake, congratulations.


## How it works (change this title cos it maybe sucks)

By simply assigning the result of the `mkFlake` function as your flake `outputs`
you can immediately begin to harness the power of Blueprint and get back to
doing the things you care about. A minimal example of which would be the
`flake.nix` above.

In order to accelerate building your flake Blueprint comes with some rules about
how your files should be structured:

### Folder structure

#### hosts/\<hostname\>/[configuruation.nix|darwin-configuration.nix]
    NixOS: inject inputs, flake
#### modules/[common,nixos,darwin,home]/(\<module\>.nix|<name\>/default.nix)

TODO

#### templates/\<name\>.nix

TODO

#### pkgs/\<name\>/(default.nix|package.nix)

* default.nix - perSystem arguments
* package.nix - by-name callPackage style. Right now only takes nixpkgs inputs.


devShells.default - devshell.nix - { pkgs, flake, perSystem, inputs }

## blueprint.lib.mkFlake

Arguments:

* inputs - the flake inputs. Those are getting merged with the blueprint inputs (nixpkgs and systems).
* nixpkgs.config - used to configure nixpkgs.
* prefix - use this if you want to load the blueprint from a directory within the repositiry other than the flake location (default: .).
* systems - use this to set for which systems the flake should be initialized. by default it imports the inputs.systems (see https://github.com/nix-systems/default).


## perSystem stuff

* inputs - flake inputs
* perSystem - a map of input name to per-system packages or legacyPackages.
* system - current system
* flake - shorthand for inputs.self
* lib - pkgs.lib + self.lib (there could be collisions)
* pkgs
    * if nixpkgs.config is passed to the blueprint constructor, a new instance of nixpkgs is created
    * otherwise it take inputs.nixpkgs.legacyPackages.${system}



## Flake checks

TODO: more stuff here
* hosts - systems closures are reported back to the checks checks.<type>
* packages - meta.tests are reported back to the checks.pkgs-<package-name>-<test-name>
