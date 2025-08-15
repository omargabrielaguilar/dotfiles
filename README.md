# Neovim Configuration – biignoisee

Este repositorio contiene mi configuración personal de **Neovim** orientada a desarrollo moderno, con soporte completo para **PHP**, **Laravel**, **TypeScript**, **Vue** y herramientas de refactorización avanzada. Está pensada para reemplazar IDEs tradicionales y optimizar flujos de trabajo con plugins de alta calidad y configuraciones personalizadas.

---

## Estructura del repositorio

.
├── after/
│ └── ftplugin/
│ ├── markdown.lua # Configuración específica para Markdown
│ └── php.lua # Configuración específica para PHP
├── init.lua # Entrada principal de Neovim
├── lazy-lock.json # Lockfile de lazy.nvim
└── lua/
├── biignoisee/
│ ├── core/
│ │ ├── init.lua # Inicialización de core
│ │ ├── keymaps.lua # Mapeos de teclas personalizados
│ │ └── options.lua # Opciones globales de Neovim
│ ├── lazy.lua # Configuración de lazy.nvim
│ ├── plugins/
│ │ ├── auto-pairs.lua
│ │ ├── colorscheme.lua
│ │ ├── conform.lua
│ │ ├── debugger.lua
│ │ ├── gitstuff.lua
│ │ ├── incline.lua
│ │ ├── init.lua
│ │ ├── laravel.lua
│ │ ├── linting.lua
│ │ ├── lsp/
│ │ │ └── mason.lua
│ │ ├── lualine.lua
│ │ ├── noice.lua
│ │ ├── nvim-cmp.lua
│ │ ├── phprefactoring.lua
│ │ ├── snacks.lua
│ │ ├── telescope.lua
│ │ ├── todo-comments.lua
│ │ ├── treesitter.lua
│ │ ├── trouble-nvim.lua
│ │ ├── undotree.lua
│ │ └── vim-test.lua
│ └── snippets/
│ ├── blade.lua
│ ├── init.lua
│ ├── javascript.lua
│ └── php.lua
├── current-theme.lua
└── lsp/
├── init.lua
├── lua.lua
├── php.lua
└── typescript.lua

---

## Características principales

- **Soporte completo PHP moderno**  
  - Snippets y refactoring avanzados con [`adibhanna/php-refactoring.nvim`](https://github.com/adibhanna/php-refactoring.nvim).  
  - Plugins específicos para Laravel (`laravel.lua`) que permiten navegación, generación de código y shortcuts útiles para Eloquent, controllers y rutas.  
  - Integración con `snacks` para scaffolding y workflows rápidos.

- **Frontend moderno**  
  - Configuración de **TypeScript**, **Vue** y **JavaScript**.  
  - Soporte LSP con autocompletado (`nvim-cmp`), linting y formateo.  
  - Integración con Treesitter para resaltado avanzado y navegación de código.

- **Flujo de trabajo optimizado**  
  - Mapeos de teclas personalizados y shortcuts para tareas frecuentes.  
  - Integración de `telescope` para búsqueda de archivos, buffers y símbolos.  
  - `lualine` y `incline` para status line e información contextual elegante.  
  - `noice.nvim` para notificaciones y feedback de UI moderno.  
  - Debugging con `debugger.lua` y testing con `vim-test.lua`.

- **Plugins de productividad**  
  - `auto-pairs` para cierre automático de paréntesis y llaves.  
  - `trouble.nvim` para manejo de errores y advertencias.  
  - `undotree` para gestión de historial de cambios.  
  - `todo-comments` para resaltar TODO, FIXME y notas importantes en código.

---

## Filosofía de trabajo

- Configuración modular y ligera, cargando solo lo necesario.  
- Reemplazo total de IDEs tradicionales, con enfoque en **flujo de desarrollo ágil y moderno**.  
- Uso intensivo de **snippets** y **refactoring** para acelerar la edición de PHP/Laravel.  
- Integración de **LSP**, **Treesitter** y **autocomplete** para autogestión de errores y navegación rápida.  

---

## Requisitos

- Neovim >= 0.9
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- Node.js, npm/yarn para TS/Vue LSP
- PHP >= 8.4 con Composer
- Laravel CLI (opcional pero recomendado)


# Abrir Neovim y Lazy instalar plugins
nvim
:Lazy install
