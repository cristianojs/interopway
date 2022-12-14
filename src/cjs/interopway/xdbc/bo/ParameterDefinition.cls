Include Ensemble

/// <p style='text-align: justify;'>
/// 	<b>2020-06-26 - Cristiano José da Silva</b><br/>
/// 	This class is used to describe parameters to be used in queries or procedures/functions
/// </p>
Class cjs.interopway.xdbc.bo.ParameterDefinition Extends (%SerialObject, %XML.Adaptor)
{

Parameter INPUT = {##Class(EnsLib.SQL.OutboundAdapter).%GetParameter("SQLParamInput")};

Parameter OUTPUT = {##Class(EnsLib.SQL.OutboundAdapter).%GetParameter("SQLParamOutput")};

Parameter INOUT = {##Class(EnsLib.SQL.OutboundAdapter).%GetParameter("SQLParamInputOutput")};

/// Parameter Value
Property Value As %String(MAXLEN = "");

/// IO type of parameter used only to call procedures/functions
Property IOType As %String(DISPLAYLIST = ",INPUT,OUTPUT,INOUT", VALUELIST = ",1,4,2");

/// Postion of parameter in the query or procedure/function
Property Ordinal As %Integer [ Required ];

/// SQL data type of parameter see EnsSQLTypes.inc
Property SqlType As %Integer;

/// Precision of parameter.
Property Precision As %Integer;

/// Scale of parameter
Property Scale As %Integer;

/// Flag to sinalize that the parameter is a large object
Property LOB As %Boolean;

/// Flag to sinalize that the parameter is binary
Property Bin As %Boolean;

/// Create a memory array with parameter description and the io specifaction of parameter
Method GetDefinition(Output array, Output io As %String)
{
	If (..Value '= "")
	{
		Set array(..Ordinal) = ..Value
	}
	If (..IOType '= "")
	{
		Set array(..Ordinal, "IOType")	= ..IOType
	}
	If (..SqlType '= "")
	{
		Set array(..Ordinal, "SqlType")	= ..SqlType
	}
	If (..Precision '= "")
	{
		Set array(..Ordinal, "Prec")	= ..Precision
	}
	If (..Scale '= "")
	{
		Set array(..Ordinal, "Scale")	= ..Scale
	}
	If (..LOB '= "")
	{
		Set array(..Ordinal, "LOB")	= ..LOB
	}
	If (..Bin '= "")
	{
		Set array(..Ordinal, "Bin")	= ..Bin
	}
	Set io	= $Get(io) _ $Case(..IOType, ..#INPUT : "i", ..#OUTPUT : "o", ..#INOUT : "b", : "") _ "#"
}

/// <p style='text-align: justify;'>
/// 	Create a new isntance of <class>cjs.interopway.xdbc.bo.ParameterDefinition</class> populated with all parameters received.
/// 	Only the ordinal parameter is required.
/// </p>
Method %OnNew(ordinal As %Integer, value As %String = "", ioType As %String = "", sqlType As %Integer = "", precision As %Integer = "", scale As %Integer = "", lob As %Boolean = "", bin As %Boolean = "") As %Status
{
	Set ..Ordinal = ordinal
	If (value '= "") 
	{
		Set ..Value = value
	}
	If (sqlType '= "")
	{
		Set ..SqlType	= sqlType
	}
	If (ioType '= "")
	{
		Set ..IOType	= ..IOTypeDisplayToLogical($ZConvert(ioType, "U"))
	}
	If (precision '= "")
	{
		Set ..Precision	= precision
	}
	If (scale '= "")
	{
		Set ..Scale	= scale
	}
	If (lob '= "")
	{	
		Set ..LOB	= lob
	}
	If (bin '= "")
	{
		Set ..Bin	= bin
	}
	Return $System.Status.OK()
}

Storage Default
{
<Data name="ParameterDefinitionState">
<Value name="1">
<Value>Value</Value>
</Value>
<Value name="2">
<Value>IOType</Value>
</Value>
<Value name="3">
<Value>Ordinal</Value>
</Value>
<Value name="4">
<Value>SqlType</Value>
</Value>
<Value name="5">
<Value>Precision</Value>
</Value>
<Value name="6">
<Value>Scale</Value>
</Value>
<Value name="7">
<Value>LOB</Value>
</Value>
<Value name="8">
<Value>Bin</Value>
</Value>
</Data>
<State>ParameterDefinitionState</State>
<StreamLocation>^cjs.intero60ED.ParameterDeC43FS</StreamLocation>
<Type>%Library.CacheSerialState</Type>
}

}
