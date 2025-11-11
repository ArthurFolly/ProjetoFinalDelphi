-- Adicionar campo tipo_usuario na tabela Usuario
ALTER TABLE "Usuario"
ADD COLUMN IF NOT EXISTS tipo_usuario VARCHAR(10) DEFAULT 'padrao';

-- Definir valores válidos (opcional - se quiser criar um CHECK constraint)
-- ALTER TABLE "Usuario"
-- ADD CONSTRAINT chk_tipo_usuario CHECK (tipo_usuario IN ('admin', 'padrao'));

-- Atualizar usuários existentes para 'padrao' (caso o campo tenha sido criado como NULL)
UPDATE "Usuario"
SET tipo_usuario = 'padrao'
WHERE tipo_usuario IS NULL;

-- Se quiser definir o primeiro usuário como admin
-- UPDATE "Usuario"
-- SET tipo_usuario = 'admin'
-- WHERE id_usuario = 1;

-- Inserir um usuário admin padrão (se não existir)
INSERT INTO "Usuario" (email, nome, senha_hash, cpf, telefone, tipo_usuario)
VALUES ('admin@contacthub.com', 'Administrador', '21232f297a57a5a743894a0e4a801fc3', '00000000000', '0000000000', 'admin')
ON CONFLICT (email) DO NOTHING;

-- SENHA DO ADMIN: 'admin' (sem aspas)
-- Hash MD5: 21232f297a57a5a743894a0e4a801fc3