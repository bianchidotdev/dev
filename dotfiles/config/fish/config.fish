source ~/.iterm2_shell_integration.fish
source ~/.config/fish/alias.fish

# set -x GPG_TTY (tty)
# set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
# gpgconf --launch gpg-agent

set fish_user_paths /usr/local/bin $fish_user_paths
set fish_user_paths "/usr/local/sbin" $fish_user_paths
set fish_user_paths "$HOME/.cargo/bin" $fish_user_paths
set fish_user_paths "$HOME/.rbenv/shims" $fish_user_paths
set fish_user_paths "$HOME/.google-cloud-sdk/bin" $fish_user_paths

set HOST 'localhost'

#set -g fish_user_paths "/usr/local/opt/terraform@0.11/bin" $fish_user_paths
