package com.my.org.erp.SmartPayroll;

import java.io.IOException;  
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;  
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class StaffBasicActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			String Empid =request.getParameter("empid");
			String basic =request.getParameter("basic");
			String gross =request.getParameter("gross");
			String bank =request.getParameter("bank");
			String pf =request.getParameter("pf");
			String esi =request.getParameter("esi");
			String Accno =request.getParameter("no");
			String empname =request.getParameter("empname");
			String ifsccode =request.getParameter("ifsccode");
			String txtpfno =request.getParameter("txtpfno").trim();
			String optpf=""+request.getParameter("optpf");
			String txtpfvalue=""+request.getParameter("txtpfvalue").trim();
			String nominee=""+request.getParameter("nominee");
			String pfdate=""+request.getParameter("pfdate");
			String optesi=""+request.getParameter("optesi");
			String txtesno=""+request.getParameter("txtesno");
			String txtesivalue=""+request.getParameter("txtesivalue").trim();
			String salarysplitupby=""+request.getParameter("salarysplitupby");
			 System.out.println("action..."+action+""+Empid);
			
			 if("PAYStaffBasicEdit".equals(action))
				{
				
				if (txtpfvalue.equals("") || txtpfvalue.equals("null") || txtpfvalue.equals("-"))
					txtpfvalue = "0";
				if (txtesivalue.equals("") || txtesivalue.equals("null") || txtesivalue.equals("-"))
					txtesivalue = "0";
				if (txtpfno.equals("") || txtpfno.equals("null") || txtpfno.equals("-") )
					txtpfno = "0";
				
				asql= " UPDATE  pay_t_basic_informations SET ";
				asql = asql+"	CHR_STAFFNAME = '"+empname+"',";
				asql = asql+"	INT_SALARY = "+basic+",";
				asql = asql+"	CHR_PF = '"+pf+"',";
				asql = asql+"	DAT_PFESIDATE = '"+DateUtil.FormateDateSQL(pfdate)+"' ,";
				asql = asql+"	CHR_ESI = '"+esi+"', ";
				asql = asql+"	INT_GROSSSALARY = "+gross+", ";
				asql = asql+"	CHR_BANK = '"+bank+"', ";
				asql = asql+"	CHR_ACCNO = '"+Accno+"', ";
				asql = asql+"	CHR_PFTYPE = '"+optpf+" ',";
				asql = asql+"	INT_PFAMT = "+txtpfvalue+", ";
				asql = asql+"	CHR_PFNO = '"+txtpfno+"',";
				asql = asql+"	CHR_ESITYPE = '"+optesi+"',";
				asql = asql+"	INT_ESIAMT = "+txtesivalue+", ";
				asql = asql+"	CHR_ESINO = '"+txtesno+"',";
				asql = asql+"	CHR_NOMINEE = '"+nominee+"', ";
				asql = asql+"	CHR_SALARYSPLITUP = '"+salarysplitupby+"', ";
				asql = asql+"	CHR_IFSC = '"+ifsccode+"'";
				asql = asql+"	WHERE  CHR_EMPID = '"+Empid+"' ";
				apstm = con.prepareStatement(asql);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close();    	
				response.sendRedirect("Smart Payroll/StaffBasic.jsp");

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
