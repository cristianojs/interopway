Import cjs.interopway.xdbc.bo

/// <p style='text-align: justify;'>
/// 	<b>2022-12-11 - Cristiano José da Silva</b><br/>
/// 	Request to update a record from the table Sample.Company
/// </p>
Class cjs.interopway.samples.company.bo.UpdateCompanyRequest Extends UpdateRequest
{

Parameter RESPONSECLASSNAME As STRING = "cjs.interopway.samples.company.bo.UpdateCompanyResponse";

/// Create a new Instance of <class>cjs.interopway.samples.person.bo.UpdateCompanyRequest</class>. Set parameters and return.
ClassMethod GetInstance(companyId As %Integer, taxId As %String) As UpdateCompanyRequest
{
	#Dim updateRequest			As UpdateCompanyRequest	= ..%New("TESTS_XDBC_CONFIG")
	//	
	Do updateRequest.Parameters.Insert(##Class(ParameterDefinition).%New(1, taxId))
	Do updateRequest.Parameters.Insert(##Class(ParameterDefinition).%New(2, companyId))
	//
	Return updateRequest
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
