-- Criar tabelas do sistema de permissões (RBAC)

-- Tabela de Roles (Cargos/Funções)
CREATE TABLE IF NOT EXISTS "Roles" (
    id_role SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao VARCHAR(200),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Recursos (Funcionalidades do sistema)
CREATE TABLE IF NOT EXISTS "Recursos" (
    id_recurso SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(200),
    modulo VARCHAR(50) NOT NULL, -- 'Contatos', 'Empresas', 'Usuarios', 'Configuracoes', 'Mensagens'
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Permissões (Vinculo entre Roles e Recursos)
CREATE TABLE IF NOT EXISTS "Permissoes" (
    id_permissao SERIAL PRIMARY KEY,
    id_role INTEGER NOT NULL REFERENCES "Roles"(id_role) ON DELETE CASCADE,
    id_recurso INTEGER NOT NULL REFERENCES "Recursos"(id_recurso) ON DELETE CASCADE,
    pode_ler BOOLEAN DEFAULT FALSE,
    pode_criar BOOLEAN DEFAULT FALSE,
    pode_editar BOOLEAN DEFAULT FALSE,
    pode_excluir BOOLEAN DEFAULT FALSE,
    UNIQUE(id_role, id_recurso),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de vinculo entre Usuários e Roles
CREATE TABLE IF NOT EXISTS "Usuario_Roles" (
    id_usuario_role SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL REFERENCES "Usuario"(id_usuario) ON DELETE CASCADE,
    id_role INTEGER NOT NULL REFERENCES "Roles"(id_role) ON DELETE CASCADE,
    UNIQUE(id_usuario, id_role),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir Roles padrão
INSERT INTO "Roles" (nome, descricao) VALUES
('Administrador', 'Acesso completo a todas as funcionalidades'),
('Gerente', 'Pode gerenciar contatos, empresas e usuários'),
('Usuario', 'Acesso básico para gerenciar próprios contatos'),
('Visualizador', 'Apenas visualização de dados')
ON CONFLICT (nome) DO NOTHING;

-- Inserir Recursos do sistema
INSERT INTO "Recursos" (nome, descricao, modulo) VALUES
-- Contatos
('Contatos - Visualizar', 'Permite visualizar contatos', 'Contatos'),
('Contatos - Criar', 'Permite criar novos contatos', 'Contatos'),
('Contatos - Editar', 'Permite editar contatos existentes', 'Contatos'),
('Contatos - Excluir', 'Permite excluir contatos', 'Contatos'),
-- Empresas
('Empresas - Visualizar', 'Permite visualizar empresas', 'Empresas'),
('Empresas - Criar', 'Permite criar novas empresas', 'Empresas'),
('Empresas - Editar', 'Permite editar empresas existentes', 'Empresas'),
('Empresas - Excluir', 'Permite excluir empresas', 'Empresas'),
-- Usuários
('Usuarios - Visualizar', 'Permite visualizar usuários', 'Usuarios'),
('Usuarios - Criar', 'Permite criar novos usuários', 'Usuarios'),
('Usuarios - Editar', 'Permite editar usuários existentes', 'Usuarios'),
('Usuarios - Excluir', 'Permite excluir usuários', 'Usuarios'),
-- Configurações
('Configuracoes - Acessar', 'Permite acessar tela de configurações', 'Configuracoes'),
('Configuracoes - Editar', 'Permite editar configurações do sistema', 'Configuracoes'),
-- Mensagens
('Mensagens - Enviar', 'Permite enviar mensagens', 'Mensagens'),
('Mensagens - Receber', 'Permite visualizar mensagens recebidas', 'Mensagens'),
-- Permissões
('Permissoes - Gerenciar', 'Permite gerenciar permissões do sistema', 'Permissoes')
ON CONFLICT (nome) DO NOTHING;

-- Configurar permissões para cada role
-- Administrador tem acesso total a tudo
INSERT INTO "Permissoes" (id_role, id_recurso, pode_ler, pode_criar, pode_editar, pode_excluir)
SELECT r.id_role, rec.id_recurso, TRUE, TRUE, TRUE, TRUE
FROM "Roles" r, "Recursos" rec
WHERE r.nome = 'Administrador'
ON CONFLICT (id_role, id_recurso) DO NOTHING;

-- Gerente pode gerenciar contatos, empresas e usuários (mas não permissões)
INSERT INTO "Permissoes" (id_role, id_recurso, pode_ler, pode_criar, pode_editar, pode_excluir)
SELECT r.id_role, rec.id_recurso, TRUE, TRUE, TRUE, TRUE
FROM "Roles" r, "Recursos" rec
WHERE r.nome = 'Gerente'
AND rec.modulo IN ('Contatos', 'Empresas', 'Usuarios', 'Mensagens')
ON CONFLICT (id_role, id_recurso) DO NOTHING;

-- Gerente pode visualizar configurações mas não editar
INSERT INTO "Permissoes" (id_role, id_recurso, pode_ler, pode_criar, pode_editar, pode_excluir)
SELECT r.id_role, rec.id_recurso, TRUE, FALSE, FALSE, FALSE
FROM "Roles" r, "Recursos" rec
WHERE r.nome = 'Gerente'
AND rec.nome = 'Configuracoes - Acessar'
ON CONFLICT (id_role, id_recurso) DO NOTHING;

-- Usuário padrão pode gerenciar contatos e visualizar empresas
INSERT INTO "Permissoes" (id_role, id_recurso, pode_ler, pode_criar, pode_editar, pode_excluir)
SELECT r.id_role, rec.id_recurso, TRUE, TRUE, TRUE, FALSE
FROM "Roles" r, "Recursos" rec
WHERE r.nome = 'Usuario'
AND rec.modulo = 'Contatos'
ON CONFLICT (id_role, id_recurso) DO NOTHING;

INSERT INTO "Permissoes" (id_role, id_recurso, pode_ler, pode_criar, pode_editar, pode_excluir)
SELECT r.id_role, rec.id_recurso, TRUE, FALSE, FALSE, FALSE
FROM "Roles" r, "Recursos" rec
WHERE r.nome = 'Usuario'
AND rec.nome = 'Empresas - Visualizar'
ON CONFLICT (id_role, id_recurso) DO NOTHING;

INSERT INTO "Permissoes" (id_role, id_recurso, pode_ler, pode_criar, pode_editar, pode_excluir)
SELECT r.id_role, rec.id_recurso, TRUE, FALSE, FALSE, FALSE
FROM "Roles" r, "Recursos" rec
WHERE r.nome = 'Usuario'
AND rec.nome LIKE 'Mensagens%'
ON CONFLICT (id_role, id_recurso) DO NOTHING;

-- Visualizador só pode ver tudo (menos configurações e permissões)
INSERT INTO "Permissoes" (id_role, id_recurso, pode_ler, pode_criar, pode_editar, pode_excluir)
SELECT r.id_role, rec.id_recurso, TRUE, FALSE, FALSE, FALSE
FROM "Roles" r, "Recursos" rec
WHERE r.nome = 'Visualizador'
AND rec.modulo IN ('Contatos', 'Empresas', 'Mensagens')
ON CONFLICT (id_role, id_recurso) DO NOTHING;

-- Índices para melhor performance
CREATE INDEX IF NOT EXISTS idx_usuario_roles_usuario ON "Usuario_Roles"(id_usuario);
CREATE INDEX IF NOT EXISTS idx_permissoes_role ON "Permissoes"(id_role);
CREATE INDEX IF NOT EXISTS idx_permissoes_recurso ON "Permissoes"(id_recurso);