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

# Named gdf, not fd: `fd` would shadow the fd binary installed via Brewfile
# (and used by PatrickF1/fzf.fish for its file search).
function gdf -d "Browse changed files with fzf, previewing each diff"
  git diff --name-only | fzf -m --ansi --preview "git diff --color=always -- {-1}"
end

function copyssh -d "Copy an ~/.ssh file to the clipboard"
    if test (count $argv) -eq 0
        echo "usage: copyssh <filename-in-~/.ssh>" >&2
        return 1
    end
    pbcopy < "$HOME/.ssh/$argv[1]"
end


function dotenv -d "Export KEY=VALUE lines from a .env file (default ./.env)"
    set file .env
    test (count $argv) -gt 0; and set file $argv[1]
    if not test -f $file
        echo "dotenv: $file not found" >&2
        return 1
    end
    for line in (string trim < $file)
        # Skip blanks and comments; accept an optional leading `export`.
        string match -qr '^(#|$)' -- $line; and continue
        set line (string replace -r '^export\s+' '' -- $line)
        # Split on the first `=` only, so values may contain `=`.
        set kv (string split -m1 = -- $line)
        test (count $kv) -eq 2; or continue
        set -gx (string trim -- $kv[1]) (string trim -c '"\'' -- (string trim -- $kv[2]))
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

function isim -d "Start iOS simulator (first iPhone or a named device)"
    set device $argv[1]
    if test -z "$device"
        set device (xcrun simctl list devices available | string match -rg '^\s+(iPhone.+?) \(' | head -1)
    end

    if test -z "$device"
        echo "❌ No iPhone simulators found. Install an iOS runtime in Xcode > Settings > Components."
        return 1
    end

    echo "📱 Starting simulator: $device"
    xcrun simctl boot "$device" 2>/dev/null
    # Xcode 27 replaced Simulator.app with DeviceHub.app; fall back for older Xcodes.
    open -b com.apple.dt.Devices 2>/dev/null; or open -a Simulator
end

complete -c isim -f -a '(xcrun simctl list devices available | string match -rg "^\s+(iPhone.+?) \(")'

function abuild -d "Build Android app locally with EAS and optionally install on device"
    set profile "dev-local"
    set install_flag 0

    # Parse arguments
    for arg in $argv
        switch $arg
            case "--profile=*"
                set profile (string split "=" $arg)[2]
            case "--install"
                set install_flag 1
        end
    end

    if test $install_flag -eq 1
        # Ensure emulator/device is connected
        if test (adb devices | grep -c 'device$') -eq 0
            echo "⚠️  No device connected. Please run 'aemu' first."
            return 1
        end
    end

    echo "🚀 Building Android app with profile: $profile"
    set last_build_apk (eas build --platform android --profile $profile --local 2>&1 | tee /dev/tty | grep -o '/.*\.apk' | tail -n 1)

    if test -n "$last_build_apk"
        set apk_name (basename $last_build_apk)
        echo "✅ Build complete: $apk_name"
        echo "📂 Location: $last_build_apk"

        if test $install_flag -eq 1
            echo "📲 Installing on device..."
            adb install -r "$last_build_apk"
        end
    else
        echo "❌ No APK found in build output."
    end
end

# Git worktrees live next to the main checkout: ~/code/foo -> ~/code/foo.worktrees/<branch>.
# Resolved from the main checkout, so these work the same from inside any worktree.
function __wt_dir -d "Print the worktrees folder for the current repo"
    set -l common (git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
    or begin
        echo "not inside a git repo" >&2
        return 1
    end
    set -l root (path dirname $common)
    echo (path dirname $root)/(path basename $root).worktrees
end

function __wt_names -d "List worktree names (for completion)"
    set -l dir (__wt_dir 2>/dev/null); or return
    git worktree list --porcelain | string replace -rf '^worktree '(string escape --style=regex -- $dir/) ''
end

function gwa -d "Add a worktree: gwa <branch> [base]"
    if test (count $argv) -eq 0
        echo "usage: gwa <branch> [base, default main]" >&2
        return 1
    end
    set -l dir (__wt_dir); or return
    set -l branch $argv[1]
    set -l base main
    set -q argv[2]; and set base $argv[2]
    set -l target $dir/$branch

    if git show-ref --verify --quiet refs/heads/$branch
        git worktree add $target $branch
    else if git show-ref --verify --quiet refs/remotes/origin/$branch
        git worktree add --track -b $branch $target origin/$branch
    else
        git worktree add -b $branch $target $base
    end
    and cd $target
end

function gwr -d "Remove a worktree: gwr <branch> [--force]"
    if test (count $argv) -eq 0
        echo "usage: gwr <branch> [--force]" >&2
        return 1
    end
    set -l dir (__wt_dir); or return
    set -l target $dir/$argv[1]
    # Step out first if we are standing inside the one being removed.
    if string match -q "$target*" -- $PWD
        cd (path dirname $dir)/(string replace -r '\.worktrees$' '' -- (path basename $dir))
    end
    git worktree remove $argv[2..] $target
    and echo "Removed $target (branch $argv[1] kept; delete it with: git branch -d $argv[1])"
end

function gwcd -d "cd into a worktree by branch, or the main checkout with no argument"
    set -l dir (__wt_dir); or return
    if test (count $argv) -eq 0
        cd (path dirname $dir)/(string replace -r '\.worktrees$' '' -- (path basename $dir))
    else
        cd $dir/$argv[1]
    end
end

complete -c gwr -f -a '(__wt_names)'
complete -c gwr -l force -d "Remove even with uncommitted changes"
complete -c gwcd -f -a '(__wt_names)'
complete -c gwa -f -a '(git for-each-ref --format="%(refname:short)" refs/heads)'

function gwl -d "Colorful git worktree list, as a table"
    set -l current (git rev-parse --show-toplevel 2>/dev/null)
    or begin
        echo "gwl: not inside a git repo" >&2
        return 1
    end
    set -l dir (__wt_dir)

    # Collect rows first so the branch column can be sized to fit.
    set -l paths; set -l branches; set -l heads; set -l flags
    set -l wt_path; set -l wt_head; set -l wt_branch; set -l wt_flag ''
    for line in (git worktree list --porcelain) ''
        switch $line
            case 'worktree *'
                set wt_path (string replace 'worktree ' '' -- $line)
            case 'HEAD *'
                set wt_head (string sub -l 9 (string replace 'HEAD ' '' -- $line))
            case 'branch *'
                set wt_branch (string replace 'branch refs/heads/' '' -- $line)
            case detached
                set wt_branch '(detached)'
            case 'locked*' 'prunable*'
                set wt_flag (string split -f1 ' ' -- $line)
            case ''
                test -z "$wt_path"; and continue
                set -a paths $wt_path; set -a heads $wt_head
                set -a branches $wt_branch; set -a flags $wt_flag
                set wt_path; set wt_head; set wt_branch; set wt_flag ''
        end
    end

    # Fixed columns: marker 3 + status 12 + commit 11 + updated 9, plus gaps.
    set -l fixed 39
    set -l width (math max 6, (string length -V -- $branches | sort -n | tail -1))
    set -l cols $COLUMNS
    test -z "$cols"; and set cols 100
    set width (math "min($width, max(12, $cols - $fixed))")

    set -l dim (set_color brblack); set -l off (set_color normal)
    echo
    echo "  $dim""Worktrees in"(set_color normal) (set_color --bold)(string replace $HOME '~' -- $dir)$off
    echo
    printf '   %s%s  %s  %s  %s%s\n' $dim (string pad -r -w $width BRANCH) (string pad -r -w 10 STATUS) (string pad -r -w 9 COMMIT) UPDATED $off
    printf '   %s%s%s\n' $dim (string repeat -n (math "$width + 33") ─) $off

    set -l dirty_total 0
    for i in (seq (count $paths))
        set -l p $paths[$i]

        set -l marker '   '
        test "$p" = "$current"; and set marker (set_color green)' ● '$off

        set -l name (string shorten -m $width -- $branches[$i])
        set -l name_color (set_color cyan)
        test "$p" = "$current"; and set name_color (set_color --bold green)

        set -l state_text; set -l state_color
        if test -n "$flags[$i]"; or not test -d "$p"
            set state_text "✗ $flags[$i]"
            test -z "$flags[$i]"; and set state_text '✗ missing'
            set state_color (set_color red)
        else
            set -l dirty (git -C $p status --porcelain 2>/dev/null | count)
            if test $dirty -gt 0
                set state_text "✎ $dirty files"
                set state_color (set_color yellow)
                set dirty_total (math $dirty_total + 1)
            else
                set state_text '✓ clean'
                set state_color (set_color green)
            end
        end

        # "2 days ago" -> "2d ago", "3 months ago" -> "3mo ago"
        set -l age (git -C $p log -1 --format=%cr 2>/dev/null | string replace -r '^(\d+) (mo|\w)\S* ago$' '$1$2 ago')

        printf '%s%s%s%s  %s%s%s  %s%s%s  %s%s%s\n' $marker \
            $name_color (string pad -r -w $width -- $name) $off \
            $state_color (string pad -r -w 10 -- $state_text) $off \
            (set_color yellow) (string pad -r -w 9 -- $heads[$i]) $off \
            $dim $age $off

        # Only worth printing a path when it is not the usual <dir>/<branch>.
        if test "$p" != "$dir/$branches[$i]"; and test "$p" != (path dirname $dir)/(string replace -r '\.worktrees$' '' -- (path basename $dir))
            printf '   %s↳ %s%s\n' $dim (string replace $HOME '~' -- $p) $off
        end
    end

    echo
    printf '  %s%d worktrees, %d with uncommitted changes%s\n\n' $dim (count $paths) $dirty_total $off
end

# Ports / processes

function ports -d "List listening TCP ports (optionally just one: ports 3000)"
    if test (count $argv) -gt 0
        lsof -nP -iTCP:$argv[1] -sTCP:LISTEN
    else
        lsof -nP -iTCP -sTCP:LISTEN
    end
end

function killport -d "Kill whatever is listening on the given port(s)"
    if test (count $argv) -eq 0
        echo "usage: killport <port> [port...]" >&2
        return 1
    end
    for p in $argv
        set pids (lsof -ti tcp:$p -sTCP:LISTEN)
        if test -z "$pids"
            echo "nothing listening on :$p"
            continue
        end
        echo "killing :$p (pid $pids)"
        # Ask nicely first; force only if something survives.
        kill $pids
        sleep 0.5
        set left (lsof -ti tcp:$p -sTCP:LISTEN)
        test -n "$left"; and kill -9 $left
    end
end

function fport -d "Pick listening ports with fzf and kill their processes"
    set pids (lsof -nP -iTCP -sTCP:LISTEN | sed 1d | fzf -m --header "kill which? (tab to multi-select)" | awk '{print $2}' | sort -u)
    test -n "$pids"; and kill $pids
end

function fkill -d "Pick processes with fzf and kill them (fkill -9 to force)"
    set sig -TERM
    test (count $argv) -gt 0; and set sig $argv[1]
    set pids (ps -axo pid,user,%cpu,%mem,command | sed 1d | fzf -m --header "kill $sig (tab to multi-select)" | awk '{print $1}')
    test -n "$pids"; and kill $sig $pids
end

# Git

function gbf -d "Checkout a branch picked with fzf, previewing its log"
    set branch (git branch -a --sort=-committerdate --format='%(refname:short)' \
        | string match -v -r '^origin(/HEAD)?$' \
        | fzf --preview 'git log --oneline --graph --color=always -20 {}' \
        | string replace -r '^origin/' '')
    # `git checkout foo` on a remote-only branch creates the tracking branch.
    test -n "$branch"; and git checkout $branch
end

# Misc

function extract -d "Extract any common archive into the current directory"
    if test (count $argv) -eq 0
        echo "usage: extract <archive> [archive...]" >&2
        return 1
    end
    for f in $argv
        if not test -f $f
            echo "extract: $f not found" >&2
            continue
        end
        # macOS tar is bsdtar (libarchive): it auto-detects gz/bz2/xz/zst and reads 7z and rar too.
        switch $f
            case '*.tar' '*.tar.*' '*.tgz' '*.tbz' '*.tbz2' '*.txz' '*.7z' '*.rar'
                tar -xf $f
            case '*.zip' '*.jar'
                unzip -q $f
            case '*.gz'
                gunzip -k $f
            case '*.bz2'
                bunzip2 -k $f
            case '*.xz'
                unxz -k $f
            case '*'
                echo "extract: don't know how to extract $f" >&2
        end
    end
end

function myip -d "Show local and public IP addresses"
    set iface (route -n get default 2>/dev/null | awk '/interface:/ {print $2}')
    set local (ipconfig getifaddr $iface 2>/dev/null; or echo unavailable)
    set public (curl -s --max-time 3 https://api.ipify.org; or echo unavailable)
    echo "local:  $local ($iface)"
    echo "public: $public"
end

function serve -d "Serve the current directory over HTTP (default port 8000)"
    set port 8000
    test (count $argv) -gt 0; and set port $argv[1]
    echo "serving "(pwd)" at http://localhost:$port"
    python3 -m http.server $port
end
