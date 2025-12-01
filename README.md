

📚 Sistema de Biblioteca - MySQL

Este projeto implementa um **modelo lógico de banco de dados para um sistema de biblioteca**, desenvolvido como parte da **Experiência Prática IV** da disciplina de **Modelagem de Banco de Dados**.  

O sistema contempla entidades como **usuários, cursos, livros, exemplares, empréstimos e multas**, com relacionamentos e regras de negócio implementadas em **MySQL**.

---

## 🚀 Funcionalidades

- Estrutura completa de tabelas com chaves primárias e estrangeiras.
- Inserção de dados fictícios para testes.
- Consultas SQL para manipulação de dados (SELECT, UPDATE, DELETE).
- **Trigger** para geração automática de multas em caso de devolução atrasada.
- **Procedure** para renovação de empréstimos.
- **View** para histórico de empréstimos e multas por usuário.

---

## 🛠️ Tecnologias Utilizadas

- **MySQL 8.x**
- **Workbench** ou outro cliente SQL
- Modelo lógico baseado em **Entity-Relationship Diagram (ERD)**

---

## 📦 Instalação e Uso

1. Clone este repositório:
   ```bash
   git clone https://github.com/seuusuario/sistema-biblioteca.git

2. Acesse a pasta do projeto:

cd sistema-biblioteca

3. Importe o script biblioteca.sql no seu MySQL Workbench ou execute diretamente:

source biblioteca.sql;

4. Teste as consultas de exemplo para validar o funcionamento.

🔍 Exemplos de Consultas

Consultar empréstimos ativos:

SELECT * FROM emprestimo WHERE status_emprestimo = 'ativo';

Renovar empréstimo:

CALL renovar_emprestimo(1);

Consultar histórico de um usuário:

SELECT * FROM vw_historico_usuario WHERE usuario = 'Ana Silva';

📊 Estrutura do Banco

cursos → armazena os cursos dos usuários.

usuario → dados pessoais e vínculo com curso.

livros → catálogo de livros.

exemplar → cópias físicas dos livros.

emprestimo → registros de empréstimos.

multa → penalidades aplicadas.

👨‍💻 Autor

Projeto desenvolvido por Gilberto Valdivino Loureiro📍 Campina Grande - PB, Brasil

📜 Licença

Este projeto é de uso acadêmico e está sob a licença MIT.Sinta-se livre para usar e modificar conforme necessário.
