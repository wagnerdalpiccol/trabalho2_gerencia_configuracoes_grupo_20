# Projeto de Gerenciamento de Banco de Dados com Migrations

Este projeto demonstra um processo de desenvolvimento de software utilizando Trunk Based Development, Pull Requests, Code Review e versionamento de banco de dados com Flyway e Spring Boot.

## Stack de Tecnologias

* **Controle de Versão:** Git & GitHub
* **Linguagem/Framework:** Java & Spring Boot
* **Banco de Dados:** PostgreSQL
* **Ferramenta de Migration:** Flyway

## Pré-requisitos

Para executar este projeto, você precisa ter instalado:
* [JDK (Java Development Kit)](https://www.oracle.com/java/technologies/downloads/) (versão 17 ou superior)
* [Apache Maven](https://maven.apache.org/download.cgi)
* [Servidor PostgreSQL](https://www.postgresql.org/download/) instalado e rodando localmente.

## Como Configurar e Executar

1.  **Prepare o Banco de Dados PostgreSQL:**
    * Certifique-se de que seu serviço do PostgreSQL está rodando.
    * Crie um banco de dados para o projeto: `CREATE DATABASE trabalhodb;`
    * Verifique se as credenciais no arquivo `src/main/resources/application.properties` correspondem à sua instalação local.

2.  **Clone o repositório:**
    ```bash
    git clone <URL_DO_SEU_REPOSITORIO>
    cd <NOME_DO_REPOSITORIO>
    ```

3.  **Execute a aplicação Spring Boot:**
    ```bash
    ./mvnw spring-boot:run
    ```
    *Ao iniciar, o Spring Boot irá se conectar ao seu banco PostgreSQL e o Flyway aplicará todas as migrations pendentes automaticamente.*
