# ZSH Theme - Preview: https://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m %{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n%{$fg[yellow]%}@%{$fg[blue]%}%m %{$reset_color%}'
    local user_symbol='$'
fi


local current_dir='%{$terminfo[bold]$fg[blue]%}%~ %{$reset_color%}'
local git_branch='$(git_prompt_info)'
local rvm_ruby='$(ruby_prompt_info)'

conda_prompt_info() {
    if [ -n "$CONDA_DEFAULT_ENV" ]; then
        echo "$ZSH_THEME_CONDA_ENV_PROMPT_PREFIX$CONDA_DEFAULT_ENV$ZSH_THEME_CONDA_ENV_PROMPT_SUFFIX"
    fi
}

spack_prompt_info() {
    if [ -n "$SPACK_ENV" ]; then
        echo "⸨`basename $SPACK_ENV`⸩"
    fi
}

pyversion() {    
    echo "`python3 -c 'import sys; print(str(sys.version_info[0])+"."+str(sys.version_info[1]))'`"
    
}

py_prompt_info() {
    if (( $+commands[python] )); then
        echo '$ZSH_THEME_PY_PROMPT_PREFIX''$(pyversion)''$ZSH_THEME_PY_PROMPT_SUFFIX'
    fi
}

venv_prompt=''
if [[ virtualenv_prompt_info ]]; then
    venv_prompt='$(virtualenv_prompt_info)'
fi

conda_prompt=''
if [[ conda_prompt_info ]]; then 
    conda_prompt='%{$fg[magenta]%}$(conda_prompt_info)%{$reset_color%}'
fi

spack_prompt=''
if [[ spack_prompt_info ]]; then
    spack_prompt='%{$fg[red]%}$(spack_prompt_info)%{$reset_color%}'
fi

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

PROMPT="╭─ ${conda_prompt}${venv_prompt}${spack_prompt} $(py_prompt_info)${user_host}${current_dir}${rvm_ruby}${git_branch}
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[red]%}«"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="» %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX

ZSH_THEME_PY_PROMPT_PREFIX="%{$fg[yellow]%}$ZSH_THEME_PY_PROMPT_PREFIX"
ZSH_THEME_PY_PROMPT_SUFFIX="$ZSH_THEME_PY_PROMPT_SUFFIX%{$reset_color%}"
