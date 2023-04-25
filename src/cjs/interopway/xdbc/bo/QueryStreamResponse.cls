/// <p style='text-align: justify;'>
/// 	<b>2020-06-10 - Cristiano José da Silva</b><br/>
/// 	Response for SELECT Statments with CLOB/BLOB columns
/// </p>
Class cjs.interopway.xdbc.bo.QueryStreamResponse Extends (%Persistent, cjs.interopway.xdbc.bo.BaseResponse)
{

/// List of character streams by query.
Property CharacterStreams As list Of %Stream.GlobalCharacter;

/// List of binary streams by query.
Property BinaryStreams As list Of %Stream.GlobalBinary;

Storage Default
{
<Data name="QueryStreamResponseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CharacterStreams</Value>
</Value>
<Value name="3">
<Value>BinaryStreams</Value>
</Value>
<Value name="4">
<Value>Snapshots</Value>
</Value>
</Data>
<DataLocation>^cjs.intero60ED.QueryStream8CB5D</DataLocation>
<DefaultData>QueryStreamResponseDefaultData</DefaultData>
<IdLocation>^cjs.intero60ED.QueryStream8CB5D</IdLocation>
<IndexLocation>^cjs.intero60ED.QueryStream8CB5I</IndexLocation>
<StreamLocation>^cjs.intero60ED.QueryStream8CB5S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
