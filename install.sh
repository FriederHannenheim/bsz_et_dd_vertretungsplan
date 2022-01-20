
#!/usr/bin/env bash

USER="$(whoami)"
SCRIPT_DIR="/home/$USER/bin"
SYSTEMD_DIR="/home/$USER/.config/systemd/user"

read -p "Klasse (Wortlaut wie im Vertretungsplan): " klasse
read -p "geschuetzt.bszet.de Nutzername: " nutzer
read -p "geschuetzt.bszet.de Passwort: " passwort

mkdir -p "$SCRIPT_DIR" "$SYSTEMD_DIR"

sed "s/&0/$USER/g" vertretung.service > "$SYSTEMD_DIR/vertretung.service"
cp vertretung.timer "$SYSTEMD_DIR"
sed "s/&0/$klasse/g;s/&1/$nutzer:$passwort/g" check_vertretungsplan > "$SCRIPT_DIR/check_vertretungsplan"

chmod +x "$SCRIPT_DIR/check_vertretungsplan"

systemctl --user enable vertretung.timer
