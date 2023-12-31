  CREATE TABLE aluno (
  cod_matricula INT PRIMARY KEY,
  nome VARCHAR(255) not NULL,
  email VARCHAR(255) not NULL,
  data_nasc DATE,
  mensagem TEXT,
  endereco varchar(255)
);

CREATE TABLE materia (
  cod_materia SERIAL PRIMARY KEY,
  nome VARCHAR(255) not NULL
);

CREATE TABLE aluno_materia (
    cod_matricula INTEGER,
    cod_materia INTEGER,
    FOREIGN KEY (cod_matricula) REFERENCES aluno(cod_matricula),
    FOREIGN KEY (cod_materia) REFERENCES materia(cod_materia),
    PRIMARY KEY (cod_matricula, cod_materia)
);


INSERT INTO aluno (cod_matricula, nome, data_nasc, email, endereco) VALUES
  (1002, 'Pedro Henrique', '2000-09-25', 'pedrohenrique@gmail.com', 'rua pernambuco'),
  (1003, 'Luis Cesar', '2002-08-20', 'luiscezar@gmail.com', 'rua mato grosso'),
  (1004, 'Ana Júlia', '2000-10-03', 'anajulia@gmail.com', 'rua arnaldo borges'),
  (1005, 'Dener', '1999-02-14', 'dener@gmail.com', 'rua 13 de julho');
  
  INSERT INTO materia (nome) VALUES
  ('Linguagem de Programação 1' ),
  ('Estrutura de Dados'),
  ('Banco de Dados'),
  ('Programação Web');

  INSERT INTO aluno_materia (cod_materia, cod_matricula) VALUES
  (1, 1002),
  (2, 1002),
  (4, 1002),
  (2, 1003),
  (2, 1004),
  (3, 1004);


CREATE TRIGGER verifica_data_nasc
AFTER INSERT
ON ALUNO FOR EACH ROW
BEGIN
    IF NEW.data_nasc IS NULL THEN
    INSERT INTO aluno(mensagem)
    VALUES('Atualize sua data de nascimento');
    END IF;
END

SELECT * from aluno;
SELECT * from materia;
SELECT * FROM aluno_materia;

SELECT aluno.cod_matricula, aluno.nome
FROM aluno
JOIN aluno_materia ON aluno.cod_matricula = aluno_materia.cod_matricula
WHERE aluno_materia.cod_materia = 2;

SELECT aluno.cod_matricula, aluno.nome
FROM aluno
JOIN aluno_materia ON aluno.cod_matricula = aluno_materia.cod_matricula
GROUP BY aluno.cod_matricula, aluno.nome
HAVING COUNT(aluno_materia.cod_materia) > 1;