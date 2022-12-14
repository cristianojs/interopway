/// <p style='text-align: justify;'>
/// <b>2020-05-11 - Cristiano José da Silva</b><br/>
/// Generic Business Operation to use XDBC connections.
/// </p>
Class cjs.interopway.xdbc.bo.Operation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Parameter SETTINGS = "MaxRowsToGet";

/// Max rows to get at once
Property MaxRowsToGet As %Integer [ InitialExpression = 10000 ];

/// Executes SELECT and returns a instance of <class>EnsLib.SQL.Snapshot</class>
Method ExecuteQuery(request As cjs.interopway.xdbc.bo.QueryRequest, Output response As cjs.interopway.xdbc.bo.QueryResponse) As %Status
{
	#Dim statusCode As %Status						= $System.Status.OK()
	#Dim exception  As %Exception.General	= ""    
	Try
	{
	  Set statusCode = request.NewResponse(.response)
	  If ($System.Status.IsError(statusCode))
	  {
			Return statusCode
	  }
	  Do ..CheckConnection(request)
	  //
	  #Dim rs 				As EnsLib.SQL.GatewayResultSet  = ""
	  #Dim parameters	As %String											= ""
		If (request.Parameters.Count())
		{
			Do request.GetParameters(.parameters)
			//
			Set statusCode = ..Adapter.ExecuteQueryParamArray(.rs, request.Statement, .parameters)
		}
		Else
		{
			Set statusCode = ..Adapter.ExecuteQuery(.rs, request.Statement)
		}
	  If ($System.Status.IsError(statusCode))
	  {               
			Return statusCode
	  }
	  #Dim snapshot As EnsLib.SQL.Snapshot = ##Class(EnsLib.SQL.Snapshot).%New()
	  //
	  Set snapshot.MaxRowsToGet	= ..MaxRowsToGet
	  Set statusCode            = rs.GetSnapshot(.snapshot, 1)
	  If ($System.Status.IsError(statusCode))
	  {               
			Return statusCode
	  }
	  Do response.Snapshots.Insert(snapshot)
	}
	Catch (exception)
	{
		Set statusCode = exception.AsStatus()
	}
	Return statusCode
}

/// Executes a SELECT that returns a stream data (CLOB or BLOB)
Method ExecuteQueryStream(request As cjs.interopway.xdbc.bo.QueryStreamRequest, Output response As cjs.interopway.xdbc.bo.QueryStreamResponse) As %Status
{
	#Dim statusCode As %Status            = $System.Status.OK()
	#Dim exception  As %Exception.General	= ""    
	Try
	{
	  Set statusCode = ..ExecuteQuery(request, .response)
	  If ($System.Status.IsError(statusCode))
		{
			Return statusCode
		}
		#Dim rs As EnsLib.SQL.GatewayResultSet = response.Snapshots.GetAt(1)
	  If (rs.Next())
	  {
			#Dim columnIndex	As %Integer = 0
			For columnIndex = 1 : 1 : request.ColumnNumbers.Size
			{
				#Dim stream	As %Stream.Object = ""
				If (rs.GetColumnIsBinary(columnIndex))
				{
					Set stream = ##Class(%Stream.GlobalBinary).%New()
					//
					Do stream.CopyFrom(rs.GetDataStream(request.ColumnNumbers.GetAt(columnIndex)))
	  			Do response.BinaryStreams.Insert(stream)
				}
				Else
				{
					Set stream = ##Class(%Stream.GlobalCharacter).%New()
					//
					Do stream.CopyFrom(rs.GetDataStream(request.ColumnNumbers.GetAt(columnIndex)))
	  			Do response.CharacterStreams.Insert(stream)
				}				
			}
	  }
	} 
	Catch (exception)
	{
		Set statusCode	= exception.AsStatus()
	}
	Return statusCode
}

/// Executa Procedures ou Functions
Method ExecuteProcedure(request As cjs.interopway.xdbc.bo.ProcedureRequest, Output response As cjs.interopway.xdbc.bo.ProcedureResponse) As %Status
{
	#Dim statusCode As %Status            = $System.Status.OK()
	#Dim exception  As %Exception.General	= ""    
	Try
	{
	  Set statusCode = request.NewResponse(.response)
		If ($System.Status.IsError(statusCode))
		{
			Return statusCode
		}
		Do ..CheckConnection(request)		
		If (request.Parameters.Count())
		{
			#Dim parameters	As %String	= ""
			#Dim io					As %String	= ""
			Do request.GetParameters(.parameters, .io)
			//
			#Dim snapshots	As %ListOfObjects		= ""
			#Dim outputs		As %ListOfDataTypes	= ""
			//
			Set statusCode = ..Adapter.ExecuteProcedureParmArray(.snapshots, .outputs, request.Statement, io, .parameters)
		}
		Else
		{
			Set statusCode = ..Adapter.ExecuteProcedure(.snapshots, .outputs, request.Statement)
		}
		If ($System.Status.IsError(statusCode))
	  {
			Return statusCode
	  }
	  Set response.Snapshots	= snapshots
	  Set response.Outputs		= outputs
	} 
	Catch (exception)
	{
		Set statusCode	= exception.AsStatus()
	}
	Return statusCode
}

/// Executes INSERT/UPDATE/DELETE
Method ExecuteUpdate(request As cjs.interopway.xdbc.bo.UpdateRequest, Output response As cjs.interopway.xdbc.bo.UpdateResponse) As %Status
{
	#Dim statusCode As %Status            = $System.Status.OK()
	#Dim exception  As %Exception.General	= ""    
	Try
	{	    
	  Set statusCode = request.NewResponse(.response)
	  If ($System.Status.IsError(statusCode))
	  {
			Return statusCode
	  }
	  Do ..CheckConnection(request)
	  //
	  #Dim rowsAfecteds	As %ListOfDataTypes	= ""
		If (request.Parameters.Count())
		{
			#Dim parameters 	As %String	= ""
			Do request.GetParameters(.parameters)
			//
			Set statusCode = ..Adapter.ExecuteUpdateParmArray(.rowsAfecteds, request.Statement, .parameters)
		}
		Else
		{
			Set statusCode = ..Adapter.ExecuteUpdate(.rowsAfecteds, request.Statement)
		}
		If ($System.Status.IsError(statusCode))
	  {
			Return statusCode
	  }
	  Set response.RowsAfecteds	= rowsAfecteds
	} 
	Catch (exception)
	{
	  Set statusCode	= exception.AsStatus()
	}
	Return statusCode
}

/// Checa se vieram dados de conexão na mensagem, e se afirmativo configura o adpater para utilizá-los.
Method CheckConnection(request As cjs.interopway.xdbc.bo.BaseRequest) [ Private ]
{
	#Dim statusCode As %Status            = $System.Status.OK()
	#Dim exception  As %Exception.General	= ""    
	Try
	{
	  If (request.Credential '= "")
	  {
	  	Set statusCode = ..Adapter.CredentialsSet(request.Credential)
      If ($System.Status.IsError(statusCode))
      {
				Throw ##class(%Exception.StatusException).CreateFromStatus(statusCode)
      }
	  }
	  If (request.DSN '= "")
	  {		
	  	Set statusCode = ..Adapter.DSNSet(request.DSN)
	    If ($System.Status.IsError(statusCode))
	    {
				Throw ##class(%Exception.StatusException).CreateFromStatus(statusCode)
	    }
	  }
	  Set statusCode = ..Adapter.Connect()
		If ($System.Status.IsError(statusCode))
		{
			Throw ##class(%Exception.StatusException).CreateFromStatus(statusCode)
		}
	}
	Catch (exception)
	{
	    Throw exception
	}
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="cjs.interopway.xdbc.bo.UpdateRequest">
		<Method>ExecuteUpdate</Method>
	</MapItem>
    <MapItem MessageType="cjs.interopway.xdbc.bo.ProcedureRequest">
		<Method>ExecuteProcedure</Method>
	</MapItem>
	<MapItem MessageType="cjs.interopway.xdbc.bo.QueryStreamRequest">
		<Method>ExecuteQueryStream</Method>
	</MapItem>
	<MapItem MessageType="cjs.interopway.xdbc.bo.QueryRequest">
		<Method>ExecuteQuery</Method>
	</MapItem>
</MapItems>
}

}
