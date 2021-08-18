setopt promptsubst

# Depends on the git plugin for work_in_progress()
(( $+functions[work_in_progress] )) || work_in_progress() {}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[magenta]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local branch=$(git_current_branch)
  [[ -n "$branch" ]] || return 0
  echo "$(parse_git_dirty)\
%{${fg_bold[yellow]}%}$(work_in_progress)%{$reset_color%}\
${ZSH_THEME_GIT_PROMPT_PREFIX}${branch}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

# Execution time
function preexec() {
  cmd_start=$(($(print -P %D{%s%6.}) / 1000))
}

function precmd() {
  if [ $cmd_start ]; then
    local now=$(($(print -P %D{%s%6.}) / 1000))
    local d_ms=$(($now - $cmd_start))
    local d_s=$((d_ms / 1000))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))

    if   ((h > 0)); then cmd_time="${h}h ${m}m"
    elif ((m > 0)); then cmd_time="${m}m ${s}s"
    # elif ((s > 9)); then cmd_time=${s}.$(printf %03d $ms | cut -c1-2)s # 12.34s
    # elif ((s > 0)); then cmd_time=${s}.$(printf %03d $ms)s # 1.234s
    elif ((s > 0)); then cmd_time=${s}s
    else cmd_time=${ms}ms
    fi

    unset cmd_start
  else
    # Clear previous result when hitting Return with no command to execute
    unset cmd_time
  fi
}


# Combine it all into a final right-side prompt
RPS1='$(git_custom_status)%F{yellow}%B$(if [ $cmd_time ]; then echo " $cmd_time"; fi)%b'
PROMPT='%F{cyan}%B%t%b %F{red}[%~% ]%(?.%F{green}.%F{red})%B λ%b '
