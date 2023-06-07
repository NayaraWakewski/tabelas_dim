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
SELECT DISTINCT canal AS nomecanal
      , CASE
           WHEN canal = 'Loja Própria' THEN 1
           WHEN canal = 'Loja Virtual' THEN 2
           ELSE 3
       END AS codigocanal
FROM tbven;
	 
SELECT * FROM dim_canal;


----Criando a tabela : dim_status---

CREATE TABLE dim_status (
    statusvenda INT,
    situacaostatusvenda VARCHAR(10)
);

INSERT INTO dim_status
SELECT DISTINCT stven::INT AS statusvenda,
    CASE
        WHEN stven = '1' THEN 'concluída'
        WHEN stven = '2' THEN 'em aberto'
        WHEN stven = '3' THEN 'cancelada'
        ELSE '4'
    END AS situacaostatusvenda
FROM tbven;

SELECT * FROM dim_status;	  

---Criando a tabela : dim_data----

CREATE TABLE dim_data AS
SELECT DISTINCT dtven AS Data,
    EXTRACT(YEAR FROM dtven) AS Ano,
    TO_CHAR(dtven, 'DDMMYYYY') AS DataCurta,
    TO_CHAR(dtven, 'Day') AS DiaDaSemana,
    EXTRACT(DAY FROM dtven) AS DiaMes,
    TO_CHAR(dtven, 'Month') AS MesNome,
    EXTRACT(MONTH FROM dtven) AS MesNumero,
    CASE
        WHEN EXTRACT(MONTH FROM dtven) <= 3 THEN 1
        WHEN EXTRACT(MONTH FROM dtven) <= 6 THEN 2
        WHEN EXTRACT(MONTH FROM dtven) <= 9 THEN 3
        ELSE 4
    END AS Trimestre,
    CASE
        WHEN EXTRACT(MONTH FROM dtven) <= 6 THEN 1
        ELSE 2
    END AS Semestre
FROM tbven;

SELECT * FROM dim_data;


	
	

	
	
