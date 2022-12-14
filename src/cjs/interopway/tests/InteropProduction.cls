Import (cjs.interopway.xdbc.bo, cjs.interopway.samples.person.bo, cjs.interopway.samples.company.bo)

/// <p style='text-align: justify;'>
/// 	<b>2022-12-11 - Cristiano José da Silva</b><br/>
/// 	Tests set for Business Opeation class: <class>Operation</class>
/// 	<br/><br/>
/// 	The tests are executed aganist a Ensemble ODBC/JDBC conection in namespace SAMPLES.
/// </p>
Class cjs.interopway.tests.InteropProduction Extends %UnitTest.TestProduction
{

/// Class name of the production.  It must contain the production class name.
Parameter PRODUCTION As STRING = "cjs.interopway.samples.InteropProducion";

/// TestMethod for Business Operation Method ExecuteQuery using a ODBC connection
Method TestExecuteQueryODBC() As %Status
{
	#Dim statusCode As %Status = ..IsProductionRunning()
	If ($System.Status.IsOK(statusCode))
	{
		Return ..ExecuteQuery("ODBC Sample Operation")
	}
	Return statusCode
}

/// TestMethod for Business Operation Method ExecuteQuery using a JODBC connection
Method TestExecuteQueryJDBC() As %Status
{
	#Dim statusCode As %Status = ..IsProductionRunning()
	If ($System.Status.IsOK(statusCode))
	{
		Return ..ExecuteQuery("JDBC Sample Operation")
	}
	Return statusCode
}

/// TestMethod for Business Operation Method ExecuteQueryStream using a ODBC connection
Method TestExecuteQueryStreamODBC() As %Status
{
	#Dim statusCode As %Status = ..IsProductionRunning()
	If ($System.Status.IsOK(statusCode))
	{
		Return ..ExecuteQueryStream("ODBC Sample Operation")
	}
	Return statusCode
}

/// TestMethod for Business Operation Method ExecuteQueryStream using a JODBC connection
Method TestExecuteQueryStreamJDBC() As %Status
{
	#Dim statusCode As %Status = ..IsProductionRunning()
	If ($System.Status.IsOK(statusCode))
	{
		Return ..ExecuteQueryStream("JDBC Sample Operation")
	}
	Return statusCode
}

/// <p style='text-align: justify;'>
/// 	TestMethod for Business Operation Method ExecuteUpdate using a ODBC connection.
/// 	<br/>
/// 	This test show how to use parameter in the UPDATE statement without describe the parameter.
/// </p>
Method TestExecuteUpdateODBC() As %Status
{
	#Dim statusCode As %Status = ..IsProductionRunning()
	If ($System.Status.IsOK(statusCode))
	{
		#Dim updateRequest As UpdateCompanyRequest = ##Class(UpdateCompanyRequest).GetInstance(1, "TaxODBC")
		//
		Return ..ExecuteUpdate("ODBC Sample Operation", updateRequest)
	}
	Return statusCode
}

/// <p style='text-align: justify;'>
/// 	TestMethod for Business Operation Method ExecuteUpdate using a JDBC connection.
/// 	<br/>
/// 	This test show how to use parametesr in the UPDATE statement without describe the parameters.
/// </p>
Method TestExecuteUpdateJDBC() As %Status
{
	#Dim statusCode As %Status = ..IsProductionRunning()
	If ($System.Status.IsOK(statusCode))
	{
		#Dim updateRequest As UpdateCompanyRequest = ##Class(UpdateCompanyRequest).GetInstance(2, "TaxJDBC")
		//
		Return ..ExecuteUpdate("JDBC Sample Operation", updateRequest)
	}
	Return statusCode
}

/// <p style='text-align: justify;'>
/// 	TestMethod for Business Operation Method ExecuteProcedue using a ODBC connection.
/// 	<br/>
/// 	This test show how to use parameters in the Procedure statement describing the parameters.
/// </p>
Method TestExecuteProcedureODBC() As %Status
{
	#Dim statusCode As %Status = ..IsProductionRunning()
	If ($System.Status.IsOK(statusCode))
	{
		#Dim procedureRequest As PersonSetsRequest = ##Class(PersonSetsRequest).GetInstance("A", "NY")
		//
		Return ..ExecuteProcedure("ODBC Sample Operation", procedureRequest)
	}
	Return statusCode
}

/// <p style='text-align: justify;'>
/// 	TestMethod for Business Operation Method ExecuteProcedue using a JDBC connection.
/// 	<br/>
/// 	This test show how to use parameters in the Procedure statement describing the parameters.
/// </p>
Method TestExecuteProcedureJDBC() As %Status
{
	#Dim statusCode As %Status = ..IsProductionRunning()
	If ($System.Status.IsOK(statusCode))
	{
		#Dim procedureRequest As PersonSetsRequest = ##Class(PersonSetsRequest).GetInstance("A", "NY")
		//
		Return ..ExecuteProcedure("JDBC Sample Operation", procedureRequest)
	}
	Return statusCode
}

/// <p style='text-align: justify;'>
/// 	Test for Business Operation Method <b>ExecuteQuery</b>. Send a request to Business Operation received
///   on parameter: <b>targetBusinessOperation</b> that should be: "ODBC Sample Operation" or "JDBC Sample Operation"
///   <br/>
/// 	This test use the request class: <class>QueryRequest</class> and the Lookup Table: 
///   <b>TESTS_XDBC_CONFIG</b>
/// 	<br/><br/>
/// 	The test consist in run the select statement bellow:
/// 	<br/><br/>
/// 	<example>
/// 		SELECT * FROM Sample.Person
/// 	<example>
/// <p style='text-align: justify;'>
Method ExecuteQuery(targetBusinessOperation As %String) As %Status [ Private ]
{
	#Dim statusCode	As %Status						= $System.Status.OK()
	#Dim exception	As %Exception.General	= ""
	Try 
	{
		#Dim queryRequest		As QueryRequest 	= ##Class(QueryRequest).%New("TESTS_XDBC_CONFIG")
		#Dim queryResponse	As QueryResponse = ""
		//
		Set statusCode = ##Class(EnsLib.Testing.Service).SendTestRequest(targetBusinessOperation, queryRequest, .queryRequest,, 1)
		//
		Do $$$AssertStatusOK(statusCode, "Status Code from ExecuteQuery")
		Do $$$AssertEquals(queryResponse.Snapshots.GetAt(1).RowCount, 200, "Total of rows returned from: "_ queryRequest.Statement)
	}
	Catch (exception)
	{
		Set statusCode = exception.AsStatus()
	}
	Return statusCode
}

/// <p style='text-align: justify;'>
/// 	Test for Business Operation Method <b>ExecuteQueryStream</b>. Send a request to Business Operation received
///   on parameter: <b>targetBusinessOperation</b> that should be: "ODBC Sample Operation" or "JDBC Sample Operation"
///   <br/>
/// 	This test use the request class: <class>QueryStreamRequest</class> and the Lookup Table: <b>TESTS_XDBC_CONFIG</b>
/// 	<br/><br/>
/// 	The test consist in run the select statement bellow:
/// 	<br/><br/>
/// 	<example>
/// 		SELECT * FROM Sample.Employee
/// 	<example>
/// <p style='text-align: justify;'>
Method ExecuteQueryStream(targetBusinessOperation As %String) As %Status [ Private ]
{
	#Dim statusCode	As %Status						= $System.Status.OK()
	#Dim exception	As %Exception.General	= ""
	Try 
	{
		#Dim queryStreamRequest		As QueryStreamRequest		= ##Class(QueryStreamRequest).%New("TESTS_XDBC_CONFIG")
		#Dim queryStreamResponse	As QueryStreamResponse	= ""
		//
		Do queryStreamRequest.ColumnNumbers.Insert(7)
		Do queryStreamRequest.ColumnNumbers.Insert(8)
		//
		Set statusCode = ##Class(EnsLib.Testing.Service).SendTestRequest(targetBusinessOperation, queryStreamRequest, .queryStreamResponse,, 1)
		//
		Do $$$AssertStatusOK(statusCode, "Status Code from ExecuteQueryStream")
		Do $$$AssertEquals(queryStreamResponse.Snapshots.GetAt(1).RowCount, 100, "Total of rows returned from: "_ queryStreamResponse.Statement)
		Do ..LogMessage("Some data of stream 1" _ queryStreamResponse.Streams.GetAt(1).Read(10) _ "...")
		Do ..LogMessage("Some data of stream 2" _ queryStreamResponse.Streams.GetAt(2).Read(10)  _ "...")
	}
	Catch (exception)
	{
		Set statusCode = exception.AsStatus()
	}
	Return statusCode
}

/// <p style='text-align: justify;'>
/// 	Test for Business Operation Method <b>ExecuteQuery</b>. Invoque the Business Operation: <b>ODBC Samples Operation</b>
///   <br/>
/// 	This test use the request class: <class>UpdateCompanyRequest</class> derived from
/// 	<class>UpdateRequest</class> and the Lookup Table: <b>TESTS_XDBC_CONFIG</b>
/// 	<br/><br/>
/// 	The test consist in run the select statement bellow:
/// 	<br/><br/>
/// 	<example>
/// 		UPDATE Sample.Person SET TaxID = '?' WHERE ID = ?
/// 	<example>
/// <p style='text-align: justify;'>
Method ExecuteUpdate(targetBusinessOperation As %String, updateRequest As UpdateCompanyRequest) As %Status [ Private ]
{
	#Dim statusCode	As %Status						= $System.Status.OK()
	#Dim exception	As %Exception.General	= ""
	Try 
	{		
		#Dim updateResponse	As UpdateCompanyResponse = ""		
		//
		Set statusCode = ##Class(EnsLib.Testing.Service).SendTestRequest(targetBusinessOperation, updateRequest, .updateResponse,, 1)
		//
		Do $$$AssertStatusOK(statusCode, "Status Code from ExecuteUpdate")
		Do $$$AssertEquals(updateResponse.RowsAfecteds, 1, "Total of rows afecteds : "_ updateResponse.RowsAfecteds)
	}
	Catch (exception)
	{
		Set statusCode = exception.AsStatus()
	}
	Return statusCode
}

/// <p style='text-align: justify;'>
/// 	Test for Business Operation Method <b>ExecuteProcedure</b>. Invoque the Business Operation: <b>ODBC Samples Operation
///   </b><br/>
/// 	This test use the request class: <class>ProcedureRequest</class> and the Lookup Table: <b>TESTS_XDBC_CONFIG</b>
/// 	<br/><br/>
/// 	The test consist in run the select statement bellow:
/// 	<br/><br/>
/// 	<example>
/// 		CALL Sample.PersonSets('A','NY')
/// 	<example>
/// <p style='text-align: justify;'>
Method ExecuteProcedure(targetBusinessOperation As %String, procedureRequest As PersonSetsRequest) As %Status [ Private ]
{
	#Dim statusCode	As %Status						= $System.Status.OK()
	#Dim exception	As %Exception.General	= ""
	Try 
	{
		#Dim procedureResponse	As PersonSetsResponse	= ""
		//
		Set statusCode = ##Class(EnsLib.Testing.Service).SendTestRequest(targetBusinessOperation, procedureRequest, .procedureResponse,, 1)
		//
		Do $$$AssertStatusOK(statusCode, "Status Code from ExecuteProcedure")
		Do $$$AssertEquals(procedureResponse.Snapshots.GetAt(1).RowCount, 2, "Total of rows returned from resultset 1: " _ procedureResponse.Snapshots.GetAt(1).RowCount)
		Do $$$AssertEquals(procedureResponse.Snapshots.GetAt(2).RowCount, 5, "Total of rows returned from resultset 2: " _ procedureResponse.Snapshots.GetAt(2).RowCount)
	}
	Catch (exception)
	{
		Set statusCode = exception.AsStatus()
	}
	Return statusCode
}

/// <p style='text-align: justify;'>
/// 	I do not know why, in test executions, the Production does not start, then 
/// 	I check if Production is running, in case of Production is stopped I start it.
/// </p>
Method IsProductionRunning() As %Status [ Private ]
{
	#Dim statusCode As %Status = $System.Status.OK()
	If ('##Class(Ens.Director).IsProductionRunning())
	{
		Do ..LogMessage("Production stopped! Starting...")
		Do $$$AssertStatusOK(##Class(Ens.Director).StartProduction(), "Status start Production!")
	}
	Return statusCode
}

}
