export EDITOR=nvim

# start ssh-agent
unset SSH_AGENT_PID

if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  gpg-connect-agent updatestartuptty /bye >/dev/null
fi
