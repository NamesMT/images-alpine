## What this?
## Script to install a similar dev environment like `Dockerfile.node-dev` environment in a fresh Alpine instance, preferably inside of WSL.

# Install basic packages
apk update
apk add --no-cache \
  gcompat libstdc++ zip jq sudo git less zsh curl

# Configures zsh
sh -c "$(wget -qO- https://github.com/deluan/zsh-in-docker/releases/latest/download/zsh-in-docker.sh)" -- \
  -x \
  -t https://github.com/spaceship-prompt/spaceship-prompt \
  -a 'SPACESHIP_USER_SHOW=false' \
  -a 'SPACESHIP_DIR_TRUNC_REPO=false' \
  -p command-not-found \
  -p git \
  -p history-substring-search \
  -p z \
  -p https://github.com/zsh-users/zsh-autosuggestions \
  -p https://github.com/zsh-users/zsh-completions \
  -p https://github.com/zsh-users/zsh-syntax-highlighting

# set zsh as default shell
sed -i 's/\/root:\/bin\/ash/\/root:\/bin\/zsh/g' /etc/passwd
zsh
export SHELL=/bin/zsh

# Install required build packages for nvm and install lts node using nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc

# Setup alternative nodejs mirror for nvm (for alpine musl builds)
touch /etc/profile.d/nvmMirror.sh && \
  echo 'export NVM_NODEJS_ORG_MIRROR=https://unofficial-builds.nodejs.org/download/release' >> /etc/profile.d/nvmMirror.sh && \
  source /etc/profile.d/nvmMirror.sh

nvm install --lts

# Setup the environment path for pnpm
touch /etc/profile.d/pnpmPath.sh && \
  echo 'export PNPM_HOME=/root/.local/share/pnpm' >> /etc/profile.d/pnpmPath.sh && \
  echo 'export PATH=$PNPM_HOME:$PATH' >> /etc/profile.d/pnpmPath.sh && \
  source /etc/profile.d/pnpmPath.sh

# Install pnpm and ni
npx pnpm i -g pnpm@latest
pnpm i -g @antfu/ni && \
  touch ~/.nirc && \
  echo 'defaultAgent=pnpm' >> ~/.nirc && \
  echo 'globalAgent=pnpm' >> ~/.nirc

# Adding a simple command to change git remote connection from/to ssh/https
touch /etc/profile.d/gitRemoteChanger.sh && \
  echo alias git-ssh=\'git remote set-url origin \"\$\(git remote get-url origin \| sed -E \'\\\'\'s,\^https://\(\[\^/\]\*\)/\(.\*\)\$,git@\\1:\\2,\'\\\'\'\)\"\' >> /etc/profile.d/gitRemoteChanger.sh && \
  echo alias git-https=\'git remote set-url origin \"\$\(git remote get-url origin \| sed -E \'\\\'\'s,\^git@\(\[\^:\]\*\):/\*\(.\*\)\$,https://\\1/\\2,\'\\\'\'\)\"\' >> /etc/profile.d/gitRemoteChanger.sh && \
  source /etc/profile.d/gitRemoteChanger.sh
