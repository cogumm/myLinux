#!/usr/bin/env bash
#---------------------------------------------------------------------------#
# Data criação: 17 de Novembro de 2026
# Última alteração: 17 de Novembro de 2026
# Nome: Gabriel F. Vilar (CoGUMm)
# E-mail: gabriel[at]cogumm[dot]net
# Telegram: http://t.me/CoGUMm
# Script: apply
# Descrição: Aplica dotfiles no $HOME com backup *.bak (sem root).
# Uso: ./apply.sh [--dry-run] [--symlink] [--all] [--aliases] [--git] [--hyper] [--theme] [--bashrc]
#---------------------------------------------------------------------------#
set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_HOME="${HOME}"

DRY_RUN=0
USE_SYMLINK=0
DO_ALIASES=0
DO_GIT=0
DO_HYPER=0
DO_THEME=0
DO_BASHRC=0
ANY_MODULE=0

_log() { echo "[dotfiles] $*"; }
_err() { echo "[dotfiles:error] $*" >&2; }

_usage() {
	cat <<'EOF'
Apply myLinux dotfiles into $HOME (never requires root).

Usage:
  ./apply.sh [options]

Options:
  --dry-run     Show actions only
  --symlink     Symlink instead of copy
  --aliases     ~/.bash_aliases + ~/.aliases/*  (default if no module given)
  --git         ~/.gitconfig + ~/.gitignore_global
  --hyper       ~/.hyper.js
  --theme       ~/.oh-my-zsh/themes/cgm.zsh-theme (only if oh-my-zsh exists)
  --bashrc      ~/.bashrc from Bash/cGm_.bashrc (opt-in; overwrites after .bak)
  --all         aliases + git + hyper + theme (not bashrc)
  -h, --help    This help

Existing files are renamed to *.bak (or *.bak.<timestamp> if .bak exists).
EOF
}

_backup_dest() {
	local dest="$1"
	local bak="${dest}.bak"
	if [[ ! -e "$dest" && ! -L "$dest" ]]; then
		return 0
	fi
	if [[ -e "$bak" || -L "$bak" ]]; then
		bak="${dest}.bak.$(date +%Y%m%d%H%M%S)"
	fi
	if ((DRY_RUN)); then
		_log "dry-run: backup $dest → $bak"
		return 0
	fi
	mv -- "$dest" "$bak"
	_log "backup: $dest → $bak"
}

_same_file() {
	local src="$1"
	local dest="$2"
	if [[ -L "$dest" ]]; then
		local cur
		cur="$(readlink -f "$dest" 2>/dev/null || readlink "$dest" 2>/dev/null || true)"
		local want
		want="$(readlink -f "$src" 2>/dev/null || echo "$src")"
		[[ -n "$cur" && "$cur" == "$want" ]]
		return
	fi
	[[ -f "$dest" && -f "$src" ]] && cmp -s -- "$src" "$dest"
}

_apply_one() {
	local src="$1"
	local dest="$2"

	if [[ ! -e "$src" ]]; then
		_err "missing source: $src"
		return 1
	fi

	if _same_file "$src" "$dest"; then
		_log "skip (already up to date): $dest"
		return 0
	fi

	local dest_dir
	dest_dir="$(dirname -- "$dest")"
	if ((DRY_RUN)); then
		_log "dry-run: mkdir -p $dest_dir"
	else
		mkdir -p -- "$dest_dir"
	fi

	_backup_dest "$dest"

	if ((USE_SYMLINK)); then
		if ((DRY_RUN)); then
			_log "dry-run: ln -sfn $src $dest"
		else
			ln -sfn -- "$src" "$dest"
			_log "symlink: $dest → $src"
		fi
	else
		if ((DRY_RUN)); then
			_log "dry-run: cp -a $src $dest"
		else
			cp -a -- "$src" "$dest"
			_log "copy: $src → $dest"
		fi
	fi
}

_apply_aliases() {
	_apply_one "${DOTFILES_ROOT}/.bash_aliases" "${TARGET_HOME}/.bash_aliases"
	local f
	local oldnullglob
	oldnullglob=$(shopt -p nullglob || true)
	shopt -s nullglob
	for f in "${DOTFILES_ROOT}/.aliases/"*_aliases; do
		_apply_one "$f" "${TARGET_HOME}/.aliases/$(basename -- "$f")"
	done
	eval "$oldnullglob" 2>/dev/null || true
}

_apply_git() {
	_log "note: git/.gitconfig is a personal template — keep tokens empty"
	_apply_one "${DOTFILES_ROOT}/git/.gitconfig" "${TARGET_HOME}/.gitconfig"
	_apply_one "${DOTFILES_ROOT}/git/.gitignore_global" "${TARGET_HOME}/.gitignore_global"
}

_apply_hyper() {
	_apply_one "${DOTFILES_ROOT}/HyperTerminal/.hyper.js" "${TARGET_HOME}/.hyper.js"
}

_apply_theme() {
	local omz_themes="${TARGET_HOME}/.oh-my-zsh/themes"
	if [[ ! -d "$omz_themes" ]]; then
		_log "skip theme: $omz_themes not found (install oh-my-zsh first)"
		return 0
	fi
	_apply_one "${DOTFILES_ROOT}/.oh-my-zsh/themes/cgm.zsh-theme" \
		"${omz_themes}/cgm.zsh-theme"
}

_apply_bashrc() {
	_apply_one "${DOTFILES_ROOT}/Bash/cGm_.bashrc" "${TARGET_HOME}/.bashrc"
}

while (($# > 0)); do
	case "$1" in
		--dry-run) DRY_RUN=1 ;;
		--symlink) USE_SYMLINK=1 ;;
		--aliases) DO_ALIASES=1; ANY_MODULE=1 ;;
		--git) DO_GIT=1; ANY_MODULE=1 ;;
		--hyper) DO_HYPER=1; ANY_MODULE=1 ;;
		--theme) DO_THEME=1; ANY_MODULE=1 ;;
		--bashrc) DO_BASHRC=1; ANY_MODULE=1 ;;
		--all)
			DO_ALIASES=1
			DO_GIT=1
			DO_HYPER=1
			DO_THEME=1
			ANY_MODULE=1
			;;
		-h|--help)
			_usage
			exit 0
			;;
		*)
			_err "unknown option: $1"
			_usage
			exit 2
			;;
	esac
	shift
done

if [[ "$(id -u)" -eq 0 ]]; then
	_err "recusando root — apply escreve em \$HOME do usuário (agora: ${TARGET_HOME}). Rode sem sudo."
	exit 1
fi

if ((ANY_MODULE == 0)); then
	DO_ALIASES=1
fi

_log "root: $DOTFILES_ROOT"
_log "target: $TARGET_HOME"
((DRY_RUN)) && _log "mode: dry-run"
((USE_SYMLINK)) && _log "mode: symlink" || _log "mode: copy"

((DO_ALIASES)) && _apply_aliases
((DO_GIT)) && _apply_git
((DO_HYPER)) && _apply_hyper
((DO_THEME)) && _apply_theme
((DO_BASHRC)) && _apply_bashrc

_log "done. Reload the shell (source ~/.bashrc / new terminal) if aliases changed."
# Fim
