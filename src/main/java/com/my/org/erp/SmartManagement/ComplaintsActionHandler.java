package com.my.org.erp.SmartManagement;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 

import org.apache.commons.beanutils.BeanUtils;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
 

public class ComplaintsActionHandler extends AbstractActionHandler {

	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String branchid = session.getAttribute("BRANCHID").toString();
			String officeid=""+session.getAttribute("OFFICEID");
			if ("MGTComplaintsAdd".equals(action)) {

				String subject = request.getParameter("subject");
				String priority = request.getParameter("priority");
				String desc  = request.getParameter("desc");
				asql = " INSERT INTO mgt_t_complaints  ";
				asql = asql + "  (";
				asql = asql + " CHR_COMPLAINTNO,CHR_SUBJECT,INT_BRANCHID,DAT_CREATION, ";
				asql = asql + " CHR_CREATEDBY,INT_PRIORITY,CHR_DESCRIPTION,CHR_USRNAME, ";
				asql = asql + " DT_UPDATEDATE,CHR_UPDATESTATUS ";
				asql = asql + " )";
				asql = asql + " VALUES (";
				asql = asql + " ?,?,?,NOW(), ";
				asql = asql + " ?,?,?,?, ";
				asql = asql + " DATE(NOW()),'Y' ";
				asql = asql + " )";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,"CMP/"+complaintNumber()+"/"+complaintLocation(officeid));
				apstm.setString(2,subject);
				apstm.setString(3,branchid);
				apstm.setString(4,userid);
				apstm.setString(5,priority);
				apstm.setString(6,desc);
				apstm.setString(7,userid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close(); 
				con.close();
				response.sendRedirect("Smart Management/Complaints.jsp");
			}
			else if ("MGTComplaintsEdit".equals(action)) 
			{ 
				String rowid = request.getParameter("rowid");
				String subject = request.getParameter("subject");
				String priority = request.getParameter("priority");
				String desc  = request.getParameter("desc");
				asql = " UPDATE mgt_t_complaints SET ";
				asql = asql +" CHR_SUBJECT =? , ";
				asql = asql +" INT_PRIORITY = ? , ";
				asql = asql +" CHR_DESCRIPTION = ?,  ";
				asql = asql +" CHR_USRNAME =? , DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS ='Y' ";
				asql = asql +" WHERE INT_COMPLAINTID =? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,subject);
				apstm.setString(2,priority);
				apstm.setString(3,desc);
				apstm.setString(4,userid);
				apstm.setString(5,rowid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close(); 
				con.close();
				response.sendRedirect("Smart Management/Complaints.jsp");
				
			} 
			else if ("MGTComplaintsDELETE".equals(action)) 
			{ 
				asql = " DELETE FROM mgt_t_complaints WHERE INT_COMPLAINTID=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,request.getParameter("rowid"));
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close(); 
				con.close();
				response.sendRedirect("Smart Management/Complaints.jsp");
			}
			else if ("MGTComplaintsResponse".equals(action)) 
			{ 
				asql = " UPDATE mgt_t_complaints  SET ";
				asql = asql + " CHR_SOLVEDBY=? ,CHR_SOLVEDESC=?,DAT_SOLVED=DATE(NOW()),CHR_STATUS ='Y', ";
				asql = asql + " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y'  ";
				asql = asql + " WHERE INT_COMPLAINTID=?"; 
				apstm = con.prepareStatement(asql);
				apstm.setString(1,userid);
				apstm.setString(2,request.getParameter("desc"));
				apstm.setString(3,userid);
				apstm.setString(4,request.getParameter("rowid"));
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close(); 
				con.close();
				response.sendRedirect("Smart Management/ComplaintsResponse.jsp");
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

	
	public static String complaintNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_COMPLAINTID)+1),'1')   FROM mgt_t_complaints)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	public static String complaintLocation(String officeid) 
	 {
		try 
	 	{
			 
			String sql =" SELECT  CHR_OFFICESHORTNAME  FROM  com_m_office  WHERE INT_OFFICEID="+officeid;
			String Officename[][] =CommonFunctions.QueryExecute(sql);
			return Officename[0][0];
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage()); 
	 	}
	 	return null;
	 }
	
}