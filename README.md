# Challenge MB - App de Exchanges de Criptomoedas

## 📱 Sobre o Projeto

Este é um aplicativo Flutter desenvolvido para um processo seletivo, que consulta exchanges de criptomoedas através da API do CoinMarketCap e exibe suas informações em uma interface moderna e responsiva. O projeto demonstra boas práticas de desenvolvimento Flutter, seguindo princípios SOLID, Clean Architecture e alta testabilidade.

## 🏗️ Arquitetura

O projeto segue os princípios da **Clean Architecture** com **Flutter BLoC** para gerenciamento de estado, implementando uma arquitetura modular e escalável:

### 📁 Estrutura de Pastas

```
lib/
├── core/                    
│   ├── config/             
│   ├── infra/              
│   │   ├── di/             
│   │   ├── errors/         
│   │   └── http/           
│   ├── theme/              
│   ├── widgets/            
│   ├── extensions/         
│   └── routes/             
├── src/                     
│   └── features/
│       └── exchanges/      
│           ├── domain/      
│           │   ├── entities/    
│           │   ├── repositories/ 
│           │   └── usecases/    
│           ├── data/        
│           │   ├── datasources/ 
│           │   ├── models/      
│           │   ├── mappers/     
│           │   └── repositories/ 
│           └── presentation/ 
│               ├── bloc/        
│               ├── pages/       
│               └── widgets/     
└── main.dart               
```

### 🎯 Princípios Arquiteturais

- **Clean Architecture**: Separação clara entre camadas (Domain, Data, Presentation)
- **SOLID**: Princípios de design orientado a objetos
- **Dependency Injection**: Uso do GetIt para injeção de dependências
- **Repository Pattern**: Abstração da fonte de dados
- **BLoC Pattern**: Gerenciamento de estado reativo
- **Error Handling**: Tratamento centralizado de erros


## 🛠️ Tecnologias Utilizadas

### Core
- **Flutter**: Framework de desenvolvimento (3.8.1+)
- **Dart**: Linguagem de programação (3.8.1+)

### State Management & Navigation
- **Flutter BLoC**: Gerenciamento de estado reativo
- **GoRouter**: Navegação declarativa e type-safe
- **Equatable**: Comparação de objetos

### Dependency Injection & Utils
- **GetIt**: Injeção de dependência
- **Dartz**: Programação funcional (Either, Option)
- **Logger**: Sistema de logs

### HTTP & API
- **HTTP**: Cliente HTTP customizado
- **JSON Annotation**: Serialização de dados
- **Flutter Dotenv**: Variáveis de ambiente

### UI & Design
- **Flutter SVG**: Renderização de ícones SVG
- **URL Launcher**: Abertura de links externos
- **Intl**: Internacionalização e formatação

### Testing
- **Mocktail**: Mocks para testes
- **BLoC Test**: Testes de BLoCs
- **Golden Toolkit**: Testes visuais (Golden Tests)
- **Network Image Mock**: Mock de imagens de rede

### Development
- **Build Runner**: Geração de código
- **Flutter Lints**: Análise estática de código

## 📋 Requisitos

### Sistema
- **Flutter SDK**: 3.8.1 ou superior
- **Dart**: 3.8.1 ou superior
- **Android Studio** / **VS Code** com extensões Flutter
- **Git**: Para controle de versão

### Dispositivos Suportados
- **Android**: API 21+ (Android 5.0+)
- **iOS**: iOS 12.0+
- **Web**: Chrome, Firefox, Safari, Edge
- **Desktop**: Windows, macOS, Linux

## 🚀 Como Executar

### 1. **Clone o Repositório**
```bash
git clone <url-do-repositorio>
cd challenge_mb
```

### 2. **Instale as Dependências**
```bash
flutter pub get
```

### 3. **Configure as Variáveis de Ambiente**
```bash
# Copie o template de configuração
cp env_template.txt .env

# Edite o arquivo .env com suas configurações
# Veja a seção "Configuração da API" abaixo
```

### 4. **Execute o App**
```bash
# Desenvolvimento
flutter run

# Modo release
flutter run --release

# Web
flutter run -d chrome

# Dispositivo específico
flutter run -d <device-id>
```

## 🔧 Configuração da API

### 1. **Obtenha uma API Key**
- Acesse [CoinMarketCap API](https://coinmarketcap.com/api/)
- Crie uma conta gratuita
- Gere sua API Key

### 2. **Configure o Arquivo .env**
```bash
# Copie o template
cp env_template.txt .env

# Edite o arquivo .env
nano .env
```

### 3. **Conteúdo do .env**
```env
# 🌐 Configurações da API
BASE_URL=https://pro-api.coinmarketcap.com/v1

# 🔑 API Key do CoinMarketCap
COINMARKETCAP_API_KEY=sua_api_key_aqui

# 📊 Configurações de ambiente
ENVIRONMENT=development
DEBUG=true
```

### 4. **Verificação**
O app verificará automaticamente se as variáveis estão configuradas corretamente na inicialização.

## 🧪 Testes

### Testes Unitários
```bash
# Executar todos os testes unitários
flutter test

# Executar testes específicos
flutter test test/src/features/exchanges/

# Executar com cobertura
flutter test --coverage

# Gerar relatório de cobertura
genhtml coverage/lcov.info -o coverage/html
```

### Testes de UI (Golden Tests)
```bash
# Usando o script customizado
./scripts/run_golden_tests.sh

# Opções disponíveis:
./scripts/run_golden_tests.sh -h                    # Ajuda
./scripts/run_golden_tests.sh -a                    # Todos os testes
./scripts/run_golden_tests.sh -c                    # Apenas widgets core
./scripts/run_golden_tests.sh -f                    # Apenas features
./scripts/run_golden_tests.sh -u                    # Atualizar imagens
./scripts/run_golden_tests.sh -d chrome             # Device específico

# Usando Flutter diretamente
flutter test test/ui/ --update-goldens
flutter test test/ui/golden_test_runner.dart
```

### Análise de Código
```bash
# Análise estática
flutter analyze

# Formatação de código
dart format lib/ test/

# Verificar dependências
flutter pub deps
flutter pub outdated
```

## 🎨 Design System

### Componentes Reutilizáveis
- **core/widgets**

### Temas
- **core/theme**

## 📄 Licença

Este projeto foi desenvolvido para fins educacionais e de processo seletivo, demonstrando boas práticas de desenvolvimento Flutter.

## 👨‍💻 Desenvolvedor

Desenvolvido com ❤️ seguindo as melhores práticas de Flutter, Clean Architecture, princípios SOLID e alta testabilidade.

