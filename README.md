# Systemd

Stow creates symlinks, but systemd doesn't accept symlinks by default.
To fix this, you can run this command (you may also need `-f` flag)

```sh
systemctl --user link ~/%path_to_stow_package%/.config/systemd/user/*
```

After this you can enable user units.
