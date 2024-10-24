package com.my.org.erp.common;

import java.io.BufferedWriter;
 
import java.io.FileWriter;
import java.io.IOException;
import java.util.Map;
 


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.bean.common.JdbcIntialization;
@WebServlet("/DBServletConfigure")
public class PropertyActionHandler extends HttpServlet  
{


	
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doPost(request,response);
	}
	
@SuppressWarnings("rawtypes")
public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
	try 
	{
			ServletContext context = getServletContext();
		    String getcode=context.getInitParameter("crystal_Property").trim();
		    JdbcIntialization d = new JdbcIntialization();
		    Map map=request.getParameterMap();
			BeanUtils.populate(d,map);
			
		    if(getcode.equals(d.getCode()))
			{
		    	String sline = "DB_DRIVER="+d.getDriver()+"\n";
		    	sline= sline + "DB_URL="+d.getUrl()+"\n";
		    	sline= sline + "DB_USERNAME="+d.getUsername()+"\n";
		    	sline= sline + "DB_PASSWORD="+d.getPassword()+"\n";
		    	sline= sline + "DB_NAME="+d.getDbname()+"\n";
		    	sline= sline + "exportpath="+d.getExportpath()+"\n";
		    	sline= sline + "jdkpath="+d.getJdkpath()+"\n";
				sline= sline + "mysqlpath="+d.getMysqlpath()+"\n";
				sline= sline + "hostname="+d.getHostname()+"\n";
				
				FileWriter fw = new FileWriter("JDBC.properties");
				BufferedWriter bw = new BufferedWriter(fw);
				bw.write(sline);
				bw.close();
				fw.close();
				
				String filename = request.getSession().getServletContext().getRealPath("/WEB-INF/classes/lock.properties");
				FileWriter fw1 = new FileWriter(filename);
				BufferedWriter bw1 = new BufferedWriter(fw1);
				bw1.write(d.getLicence());
				bw1.close();
				fw1.close();
				
				 
				
				response.sendRedirect("CompanyIntialization.jsp");
			}
		    else
		    	response.sendRedirect("JdbcDriveIntialisation.jsp?error=Invalid secret code and try again ....");
		 
			
	} 
	catch (Exception e) 
	{
		 System.out.println(e.getMessage());
		 request.setAttribute("error", e.getMessage() );
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    	 dispatchers.forward(request, response); 
	}
}
 

}