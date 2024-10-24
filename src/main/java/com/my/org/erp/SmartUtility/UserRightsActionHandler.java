package com.my.org.erp.SmartUtility;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
 

public class UserRightsActionHandler extends AbstractActionHandler
{
		public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					HttpSession session = request.getSession();
					String userid = (String) session.getAttribute("USRID");
					if(action.equals("UTIUserRightsTransfer"))
					{ 
						String usertype=request.getParameter("usertype");
						String from =request.getParameter("From");
						String To[] =request.getParameterValues("To");
						String Module[] =request.getParameterValues("Modules");
						String sql ="";
						String empid ="";
						sql =" UPDATE m_user a, m_user b  SET ";
						if(Module.length>0)
							for(int h=0;h<Module.length;h++)
								if(!"0".equals(Module[h].trim()))
									sql = sql + " a." +Module[h].trim()+ " = b." +Module[h].trim()+" , ";
						sql = sql +" a.DT_UPDATEDATE=now() , a.CHR_UPDATESTATUS='Y' ";
						if("Y".equals(usertype))
							sql = sql + " , a.CHR_TYPE= b.CHR_TYPE";
						
						sql = sql +" WHERE b.CHR_EMPID= '"+from+"' " ;
						sql = sql +" AND a.CHR_EMPID IN (";
						
						empid ="";
						if(To.length>0)
							for(int u=0;u<To.length;u++)
								empid = empid +" '"+To[u]+"' , " ;
						sql = sql +empid;
						sql = sql +" '0' )";
						System.out.println(sql);
						CommonFunctions.Execute(sql);
						con.close();   
						response.sendRedirect("Utility/Userframe.jsp");
						 
					}
					else if(action.equals("UTIEmployeeMailandMobileReset"))
					{
						asql =" UPDATE com_m_staff SET CHR_ADDRESSSTATUS='N' WHERE CHR_TYPE !='T'  AND CHR_EMPID !='ADMIN' ";
						apstm = con.prepareStatement(asql);//CHR_EMAILID=null ,CHR_PERMAILID =null, CHR_MOBILE= null ,
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = " UPDATE m_user SET CHR_LOGINTERMSANDCONDITIONS='N' WHERE CHR_EMPID !='ADMIN'";
						apstm = con.prepareStatement(asql); 
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						con.close();   
						response.sendRedirect("Utility/Userframe.jsp");
					}
					else if(action.equals("UTIEmployeePFUpdate"))
					{
						String length = request.getParameter("dec");
						int rowcount = Integer.parseInt(length);
						String pfnumber="";
						String accept="";
						String empid="";
						try 
						{
							acs = con.prepareCall("{call  COM_PRO_PFNUMBERUPDATION (?,?,?,?,? )}");
							for (int u=0;u<rowcount;u++) 
							{
								pfnumber = request.getParameter("pfnumber"+u);
								accept = ""+request.getParameter("accept"+u);
								empid = ""+request.getParameter("empid"+u);
								String doj =""+request.getParameter("doj"+u) ;
 								if("on".equals(accept) && !"".equals(pfnumber)) 
								{
									acs.setString(1, "UPDATE");
									acs.setString(2, empid);
									acs.setString(3, doj);
									acs.setString(4 , ""+pfnumber);
									acs.setString(5 , userid.toUpperCase() );
									System.out.println(""+acs);
									acs.addBatch();
									 
								}	
							}
							acs.executeBatch();
							acs.close();
						}
						catch (Exception e) 
						{
							con.close();    
							response.sendRedirect("error/index.jsp?error=" + e.getMessage());
							 
						}
						con.close();   
						response.sendRedirect("Utility/Userframe.jsp");
						 
						
					}
					else if(action.equals("UTIEmployeeESIUpdate"))
					{

						String length = request.getParameter("dec");
						int rowcount = Integer.parseInt(length);
						String esinumber="";
						String accept="";
						String empid="";
						try 
						{
							acs = con.prepareCall("{call  COM_PRO_ESINUMBERUPDATION (?,?,?,?  )}");
							for (int u=0;u<rowcount;u++) 
							{
								esinumber = request.getParameter("esinumber"+u);
								accept = ""+request.getParameter("accept"+u);
								empid = ""+request.getParameter("empid"+u);
								if("on".equals(accept) && !"".equals(esinumber)) 
								{
									acs.setString(1, "UPDATE");
									acs.setString(2, empid);
									acs.setString(3, ""+esinumber);
									acs.setString(4 , userid.toUpperCase() );
									acs.addBatch();
								}	
							}
							acs.executeBatch();
							acs.close();
						}
						catch (Exception e) 
						{
							con.close();   
							response.sendRedirect("error/index.jsp?error=" + e.getMessage());
						}
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