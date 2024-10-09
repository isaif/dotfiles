#!/bin/sh

# # hide mouse cursor
# unclutter &

# # start xbindkeys
# # this file has keybinds for changing volume using keyboard
# xbindkeys &

# if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
#   eval $(dbus-launch --exit-with-session --sh-syntax)
# fi
# systemctl --user import-environment DISPLAY XAUTHORITY
#
# if command -v dbus-update-activation-environment >/dev/null 2>&1; then
#         dbus-update-activation-environment DISPLAY XAUTHORITY
# fi
#
# eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
# export SSH_AUTH_SOCK

# Start D-Bus session
eval $(dbus-launch --sh-syntax)

# Start GNOME Keyring daemon
# eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)

# Export necessary environment variables
export GNOME_KEYRING_CONTROL GPG_AGENT_INFO SSH_AUTH_SOCK

workrave &

exec awesome
