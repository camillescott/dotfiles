local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
    local user_host="%{$terminfo[bold]$fg[red]%}%n@"'$(prompt_hostname)'" %{$reset_color%}"
    local user_symbol='#'
elif [[ $USER -ne camille ]]; then
    local user_host="%{$terminfo[bold]$fg[orange]%}%n@"'$(prompt_hostname)'" %{$reset_color%}"
    local user_symbol='#'
else
    local user_host="%{$terminfo[bold]$fg[green]%}󱑷 %{$fg[yellow]%}@%{$fg[blue]%}"'$(prompt_hostname)'" %{$reset_color%}"
    local user_symbol='$'
fi

function prompt_hostname() {
    # Split the FQDN into an array using '.' as a delimiter
    local -a tokens=( ${(s:.:)$(hostname -f 2>/dev/null || echo $HOST)} )
    
    if (( ${#tokens} >= 2 )); then
        if [[ "${tokens[1]}" == "${tokens[2]}" ]]; then
            echo "${tokens[1]}²"
        else
            echo "${tokens[1]}.${tokens[2]}"
        fi
    else
        echo "${tokens[1]:-$HOST}"
    fi
}

function spack_prompt_info() {
    [[ -n ${SPACK_ENV} ]] || return
    echo "${ZSH_THEME_SPACK_PREFIX=⸨}`basename $SPACK_ENV`${ZSH_THEME_SPACK_SUFFIX=⸩}"
}

# Get the version once and store it; only update if we have to
function pyversion() {
    if [[ -z "$_PROMPT_PY_CACHE" ]]; then
        _PROMPT_PY_CACHE=$(python3 -V 2>/dev/null | cut -d' ' -f2 | cut -d. -f1,2)
    fi
    echo "${_PROMPT_PY_CACHE:-?.?}"
}

# Optional: Clear the cache when switching conda/venv environments
function _clear_py_cache() { unset _PROMPT_PY_CACHE }
autoload -U add-zsh-hook
add-zsh-hook chpwd _clear_py_cache

function py_prompt_info() {
    echo "$ZSH_THEME_PY_PROMPT_PREFIX$(pyversion)$ZSH_THEME_PY_PROMPT_SUFFIX"
}

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local current_dir="%{$terminfo[bold]$FG[248]%}%~ %{$reset_color%}"

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{130}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[red]%}«"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="» %{$reset_color%}"

ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX

ZSH_THEME_PY_PROMPT_PREFIX="%F{070} "
ZSH_THEME_PY_PROMPT_SUFFIX="%f "

ZSH_THEME_CONDA_PREFIX="%F{magenta}󰜐 "
ZSH_THEME_CONDA_SUFFIX=" %f"

ZSH_THEME_SPACK_PREFIX="%F{red}󰓁 "
ZSH_THEME_SPACK_SUFFIX=" %f"

#PROMPT="╭─ \$(spack_prompt_info)\$(conda_prompt_info)\$(virtualenv_prompt_info)\$(py_prompt_info)${user_host}${current_dir}"'$(ruby_prompt_info)$(git_prompt_info)'"
#╰─%B${user_symbol}%b "

PROMPT="╭─${user_host}${current_dir}\$(git_prompt_info) \$(spack_prompt_info)\$(conda_prompt_info)\$(virtualenv_prompt_info)\$(py_prompt_info)\$(ruby_prompt_info)
%B${user_symbol}%b "

RPROMPT="%B${return_code}%b"

