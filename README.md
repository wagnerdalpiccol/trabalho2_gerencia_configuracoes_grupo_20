# 📄 Funcionamento Detalhado da Pipeline de Deploy (deploy.yml)

[cite_start]O arquivo `deploy.yml` orquestra o processo de **Continuous Deployment (CD)** para os três ambientes (**Dev**, **Preprod**, **Prod**), garantindo o **isolamento de dados** e a **atualização automática** da página HTML e do banco de dados em cada ciclo[cite: 4, 5].

---

## 1. Matriz de Gatilhos (Triggers)

[cite_start]A pipeline é ativada por diferentes eventos, conforme a regra de negócio do ambiente alvo[cite: 7].

| Ambiente | Gatilho | Condição de Execução |
| :--- | :--- | :--- |
| **Produção** (`main`/`master`) | `push` | [cite_start]**Automático**: Sempre que houver um commit ou um Pull Request for mesclado nessas branches[cite: 8]. |
| **Pré-Produção** (`preprod`) | `schedule` E `workflow_dispatch` | [cite_start]**Agendado**: Diariamente às 10:00 UTC **E** **Manual** via interface do GitHub[cite: 8]. |
| **Desenvolvimento** (`dev`) | `workflow_dispatch` | [cite_start]**Apenas Manual**: Acionado sob demanda pela interface do GitHub Actions[cite: 8]. |

---

## 2. Fluxo de Execução da Pipeline

[cite_start]O trabalho (`job: deploy`) é dividido em etapas que garantem a segurança e a correta aplicação das alterações em ambiente isolado[cite: 10].

### Etapas Críticas:

| Passo | Objetivo | Detalhe da Implementação |
| :--- | :--- | :--- |
| **Definir Variáveis** (`set_env`) | [cite_start]Determina qual ambiente (**prod**, **preprod**, **dev**) foi acionado e carrega os Secrets (`DB_URL`, `DEPLOY_HOOK`) correspondentes[cite: 12]. | [cite_start]Usa lógica `if/elif` baseada em `github.event_name` e `target_environment`[cite: 12]. |
| **Checkout do Código** | [cite_start]Baixa o código-fonte da branch alvo[cite: 12]. | [cite_start]Garante que o runner do GitHub tenha acesso aos scripts SQL e ao HTML[cite: 12]. |
| **INICIALIZAÇÃO: Criar Schema** | [cite_start]Garante o **isolamento de dados** no banco de dados[cite: 12]. | [cite_start]Usa o `psql` para executar comandos que criam um `SCHEMA` (**prod**, **preprod**, ou **dev**) com base na variável `TARGET_ENV` e define o `search_path` para esse novo schema[cite: 12]. |
| **Deploy do Frontend** | [cite_start]Atualiza a página HTML[cite: 12]. | [cite_start]Envia um comando `curl POST` para o **Deploy Hook** exclusivo do Vercel, acionando o build e deploy do site estático[cite: 12]. |
| **Executar Migrações** | [cite_start]Atualiza a infraestrutura do banco de dados[cite: 12]. | [cite_start]Executa um loop que encontra e roda todos os seus scripts SQL (`V*.sql`) em ordem, ocorrendo **dentro do Schema isolado** do ambiente[cite: 12]. |

[cite_start]O isolamento garante que o `prod` nunca seja afetado pelo `dev`[cite: 17].

---

## 3. Isolamento de Ambientes (Schema Based)

[cite_start]O projeto utiliza um **único cluster de banco de dados (Supabase)** com **isolamento por Schema (Esquema)**[cite: 19].

* [cite_start]**Separação Lógica**: Em vez de três bancos de dados físicos, existem **três schemas** (`prod`, `preprod`, `dev`) no mesmo servidor[cite: 20].
* [cite_start]**Segurança**: A pipeline usa o `psql` para criar/selecionar o schema correto no início da sessão[cite: 21].
* [cite_start]**Aplicação de Alterações**: Todas as migrações (criação de tabelas e inserção de dados) ocorrem exclusivamente **dentro do schema do ambiente em questão**[cite: 22].
* [cite_start]**Idempotência**: Os scripts de migração incluem `DROP TABLE IF EXISTS` e `CREATE TABLE IF NOT EXISTS` para garantir que a re-execução em um ambiente de teste não cause falhas por tabela já existente[cite: 23].

[cite_start]A conclusão bem-sucedida de todas essas etapas garante que cada ambiente esteja sempre atualizado e isolado[cite: 24].
