package com.my.org.erp.examples;

import java.sql.*;
public class UserLogin 
{
	public static void main(String[] args) 
	{
		try 
		{
			// Load MS accces driver class
			//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			
			// C:\\databaseFileName.accdb" - location of your database 
			//String url = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=" + "D:\\bank.accdb";
			
			// specify url, username, pasword - make sure these are valid 
			//Connection conn = DriverManager.getConnection(url, "", "");
			
			
			Connection CONNECTION = null;
			String dbURL="";
			String dbFile = "d:\\bank.mdb";
			String connectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=";
			String driverID = ";DriverID=22;READONLY=true;}";
			if (CONNECTION == null || CONNECTION.isClosed()) 
			{
			   dbURL = connectionString + dbFile.trim() + driverID;
			   Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			   CONNECTION = DriverManager.getConnection(dbURL);
			}
			
			
			
			System.out.println("Connection Succesfull");
		} 
		catch (Exception e) 
		{
			System.err.println("Got an exception! ");
			System.err.println(e.getMessage());

		}
		}
	}
