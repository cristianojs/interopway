/// <p style='text-align: justify;'>
/// 	<b>2020-06-17 - Cristiano José da Silva</b><br/>
/// 	Base request to the Business Operation <class>cjs.interopway.xdbc.bo.Operation</class><br/>
/// 	This class can not be instantiated. Use one of the following subclasses:<br>
/// 	<ul>
/// 		<li><class>cjs.interopway.xdbc.bo.ProcedureRequest</class> - To execute StroredProcedures/Functions<li>
/// 		<li><class>cjs.interopway.xdbc.bo.QueryRequest</class> - To execute SELECT statements<li>
/// 		<li><class>cjs.interopway.xdbc.bo.QueryStreamRequest</class> - To execute SELECT statements that return BLOB/CLOB<li>
/// 		<li><class>cjs.interopway.xdbc.bo.UpdateRequest</class> - To execute INSERT/UPDATE/DELETE statements<li>
/// 	</ul>
/// </p>
Class cjs.interopway.xdbc.bo.BaseRequest Extends (%Persistent, Ens.Request) [ Abstract ]
{

Parameter RESPONSECLASSNAME As STRING = "cjs.interopway.xdbc.bo.BaseResponse";

/// SQL Statement to be executed.
Property Statement As %String(MAXLEN = "");

/// Name of the credential used to connect to a external database.
Property Credential As %String(MAXLEN = 50);

/// For ODBC connections the DNS contigurated to access the external database.<br>
/// For JDBC connections the connection string to to access the external database.
Property DSN As %String(MAXLEN = "");

/// List of paramters used in the SQL Statement
Property Parameters As list Of cjs.interopway.xdbc.bo.ParameterDefinition;

/// Method to retreave a in memory array with parameter description and the io specification.
Method GetParameters(Output array, Output io As %String)
{
	#Dim indiexParmaters As %Integer	= 0
	//
	Set array = ..Parameters.Count()
	For indiexParmaters = 1 : 1 : array
	{
		Do ..Parameters.GetAt(indiexParmaters).GetDefinition(.array, .io)
	}
}

/// /// <p style='text-align: justify;'>
/// 	Return a new instance of the message populated with the settings in the Lookup Table received in the parameter lookupTable.
/// 		<br/>
/// 	The key of the Lookup Table is the fully qualified name of the request class. Bellow a sample:
/// 	<pre>
/// 		&lt;?xml version="1.0"?&gt;
/// 		&lt;lookupTable&gt;
/// 			&lt;entry table="TESTS_XDBC_CONFIG" key="cjs.interopway.xdbc.bo.QueryRequest"&gt;
/// 				{
/// 					"credential":"ENSEMBLE Samples",
/// 					"dsn":"ENSEMBLE Samples",
/// 					"statement":"SELECT * FROM Sample.Person"
/// 				}
/// 			&lt;entry&gt;
/// 		&lt;/lookupTable&gt;
/// 	</pre>
/// </p>
Method %OnNew(lookupTable As %String = "XDBC") As %Status
{
	#Dim exception	As %Exception.General = ""
	#Dim statusCode	As %Status						= $System.Status.OK()
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

Storage Default
{
<Data name="BaseRequestDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Statement</Value>
</Value>
<Value name="3">
<Value>Credential</Value>
</Value>
<Value name="4">
<Value>DSN</Value>
</Value>
<Value name="5">
<Value>Parameters</Value>
</Value>
</Data>
<DataLocation>^cjs.interopway60ED.BaseRequestD</DataLocation>
<DefaultData>BaseRequestDefaultData</DefaultData>
<IdLocation>^cjs.interopway60ED.BaseRequestD</IdLocation>
<IndexLocation>^cjs.interopway60ED.BaseRequestI</IndexLocation>
<StreamLocation>^cjs.interopway60ED.BaseRequestS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
