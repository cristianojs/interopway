/// <p style='text-align: justify;'>
/// 	<b>2020-11-13 - Cristiano José da Silva</b><br/>
/// 	Request for SELECT Statments with CLOB/BLOB columns
/// </ps>
Class cjs.interopway.xdbc.bo.QueryStreamRequest Extends cjs.interopway.xdbc.bo.BaseRequest
{

Parameter RESPONSECLASSNAME = "cjs.interopway.xdbc.bo.QueryStreamResponse";

/// List of column number where is the CLOB/BLOB data
Property ColumnNumbers As list Of %Integer;

Storage Default
{
<Data name="QueryStreamRequestDefaultData">
<Subscript>"QueryStreamRequest"</Subscript>
<Value name="1">
<Value>ColumnNumbers</Value>
</Value>
</Data>
<DefaultData>QueryStreamRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
