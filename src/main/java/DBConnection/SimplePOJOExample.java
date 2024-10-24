package DBConnection;

import java.sql.Connection;
import org.apache.tomcat.jdbc.pool.DataSource;
import org.apache.tomcat.jdbc.pool.PoolProperties;

public class SimplePOJOExample 
{

	public static void main(String[] args) throws Exception 
	{
		System.out.println(""+get_tomcat_jdbc_Connection());
	}
	
	
	public static Connection get_tomcat_jdbc_Connection( ) throws Exception 
    {
        PoolProperties p = new PoolProperties();
        p.setUrl("jdbc:mysql://localhost:3306/smartcampus");
        p.setDriverClassName("com.mysql.jdbc.Driver");
        p.setUsername("root");
        p.setPassword("mythra");
        p.setJmxEnabled(true);
        p.setTestWhileIdle(false);
        p.setTestOnBorrow(true);
        p.setTestOnReturn(false);
        p.setValidationInterval(30000);
        p.setTimeBetweenEvictionRunsMillis(30000);
        p.setMaxActive(100);
        p.setInitialSize(10);
        p.setMaxWait(10000);
        p.setRemoveAbandonedTimeout(60);
        p.setMinEvictableIdleTimeMillis(30000);
        p.setMinIdle(10);
        p.setLogAbandoned(true);
        p.setRemoveAbandoned(true);
        p.setJdbcInterceptors("org.apache.tomcat.jdbc.pool.interceptor.ConnectionState;"+
          "org.apache.tomcat.jdbc.pool.interceptor.StatementFinalizer");
        DataSource datasource = new DataSource();
        datasource.setPoolProperties(p); 
        Connection con = null;
        try 
        {
          con = datasource.getConnection();
          return con;
        }
        finally 
        {
          if (con!=null) 
        	  try 
           		{
        		  con.close();
        		}
                catch (Exception ignore) 
                {
                	
                }
        }
        
    }

}