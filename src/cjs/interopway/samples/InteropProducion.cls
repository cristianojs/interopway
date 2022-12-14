/// <p >
///   <b>2022-12-11 - Cristiano José da Silva</b><br/>
///   Production that show how to use the XDBC classes with few line of code e and 
///   configurations, to achieve interoperability with external databases.
/// </p>
Class cjs.interopway.samples.InteropProducion Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="cjs.interopway.samples.InteropProducion" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description>Production for test XDBC and REST components</Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="ODBC Sample Operation" Category="" ClassName="cjs.interopway.xdbc.bo.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="DSN">ENSEMBLE Samples</Setting>
    <Setting Target="Adapter" Name="StayConnected">0</Setting>
    <Setting Target="Adapter" Name="Credentials">ENSEMBLE Samples</Setting>
  </Item>
  <Item Name="JDBC Sample Operation" Category="" ClassName="cjs.interopway.xdbc.bo.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="DSN">jdbc:Cache://127.0.0.1:56773/SAMPLES</Setting>
    <Setting Target="Adapter" Name="JDBCDriver">com.intersys.jdbc.CacheDriver</Setting>
    <Setting Target="Adapter" Name="JGService">EnsLib.JavaGateway.Service</Setting>
    <Setting Target="Adapter" Name="StayConnected">0</Setting>
    <Setting Target="Adapter" Name="Credentials">ENSEMBLE Samples</Setting>
  </Item>
  <Item Name="EnsLib.JavaGateway.Service" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ClassPath">C:\InterSystems\Ensemble\dev\java\lib\JDK18\cache-db-2.0.0.jar;C:\InterSystems\Ensemble\dev\java\lib\JDK18\cache-jdbc-2.0.0.jar</Setting>
  </Item>
</Production>
}

}
