package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class NDCActionHandler extends AbstractActionHandler 
{

	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			
			if (action.equals("PAYNDCStoreAccept")) 
			{
				String Rowid= request.getParameter("Rowid");
				String acceptdate= request.getParameter("acceptdate");
				String status= request.getParameter("status");
				String reason= request.getParameter("reason");
				String amount= request.getParameter("amount");
				
				String stdate[] = acceptdate.split(" ");
				String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
				asql= " UPDATE pay_t_emp_ndc SET DOU_STORE =?,CHR_STORE =?, CHR_STORE_DESC=?, CHR_STORE_EMPID=?,  DAT_STORE_DATE=? WHERE INT_NDCID=?";
				apstm  = con.prepareStatement(asql);
				apstm.setString(1,amount );
				apstm.setString(2,status );
				apstm.setString(3,reason );
				apstm.setString(4,""+session.getAttribute("EMPID") );
				apstm.setString(5,sdate );
				apstm.setString(6,Rowid );
				apstm.execute();
				apstm.close();
				con.close();    
				response.sendRedirect("Smart Payroll/NDC_Store.jsp");
			}
			else if("PAYNDCAccountsAccept".equals(action ))
			{
				String Rowid= request.getParameter("Rowid");
				String acceptdate= request.getParameter("acceptdate");
				String status= request.getParameter("status");
				String reason= request.getParameter("reason");
				String amount= request.getParameter("amount");
				String stdate[] = acceptdate.split(" ");
				String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
				asql= " UPDATE pay_t_emp_ndc SET DOU_ACCOUNTS =?,CHR_ACCOUNTS =?, CHR_ACCOUNTS_DESC=?, CHR_ACCOUNTS_EMPID=?,  DAT_ACCOUNTS_DATE=? WHERE INT_NDCID=?";
				apstm  = con.prepareStatement(asql);
				apstm.setString(1,amount );
				apstm.setString(2,status );
				apstm.setString(3,reason );
				apstm.setString(4,""+session.getAttribute("EMPID") );
				apstm.setString(5,sdate );
				apstm.setString(6,Rowid );
				apstm.execute();
				apstm.close();
				con.close();    
				response.sendRedirect("Smart Payroll/NDC_Accounts.jsp");
			}
			else if("PAYNDCHRAccept".equals(action ))
			{
				String Rowid= request.getParameter("Rowid");
				String acceptdate= request.getParameter("acceptdate");
				String status= request.getParameter("status");
				String reason= request.getParameter("reason");
				String amount= request.getParameter("amount");
				String idcard= request.getParameter("idcard");
				String accesscard= request.getParameter("accesscard");
				String emaildeletion= request.getParameter("emaildeletion");
				String outsource= request.getParameter("outsource");
				String outsourceclaim= request.getParameter("outsourceclaim");
				if(!"Y".equals(idcard))
					idcard ="N";
				
				if(!"Y".equals(accesscard))
					accesscard ="N";
				
				if(!"Y".equals(emaildeletion))
					emaildeletion ="N";
				
				String stdate[] = acceptdate.split(" ");
				String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
				asql= " UPDATE pay_t_emp_ndc SET DOU_HR =?,CHR_HR =?, CHR_HR_DESC=?, CHR_HR_EMPID=?,  DAT_HR_DATE=?, CHR_HR_IDCARD=?,CHR_HR_ACCESSCARD=?,CHR_HR_EMAILDELETION=?, CHR_OUTSOURCE_EMPLOYEE=?,CHR_OUTSOURCE=?  WHERE INT_NDCID=?";
				apstm  = con.prepareStatement(asql);
				apstm.setString(1,amount );
				apstm.setString(2,status );
				apstm.setString(3,reason );
				apstm.setString(4,""+session.getAttribute("EMPID") );
				apstm.setString(5,sdate );
				apstm.setString(6,idcard );
				apstm.setString(7,accesscard);
				apstm.setString(8,emaildeletion);
				apstm.setString(9,outsource);
				apstm.setString(10,outsourceclaim);
				apstm.setString(11,Rowid );
				apstm.execute();
				apstm.close();
				con.close();    
				response.sendRedirect("Smart Payroll/NDC_HR.jsp");
			}
			else if("PAYNDCGeneralAccept".equals(action ))
			{
				String Rowid= request.getParameter("Rowid");
				String acceptdate= request.getParameter("acceptdate");
				String status= request.getParameter("status");
				String reason= request.getParameter("reason");
				String amount= request.getParameter("amount");
				String stdate[] = acceptdate.split(" ");
				String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
				asql= " UPDATE pay_t_emp_ndc SET DOU_GENERAL =?, CHR_GENERAL =?, CHR_GENERAL_DESC=?, CHR_GENERAL_EMPID=?,  DAT_GENERAL_DATE=? WHERE INT_NDCID=?";
				apstm  = con.prepareStatement(asql);
				apstm.setString(1,amount );
				apstm.setString(2,status );
				apstm.setString(3,reason );
				apstm.setString(4,""+session.getAttribute("EMPID") );
				apstm.setString(5,sdate );
				apstm.setString(6,Rowid );
				apstm.execute();
				apstm.close();
				con.close();    
				response.sendRedirect("Smart Payroll/NDC_Business.jsp");
			}
			else if("PAYNDCFinallAccept".equals(action ))
			{
				String Rowid= request.getParameter("Rowid");
				String acceptdate= request.getParameter("acceptdate");
				String status= request.getParameter("status");
				String reason= request.getParameter("reason");
				String amount= request.getParameter("amount");
				String stdate[] = acceptdate.split(" ");
				String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
				asql= " UPDATE pay_t_emp_ndc SET   DOU_FINAL =?,  CHR_FINAL =?, CHR_FINAL_DESC=?, CHR_FINAL_EMPID=?,  DAT_FINAL_DATE=? WHERE INT_NDCID=?";
				apstm  = con.prepareStatement(asql);
				apstm.setString(1,amount );
				apstm.setString(2,status );
				apstm.setString(3,reason );
				apstm.setString(4,""+session.getAttribute("EMPID") );
				apstm.setString(5,sdate );
				apstm.setString(6,Rowid );
				apstm.execute();
				apstm.close();
				con.close();    
				response.sendRedirect("Smart Payroll/NDC_Final.jsp");
			}
			
			else
				response.sendRedirect("Smart Payroll/Payrollmain.jsp");
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
