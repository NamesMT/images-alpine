## What this?
Commands to install the same node-dev environment in a fresh Alpine instance, preferably inside of WSL.

```sh
# Setting the required environment path for pnpm
touch /etc/profile.d/pnpmPath.sh
echo 'export PNPM_HOME=/root/.local/share/pnpm' >> /etc/profile.d/pnpmPath.sh
echo 'export PATH=$PNPM_HOME:$PATH' >> /etc/profile.d/pnpmPath.sh
source /etc/profile.d/pnpmPath.sh

# Installing packages
apk update
apk add --no-cache \
  gcompat libstdc++ zip jq sudo git less zsh curl nodejs npm

# Install pnpm and ni
npx pnpm i -g pnpm@latest
pnpm i -g @antfu/ni && echo 'globalAgent=pnpm' > /root/.nirc

# Configures zsh
sh -c "$(wget -qO- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
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
```
