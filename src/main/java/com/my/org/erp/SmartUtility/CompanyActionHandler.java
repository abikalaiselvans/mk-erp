package com.my.org.erp.SmartUtility;
 
import java.io.IOException;
 
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class CompanyActionHandler extends AbstractActionHandler
{
		@SuppressWarnings("rawtypes")
		public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					if(action.equals("UTICompany"))
					{ 
						String  rowid= request.getParameter("rowid");
						String  name= request.getParameter("name");
						String  address1= request.getParameter("address1");
						String  address2= request.getParameter("address2");
						String  city= request.getParameter("city");
						String  district= request.getParameter("district");
						String  state= request.getParameter("state");
						String  country= request.getParameter("country");
						String  pin= request.getParameter("pin");
						String  phone= request.getParameter("phone");
						String  fax= request.getParameter("fax");
						String  email= request.getParameter("email");
						String  website= request.getParameter("website");
						String  googlelocation= request.getParameter("googlelocation");
						
						Map m=request.getParameterMap();
					    Set s = m.entrySet();
					    Iterator it = s.iterator();
					    while(it.hasNext())
					    {
					           Map.Entry<String,String[]> entry = (Map.Entry<String,String[]>)it.next();
					           String key             = entry.getKey();
					           String[] value         = entry.getValue();
					          /*// System.out.println( "Key is "+key+"<br>");
					           if(value.length>1)
					           {    
					               for (int i = 0; i < value.length; i++) 
					                  	 System.out.println("<li>" + value[i].toString() + "</li><br>");
					           }
					           else
					               	 System.out.println("Value is "+value[0].toString()+"<br>");
					 */
					           
					     }
						
						 
						 
						asql = " UPDATE m_company SET ";
					    asql = asql+ " CHR_NAME =?,";
						asql = asql+ " CHR_ADDRESS1=?, ";
						asql = asql+ " CHR_ADDRESS2=?, ";
						asql = asql+ " INT_CITYID=?, ";
						asql = asql+ " INT_DISTRICTID=?, ";
						asql = asql+ " INT_STATEID=?, ";
						asql = asql+ " INT_COUNTRYID=?,";
						asql = asql+ " INT_PINCODE=?, ";
						asql = asql+ " CHR_PHONE=?, ";
						asql = asql+ " CHR_FAX =?, ";
						asql = asql+ " CHR_EMAIL= ?,";
						asql = asql+ " CHR_WEBSITE=?, CHR_GOOGLELOCATION=?,";
						asql = asql+ " CHR_USRNAME=?,";
						asql = asql+ "  DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS ='Y' ";
						asql = asql+ " WHERE INT_CPYID= ?";
						apstm =con.prepareStatement(asql);
						apstm.setString(1, name);
						apstm.setString(2, address1);
						apstm.setString(3,address2 );
						apstm.setString(4,city );
						apstm.setString(5,district );
						apstm.setString(6,state );
						apstm.setString(7,country );
						apstm.setString(8,pin );
						apstm.setString(9,phone );
						apstm.setString(10,fax );
						apstm.setString(11,email );
						apstm.setString(12,website );
						apstm.setString(13,googlelocation );
						apstm.setString(14,auserid );
						apstm.setString(15,rowid );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						con.close();
						response.sendRedirect("Utility/Userframe.jsp");
						
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