package sample.db;

 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
 
import java.sql.Statement;
 
public class MsAccessfDBCon 
{
	private Connection con = null;
	public MsAccessfDBCon() throws Exception 
	{

	}

	public void getConnection() 
	{
		try 
		{
			
			@SuppressWarnings("unused")
			String path ="jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=D:/netXs.mdb;READONLY=true";
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			System.out.println("class created");


			//DBQ=d:/netXs.MDB
			String myDB =
			"jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=Z:/netXs.MDB;READONLY=true";
			con = DriverManager.getConnection(myDB,"Admin","XsControl");

			
			System.out.println("con created");
			String sql="SELECT empid,MIN(Format(intime,'hh:mm AMPM'))  FROM IOTRANS  WHERE DT=CDATE('7/11/2009') GROUP BY empid ORDER BY empid" ;
			Statement st = con.createStatement();
			System.out.println("statement created");
			ResultSet rs = st.executeQuery(sql);
			int u=0;
			while(rs.next())
			{
				System.out.println((u+1)+" / " +rs.getString(1)+" / "+rs.getString(2));
				u=u+1;
			}	
			st.close();
		 
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

}
