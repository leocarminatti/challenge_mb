#!/bin/bash

# Script para executar Golden Tests
# Uso: ./scripts/run_golden_tests.sh [opções]

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para mostrar ajuda
show_help() {
    echo "Uso: $0 [opções]"
    echo ""
    echo "Opções:"
    echo "  -h, --help              Mostra esta ajuda"
    echo "  -a, --all               Executa todos os golden tests"
    echo "  -c, --core              Executa apenas os testes dos widgets core"
    echo "  -f, --features          Executa apenas os testes das features"
    echo "  -u, --update            Atualiza as imagens de referência"
    echo "  -v, --verbose           Modo verboso"
    echo "  -d, --device <device>   Especifica o device para teste"
    echo ""
    echo "Exemplos:"
    echo "  $0 -a                    # Executa todos os testes"
    echo "  $0 -c -u                 # Executa testes core e atualiza imagens"
    echo "  $0 -f -d chrome          # Executa testes de features no Chrome"
}

# Variáveis padrão
UPDATE_GOLDENS=false
VERBOSE=false
DEVICE=""
TEST_PATH=""

# Processar argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -a|--all)
            TEST_PATH="test/ui/golden_test_runner.dart"
            shift
            ;;
        -c|--core)
            TEST_PATH="test/ui/core/widgets/"
            shift
            ;;
        -f|--features)
            TEST_PATH="test/ui/features/"
            shift
            ;;
        -u|--update)
            UPDATE_GOLDENS=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -d|--device)
            DEVICE="$2"
            shift 2
            ;;
        *)
            echo -e "${RED}Erro: Opção desconhecida $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Se nenhum caminho foi especificado, usar todos os testes
if [ -z "$TEST_PATH" ]; then
    TEST_PATH="test/ui/golden_test_runner.dart"
fi

# Construir comando Flutter
FLUTTER_CMD="flutter test"

if [ "$UPDATE_GOLDENS" = true ]; then
    FLUTTER_CMD="$FLUTTER_CMD --update-goldens"
    echo -e "${YELLOW}⚠️  Modo de atualização ativado - as imagens de referência serão atualizadas${NC}"
fi

if [ "$VERBOSE" = true ]; then
    FLUTTER_CMD="$FLUTTER_CMD --verbose"
fi

if [ -n "$DEVICE" ]; then
    FLUTTER_CMD="$FLUTTER_CMD -d $DEVICE"
fi

FLUTTER_CMD="$FLUTTER_CMD $TEST_PATH"

# Verificar se o Flutter está disponível
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter não encontrado. Certifique-se de que o Flutter está instalado e no PATH.${NC}"
    exit 1
fi

# Verificar se estamos no diretório correto
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}❌ pubspec.yaml não encontrado. Execute este script no diretório raiz do projeto Flutter.${NC}"
    exit 1
fi

# Verificar se as dependências estão instaladas
echo -e "${BLUE}🔍 Verificando dependências...${NC}"
flutter pub get

# Executar os testes
echo -e "${BLUE}🚀 Executando Golden Tests...${NC}"
echo -e "${BLUE}Comando: $FLUTTER_CMD${NC}"
echo ""

# Executar o comando
if eval $FLUTTER_CMD; then
    echo ""
    echo -e "${GREEN}✅ Golden Tests executados com sucesso!${NC}"
    
    if [ "$UPDATE_GOLDENS" = true ]; then
        echo -e "${YELLOW}📸 Imagens de referência atualizadas${NC}"
    fi
else
    echo ""
    echo -e "${RED}❌ Golden Tests falharam${NC}"
    exit 1
fi
