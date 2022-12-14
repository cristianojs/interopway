[English](/README.en-us.md)
---
# Interopway

<p align="center">
  <img src="https://www.publicdomainpictures.net/pictures/190000/velka/milky-way.jpg" width="50%" height="50%"/>
</p>

Este projeto visa disponibilizar um framework para auxiliar no desenvolvimento de projetos de interoperabilidade utilizando as tecnologias [InterSystems](https://www.intersystems.com), tais como: 

- [Ensemble](https://docs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls)
- [IRIS Data Platform](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls)
- [IRIS for Health](https://docs.intersystems.com/irisforhealthlatest/csp/docbook/DocBook.UI.Page.cls)
- [HealthShare Health Connect](https://docs.intersystems.com/healthconnectlatest/csp/docbook/DocBook.UI.Page.cls)

O objetivo principal é encapsular todo o desenvolvimento repetitivo em componentes configuráveis.

## Protocolos e Tecnologias

Nesta primeira versão é disponibilizadao o módulo **XDBC** para desenvolvimento de interoperabilidade com acesso a banco de dados relacionais. Este módulo pode ser utilizado no Ensemble, IRIS, IRIS for Health e Health Connect.

Todas as colaborações são bem vindas. Fiquem a vontade para fazer fork do repositório e contribuir.

## XDBC

Este módulo visa agilizar o desenvolvimennto de interoperabilidade utilizando **ODBC** ou **JDBC**. a intalação e bem simples. Baixe o pacote xml [Interopway_XDBC-V0.0.1.xml](/xmlexport/Interopway_XDBC.xml) e importe no namespace desejado.

A importação pode ser feita de 3 modos:

1. [Via Studio](https://docs.intersystems.com/ens201815/csp/docbook/DocBook.UI.Page.cls?KEY=GSTD_Commands#GSTD_Commands_Tools) (apenas em Windows);

<p style='text-align: justify;'>
  <img src="./images/ImportacaoClassesStudio.png" width="60%" height="60%"/>
</p>

2. [Via SMP](https://docs.intersystems.com/ens201815ImportacaoClassesStudio.png/csp/docbook/DocBook.UI.Page.cls?KEY=ACLS#ACLS_import) (qualquer SO);

<p style='text-align: justify;'>
  <img src="./images/ImportacaoClassesSMP.png" width="60%" height="60%"/>
</p>

3. Terminal ou [WebTerminal](https://intersystems-community.github.io/webterminal/) (qualquer SO)

```objectscript
Do $system.OBJ.Load("</caminho/arquivo>/Interopway_XDBC-V0.0.1.xml","ck")
```

O uso é fácil e quase auto explicativo. No pacote [cjs.interopway.samples](/src/cjs/interopway/samples/) existe uma [Production](cjs/interopway/samples/InteropProducion.cls) configurada demonstrando o uso de interoperabilidade **ODBC** e **JDBC**.

A classe [cjs.interopway.tests.InteropProduction](/src/cjs/interopway/tests/InteropProduction.cls) com os casos de testes a serem executados para validar se a instalação.

Abaixo são detalhados os pré-requistos e passos necessários para a excução dos casos de testes. Os testes foram executados em ambiente Windows em uma instância Ensemble:

	$ZV=Cache for Windows (x86-64) 2018.1.5 (Build 659U) Mon Mar 22 2021 07:03:57 EDT

## Pré-requisitos para executar os casos de testes:

- JDK 1.7 ou 1.8 instalado. Usado pela conexão **JDBC**;

![JDK](/images/JDK.png)

- DSN de Sistemas com o nome *Ensemble Samples* usado pela conexão **ODBC**;
<p style='text-align: justify;'>
  <img src="./images/EnsembleSamplesDSN.png" width="60%" height="60%"/>
</p>

- Diretório vazio *C:\Temp\tests*. Usado pelo Test Manager;

![JDK](/images/TempTests.png)

- [Credencial](https://docs.intersystems.com/ens201815/csp/docbook/DocBook.UI.Page.cls?KEY=ECONFIG_reusable#ECONFIG_reusable_credentials) *Ensemble Samples* configurada no SMP no namespace da instalação.

<p style='text-align: justify;'>
  <img src="./images/Credential.png" width="70%" height="70%"/>
</p>

## Execução dos Casos de Testes

Uma vez que os pré-requistos estejam atendidos abra uma sessão do Terminal ou [WebTerminal](https://intersystems-community.github.io/webterminal/) no namespace onde o módulo XDBC foi instalado e execute a linha abaixo:

```objectscript
Do ##Class(%UnitTest.Manager).RunTest("tests:cjs.interopway.tests.InteropProduction", "/noload/nodelete")
```

Ao término da execução dos testes, se tudo ocorreu conforme o esperado, a saída deverá ser algo pareceido com a imagem abaixo. Para um relatório detalhado da execução acesse a URL que aprece no destaque da imagem.

<p style='text-align: justify;'>
  <img src="./images/FimTeste.png" width="70%" height="70%"/>
</p>

A URL te levará até o Portal de Testes onde pode-se inspecionar cada caso de teste individualmente.

![Relatório de Testes](/images/ResultadoTestes.png)

Detalhe execução do Caso de Teste *TestExecuteProcedureODBC*

![Relatório de Testes](/images/DetalheCasoTeste.png)

## Entendo o Código de Exemplo e Testes

Detalharemos o uso da *Lookup Table* [TESTS_XDBC_CONFIG](/src/TESTS_XDBC_CONFIG.LUT) e as classes do pacote de exemplo [cjs.interopway.samples](/src/cjs/interopway/samples):

0. [TESTS_XDBC_CONFIG](/src/TESTS_XDBC_CONFIG.LUT) - Lookup Table com as configurações necessárias para a execução dos comandos SQL a serem executos nos bancos de dados externos.

	```xml
	<?xml version="1.0"?>
	<lookupTable>
		<entry table="TESTS_XDBC_CONFIG" key="cjs.interopway.samples.company.bo.UpdateCompanyRequest">{
			"credential":"ENSEMBLE Samples",
			"statement":"UPDATE Sample.Company SET TaxID = ? WHERE ID = ?"
		}
		</entry>
		<entry table="TESTS_XDBC_CONFIG" key="cjs.interopway.samples.person.bo.PersonSetsRequest">{
			"credential":"ENSEMBLE Samples",
			"statement":"? = CALL Sample.PersonSets(?,?)"
		}
		</entry>
		<entry table="TESTS_XDBC_CONFIG" key="cjs.interopway.xdbc.bo.QueryRequest">{
			"credential":"ENSEMBLE Samples",
			"statement":"SELECT * FROM Sample.Person"
		}
		</entry>
		<entry table="TESTS_XDBC_CONFIG" key="cjs.interopway.xdbc.bo.QueryStreamRequest">{
			"credential":"ENSEMBLE Samples",	
			"statement":"SELECT * FROM Sample.Employee"
		}
		</entry>
	</lookupTable>
	```

A Lookup Table acima é utilizada por todas as classes que constam no atributo *key* da lookup mais especificamente no construtor que fica definido na classe base de request [cjs.interopway.xdbc.bo.BaseRequest](/src/cjs/interopway/xdbc/bo/BaseRequest.cls):

  ```objectscript
  Method %OnNew(lookupTable As %String = "XDBC") As %Status
  {
  	#Dim exception	As %Exception.General = ""
  	#Dim statusCode	As %Status            = $System.Status.OK()
  	Try 
  	{
  		#Dim configString	As %String = ##Class(Ens.Util.FunctionSet).Lookup(lookupTable, $ClassName())
  		If (configString = "")
  		{
  			Return statusCode
  		}
  		#Dim config As %DynamicObject = {}.%FromJSON(configString)
  		If (config.credential '= "" && '##Class(Ens.Config.Credentials).%ExistsId(config.credential))
  		{
  			Return $System.Status.Error(5001, "Credential does not exists.")
  		}
  		If (config.credential '= "")
  		{
  			Set ..Credential	= config.credential
  		}
  		If (config.statement '= "")
  		{
  			Set ..Statement	= config.statement
  		}
  		If (config.dsn '= "")
  		{
  			Set ..DSN	= config.dsn
  		}				
  	}
  	Catch (exception) 
  	{
  		Set statusCode = exception.AsStatus()
  	}
  	Return statusCode
  }
  ```

1. [cjs.interopway.samples.company.bo.UpdateCompanyRequest](/src/cjs/interopway/samples/company/bo/UpdateCompanyRequest.cls)  - Request específico para executar uma atualização com parâmetros sem descrevê-los.

  ```objectscript
  ClassMethod GetInstance(companyId As %Integer, taxId As %String) As UpdateCompanyRequest
  {
  	#Dim updateRequest			As UpdateCompanyRequest	= ..%New("TESTS_XDBC_CONFIG")
  	//	
  	Do updateRequest.Parameters.Insert(##Class(ParameterDefinition).%New(1, taxId))
  	Do updateRequest.Parameters.Insert(##Class(ParameterDefinition).%New(2, companyId))
  	//
  	Return updateRequest
  }
  ```

1. [cjs.interopway.samples.person.bo.PersonSetsRequest](/src/cjs/interopway/samples/person/bo/PersonSetsRequest.cls)  - Request específico para executar a proceduere que retorna 2 *ResultsSets* e descreve os parâmetros da chamada.

  ```objectscript
  ClassMethod GetInstance(name As %Integer, state As %String) As PersonSetsRequest
  {
  	#Dim procedureRequest	As UpdateCompanyRequest	= ..%New("TESTS_XDBC_CONFIG")	
  	#Dim returnParameter	As ParameterDefinition	= ##Class(ParameterDefinition).%New(1)
  	#Dim nameParameter		As ParameterDefinition	= ##Class(ParameterDefinition).%New(2, name)
  	#Dim stateParameter		As ParameterDefinition	= ##Class(ParameterDefinition).%New(3, state)
  	//
  	Set returnParameter.IOType	= returnParameter.IOTypeDisplayToLogical("OUTPUT")
  	Set nameParameter.IOType		= nameParameter.IOTypeDisplayToLogical("INPUT")
  	Set stateParameter.IOType		= stateParameter.IOTypeDisplayToLogical("INPUT")
  	Set returnParameter.SqlType	= $$$SqlInteger
  	Set nameParameter.SqlType		= $$$SqlVarchar
  	Set stateParameter.SqlType	= $$$SqlVarchar
  	//
  	Do procedureRequest.Parameters.Insert(returnParameter)
  	Do procedureRequest.Parameters.Insert(nameParameter)
  	Do procedureRequest.Parameters.Insert(stateParameter)
  	//
  	Return procedureRequest
  }
  ```

3. [cjs.interopway.samples.InteropProducion.cls](/src/cjs/interopway/samples/InteropProducion.cls)  - Class da Production de exemplo contento os componentes:

	- *EnsLib.JavaGateway.Service* - Busines Service que se comunica com a JVM. Dev-se configurar o caminho para os drivers JDBC da base de dados externa.

	  ![classpath](/images/Calsspath.png)

	- *JDBC Sample Operation* - Instância da classe [cjs.interopway.xdbc.bo.Operation](/src/cjs/interopway/xdbc/bo/Operation.cls). Business Operation que se comunica com a base de dados exteran via **JDBC**. Aqui é configurado a DSN que neste caso é  a String de conexão, Credencial e classe do driver 

		![Confguração JDBC](/images/ConfiguracaoJDBC.png)

	- *ODBC Sample Operation* - Instância da classe [cjs.interopway.xdbc.bo.Operation](/src/cjs/interopway/xdbc/bo/Operation.cls). Business Operation que se comunica com a base de dados exteran via **ODBC**. Aqui é configurado a DSN  e Credencial.

		![Confguração JDBC](/images/ConfiguracaoODBC.png)

Abaixo é detalhado [cjs.interopway.tests](/src/cjs/interopway/tests):

4. [cjs.interopway.tests.InteropProduction](/src/cjs/interopway/tests/InteropProduction.cls) - Classe com os casos de testes a serem executados:

   - *TestExecuteQueryODBC* - Executa o comando SQL *SELECT * FROM Sample.Person* na conexão ODBC.
		
   - *TestExecuteQueryJDBC* - Executa o comando SQL *SELECT * FROM Sample.Person* na conexão JDBC.

   - *TestExecuteQueryStreamODBC* - Executa o comando SQL *SELECT * FROM Sample.Employee* na conexão ODBC.

   - *TestExecuteQueryStreamODBC* - Executa o comando SQL *SELECT * FROM Sample.Employee* na conexão JDBC.

   - *TestExecuteUpdateODBC* - Executa o comando SQL *UPDATE Sample.Company SET TaxID = ? WHERE ID = ?* na conexão ODBC com parâmetros porém se descrevê-los.
		
   - *TestExecuteUpdateJDBC* - Executa o comando SQL *UPDATE Sample.Company SET TaxID = ? WHERE ID = ?* na conexão JDBC com parâmetros porém se descrevê-los
		
   - *TestExecuteProcedureODBC* - Executa o comando SQL *? = CALL Sample.PersonSets(?,?)* na conexão JDBC com parâmetros e descrevendo-os.

   - *TestExecuteProcedureODBC* - Executa o comando SQL *? = CALL Sample.PersonSets(?,?)* na conexão JDBC com parâmetros e descrevendo-os.