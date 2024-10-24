package com.my.org.erp.jnidi.datasource;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
@WebServlet("/employee.do")
public class EmployeeServlet extends HttpServlet 
{
    private static final long serialVersionUID = 1L;
    public EmployeeServlet() 
    {
    	
    	System.out.println("Constructor");	
    	
    }
 
    public void doGet(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException 
    {
    	Context envContext = null;
        try {
        	System.out.println("Inside get method");
        	envContext = new InitialContext();
           //Context initContext  = (Context)envContext.lookup("java:/comp/env");
            //DataSource ds = (DataSource)initContext.lookup("jdbc/testDB");
            System.out.println("Context intialized...");
            DataSource ds = (DataSource)envContext.lookup("java:/comp/env/jdbc/testDB");
            System.out.println("DataSource intialized...");
            Connection con = ds.getConnection();
            System.out.println(""+con);
            Statement stmt = con.createStatement();
            String query = "select * from com_m_staff";
            ResultSet rs = stmt.executeQuery(query);
 
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            out.print("<center><h1>Employee Details</h1></center>");
            out.print("<html><body><table border=\"1\" cellspacing=10 cellpadding=5>");
            out.print("<th>Employee ID</th>");
            out.print("<th>Employee Name</th>");
            out.print("<th>Salary</th>");
            out.print("<th>Department</th>");
 
            while(rs.next())
            {
                out.print("<tr>");
                out.print("<td>" + rs.getString(1) + "</td>");
                out.print("<td>" + rs.getString(2) + "</td>");
                out.print("<td>" + rs.getString(3) + "</td>");
                out.print("<td>" + rs.getString(4) + "</td>");
                out.print("</tr>");
            }
            out.print("</table></body></html>");
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
            System.out.println(e.getMessage());
        } 
        catch (NamingException e) 
        {
        	System.out.println(e.getMessage());
            e.printStackTrace();
        }
        catch (Exception e) 
        {
        	System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
}
 