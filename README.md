## Features
- Alpine 3.18
- Latest Node LTS & pnpm (**node**)
  - [@antfu/ni](https://github.com/antfu/ni)
- Self-built aws-cli v2 (**aws**)
- git + curl + zsh + Oh My Zsh! (**dev**)
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

Build command:
```sh
export iaTAG= # node | node-dev | node-aws ...
podman build --build-arg AWS_CLI_VERSION=2.13.28 -t namesmt/images-alpine:${iaTAG} -f Dockerfile.${iaTAG}
podman push namesmt/images-alpine:${iaTAG}
```

Refs:
- `https://github.com/aws/aws-cli/tags`

## Roadmap
- [ ] Github Actions to automate build

## Credits:
- [theidledeveloper/aws-cli-alpine](https://github.com/theidledeveloper/aws-cli-alpine): most of starting points
