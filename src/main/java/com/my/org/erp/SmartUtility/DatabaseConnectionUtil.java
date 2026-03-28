package com.my.org.erp.SmartUtility;

import java.lang.System;

public class DatabaseConnectionUtil {

    public static String getDbPassword() {
        // Get the environment variable
        String password = System.getenv("MYSQL_PASSWORD");
        if (password == null) {
            // Handle the case where the environment variable is not set
            // maybe throw an exception or use a default
            System.err.println("Error: MYSQL_PASSWORD environment variable is not set.");
        }
        return password;
    }
    
    
    // Use this method to get the password and connect to the DB
}
