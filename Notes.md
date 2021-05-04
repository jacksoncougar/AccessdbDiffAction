# Notes

```bash
git diff-tree --no-commit-id --name-only -r fa9a08dffb5bc16cb7f145bcc0c4ad136fd365b4 | grep accdb | xargs -I{} git difftool --tool=access HEAD^^ {} --no-prompt
```
