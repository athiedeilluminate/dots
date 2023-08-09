# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
export EDITOR='nvim'
export WLR_NO_HARDWARE_CURSORS=1

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

[ $TERM == "alacritty" ] && export TERM=xterm-256color
# fedora
[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] && source /usr/share/git-core/contrib/completion/git-prompt.sh
# alpine
[ -f /usr/share/git-core/git-prompt.sh ] && source /usr/share/git-core/git-prompt.sh
# arch
[ -f /usr/share/git/completion/git-prompt.sh ] && source /usr/share/git/completion/git-prompt.sh

exitcode () 
{ 
    ec=$?;
    if [ $ec -eq 0 -o $ec -eq 130 ]; then
        printf "";
    else
        printf "\e[1;31m$ec\e[0m ";
    fi
}
inadistrobox () 
{ 
    if [ -n "$DISTROBOX_ENTER_PATH" ]; then
        printf "\e[33;35m⬢\e[0m ";
    fi
}
man () 
{ 
    MANPAGER='less -s -M +Gg' GROFF_NO_SGR=1 LESS_TERMCAP_md='' LESS_TERMCAP_me='' LESS_TERMCAP_se='' LESS_TERMCAP_so='' LESS_TERMCAP_ue='' LESS_TERMCAP_us='' command man "$@"
}
quote () 
{ 
    local quoted=${1//\'/\'\\\'\'};
    printf "'%s'" "$quoted"
}
quote_readline () 
{ 
    local ret;
    _quote_readline_by_ref "$1" ret;
    printf %s "$ret"
}
sshclean () 
{ 
    echo "removing $@ from ~/.ssh/known_hosts...";
    grep --color=auto $@ ~/.ssh/known_hosts;
    sed -i -e "/.*$@.*/d" ~/.ssh/known_hosts
}
tf () 
{ 
    case $1 in 
		"devops")
			# for devops2 host
			export VSPHERE_USER=''
			export VSPHERE_PASSWORD=''
			export VSPHERE_SERVER=''
			export SITE_NAME='devops'
		;;
		"qa")
			export VSPHERE_USER=''
			export VSPHERE_PASSWORD=''
			export VSPHERE_SERVER=''
			export SITE_NAME='qa'
		;;
		"fu")
			shift 1
			terraform force-unlock $1 -force
		;;
        "init")
            terraform init -upgrade
        ;;
        "de")
            terraform destroy
        ;;
        "ap")
            terraform apply
        ;;
        "pl")
            terraform plan
        ;;
        "rebuild")
            terraform destroy -auto-approve && terraform apply -auto-approve
        ;;
        *)
            terraform $@
        ;;
    esac
}
alias nboat='newsboat'
alias podrm='find ~/.local/share/newsboat/Podcasts/ -type f -mtime +4 -delete'
alias swfeed='newsboat -c ~/.config/newsboat/sw.db -u ~/.config/newsboat/swurls'
alias alpine='distrobox-enter --name alpine'
alias editrc='$EDITOR ~/.bashrc'
alias egrep='egrep --color=auto'
alias alpine='distrobox-enter --name alpine'
alias debian='distrobox-enter --name debian'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ip='ip -h -c'
alias l.='ls -d .* --color=auto'
alias ll='ls -lth'
alias ls='ls --color=auto'
alias lsd='ls -d */'
alias master='git checkout master||git checkout main;git pull origin `git branch --show-current`'
alias myip='curl -s ifconfig.io'
alias nvrc='$EDITOR ~/.config/nvim/init.lua'
alias pull='git pull origin `git branch --show-current`'
alias push='git push origin `git branch --show-current`'
alias reload='. ~/.bashrc'
alias sshconfig='$EDITOR ~/.ssh/config'
alias tb='nc termbin.com 9999'
alias vim='nvim'
alias vimdiff='nvim -d'
alias vimrc='$EDITOR ~/.vimrc'
alias wifis='nmcli device wifi rescan; nmcli device wifi list'
alias wtr='curl wttr.in/?T\&format=2'
alias wttr='curl wttr.in/?T'
export PS1='$(exitcode)\e[1m\A $(inadistrobox)\e[0m\h\e[0m [\w]$(__git_ps1 " %s")\e[0m\n\$ '

