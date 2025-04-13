## generate initial config
```bash
sudo nixos-generate-config --no-filesystems --root /mnt
```

## clone configuration repository
```bash
nix-shell -p git && git clone https://github.com/ian-pge/NixOS.git /mnt/etc/nixos
```

## disko formatting command
replace `'"/dev/vda"'` with your drive
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /mnt/etc/nixos/disko.nix --arg device '"/dev/vda"'
```

## installing nixos
```bash
nixos-install --root /mnt --flake /mnt/etc/nixos#default
```
