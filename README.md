# Rocx
Nix flake to build and expose the [tree-sitter grammar](https://github.com/faldor20/tree-sitter-roc) of Roc.

*Purpose: Automate my [Helix](https://helix-editor.com/) configuration for the [Roc](https://github.com/roc-lang/roc) language while it is not supported.*

## Use
This flake makes it easy for me to rebuild the grammar and pipe the outputs into other flakes.

To manually generate the output, use `nix build`.

Current structure of the result:
- The `queries/` directory is placed into `result/queries/roc/` (content to be copied into `.config/helix/runtime/queries/roc/`).
- The generated `.so` file is placed into `result/grammars/` (content to be copied into `.config/helix/runtime/grammars/`).
