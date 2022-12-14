/// <p style='text-align: justify;'>
/// 	<b>2020-06-10 - Cristiano José da Silva</b><br/>
/// 	Response for Procedures/Funcions statements
/// </p>
Class cjs.interopway.xdbc.bo.ProcedureResponse Extends (%Persistent, cjs.interopway.xdbc.bo.BaseResponse)
{

/// List of all output parameters of procedure/function
Property Outputs As list Of %String;

Storage Default
{
<Data name="ProcedureResponseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Outputs</Value>
</Value>
<Value name="3">
<Value>Snapshots</Value>
</Value>
</Data>
<DataLocation>^cjs.intero60ED.ProcedureRe76C5D</DataLocation>
<DefaultData>ProcedureResponseDefaultData</DefaultData>
<IdLocation>^cjs.intero60ED.ProcedureRe76C5D</IdLocation>
<IndexLocation>^cjs.intero60ED.ProcedureRe76C5I</IndexLocation>
<StreamLocation>^cjs.intero60ED.ProcedureRe76C5S</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
