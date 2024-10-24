package com.my.org.erp.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
 
import com.my.org.erp.listener.db.DBConnectionManager;
 
 
public class AppContextListener implements ServletContextListener 
{
 
    public void contextInitialized(ServletContextEvent servletContextEvent) 
    {
        ServletContext ctx = servletContextEvent.getServletContext();
        String url = ctx.getInitParameter("Url");
        String u = "root";
        String p = "mythra";
         
        //create database connection from init parameters and set it to context
        DBConnectionManager dbManager = new DBConnectionManager(url, u, p);
        ctx.setAttribute("DBManager", dbManager);
        System.out.println("Database connection initialized for Application.");
    }
 
    public void contextDestroyed(ServletContextEvent servletContextEvent) 
    {
        ServletContext ctx = servletContextEvent.getServletContext();
        DBConnectionManager dbManager = (DBConnectionManager) ctx.getAttribute("DBManager");
        dbManager.closeConnection();
        System.out.println("Database connection closed for Application.");
         
    }
     
}