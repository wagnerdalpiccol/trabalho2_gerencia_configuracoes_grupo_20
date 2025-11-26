-- ESTE SCRIPT SÓ É EXECUTADO NO AMBIENTE 'DEV'

-- Remove a tabela principal (e todas as tabelas que dependem dela, como as que contêm os registros)
-- O comando CASCADE garante que quaisquer chaves estrangeiras sejam removidas sem erro.
-- O comando IF EXISTS garante que o script não falhe se a tabela ainda não existir.

DROP TABLE IF EXISTS clientes CASCADE;

-- Se o seu V1__cria_tabela_cliente.sql criar outras tabelas, adicione-as aqui.
-- Exemplo (fictício): DROP TABLE IF EXISTS produtos CASCADE;