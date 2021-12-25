# gal

gal is a minimalst zsh theme intended primarly for personal use. based on [gallois](https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/gallois.zsh-theme).

![scrot](./assets/scrot.png)

## installation

- ### [zinit](https://github.com/zdharma-continuum/zinit)

  ```sh
  zinit ice wait'!0'
  zinit light x6r/gal
  ```

  - in `.zshrc`

- ### [antigen](https://github.com/zsh-users/antigen)

  ```sh
  antigen theme x6r/gal gal
  ```

  - in `.zshrc`

- ### [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)

  - clone this repo

  - symlink the theme file

  ```sh
  ln -s gal/gal.zsh-theme ~/.ohmyzsh/themes/
  ```

  - set the theme in `.zshrc`

  ```sh
  ZSH_THEME="gal"
  ```
