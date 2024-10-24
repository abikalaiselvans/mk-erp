package com.my.org.erp.SmartConveyance;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 
public class ConveyanceAdvanceActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String empid = ""+session.getAttribute("EMPID");
			System.out.println("................."+action);
			if ("CONConveyanceAdvanceDelete".equals(action)) 
			{ 
				String rowid [] = request.getParameterValues("rowid");
				if(rowid.length>0)
				{
					asql = "DELETE FROM conveyance_m_advance WHERE INT_ADVANCEID=?";
					apstm = con.prepareStatement(asql);
					for(int u=0;u<rowid.length;u++)
					{
						apstm.setString(1, rowid[u]);
						apstm.addBatch();
					}
					apstm.executeBatch();
					apstm.close();
				}
				con.close();
				response.sendRedirect("Smart Conveyance/ConveyanceAdvance.jsp");
				
			}
			else if ("CONConveyanceAdvanceAdd".equals(action)) 
			{ 
				String staffid = "" + request.getParameter("ename");
				staffid.trim();
				String openDate = "" + request.getParameter("opendate");
				openDate=DateUtil.FormateDateSQL(openDate);
				String advAmount = "" + request.getParameter("advamount");
				String desc = "" + request.getParameter("desc");
				String authorised = "" + request.getParameter("authorised");
				String creditto = "" + request.getParameter("creditto");
				
				asql =  "INSERT INTO conveyance_m_advance (CHR_EMPID,DAT_ENTRYDATE,DOU_AMOUNT,";
				asql = asql +" CHR_DESC, INT_DEPOSITID, CHR_AUTHORITY,CHR_ENTRYBY, CHR_USRNAME, DT_UPDATEDATE, CHR_UPDATESTATUS) ";
				asql = asql +" VALUES ( ";
				asql = asql + "?,?,?,?,?,?,?,?,NOW(),'Y')";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,staffid);
				apstm.setString(2,openDate);
				apstm.setString(3,advAmount);
				apstm.setString(4,desc);
				apstm.setString(5,creditto);
				apstm.setString(6,empid);
				apstm.setString(7,authorised);
				apstm.setString(8,auserid);
				System.out.println(""+apstm);
				apstm.execute(); 
				con.close();    
				response.sendRedirect("Smart Conveyance/ConveyanceAdvance.jsp");
			}
			else if ("CONConveyanceAdvanceUpdate".equals(action)) 
			{ 
				String staffid = "" + request.getParameter("ename");
				String rowid = "" + request.getParameter("rowid");
				staffid.trim();
				String openDate = "" + request.getParameter("opendate");
				openDate=DateUtil.FormateDateSQL(openDate);
				String advAmount = "" + request.getParameter("advamount");
				String desc = "" + request.getParameter("desc");
				String authorised = "" + request.getParameter("authorised");
				asql =   "UPDATE conveyance_m_advance SET ";
				asql = asql +" DAT_ENTRYDATE=?,";
				asql = asql +" DOU_AMOUNT=?,";
				asql = asql +" CHR_DESC=?,";
				asql = asql +" CHR_AUTHORITY=?,";
				asql = asql +" CHR_USRNAME= ?,";
				asql = asql +" DT_UPDATEDATE= DATE(NOW())  WHERE INT_ADVANCEID =? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,openDate);
				apstm.setString(2,advAmount);
				apstm.setString(3,desc);
				apstm.setString(4,authorised);
				apstm.setString(5,auserid);
				apstm.setString(6,rowid);
				System.out.println(""+apstm);
				apstm.execute(); 
				con.close();    
				response.sendRedirect("Smart Conveyance/ConveyanceAdvance.jsp");
			}
			else if ("CONConveyanceAdvanceDED".equals(action)) 
			{
				int len = Integer.parseInt(request.getParameter("len"));
				String paydate = "" + request.getParameter("paydate");
				asql ="";
				
	            //INSERT THE ADVANCE
				asql =" INSERT INTO conveyance_m_advance "; 
	            asql = asql +" ( CHR_EMPID,DOU_CAMOUNT,DAT_CDATE,CHR_CENTRY, ";
	            asql = asql +" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
	            asql = asql +" (?,?,?,?,?,DATE(NOW()),? )";
	            apstm = con.prepareStatement(asql);
	            
				for(int u=0;u<len;u++)
				{
					String staffid = "" + request.getParameter("empid"+(u+1));
					String deduction = "" + request.getParameter("deduction"+(u+1));
					apstm.setString(1,staffid);
					apstm.setString(2,deduction);
					apstm.setString(3,paydate);
					apstm.setString(4,empid );
					apstm.setString(5,auserid );
					apstm.setString(6,"Y" );
					System.out.println(""+apstm);
					apstm.addBatch();
					
					asql = " UPDATE conveyance_t_conveyance SET CHR_ADVANCEFLAG ='Y'  ";
					asql = asql +" WHERE  CHR_ACCSTATUS='Y' AND DAT_ACCDATE ='"+paydate+"'";
					asql = asql +" AND CHR_EMPID ='"+staffid+"'";
					System.out.println(asql);
					CommonFunctions.Execute(asql);
				    
				}
				apstm.executeBatch();
				con.close();    
				
				 
				response.sendRedirect("Smart Conveyance/PaidConveyance.jsp");
			}
			else if ("CONConveyanceAdvanceDEDChanges".equals(action)) 
			{
				String paydate = "" + request.getParameter("paydate");
				asql ="";
				
				//DELETE THE ADVANCE	
				asql = " DELETE FROM conveyance_m_advance WHERE  DAT_CDATE=? ";
				apstm = con.prepareStatement(asql);
	            apstm.setString(1, paydate);
				System.out.println(""+apstm);
				apstm.execute();	 
	            apstm.close();
	            
	            
				//RESET THE ADVANCE FLAG	
				asql = " UPDATE conveyance_t_conveyance SET CHR_ADVANCEFLAG ='N'  ";
				asql = asql +" WHERE  CHR_ACCSTATUS='Y' AND DAT_ACCDATE ='"+paydate+"'";
				apstm = con.prepareStatement(asql);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				response.sendRedirect("Smart Conveyance/ConveyancesAdvanceDeduction.jsp?paydate="+paydate);	
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
