# .dotfiles

My dotfiles, managed by [Mise](https://mise.en.dev/dotfiles)

## Fish stuff

### Persistent abbreviations

Persistent abbreviations are stored in `~/.config/fish/conf.d/abbrs.fish`. When you do `abbr --add {x} {xyz}`, the abbreviation is _not_ automatically added to this file. To make it persistent, add `abbr --add {x} {xyz}` to `~/.config/fish/conf.d/abbrs.fish`. Or, you can use `abbr > ~/.config/fish/conf.d/abbrs.fish` to update the file with all existing and current abbreviations. Use `abbr -s` to see what abbreviations are currently defined.

See [Fish's `abbr` documentation](https://fishshell.com/docs/current/cmds/abbr.html) for details.
