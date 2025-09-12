function mkd -d "Create a directory and set CWD"
    command mkdir $argv
    if test $status = 0
        switch $argv[(count $argv)]
            case '-*'

            case '*'
                cd $argv[(count $argv)]
                return
        end
    end
end

function fd -d "Show git diff using fzf" 
  # preview="git diff $@ --color=always -- {-1}"
  git diff --name-only | fzf -m --ansi --preview "git diff --color=always -- {-1}"
end


function load_env_vars -d "Load variables in a .env file"
    for i in (cat $argv)
        set arr (echo $i |tr = \n)
        set -gx $arr[1] $arr[2]
    end
end

function now -d "Print the current date and time"
    date "+%Y-%m-%d %H:%M:%S"
end

function nv -d "Launch Neovim"
    if count $argv >/dev/null
        nvim $argv
    else
        nvim
    end
end

function o -d Open
    if count $argv >/dev/null
        open $argv
    else
        open .
    end
end

function ta -d "Attach to previous Tmux session"
    tmux new-session -t $argv
end

function tn -d "Create a new Tmux session (or attach to one) based on the current directory"
    set selected (pwd | sed 's/.*\///g')
    # Replace a '.' in any file names with an underscore
    set selected_name $(basename "$selected" | tr . _)
    tmux new -A -s $selected_name
end

function italic -d "Test if italic text is working"
    echo -e "\e[3mThis text should be in italics\e[23m"
end

function col -d "Test if color is working"
    curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/e50a28ec54188d2413518788de6c6367ffcea4f7/print256colours.sh | bash
end

function aemu -d "Start Android emulator (first or specific AVD)"
    set avds (emulator -list-avds)

    if test (count $argv) -eq 0
        if test (count $avds) -gt 0
            echo "📱 Starting first emulator: $avds[1]"
            nohup emulator -avd $avds[1] > /dev/null 2>&1 &
        else
            echo "❌ No AVDs found. Create one with 'avdmanager create avd'."
        end
    else
        echo "📱 Starting emulator: $argv[1]"
        nohup emulator -avd $argv[1] > /dev/null 2>&1 &
    end
end

function abuild -d "Build Android app locally with EAS and install on device"
    # Ensure emulator/device is connected
    if test (adb devices | grep -c 'device$') -eq 0
        echo "⚠️  No device connected. Please run 'aemu' first."
        return 1
    end

    # Run build
    set last_build_apk (eas build --platform android --profile dev-local --local 2>&1 | tee /dev/tty | grep -o '/.*\.apk' | tail -n 1)

    if test -n "$last_build_apk"
        echo "✅ Build complete. Installing $last_build_apk ..."
        adb install -r "$last_build_apk"
    else
        echo "❌ No APK found in build output."
    end
end
