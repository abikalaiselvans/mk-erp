package sample.db;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Hashtable;
import java.util.Properties;

public class Singleton 
{ 
    private static Singleton m_SingletonInstance = null; 
    private Connection con = null; 
    private Hashtable m_PrefsHash = null; 

 
    private Singleton() 
    { 
    	try 
		{
    		m_PrefsHash = new Hashtable(); 
    		String profilename = "JDBC.properties";
			InputStream input = new FileInputStream(profilename);
			Properties jdbc = new Properties();
			jdbc.load(input);
			String driver =jdbc.getProperty("DB_DRIVER");
			String url = jdbc.getProperty("DB_URL");
			String struser =jdbc.getProperty("DB_USERNAME");
			String Passw =  jdbc.getProperty("DB_PASSWORD");
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smartcampus", "root", "mythra");
			m_PrefsHash.put("Connection",con); 
		} 
		catch (Exception e) 
		{
		}
    } 

     public static Singleton getInstance() 
    { 
        
    	 if(m_SingletonInstance == null) 
        {
            m_SingletonInstance = new Singleton();
            
        }
        
        return m_SingletonInstance; 
    } 


     public Connection getPrefsFor(String connection) 
     { 
         return (Connection)m_PrefsHash.get(connection); 
     }
     
    

} 
