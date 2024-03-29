import argparse
import datetime
import os
import stat
import subprocess
import sys

NVIM_APPIMAGE = 'https://github.com/neovim/neovim/releases/latest/download/nvim.appimage'
ZSH_SNAP = 'https://github.com/marlonrichert/zsh-snap.git'
NODEJS_VERSION = 'v16.18.0'
ZSH_LOGIN_EMU = '[ -f /etc/zshrc ] && . /etc/zshrc; [ -f ~/.zshrc ] && . ~/.zshrc'

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--user', '-u', default='camw')
    parser.add_argument('--home-root', default='/home')
    parser.add_argument('--dotfiles')
    parser.add_argument('--no-backup', action='store_true', default=False)
    args = parser.parse_args()

    home_dir = os.path.join(args.home_root, args.user)
    zsh_dir = os.path.join(home_dir, '.local', 'share', 'zsh')
    config_dir = os.path.join(home_dir, '.config')
    bin_dir = os.path.join(home_dir, '.local', 'bin')
    cur_time = datetime.datetime.now().strftime("%Y-%m-%d-%H:%M")
    if args.dotfiles is None:
        dotfiles = os.path.join(home_dir, 'dotfiles')
    else:
        dotfiles = args.dotfiles

    print(f'Initializing {home_dir}...')

    if args.no_backup:
        print('* SKIPPING config file backups!')
    else:
        print('* Making backups of config files!')
        zshrc = os.path.join(home_dir, '.zshrc')
        zshrc_bak = backup_file(zshrc, cur_time)

        condarc = os.path.join(home_dir, '.condarc')
        condarc_bak = backup_file(condarc, cur_time)

        gitconfig = os.path.join(home_dir, '.gitconfig')
        gitconfig_bak = backup_file(gitconfig, cur_time)

        nvimconf = os.path.join(home_dir, '.config', 'nvim')
        nvimconf_bak = backup_file(nvimconf, cur_time)

        bash_profile = os.path.join(home_dir, '.bash_profile')
        bash_profile_bak = backup_file(bash_profile, cur_time)

        profile = os.path.join(home_dir, '.profile')
        profile_bak = backup_file(profile, cur_time)

    print(f'* Setting up zsh!')
    
    create_dir(zsh_dir)

    print(f'...Installing zsh-snap: ', end='')
    cmd = ['git', 'clone', '--depth', '1', ZSH_SNAP]

    ret, out, err = run_shell(cmd, in_directory=zsh_dir)
        
    if ret == 128:
        print(f'\n\tzsh-snap repo already exists, continuing.')
    elif ret != 0:
       print(f'\n\tUnknown git error, exiting.')
       print(f'\n\tstderr: {err}')
       sys.exit(ret)
    else:
        print(': done.')

    zshrc_df = os.path.join(dotfiles, 'zshrc')
    print(f'...Linking {zshrc} to {zshrc_df}: ', end='')
    os.symlink(zshrc_df, zshrc)
    print('done.')

    print(f'...Linking {dotfiles} into {zsh_dir}: ', end='')
    try:
        os.symlink(dotfiles, os.path.join(zsh_dir, 'dotfiles'))
    except FileExistsError:
        pass
    print('done.')

    print(f'...Linking {profile} and {bash_profile} to {dotfiles}: ', end='')
    try:
        os.symlink(os.path.join(dotfiles, 'profile'), profile)
    except FileExistsError:
        pass
    try:
        os.symlink(os.path.join(dotfiles, 'bash_profile'), bash_profile)
    except FileExistsError:
        pass
    print('done.')

    
    print(f'...Trying initial zsh init: ', end='')
    cmd = f'zsh --login -c "{ZSH_LOGIN_EMU}; echo \$SHELL"'
    ret, out, err = run_shell(cmd, shell=True)
    if ret == 0:
        print('done.')
    else:
        print(f'\n\tError on zsh init, exiting.')
        print(f'\n\tstderr: {err}')
        sys.exit(ret)
    
    print('* Setting up conda config!')
    condarc_df = os.path.join(dotfiles, 'condarc')
    print(f'...Linking {condarc} to {condarc_df}: ', end='')
    os.symlink(condarc_df, condarc)
    print('done.')

    print('* Setting up git config!')
    gitconfig_df = os.path.join(dotfiles, 'gitconfig')
    print(f'...Link {gitconfig} to {gitconfig_df}: ', end='')
    os.symlink(gitconfig_df, gitconfig)
    print('done.')

    print('* Setting up nvim!')
    create_dir(config_dir)
    nvimconf_df = os.path.join(dotfiles, 'nvim')
    print(f'...Linking {nvimconf} to {nvimconf_df}: ', end='')
    os.symlink(nvimconf_df, nvimconf)
    print('done.')
    
    create_dir(bin_dir)
    print('...Downloading nvim appimage: ', end='')
    cmd = ['curl', '-OL', NVIM_APPIMAGE]
    nvim_appimage_exe = os.path.join(bin_dir, 'nvim.appimage')
    nvim_exe = os.path.join(bin_dir, 'nvim')
    run_shell(cmd, in_directory=bin_dir)
    print('done.')
    print(f'...Setting permisions on {nvim_appimage_exe} to u+x: ', end='')
    os.chmod(nvim_appimage_exe, os.stat(nvim_appimage_exe).st_mode | stat.S_IXUSR)
    print('done.')
    print(f'...Linking nvim.appimage to nvim.')
    try:
        os.symlink(nvim_appimage_exe, nvim_exe)
    except FileExistsError as e:
        pass
    
    print(f'* Initializing nvm!')
    print(f'...Installing nodejs {NODEJS_VERSION}: ', end='')
    cmd = f'zsh --login -c  "{ZSH_LOGIN_EMU}; nvm install {NODEJS_VERSION}"'
    ret, out, err = run_shell(cmd, shell=True)
    if ret == 0:
        print(': done.')
    else:
        print(f'\n\tError installing nodejs: {err}')

           
def create_dir(new_dir):
    print(f'...Creating {new_dir}: ', end='')
    try:
        os.makedirs(new_dir, exist_ok=False)
    except FileExistsError as e:
        print(f'\n\t{new_dir} already exists.')
    else:
        print('done.')


def run_shell(cmd, in_directory=None, shell=False):
    cwd = os.getcwd()
    if in_directory:
        os.chdir(in_directory)
    else:
        in_directory = cwd


    print(f'in {in_directory}:', cmd, end='')
    try:
        p = subprocess.Popen(cmd,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE,
                             shell=shell)
        (out, err) = p.communicate()

        out = out.decode('utf-8')
        err = err.decode('utf-8')

        return (p.returncode, out, err)
    finally:
        os.chdir(cwd)


def backup_file(src, cur_time):
    bak = f'{src}.{cur_time}.bak'
    print(f'...{src} => {bak}: ', end='')
    
    if os.path.islink(src):
        target = os.readlink(src)
        print(f'{src} is a symlink to {target}, removing.')
        os.remove(src)
        return None

    try:
        os.rename(src, bak)
    except FileNotFoundError:
        print('file does not exist.')
    else:
        print('done.')
    finally:
        return bak

if __name__ == '__main__':
    main()
