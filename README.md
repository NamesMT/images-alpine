## Features
- Alpine 3.18
- Latest Node LTS & pnpm (**node**)
  - [@antfu/ni](https://github.com/antfu/ni)
- Self-built latest aws-cli v2 (**aws**)
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
export imageName = namesmt/images-alpine
export imageTag= # node | node-dev | node-aws ...
podman build --build-arg -t imageName:${imageTag} -f Dockerfile.${imageTag}
podman push imageName:${imageTag}
```

## Roadmap
- [x] Github Actions to automate build
  - builds will be automated with each pnpm release

## Credits:
- [theidledeveloper/aws-cli-alpine](https://github.com/theidledeveloper/aws-cli-alpine): most of starting points
