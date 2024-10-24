package com.my.org.erp.example.util;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;

public class JDBC 
{
  public static void main(String[] argv) throws Exception 
  {
    String driver = "com.mysql.jdbc.Driver";
    String user = "root";
    String pass = "mythra";

    Class.forName(driver);
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smartcampus", user,  pass);

    DatabaseMetaData dbm = con.getMetaData();
    String[] types = { "TABLE" };
    ResultSet rs = dbm.getTables(null, null, "%", types);
    while (rs.next()) 
    {
      String table = rs.getString("TABLE_NAME");
      System.out.println(table);
       
    }

  }
}