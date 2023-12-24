# Operating System

Repository containing handy dandy OS setups

## Bonus git setup for windows

Run 

```sh
git config --global -e
```

It will open .gitconfig file in your default editor that you should have configured for git. Add this to your .gitconfig file.
```sh
[alias]
	branch-prune = "!git fetch -p && for b in $(git for-each-ref --format='%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)' refs/heads); do git branch -D $b; done"
```

