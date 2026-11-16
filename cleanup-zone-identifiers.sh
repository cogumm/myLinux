#!/bin/bash

# Script de Limpeza de Arquivos Zone.Identifier
# Autor: Sistema de Limpeza Automatizada
# Data: $(date +"%Y-%m-%d")
# Descrição: Remove todos os arquivos :Zone.Identifier criados pelo Windows

set -e  # Para em caso de erro

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para imprimir mensagens coloridas
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Banner do script
echo "=================================================="
echo "  Script de Limpeza - Arquivos Zone.Identifier"
echo "=================================================="
echo ""

# Processar argumentos
FORCE_MODE=false
SEARCH_DIR=""

for arg in "$@"; do
    case $arg in
        --force|-f)
            FORCE_MODE=true
            ;;
        *)
            if [ -z "$SEARCH_DIR" ]; then
                SEARCH_DIR="$arg"
            fi
            ;;
    esac
done

# Verifica se um diretório foi passado como argumento
if [ -z "$SEARCH_DIR" ]; then
    SEARCH_DIR=$(pwd)
    print_info "Nenhum diretório especificado. Usando diretório atual: $SEARCH_DIR"
else
    if [ ! -d "$SEARCH_DIR" ]; then
        print_error "Diretório não encontrado: $SEARCH_DIR"
        exit 1
    fi
    print_info "Usando diretório especificado: $SEARCH_DIR"
fi

echo ""

# Função para contar arquivos Zone.Identifier
count_zone_files() {
    local count=$(find "$SEARCH_DIR" -name "*:Zone.Identifier" -type f 2>/dev/null | wc -l)
    echo $count
}

# Verifica quantos arquivos existem antes da limpeza
print_info "Verificando arquivos Zone.Identifier no diretório: $SEARCH_DIR"
initial_count=$(count_zone_files)

if [ $initial_count -eq 0 ]; then
    print_success "Nenhum arquivo Zone.Identifier encontrado. Sistema já está limpo!"
    exit 0
else
    print_warning "Encontrados $initial_count arquivos Zone.Identifier"
fi

# Lista alguns exemplos (máximo 10) dos arquivos encontrados
echo ""
print_info "Exemplos de arquivos que serão removidos:"
find "$SEARCH_DIR" -name "*:Zone.Identifier" -type f 2>/dev/null | head -10 | while read file; do
    echo "  • $file"
done

if [ $initial_count -gt 10 ]; then
    echo "  ... e mais $((initial_count - 10)) arquivos"
fi

echo ""

# Pergunta confirmação (pode ser desabilitada com --force)
if [ "$FORCE_MODE" != true ]; then
    read -p "Deseja continuar com a remoção? [y/N]: " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Operação cancelada pelo usuário."
        exit 0
    fi
fi

echo ""
print_info "Iniciando processo de limpeza..."

# Função para remover arquivos com tratamento de erro
remove_zone_files() {
    local removed_count=0
    local failed_count=0
    
    # Usar while loop para melhor controle de erro
    find "$SEARCH_DIR" -name "*:Zone.Identifier" -type f 2>/dev/null | while read -r file; do
        if rm -f "$file" 2>/dev/null; then
            ((removed_count++))
            if [ $((removed_count % 10)) -eq 0 ]; then
                echo -n "."  # Progresso visual a cada 10 arquivos
            fi
        else
            ((failed_count++))
            print_warning "Falha ao remover: $file"
        fi
    done
}

# Executar remoção
print_info "Removendo arquivos Zone.Identifier..."
find "$SEARCH_DIR" -name "*:Zone.Identifier" -type f -print0 2>/dev/null | xargs -0 -r rm -f

echo ""

# Verificar resultado final
final_count=$(count_zone_files)
removed_files=$((initial_count - final_count))

echo ""
print_info "Resultado da limpeza:"
echo "  • Arquivos encontrados inicialmente: $initial_count"
echo "  • Arquivos removidos: $removed_files"
echo "  • Arquivos restantes: $final_count"

# Verificar se todos foram removidos
if [ $final_count -eq 0 ]; then
    print_success "✅ Limpeza concluída com sucesso! Todos os arquivos Zone.Identifier foram removidos."
else
    print_warning "⚠️  Alguns arquivos não puderam ser removidos. Verifique as permissões."
    echo ""
    print_info "Arquivos restantes:"
    find "$SEARCH_DIR" -name "*:Zone.Identifier" -type f 2>/dev/null | head -5 | while read file; do
        echo "  • $file"
    done
fi

# Estatísticas de espaço (opcional)
if command -v du >/dev/null 2>&1; then
    echo ""
    print_info "Espaço total do diretório após limpeza:"
    du -sh "$SEARCH_DIR" 2>/dev/null || echo "Não foi possível calcular o tamanho"
fi

echo ""
print_success "Script de limpeza finalizado!"
echo "=================================================="
