package com.my.org.erp.example.util;

import java.sql.Connection;

import org.apache.commons.dbcp.BasicDataSource;

public class BasicDataSourceExample {

  public static void main(String args[]) throws Exception {

    BasicDataSource bds = new BasicDataSource();
    bds.setDriverClassName("com.mysql.jdbc.Driver");
    bds.setUrl("jdbc:mysql://localhost:3306/smartcampus");
    bds.setUsername("root");
    bds.setPassword("care#1994*");

//    bds.setInitialSize(5);

    Connection connection = bds.getConnection();

    System.err.println(connection);
    connection.close();
  }
}