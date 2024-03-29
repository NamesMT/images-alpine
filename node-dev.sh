## What this?
## Script to install the same node-dev environment in a fresh Alpine instance, preferably inside of WSL.

# Setting the required environment path for pnpm
touch /etc/profile.d/pnpmPath.sh && \
  echo 'export PNPM_HOME=/root/.local/share/pnpm' >> /etc/profile.d/pnpmPath.sh && \
  echo 'export PATH=$PNPM_HOME:$PATH' >> /etc/profile.d/pnpmPath.sh && \
  source /etc/profile.d/pnpmPath.sh

# Installing packages
apk update
apk add --no-cache \
  gcompat libstdc++ zip jq sudo git less zsh curl nodejs npm

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
sed -i 's/\/root:\/bin\/ash/\/root:\/bin\/zsh/g' /etc/passwd
