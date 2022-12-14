/// <p style='text-align: justify;'>
/// 	 <b>2020-06-30 - Cristiano José da Silva</b><br/>
/// 	 Response for UPDATE/DELETE statements.
/// </p>
Class cjs.interopway.xdbc.bo.UpdateResponse Extends (%Persistent, cjs.interopway.xdbc.bo.BaseResponse)
{

/// Number of lines afecteds by the INSERT/UPDATE/DELETE
Property RowsAfecteds As %Integer;

Storage Default
{
<Data name="UpdateResponseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>RowsAfecteds</Value>
</Value>
<Value name="3">
<Value>Snapshots</Value>
</Value>
</Data>
<DataLocation>^cjs.interop60ED.UpdateResponseD</DataLocation>
<DefaultData>UpdateResponseDefaultData</DefaultData>
<IdLocation>^cjs.interop60ED.UpdateResponseD</IdLocation>
<IndexLocation>^cjs.interop60ED.UpdateResponseI</IndexLocation>
<StreamLocation>^cjs.interop60ED.UpdateResponseS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
