package com.my.org.erp.example.util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DemoScrollableResultSet_MySQL {

  public static Connection getConnection() throws Exception {
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/smartcampus";
    String username = "root";
    String password = "care#1994*";
    Class.forName(driver);
    return DriverManager.getConnection(url, username, password);
  }

  public static void main(String[] args) {
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
      conn = getConnection();
      String query = "select CHR_EMPID, CHR_STAFFNAME, CHR_STAFFFNAME from com_m_staff";
      stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
      rs = stmt.executeQuery(query);
     
      // extract data from the ResultSet scroll from top
      while (rs.next()) {
        String id = rs.getString(1);
        String name = rs.getString(2);
        System.out.println( id + "  name=" + name);
      }
      
      
      // scroll from the bottom
      rs.afterLast();
      while (rs.previous()) {
        String id = rs.getString(1);
        String name = rs.getString(2);
        System.out.println("--id=" + id + "  name=" + name);
      }
    } catch (Exception e) {
       System.out.println(e.getMessage());
    } finally {
      // release database resources
      try {
        rs.close();
        stmt.close();
        conn.close();
      } catch (SQLException e) {
         System.out.println(e.getMessage());
      }
    }
  }
}
