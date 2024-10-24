package sample.db;
 
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.*;
 
public class DBSingleton
{
    
    private static DBSingleton m_SingletonInstance = null;
    private Connection con = null;
    @SuppressWarnings("unused")
	private Connection DBSingleton()
    {
	    	try 
			{
				String profilename = "JDBC.properties";
				InputStream input = new FileInputStream(profilename);
				Properties jdbc = new Properties();
				jdbc.load(input);
				String driver =jdbc.getProperty("DB_DRIVER");
				String url = jdbc.getProperty("DB_URL");
				String struser =jdbc.getProperty("DB_USERNAME");
				String Passw =  jdbc.getProperty("DB_PASSWORD");
				Class.forName(driver);
				con = DriverManager.getConnection(url, struser, Passw);
				if(con == null)
					System.out.println("Connection null");
				return con;
			} 
			catch (Exception e) 
			{
				return null;
			}
    }

    public static  DBSingleton getInstance()
    {
        if(m_SingletonInstance == null)
            m_SingletonInstance = new DBSingleton();

        return m_SingletonInstance;
    }


    

}
 
