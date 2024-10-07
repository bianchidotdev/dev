# Development Environemnt

This is now managed by [chezmoi](https://www.chezmoi.io/).

Install homebrew && `chezmoi`:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshrc && source ~/.zshrc
brew install chezmoi
```

Initialize `chezmoi`:
```
chezmoi init --apply https://github.com/bianchidotdev/dev.git
```

## What happens

* Chezmoi syncs all dotfiles in the `chezmoi/` directory (check what these are using `chezmoi managed`)
* Rosetta is installed
* Screenshots are redirected to `~/Documents/screenshots`
* Homebrew packages in `chezmoi/Brewfile` are installed

## Roadmap

* Template-ify `Brewfile`
* Dash sync setup
* logseq configuration
