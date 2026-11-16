# WSL Zone.Identifier cleanup

Script: `cleanup-zone-identifiers.sh`

Removes `*:Zone.Identifier` files left when copying from Windows into WSL/Linux trees.

```bash
./cleanup-zone-identifiers.sh              # current directory
./cleanup-zone-identifiers.sh /path/to/dir
./cleanup-zone-identifiers.sh /path -f     # --force non-interactive
```

Review the dry-run/listing behavior in the script before `--force` on large trees.
