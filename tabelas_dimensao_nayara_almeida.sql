-------CRIANDO DAS TABELAS DIMENSÕES------
------ALUNA NAYARA------------------------

--- Criando a tabela : dim_produto---

CREATE TABLE dim_produto AS
SELECT cdpro AS codigoproduto
	 , nmpro AS nomeproduto
	 , tppro AS tipoproduto
	 , undpro AS unidadeproduto
	 , slpro AS saldodoproduto
	 , stpro AS statusproduto
	FROM public.tbpro;

SELECT * FROM dim_produto;
	
---- Criando a tabela : dim_vendedor-----

CREATE TABLE dim_vendedor AS
SELECT cdvdd AS codigovendedor
	 , nmvdd AS nomevendedor
	 , CASE WHEN sxvdd = 0 THEN 'M' ELSE 'F' END AS sexovendedor
	 , perccomissao AS percentualcomissão
	 , matfunc AS matriculafuncional
	FROM public.tbvdd;	
	
SELECT * FROM dim_vendedor;	

---Criando a tabela : dim_dependente----

CREATE TABLE dim_dependente AS
SELECT cddep AS codigodependente
	 , nmdep AS nomedependente
	 , dtnasc AS datanascimento
	 , sxdep AS sexodependente
	 , cdvdd AS codigovendedor
	 , inepescola AS codigoinep
	FROM public.tbdep;
	
SELECT * FROM dim_dependente;	


----Criando a tabela : dim_cliente----

CREATE TABLE dim_cliente AS
SELECT DISTINCT cdcli AS codigocliente
	 , nmcli AS nomecliente
	 , agecli AS idadecliente
	 , clacli AS classificacaocliente
	 , sxcli AS sexocliente
	 , cidcli AS cidadecliente
	 , estcli AS estadocliente
	 , paicli AS paiscliente
	FROM public.tbven;
	
SELECT * FROM dim_cliente;	

----Criando a tabela : dim_canal----

CREATE TABLE dim_canal AS
SELECT canal AS nomecanal
      , CASE
           WHEN canal = 'Loja Própria' THEN 1
           WHEN canal = 'Loja Virtual' THEN 2
           ELSE 3
       END AS codigocanal
FROM (SELECT DISTINCT canal FROM tbven) AS subquery;
	 
SELECT * FROM dim_canal;


----Criando a tabela : dim_status---

CREATE TABLE dim_status AS
SELECT DISTINCT stven AS statusvenda
      , ROW_NUMBER() OVER (ORDER BY stven) AS codigostatus
	  FROM tbven;
	  
SELECT * FROM dim_status;	  

---Criando a tabela : dim_data----

CREATE TABLE dim_data (
    Data DATE PRIMARY KEY,
    Ano INT,
    Mes INT,
    Dia INT,
    DiaDaSemana INT,
    Trimestre INT,
    Semestre INT,
    Feriado VARCHAR(100),
    DiaUtil VARCHAR(3),
    DiaDoAno INT
);



-- Preencher a tabela de dimensão com as datas da tabela de vendas

INSERT INTO dim_data (Data)
SELECT DISTINCT dtven
FROM tbven;

-- Preencher a tabela de dimensão com as datas da tabela de dependentes

INSERT INTO dim_data (Data)
SELECT DISTINCT dtnasc
FROM tbdep;

---------- Selecionando toda a tabela dim_data-----------------------

SELECT * FROM dim_data;

------------Selecionando a data da tbven join dim_data --------------------

SELECT v.dtven AS data_vendas
FROM tbven AS v
JOIN dim_data AS dd ON v.dtven = dd.Data;

------------Selecionando a data da tbdep join dim_data---------------------

SELECT d.dtnasc AS data_nascimento
FROM tbdep AS d
JOIN dim_data AS dd ON d.dtnasc = dd.Data;

	
	