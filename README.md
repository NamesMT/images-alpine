# [namesmt/images-alpine](https://github.com/NamesMT/images-alpine) - [Docker link](https://hub.docker.com/repository/docker/namesmt/images-alpine/general)
![Docker Pulls](https://img.shields.io/docker/pulls/namesmt/images-alpine)
![Docker Image Size (node)](https://img.shields.io/docker/image-size/namesmt/images-alpine/node?label=image%20size%3Anode)
![Docker Image Size (node-aws-dev)](https://img.shields.io/docker/image-size/namesmt/images-alpine/node-aws-dev?label=image%20size%3Anode-aws-dev)

### Features:
- Alpine 3.20
- Latest Node LTS & pnpm (**node**)
  - [@antfu/ni](https://github.com/antfu/ni)
- Self-built latest aws-cli v2 (**aws**)
- git + Oh My Zsh! (**dev**)
  - Theme: [spaceship](https://spaceship-prompt.sh/)
    - SPACESHIP_USER_SHOW=false
    - SPACESHIP_DIR_TRUNC_REPO=false
  - Plugins:
    - command-not-found
    - git
    - history-substring-search
    - z
    - https://github.com/zsh-users/zsh-autosuggestions
    - https://github.com/zsh-users/zsh-completions
    - https://github.com/zsh-users/zsh-syntax-highlighting
- These common packages are also installed for all suffix/version:
  - `gcompat` `libstdc++` `zip` `unzip` `jq` `sudo` `curl`

---

### Use:
Available on Docker registry: (auto-built on pnpm releases)
```sh
docker run -it --rm namesmt/images-alpine:node-dev

# For CIs, you should pin the version: 
docker run -it --rm namesmt/images-alpine:node-dev_pnpm8.10.5
```

#### WSL2 Alpine Quick Start:
Follow [Yuka](https://github.com/yuk7/AlpineWSL)'s instruction to install Alpine WSL2

Setting up `node-dev` *([`fnm`](https://github.com/Schniz/fnm) included to manage node version)*:
```sh
wget https://raw.githubusercontent.com/NamesMT/images-alpine/main/node-dev.sh -O- | bash
```

#### Additional scripts:
##### [fnm](https://github.com/Schniz/fnm) - Fast Node Manager, similar to `nvm`
```sh
wget https://raw.githubusercontent.com/NamesMT/images-alpine/main/scripts/install-fnm.sh -O- | sh
```
##### Docker
```sh
wget https://raw.githubusercontent.com/NamesMT/images-alpine/main/scripts/install-docker.sh -O- | sh
```

---

### Build:
```sh
export imageName=namesmt/images-alpine
export imageTag= # node | node-dev | node-aws ...
docker build -f "Dockerfile.${imageTag}" -t "${imageName}:${imageTag}" "."
docker push "${imageName}:${imageTag}"
```

## Roadmap
- [x] Github Actions to automate build
  - builds will be automated with each pnpm release

## Credits:
- [theidledeveloper/aws-cli-alpine](https://github.com/theidledeveloper/aws-cli-alpine): most of starting points
