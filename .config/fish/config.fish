# Activate mise so all tool paths are globally accessible
$HOME/.local/bin/mise activate fish | source

# globals
set -gx BROWSER explorer.exe
set -gx VISUAL nano
set -gx EDITOR nano

# INTERACTIVE ONLY CONFIGURATION (Prevents slowing down non-interactive scripts)
if status is-interactive
    echo using (set_color red)$CORE_DOTFILES_VERSION(set_color normal) of fish config

    # --- STARSHIP PROMPT OPTIMIZATION ---
    # Standard initialization forks a process.
    # Instead, we compile the prompt configuration once into Fish memory.
    if type -q starship
        function fish_prompt
            starship prompt --terminal-width=$COLUMNS --status=$status --pipestatus=$pipestatus --keymap=$fish_keymap
        end
        # Enable right prompt if you use it, otherwise leave commented out
        function fish_right_prompt; starship prompt --right; end
    end

    # --- DEFERRED FZF CONFIGURATION ---
    # Sets preferred search behaviors for FZF utilizing fd and ripgrep
    if type -q fzf
        set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
        set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
        set -gx FZF_ALT_C_COMMAND 'fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'

        # Initialize fzf keybindings seamlessly
        fzf --fish | source
    end

    # --- LAZY-LOADED ZOXIDE INITIALIZATION ---
    # This magic function tricks Fish into waiting to initialize Zoxide
    # until the first time you type 'z' or 'zi'. Startup penalty drops to 0ms.
    function z --description "Lazy-load zoxide"
        if type -q zoxide
            functions -e z zi # Remove these temporary wrappers
            zoxide init fish | source # Fully load zoxide hooks
            z $argv # Pass arguments to the real z command
        end
    end
    function zi --description "Lazy-load zoxide interactive"
        if type -q zoxide
            functions -e z zi
            zoxide init fish | source
            zi $argv
        end
    end

    # Added by Antigravity CLI installer
    set -gx PATH "$HOME/.local/bin" $PATH

end
