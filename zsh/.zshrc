

export HISTFILE=$ZDOTDIR/.zsh_history
export ZSH_COMPDUMP=$ZDOTDIR/.zcompdump-$HOST-$ZSH_VERSION
export HISTFILE=$HOME/.config/zsh/.zsh_history
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
export PATH="$HOME/.config/scripts:$PATH"
# Path to your Oh My Zsh installation.
export ZSH=$ZDOTDIR/.oh-my-zsh
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export STARSHIP_CACHE=~/.config/starship/cache

ZSH_THEME=""
 
if [ -f "$HOME/.config/zsh/aliases.zsh" ]; then
    source "$HOME/.config/zsh/aliases.zsh"
fi

source "$HOME/.config/zsh/automatic.zsh"
ff1

plugins=(git 
	zsh-autocomplete
	zsh-autosuggestions


	)
source $ZSH/oh-my-zsh.sh
# ==============================================================================
# ULTRA-COMPACT ZSH-AUTOCOMPLETE STYLING (DARK GREEN & GOLD)
# ==============================================================================

# 1. Minimize Menu Height (Keeps it tight, only 5 lines max)
zstyle ':autocomplete:*' list-lines 5

# 2. Minimalist Group Headers (Gold/Yellow text inside Dark Green brackets)
zstyle ':completion:*:descriptions' format $'%F{28}[%B%F{220}%U%d%u%b%F{28}]%f'
zstyle ':completion:*:messages' format $'%F{142}%d%f'
zstyle ':completion:*:warnings' format $'%F{167}! %d%f'

# 3. Strip Extra Text Columns (Turns off descriptions for flags/options)
zstyle ':completion:*' verbose no

# 4. Dense Selection Highlight (Gold text on a Deep Forest Green background)
# ma=48;5;22;38;5;220m -> Background: ANSI 22 (Dark Green), Foreground: ANSI 220 (Gold)
zstyle ':completion:*' menu select=1
zstyle ':completion:*:default' list-colors "ma=48;5;22;38;5;220m"

# 5. Pack Items Closely Together
zstyle ':completion:*' group-name ''

eval "$(starship init zsh)"
