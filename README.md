<h1 align="center">
    <br>
    <p align="center">Documentação do Código de Criação das Tabelas de Dimensão<p>
</h1>


## 1. Descrição Geral? 

<br>

<p align="justify"> Este código tem como objetivo criar tabelas de dimensão a partir de tabelas existentes no banco de dados. As tabelas de dimensão são utilizadas para armazenar informações relevantes e consolidadas de entidades específicas, permitindo consultas mais eficientes e análises mais complexas.
     
<br>    
    
## 2.  Estrutura do Banco de Dados.     
    
<p align="justify"> O banco de dados consiste em várias tabelas relacionais, incluindo as tabelas originais (tbpro, tbven_item, tbvdd, tbdep, tbven) e as tabelas de dimensão (dim_produto, dim_vendedor, dim_dependente, dim_cliente, dim_canal, dim_status, dim_data). Essas tabelas estão relacionadas por meio de chaves primárias e estrangeiras, permitindo a integração e consulta de dados.
<br>

<br>
  
| Tabelas Dimensionais | Descrição |
| --- | --- |
| `dim_produto` | A tabela dim_produto é criada a partir da tabela tbpro. Ela armazena informações sobre produtos, incluindo o código do produto, nome, tipo, unidade, saldo e status. |
| `dim_vendedor` | A tabela dim_vendedor é criada a partir da tabela tbvdd. Ela armazena informações sobre vendedores, incluindo o código do vendedor, nome, sexo, percentual de comissão e matrícula funcional. Nessa tabela utilizamos o CASE para mudar a informação de sexo de numeral para texto (F ou M)|
| `dim_dependente` | A tabela dim_dependente é criada a partir da tabela tbdep. Ela armazena informações sobre dependentes, incluindo o código do dependente, nome, data de nascimento, sexo, código do vendedor associado e código INEP da escola. |
| `dim_cliente` | A tabela dim_cliente é criada a partir da tabela tbven. Ela armazena informações sobre clientes, incluindo o código do cliente, nome, idade, classificação, sexo, cidade, estado e país. Utilizamos o DISTINCT ao SELECT para garantir que apenas linhas distintas sejam selecionadas na criação da tabela dimensão dim_cliente. Isso garante que não haja duplicatas na dimensão.| 
| `dim_canal` | A tabela dim_canal é criada a partir da tabela tbven. Ela armazena informações sobre canais de venda, incluindo o nome do canal e um código atribuído com base no tipo de canal. Utilizamos o DISTINCT ao SELECT para garantir que apenas linhas distintas sejam selecionadas na criação da tabela dimensão dim_canal. Isso garante que não haja duplicatas na dimensão. Adicionamos a cláusula CASE no SELECT para mapear os valores da coluna canal para códigos correspondentes na coluna codigocanal, para que cada canal tem um código específico correspondente, para evitar que na inclusão de uma coluna canal, seja criado códigos seriados, mesmo com o nome do canal já existente.|
| `dim_status` | A tabela dim_status é criada a partir da tabela tbven. Ela armazena informações sobre os status das vendas, incluindo o nome do status e um código atribuído sequencialmente. Utilizamos o DISTINCT ao SELECT para garantir que apenas linhas distintas sejam selecionadas na criação da tabela dimensão dim_canal. Isso garante que não haja duplicatas na dimensão.| 
| `dim_data` |A tabela dim_data é criada para armazenar informações relacionadas a datas. Ela inclui informações como a data em si, ano, mês, dia, dia da semana, trimestre, semestre, feriado, dia útil e dia do ano.|     

<br>


<br>

## 3. Exemplo de Consulta
    
### 3.1 [dim_produto] - A tabela dim_produto pode ser consultada para obter informações consolidadas sobre produtos, como nome, tipo e saldo.
   
```
SELECT * FROM dim_produto;

```
### 3.2 [dim_vendedor] - A tabela dim_vendedor pode ser consultada para obter informações sobre vendedores, como nome, sexo e percentual de comissão.

```
SELECT * FROM dim_vendedor;

```
    
### 3.3 [dim_dependente] - A tabela dim_dependente pode ser consultada para obter informações sobre dependentes, como nome, data de nascimento e sexo.
   
```
SELECT * FROM dim_dependente;

```
     
### 3.4 [dim_cliente] - A tabela dim_cliente pode ser consultada para obter informações sobre clientes, como nome, idade e cidade.
   
```
SELECT * FROM dim_cliente;

``` 

### 3.5 [dim_canal] - A tabela dim_canal pode ser consultada para obter informações sobre canais de venda, como o nome do canal.
   
```
SELECT * FROM dim_canal;

``` 

### 3.6 [dim_status] - A tabela dim_status pode ser consultada para obter informações sobre os status das vendas, como o nome do status.
   
```
SELECT * FROM dim_status;

``` 

### 3.7 [dim_data] (GERAL) - A tabela dim_data pode ser consultada para obter informações relacionadas a datas, como o ano, mês e dia.
   
```
SELECT * FROM dim_data;

``` 

### 3.8 [dim_data] (SELECIONANDO DATA DA tbven) - Podemos criar uma consulta com JOIN para filtrar as datven da tbven.
   
```
SELECT v.dtven AS data_vendas
FROM tbven AS v
JOIN dim_data AS dd ON v.dtven = dd.Data;

``` 

### 3.9 [dim_data] (SELECIONANDO DATA DA tbdep) - Podemos criar uma consulta com JOIN para filtrar as dtnasc da tbdep.

```
SELECT d.dtnasc AS data_nascimento
FROM tbdep AS d
JOIN dim_data AS dd ON d.dtnasc = dd.Data;

``` 
    
<br>


<br>
    
## 4. Dúvidas

*  Tive dúvida na criação da dim_data, fiz os inserts puxando as datas da tbven e tbdep, mais fico na dúvida se as tabelas relacionais e dimensionais precisam ter uma foreign key?.  
    
<br>
    
        
## 5. Aluna:   
     
  ### Nayara Valevskii
- [Linkedin](https://www.linkedin.com/in/nayaraba)
- [Github](https://github.com/NayaraWakewski)

    
    
    
    
