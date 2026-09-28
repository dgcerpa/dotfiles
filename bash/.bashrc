#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Añadir ~/.local/bin al PATH (para claude-code nativo y otros binarios de usuario)
export PATH="$HOME/.local/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/diego/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/diego/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/diego/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/diego/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Ejecutar fastetch por defecto en shells interactivas
if [[ $- == *i* ]]; then
	fastfetch
fi

# yazi: al salir con q, la terminal queda en la carpeta donde estabas
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
