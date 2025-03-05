# Fish Productivity Setup - FishKar (Abhi Wakt Hai Bro Kr Le)
# Stop wasting time. Start working like a real coder.

if status is-interactive
    set -U fish_user_paths $fish_user_paths ~/go/bin
    # Commands to run in interactive sessions can go here
end

# Created by `pipx` on 2025-01-19 07:07:24
set PATH $PATH ~/.local/bin
set -U fish_user_paths ~/.local/bin $fish_user_paths

function pentest
    set target (string trim -- $argv[1])  # Use argument if provided

    if test -z "$target"
        if command -v xclip >/dev/null
            set target (xclip -selection clipboard -o)
        else if command -v wl-paste >/dev/null
            set target (wl-paste)
        else
            echo "Clipboard command not found! Install xclip or wl-clipboard."
            return 1
        end
    end

    if test -z "$target"
        echo "Clipboard is empty. Provide a target manually."
        return 1
    end

    mkdir -p ~/Desktop/.Pentest/$target
    cd ~/Desktop/.Pentest/$target
    echo $target recon
    echo "Created folder: ~/Desktop/.Pentest/$target"
    echo "Enough talking, start hacking."
end

function pencd
    if test -f ~/.last_pentest_dir
        set last_dir (cat ~/.last_pentest_dir)
        if test -d "$last_dir"
            cd "$last_dir"
            echo "Moved to: $last_dir"
        else
            echo "Error: Last pentest folder does not exist. Time to do some real work."
        end
    else
        echo "Error: No pentest folder has been created yet. Don't be lazy, create one."
    end
end

function dsa
    cd ~/Desktop/DSA/week1/DAY4
    clear
    nvim
end

function nano
    command nvim $argv
end

function cat
    command batcat $argv
end

function cprun
    g++  $argv -o a.out && time ./a.out
end

function slae
    cd ~/Desktop/SLAE/Videos/Video24/
    clear
end

starship init fish | source

function password
    echo "Nice try, Sherlock."
end

function sysid
    cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h
end

function sysfind
    if test (count $argv) -eq 0
        echo "Usage: sysfind <constant_or_syscall>"
        return 1
    end

    grep -rnw "/usr/include/" -e "$argv"
end

function note
    nvim ~/Notes/(date +"%Y-%m-%d").md
end

# Productivity Features
abbr gco "git checkout"
abbr gst "git status"
abbr cl "clear"
abbr ll "ls -la"
abbr python "python3"

fish_vi_key_bindings

function focus
    notify-send "Start Working" && sleep 3000 && notify-send "Take a Break!"
end

echo "FISHCUT Loaded. No more excuses. Get to work."
