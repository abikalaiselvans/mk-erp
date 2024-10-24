package sample.db;

import java.sql.Connection;

public class SingletonExample 
{ 
    public static void main(String[] args) 
    { 
    	
    	Connection con  = Singleton.getInstance().getPrefsFor("Connection");
    	System.out.println(""+con);
    	/*con = Singleton.getInstance().getPrefsFor("connection");
    	System.out.println(""+con);
    	con = Singleton.getInstance().getPrefsFor("connection");
    	System.out.println(""+con);
    	con = Singleton.getInstance().getPrefsFor("connection");
    	System.out.println(""+con);
    	con = Singleton.getInstance().getPrefsFor("connection");
    	System.out.println(""+con);*/
    	 
    } 
} 
