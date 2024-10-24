package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

import com.my.org.erp.common.CommonFunctions;
public class SalesInstallationActionHandler extends AbstractActionHandler
{
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				String user = session.getAttribute("USRID").toString();
				String branchid = session.getAttribute("INVBRANCH").toString(); 
				String sql ="";
				if("INVSalesInstallationAssigned".equals(action))
				{ 
					String salesno = request.getParameter("salesno");
					String installdate = request.getParameter("installdate");
					String ename = request.getParameter("ename");
					String division = request.getParameter("division");
					
					
					sql = " INSERT INTO inv_t_directsales_installation " ; 
					sql = sql + " ( CHR_SALESNO ,DAT_SALESDATE,CHR_ITEMID ,CHR_SERIALNO , CHR_WARRANTY , " ; 
					sql = sql + " CHR_TYPE, CHR_DESC ,DAT_INSTALLATION,CHR_EMPID,CHR_USRNAME , DT_UPDATEDATE , CHR_UPDATESTATUS ) " ; 
					sql = sql + "  SELECT a.CHR_SALESNO,b.DAT_SALESDATE,a.CHR_ITEMID,a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_TYPE, " ; 
					sql = sql + "  a.CHR_SWAPDESC ,'"+DateUtil.FormateDateandTimeSQL(installdate)+"','"+ename+"','"+user+"',DATE(NOW()),'Y' FROM inv_t_swapsalesserialno a,  inv_t_directsales b  " ; 
					sql = sql + "  WHERE a.CHR_SALESNO = b.CHR_SALESNO AND  a.CHR_SALESNO ='"+salesno+"' ORDER By a.INT_ID " ; 
					CommonFunctions.Execute(sql);
					
					sql = " UPDATE inv_t_directsales SET CHR_INSTALLATION_STATUS='Y' WHERE CHR_SALESNO ='"+salesno+"' ";
					CommonFunctions.Execute(sql);	
					
					//mail alert
					InstallationMail.sendEngineerAssignedforInstallationMail(branchid,salesno, division, Path);
					
					con.close();   
					response.sendRedirect("Smart Inventory/SalesInstallation.jsp");
				}
				if("INVSalesInstallationUpdate".equals(action))
				{
					String salesid = request.getParameter("salesid");
					String updationdate = request.getParameter("updationdate");
					updationdate= DateUtil.FormateDateandTimeSQL(updationdate);
					String status = request.getParameter("status");
					String reason = request.getParameter("reason");
					String description = request.getParameter("description");
					String division = request.getParameter("division");
					String salesno = request.getParameter("salesno");
					if("Y".equals(status))
					{
						asql = "UPDATE inv_t_directsales_installation SET ";
						asql = asql +" CHR_STATUS ='Y' , DAT_UPDATION='"+updationdate+"'  ,CHR_REASON="+reason+",";
						asql = asql +" CHR_UPDATION_DESC ='"+description+"' ,CHR_USRNAME ='"+user+"' , DT_UPDATEDATE= DATE(NOW()),  CHR_UPDATESTATUS ='Y' ";
						asql = asql +" WHERE INT_INSTALLATIONID ="+ salesid;
						apstm = con.prepareStatement(asql);
						apstm.execute();
						apstm.close();
						
						
						//mail alert
						InstallationMail.sendInstallationUpdationMail(branchid,salesno, division, Path,salesid);
							 
					}
					else 
					{
						
						 
						asql = "INSERT INTO inv_t_directsales_installation_postpone ( ";
						asql = asql +" CHR_SALESNO ,DAT_SALESDATE, CHR_ITEMID , CHR_SERIALNO , CHR_WARRANTY , CHR_TYPE , ";
						asql = asql +" CHR_DESC , DAT_INSTALLATION , CHR_EMPID , CHR_STATUS , CHR_POSTPONE_FLAG , ";
						asql = asql +" INT_PARENTID , CHR_REASON, DAT_UPDATION , CHR_UPDATION_DESC , CHR_USRNAME , DT_UPDATEDATE , CHR_UPDATESTATUS  ";
						asql = asql +" ) ";
						asql = asql +" SELECT  ";
						asql = asql +" CHR_SALESNO ,DAT_SALESDATE,CHR_ITEMID , CHR_SERIALNO , CHR_WARRANTY , CHR_TYPE , ";
						asql = asql +" CHR_DESC , '"+updationdate+"' , CHR_EMPID , 'P' , CHR_POSTPONE_FLAG , ";
						asql = asql +" "+salesid+" , '"+reason+"' , DAT_UPDATION , CHR_UPDATION_DESC , CHR_USRNAME , DATE(NOW()) , CHR_UPDATESTATUS  ";
						asql = asql +" FROM inv_t_directsales_installation WHERE INT_INSTALLATIONID="+ salesid;
						apstm = con.prepareStatement(asql);
						apstm.execute();
						apstm.close();
						
						asql = "UPDATE inv_t_directsales_installation SET CHR_POSTPONE_FLAG='Y' ,";
						asql = asql +" CHR_STATUS ='P' , DAT_UPDATION='"+updationdate+"' ,CHR_REASON="+reason+",";
						asql = asql +" CHR_UPDATION_DESC ='"+description+"' ,CHR_USRNAME ='"+user+"' , DT_UPDATEDATE= DATE(NOW()),  CHR_UPDATESTATUS ='Y' ";
						asql = asql +" WHERE INT_INSTALLATIONID ="+ salesid;
						apstm = con.prepareStatement(asql);
						apstm.execute();
						apstm.close();
						
					}
					con.close();   
					response.sendRedirect("Smart Inventory/InstallationUpdationView.jsp");
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


