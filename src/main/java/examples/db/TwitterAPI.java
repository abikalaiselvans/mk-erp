package examples.db;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

public class TwitterAPI 
{

    private static String server_name = "localhost:3306";
    private static String database = "smartcampus";
    private static String username = "root";
    private static String password = "mythra";
    public static DataSource dataSource = DBUtils.getDataSource(server_name, database, username, password);

    public static Connection getDBConnection( ) 
    {
        //Set DB parameters
        //DBUtils mysql_obj = setDBParams(server_name, database, username, password);               
        Connection connection = null;
        //connection = mysql_obj.createConnection();
        try 
        {
            connection = dataSource.getConnection();
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
        }
        return connection;
    }

    
    public static DBUtils setDBParams(String server_name, String database, String username, String password)
    {
        DBUtils mysql_obj = new DBUtils();
        mysql_obj.setServer_name(server_name);
        mysql_obj.setDatabase(database);
        mysql_obj.setUsername(username);
        mysql_obj.setPassword(password);
        return mysql_obj;
    }
}

 