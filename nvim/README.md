# Alpha-Nvim

[English](#english) | [Español](#español)

## English

### Introduction

Welcome to Alpha-Nvim, my Neovim configuration for 2025. The goal of this configuration is to leverage the best of the Nix ecosystem while being fully functional without it. This is made possible thanks to the excellent work of [nixCats](https://github.com/BirdeeHub/nixCats-nvim) who have created this integration.

### Features

- Seamless integration with Nix.
- Can be used without Nix.
- Automatically handles package management.

### Installation

#### Using Nix

If you use Nix, this configuration includes a flake that you can integrate directly into your setup or run with `nix run`.

#### Without Nix

If you don't use Nix, you can clone this repository like any other configuration. The nixCats wrapper ensures that both approaches will work seamlessly.

### Usage

When starting in a Nix environment, packages already obtained by Nix will not be downloaded by lazy. However, it will still work even if not included with Nix, as lazy will download them.

## Español

### Introducción

Bienvenido a Alpha-Nvim, mi configuración de Neovim para este 2025. El objetivo de esta configuración es obtener lo mejor del mundo de Nix, pero pudiendo funcionar completamente sin él. Esto se logra gracias al excelente trabajo de [nixCats](https://github.com/BirdeeHub/nixCats-nvim) quienes han creado esta integración.

### Características

- Integración perfecta con Nix.
- Puede ser utilizado sin Nix.
- Manejo automático de paquetes.

### Instalación

#### Usando Nix

Si usas Nix, esta configuración incluye un flake que puedes integrar directamente en tu configuración o ejecutar con `nix run`.

#### Sin Nix

Si no usas Nix, puedes clonar este repositorio como cualquier otra configuración. El wrapper de nixCats asegura que ambos enfoques funcionen sin problemas.

### Uso

Cuando iniciamos en un ambiente de Nix, los paquetes ya obtenidos por Nix no serán descargados por lazy. Sin embargo, incluso funcionará si no se incluye con Nix, ya que lazy los descargará.
