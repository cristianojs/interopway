Import cjs.interopway.xdbc.bo

Include EnsSQLTypes

/// <p style='text-align: justify;'>
/// 	<b>2022-12-11 - Cristiano José da Silva</b><br/>
/// 	Request to call the stored procedure ? = CALL Sample.PersonSets('?','?')
/// </p>
Class cjs.interopway.samples.person.bo.PersonSetsRequest Extends ProcedureRequest
{

Parameter RESPONSECLASSNAME As STRING = "cjs.interopway.samples.person.bo.PersonSetsResponse";

/// Create a new Instance of <class>cjs.interopway.samples.person.bo.PersonSetsRequest</class>.
/// Set, describe parameters and return.
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

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
