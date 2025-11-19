# ContactHub - Sistema de Gestão de Contatos
Sistema completo para gestão de contatos desenvolvido em Delphi com arquitetura MVC e banco de dados PostgreSQL.

## 📞 Visão Geral

O Sistema **ContactHub** é uma solução completa para gerenciamento de contatos, permitindo o controle total de pessoas, empresas, usuários e mensagens. O sistema oferece interface intuitiva e funcionalidades robustas para otimizar o fluxo de trabalho de gestão de relacionamento.

## ✨ Funcionalidades

### 🧾 Gestão de Contatos
- **Cadastro Completo**: Informações pessoais e profissionais
- **Controle de Dados**: Nome, telefone, email, empresa, endereço completo
- **Sistema de Ativação/Desativação**: Soft delete com campo ativo
- **Busca e Filtragem**: Busca rápida por nome, telefone, email
- **Favoritos**: Sistema de favoritos personalizado por usuário
- **Edição Inline**: Edição direta na grade com atualização imediata

### 🏢 Gestão de Empresas
- **Cadastro de Empresas**: Informações corporativas completas
- **Validação de CNPJ**: Validação automática de CNPJ
- **Gerenciamento de Contato**: Telefone, email, endereço
- **Controle de Status**: Sistema de ativação/desativação
- **Associação com Contatos**: Vínculo entre contatos e empresas

### 📝 Sistema de Mensagens
- **Mensagens Internas**: Comunicação entre usuários
- **Controle de Destinatários**: Envio para usuários específicos
- **Registro de Mensagens**: Histórico completo de comunicações
- **Status Management**: Mensagens lidas/não lidas

### 👥 Gestão de Usuários
- **Sistema de Autenticação**: Login seguro com MD5 password hashing
- **Múltiplos Níveis de Permissão**: Sistema RBAC completo
- **Gerenciamento de Contas**: Administração completa de usuários
- **Controle de Acesso**: Permissões granulares por funcionalidade

### 🌟 Sistema de Favoritos
- **Contatos Favoritos**: Marcação de contatos como favoritos
- **Gestão por Usuário**: Favoritos específicos por usuário
- **Toggle Functionality**: Adicionar/remover favoritos facilmente
- **Data de Criação**: Controle de quando foi adicionado

### 📤 Importação e Exportação
- **Importação VCard**: Suporte para arquivos .vcf
- **Exportação de Dados**: Múltiplos formatos
- **Migração de Contatos**: Importação de outras fontes

### 📊 Sistema de Relatórios
- **Relatórios por Empresas**: Lista completa de empresas
- **Relatórios por Contatos**: Informações detalhadas de contatos
- **Relatórios de Usuários**: Gestão de usuários e permissões
- **Exportação em Diversos Formatos**: PDF, Excel, HTML

### 📝 Logs do Sistema
- **Registro Completo**: Todas as operações são registradas
- **Logs de Contatos**: Operações de inclusão, alteração, exclusão
- **Logs de Usuários**: Ações dos usuários no sistema
- **Auditoria e Rastreabilidade**: Histórico completo de ações

## 🏗️ Arquitetura

O sistema implementa uma arquitetura MVC (Model-View-Controller) bem definida:

**Model**: Classes de dados e entidades com getters/setters
**View**: Interfaces de usuário (formulários Delphi VCL)
**Controller**: Lógica de negócio e controle
**Repository**: Camada de acesso a dados com PostgreSQL
**Utils**: Utilitários e funcionalidades auxiliares

## 🔧 Tecnologias

- **Linguagem**: Object Pascal (Delphi)
- **Banco de Dados**: PostgreSQL
- **Relatórios**: FastReport
- **Framework**: VCL (Visual Component Library)
- **Acesso a Dados**: FireDAC

## 📁 Estrutura do Projeto

```
/ProjetoFinalDelphi/
├── Controller/                # Controladores da aplicação
│   ├── ContatosController.pas     # Gestão de contatos
│   ├── LoginUsuarioController.pas # Autenticação
│   ├── CadastroUsuarioController.pas # Cadastro de usuários
│   ├── EmpresaController.pas      # Gestão de empresas
│   ├── FavoritosController.pas    # Sistema de favoritos
│   ├── GruposController.pas       # Gestão de grupos
│   ├── PermissoesController.pas   # Sistema de permissões
│   └── [Outros controllers]
├── Model/                     # Modelos de dados
│   ├── TContatosModel.pas         # Entidade de contatos
│   ├── TUsuarioModel.pas          # Entidade de usuários
│   ├── EmpresaModel.pas           # Entidade de empresas
│   ├── FavoritosModel.pas         # Entidade de favoritos
│   ├── GruposModel.pas            # Entidade de grupos
│   ├── PermissoesModel.pas        # Entidade de permissões
│   ├── ConfiguracaoModel.pas      # Configurações do sistema
│   └── [Outros models]
├── Repository/                # Camada de acesso a dados
│   ├── ContatosRepository.pas     # Acesso a dados de contatos
│   ├── TUsuarioRepository.pas     # Acesso a dados de usuários
│   ├── ConexaoBanco.pas           # Conexão PostgreSQL
│   ├── EmpresaRepository.pas      # Acesso a dados de empresas
│   ├── FavoritosRepository.pas    # Acesso a dados de favoritos
│   ├── GruposRepository.pas       # Acesso a dados de grupos
│   └── [Outros repositories]
├── View/                      # Interfaces de usuário
│   ├── uMain.pas               # Tela principal com navegação
│   ├── uLogin.pas              # Tela de login
│   ├── uCadastroUsuariosView.pas # Cadastro de usuários
│   ├── [Outras telas]
├── Pictures/                  # Imagens e ícones
├── lib/                      # Bibliotecas externas (libpq.dll)
├── Logs/                     # Logs do sistema
├── Project2.dpr              # Arquivo principal do projeto
├── Project2.dproj            # Projeto Delphi
└── README.md                 # Este arquivo
```

## 🗄️ Banco de Dados

O sistema utiliza PostgreSQL com as seguintes tabelas principais:

**"Contato"**: Dados dos contatos com soft delete
**"Empresa"**: Informações das empresas com validação CNPJ
**"Usuario"**: Sistema de autenticação e usuários
**"Favoritos"**: Sistema de favoritos por usuário
**"Mensagens"**: Sistema de mensagens internas
**"Configuracao"**: Configurações do sistema
**"grupo_usuarios"**: Controle de permissões

## 🚀 Instalação

### Pré-requisitos
- Delphi 20.1 ou superior
- PostgreSQL 12 ou superior
- FastReport para geração de relatórios

### Passos para instalação

1. **Configure o banco de dados:**
   ```bash
   # Crie o banco ContactHub no PostgreSQL
   CREATE DATABASE contacthub;
   ```

2. **Configure a conexão:**
   - Servidor: localhost
   - Porta: 5432
   - Banco: ContactHub
   - Usuário: postgres
   - Senha: root

3. **Abra o projeto no Delphi:**
   - Abra o arquivo Project2.dpr
   - Compile o projeto (Ctrl+F9)

4. **Execute a aplicação:**
   - Execute o projeto (F9)
   - Faça login com as credenciais padrão

## 📖 Como Usar

### Login
1. Abra a aplicação
2. Digite usuário e senha
3. Clique em "Entrar"

### Módulos Principais

**Contatos:**
- Adicione novos contatos clicando em "Novo"
- Preencha todos os campos obrigatórios
- Salve as alterações
- Use o campo de busca para encontrar contatos rapidamente
- Marque contatos como favoritos para acesso rápido

**Empresas:**
- Cadastre as empresas da sua rede de contatos
- Mantenha os dados atualizados
- Valide CNPJ automaticamente
- Controle o status ativo/inativo

**Usuários:**
- Gerencie o acesso ao sistema
- Defina níveis de permissão
- Controle contas de usuários
- Monitore atividades através dos logs

**Mensagens:**
- Envie mensagens internas
- Comunique-se com outros usuários
- Mantenha histórico de conversas

**Configuração:**
- Ajuste parâmetros do sistema
- Gerencie permissões
- Configure grupos de usuários

## 📊 Relatórios

O sistema oferece três tipos principais de relatórios:

**Relatório por Empresas:**
- Lista todas as empresas cadastradas
- Informações detalhadas sobre cada uma
- Status e contatos
- Validação de CNPJ

**Relatório por Contatos:**
- Catálogo completo de contatos
- Detalhes e informações pessoais
- Controle de favoritos
- Filtros por diversos critérios

**Relatório de Usuários:**
- Lista de usuários do sistema
- Níveis de permissão
- Status das contas
- Histórico de atividades

## 📝 Logs do Sistema

O sistema mantém logs detalhados de todas as operações:

- **contato_log.txt**: Operações relacionadas a contatos
- **empresa_log.txt**: Operações relacionadas a empresas
- **usuario_log.txt**: Operações relacionadas a usuários
- **sistema_log.txt**: Operações gerais do sistema

Os logs registram:
- Data e hora da operação
- Usuário que realizou a ação
- Tipo de operação (inclusão, alteração, exclusão)
- Detalhes da operação

## 🔐 Segurança

O sistema implementa:

- **Controle de Acesso**: Por usuário e senha com MD5 hashing
- **Diferentes Níveis de Permissão**: Sistema RBAC completo
- **Registro de Auditoria**: Logs completos de todas as operações
- **Validação de Dados**: Em todas as operações de entrada
- **SQL Injection Protection**: Queries parametrizadas



## 🎨 Interface do Usuário

### Design e Navegação
- **Card-based Navigation**: Interface principal usa TCardPanel com múltiplas seções
- **Hover Effects**: Efeitos visuais ao passar o mouse nos painéis
- **Responsive Design**: Redimensionamento dinâmico da interface
- **Grid Editing**: Edição inline para maior produtividade
- **Tabbed Interface**: Organização por abas dentro de cada seção

### Seções Principais
1. **Contatos**: Gestão completa de contatos
2. **Favoritos**: Acesso rápido aos contatos favoritos
3. **Empresas**: Cadastro de empresas
4. **Grupos**: Sistema de grupos e permissões
5. **Mensagens**: Comunicação interna
6. **Configuração**: Administração do sistema

## 🔧 Padrões de Desenvolvimento

### MVC Implementation
- **Models**: Classes com getters/setters e validação
- **Views**: Formulários VCL com lógica mínima
- **Controllers**: Orquestração de regras de negócio
- **Repositories**: Acesso a dados com SQL parametrizado


**ContactHub** é um sistema robusto e completo para gestão de contatos, desenvolvido com as melhores práticas de engenharia de software em Delphi, oferecendo uma solução eficiente, segura e extensível para gerenciamento de relacionamentos empresariais e pessoais.