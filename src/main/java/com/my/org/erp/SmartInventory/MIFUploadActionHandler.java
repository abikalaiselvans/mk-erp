package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class MIFUploadActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				String branchid = session.getAttribute("INVBRANCH").toString();
				String userid = session.getAttribute("USRID").toString();
				if("INVMIFUploadUploadedExcel".equals(action))
				{ 
					String filename =""+request.getParameter("xlsfilename");
					String customer=""+request.getParameter("customer");
					String location=""+request.getParameter("location");
	 				String equipmenttype=""+request.getParameter("equipmenttype");
	 				String model=""+request.getParameter("model");
	 				String category=""+request.getParameter("category");
	 				String filepath = request.getRealPath("/")+"uploadfiles/MIF/"+filename+"_"+location+"_"+equipmenttype+".xls" ;
	 				Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	 				String myDB ="jdbc:odbc:Driver={Microsoft Excel Driver (*.xls)};DBQ="+filepath+";DriverID=22;READONLY=false";
	 				Connection cona = DriverManager.getConnection(myDB,"","");
	 				Statement sts = cona.createStatement();
	 				ResultSet rss = sts.executeQuery("SELECT * FROM [Sheet1$]");
	 				acs = con.prepareCall("{call  INV_PRO_SPARE_UPLOAD(?,?,?,?,?,?,?,?,?,?)}");
	 				while(rss.next())
	 				{
	 					acs.setString(1, customer);
	 					acs.setString(2, location);
	 					acs.setString(3, equipmenttype);
	 					acs.setString(4, model);
	 					acs.setString(5, category);
	 					acs.setString(6, ""+rss.getString(6));
	 					acs.setString(7, ""+rss.getString(7));
	 					acs.setString(8, ""+rss.getString(8));
	 					acs.setString(9, ""+rss.getString(9));
	 					acs.setString(10, userid);
	 					System.out.println(  ""+acs);
	 					acs.addBatch();
	 				}
	 				acs.executeBatch();
	 				acs.close();
					rss.close();
					sts.close();
					cona.close(); 
					con.close();   
					response.sendRedirect("Common/exit.jsp");
				
				}
				 
						
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


