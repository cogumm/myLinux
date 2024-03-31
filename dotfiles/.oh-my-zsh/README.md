# Instalando os temas personalizados.

## Powerlevel10k

Instalando o powerlevel10k:

```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Definindo no arquivo zshrc

```
ZSH_THEME="powerlevel10k/powerlevel10k"
```

## Spaceship

Instalando o spaceship:

```
git clone https://github.com/spaceship-prompt/spaceship-prompt.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship-prompt" --depth=1
```

Criando um link simbólico:

```
ln -s ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme" ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship.zsh-theme"
```

Definindo no arquivo zshrc

```
ZSH_THEME="spaceship"
```