package sample.db;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.commons.dbcp.BasicDataSource;

public class DataSourceExample {
        Connection connection = null;
        BasicDataSource bdSource = new BasicDataSource();

        public DataSourceExample() {
                bdSource.setDriverClassName("com.mysql.jdbc.Driver");
                bdSource.setUrl("jdbc:mysql://localhost:3306/smartcampus");
                bdSource.setUsername("root");
                bdSource.setPassword("mythra");
        }

        public Connection createConnection() {
                Connection con = null;
                try {
                        if (connection != null) {
                                System.out.println("Cant create a New Connection");
                        } else {
                                con = bdSource.getConnection();
                                System.out.println("Connection Done successfully");
                        }
                } catch (Exception e) {
                        System.out.println("Error Occured " + e.toString());
                }
                return con;
        }

        
        
        public static void main(String args[]) throws Exception 
        {
                DataSourceExample dsExample = new DataSourceExample();
                Connection con = dsExample.createConnection();
                Statement stmt = con.createStatement();
                String query = "SELECT * FROM test";
                ResultSet rs = stmt.executeQuery(query);
                while (rs.next()) {
                        System.out.println("Name- " + rs.getString("CHR_NAME") + ", Roll No- "
                                        );
                }
                con.close();
                stmt.close();
                rs.close();
        }
}