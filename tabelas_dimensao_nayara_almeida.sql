-------CRIANDO DAS TABELAS DIMENSÕES E FATOS------
------ALUNA NAYARA------------------------


-------CRIANDO O SCHEMA PARA AS TABELAS DIMENSÕES E FATO-----

CREATE SCHEMA dw

-------------CRIANDO AS TABELAS DIMENSÕES------------

--- Criando a tabela : dim_produto---

CREATE TABLE dw.dim_produto AS
SELECT cdpro AS codigoproduto
	 , nmpro AS nomeproduto
	 , tppro AS tipoproduto
	 , undpro AS unidadeproduto
	 , slpro AS saldodoproduto
	 , stpro AS statusproduto
	FROM public.tbpro;

SELECT * FROM dim_produto;
	
---- Criando a tabela : dim_vendedor-----

CREATE TABLE dw.dim_vendedor AS
SELECT cdvdd AS codigovendedor
	 , nmvdd AS nomevendedor
	 , CASE WHEN sxvdd = 0 THEN 'M' ELSE 'F' END AS sexovendedor
	 , perccomissao AS percentualcomissão
	 , matfunc AS matriculafuncional
	FROM public.tbvdd;	
	
SELECT * FROM dim_vendedor;	

---Criando a tabela : dim_dependente----

CREATE TABLE dw.dim_dependente AS
SELECT cddep AS codigodependente
	 , nmdep AS nomedependente
	 , dtnasc AS datanascimento
	 , sxdep AS sexodependente
	 , cdvdd AS codigovendedor
	 , inepescola AS codigoinep
	FROM public.tbdep;
	
SELECT * FROM dim_dependente;	


----Criando a tabela : dim_cliente----

CREATE TABLE dw.dim_cliente AS
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

CREATE TABLE dw.dim_canal AS
SELECT DISTINCT canal AS nomecanal
      , CASE
           WHEN canal = 'Loja Própria' THEN 1
           WHEN canal = 'Loja Virtual' THEN 2
           ELSE 3
       END AS codigocanal
	   FROM public.tbven;
	 
SELECT * FROM dim_canal;


----Criando a tabela : dim_status---

CREATE TABLE dw.dim_status (
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
    FROM public.tbven;

SELECT * FROM dim_status;	  


---Criando a tabela : dim_data----

------- CRIANDO A FUNÇÃO PARA DEIXAR OS NOMES MESES E NOME SEMANA EM PORTUGUÊS--------

CREATE OR REPLACE FUNCTION data_nome_pt(data DATE)
  RETURNS TABLE (nome_mes TEXT, nome_dia_semana TEXT)
AS $$
DECLARE
  meses TEXT[] := ARRAY['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];
  dias_semana TEXT[] := ARRAY['Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado'];
BEGIN
  nome_mes := meses[EXTRACT(MONTH FROM data)::integer];
  nome_dia_semana := dias_semana[EXTRACT(DOW FROM data)::integer + 1];
  RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

-------------TABELA DIM_DATA----------------

CREATE TABLE dw.dim_data AS
SELECT DISTINCT
    dtven AS Data,
    EXTRACT(YEAR FROM dtven) AS Ano,
    TO_CHAR(dtven, 'DDMMYYYY') AS DataCurta,
    (data_nome_pt(dtven)).nome_dia_semana AS DiaDaSemana,
    EXTRACT(DAY FROM dtven) AS DiaMes,
    (data_nome_pt(dtven)).nome_mes AS MesNome,
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
FROM public.tbven;

SELECT * FROM dw.dim_data;



---CRIANDO AS TABELAS FATOS-------------------
---Criando a tabela : fato_vendas----


CREATE TABLE dw.fato_vendas AS
SELECT v.cdven AS codigovenda,
       v.dtven AS datavenda,
       v.cdcli AS codigocliente,
       v.cdvdd AS codigovendedor,
       vi.cdpro AS codigoproduto,
       vi.qtven AS quantidadevendas,
       vi.vruven AS valorunitariovendido,
       vi.vrtven AS valortotalvendas,
	   CASE WHEN canal = 'Loja Própria' THEN 1
	   ELSE 2 END AS codigocanal,
       v.stven AS statusvenda,
       v.deleted AS deletado
FROM public.tbven v
JOIN public.tbven_item vi ON vi.cdven = v.cdven;

SELECT * FROM dw.fato_vendas;
	
	

	
	
