/// /// <p style='text-align: justify;'>
/// 	<b>2020-06-17 - Cristiano José da Silva</b><br/>
/// 	Base response to the Business Operation <class>cjs.interopway.xdbc.bo.Operation</class><br/>
/// 	This class can not be instantiated. Use one of the following subclasses:<br>
/// 	<ul>
/// 		<li><class>cjs.interopway.xdbc.bo.ProcedureResponse</class> - Result of  StroredProcedures/Functions<li>
/// 		<li><class>cjs.interopway.xdbc.bo.QueryResponse</class> - Result of SELECT statements<li>
/// 		<li><class>cjs.interopway.xdbc.bo.QueryStreamResponse</class> - Result of SELECT statements that return BLOB/CLOB<li>
/// 		<li><class>cjs.interopway.xdbc.bo.UpdateResponse</class> - Result of INSERT/UPDATE/DELETE statements<li>
/// 	</ul>
/// </p>
Class cjs.interopway.xdbc.bo.BaseResponse Extends (%Persistent, Ens.Response) [ Abstract ]
{

/// List of snapshots returned by statement execution
Property Snapshots As list Of EnsLib.SQL.Snapshot;

Storage Default
{
<Data name="BaseResponseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Snapshots</Value>
</Value>
</Data>
<DataLocation>^cjs.interopwa60ED.BaseResponseD</DataLocation>
<DefaultData>BaseResponseDefaultData</DefaultData>
<IdLocation>^cjs.interopwa60ED.BaseResponseD</IdLocation>
<IndexLocation>^cjs.interopwa60ED.BaseResponseI</IndexLocation>
<StreamLocation>^cjs.interopwa60ED.BaseResponseS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
