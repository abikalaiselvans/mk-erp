package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.payroll.PayrollInfo;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.Math.MathFunction;

public class UploadUpdateActionHandler extends AbstractActionHandler 
{
	ArrayList<PayrollInfo> payrollinfo = new ArrayList<PayrollInfo>();
	HttpSession session =null;
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		try 
		{ 
			
			String action = request.getParameter("actionS");
			session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			session.removeAttribute("payrollinfos"); 
			boolean flag = false;
			if("ATTUploadAttendance".equals(action))
 			{
 				flag = false;
 				String month=""+request.getParameter("month");
 				String monthname = DateUtil.getMonth(Integer.parseInt(month));
 				String year=""+request.getParameter("year");
 				@SuppressWarnings("deprecation")
				String filepath = request.getRealPath("/")+"UploadExcelFile/Attendance_"+month+"_"+year+".xls" ;
 				Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
 				String myDB ="jdbc:odbc:Driver={Microsoft Excel Driver (*.xls)};DBQ="+filepath+";DriverID=22; ";
 				Connection cona = DriverManager.getConnection(myDB,"","");
 				Statement sts = cona.createStatement();
 				ResultSet rss = sts.executeQuery("SELECT * FROM [Sheet1$]");
 				String empid="";
 				String Salary="";
 				 
 				if(CommonFunction.RecordExist("SELECT COUNT(*) FROM pay_t_salaryallowance WHERE CHR_MONTH= '"+monthname+"' AND INT_YEAR="+year))
 				{	
		 				asql="";
		 				asql = " UPDATE pay_t_salaryallowance  SET CHR_USRNAME =? ,DT_UPDATEDATE=DATE(NOW()) ,CHR_UPDATESTATUS='Y' ";
						asql = asql + " WHERE CHR_MONTH= ? AND INT_YEAR=?"; 
						asql = asql + " AND CHR_EMPID=?";
						apstm = con.prepareStatement(asql);
						boolean f1=false;
						boolean f2=false;
						while(rss.next())
		 				{
		 					 
								f1=false;
								f2=false;	
								empid = ""+rss.getString(1) ;
								Salary = ""+rss.getString(2) ;
								 
								f1=CommonFunction.RecordExist("SELECT COUNT(*) FROM com_m_staff WHERE CHR_EMPID='"+empid+"'");
								f2=MathFunction.isDoubleNumber(Salary);
								 
								if(f1 && f2) 
								{  
									apstm.setString(1, ""+ (int)Double.parseDouble(Salary)  );
									apstm.setString(2, userid);
									apstm.setString(3, monthname);
									apstm.setString(4, year);
									apstm.setString(5, empid);
									apstm.addBatch();
								}
								else
								{
									 
									PayrollInfo p = new PayrollInfo();
									p.setEmpid(empid);
									p.setAmount(Salary);
									if(!f1)
										p.setDescription("<font class='bolddeepred'>Invalid Employee id...</font>");
									else if(f2)
										p.setDescription("<font class='bolddeepred'>Invalid Amount...</font>");
									else
										p.setDescription("<font class='bolddeepred'>Allowance Employee & Amount Invalid ...</font>");
									payrollinfo.add(p);
									flag = true;
								}
							 
		 					
						}
						
						apstm.executeBatch();
						apstm.close();
						rss.close();
						sts.close();
						cona.close(); 
						
						if(flag)
						{
							
							session.setAttribute("payrollinfos", payrollinfo); 
							redirectFile(request, response,"Smart Payroll/paybeanerror.jsp");
						   
						}
						else
						{
							redirectFile(request, response,"Common/exit.jsp");
							 
						}
 				}
 				else
 				{
 					rss.close();
					sts.close();
					cona.close(); 
 					cona.close(); 
 					redirectFile(request, response,"Smart Payroll/payerror.jsp?msg=Please Migrate the Allowance and Recovery for the month "+monthname +" - "+year);
 					 
 				}	
 				 
 			}
 			
 			else if("PAYClearAllowance".equals(action))
  			{
 				String  Allowance= request.getParameter("Allowance");
 				String  month= request.getParameter("month");
 				String  year= request.getParameter("year");
 				String monthname = DateUtil.getMonth(Integer.parseInt(month));
 				
 				asql =" UPDATE pay_t_salaryallowance SET ";
 				asql = asql +Allowance +" = 0 ";
 				asql = asql + " WHERE CHR_MONTH=? AND INT_YEAR=?";
 				apstm= con.prepareStatement(asql);
 				apstm.setString(1,monthname);
 				apstm.setString(2,year);
 				apstm.execute();
 				apstm.close();
 			 
 				response.sendRedirect("Smart Attendance/StaffType.jsp");
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
	
	
	
	
	private void redirectFile(HttpServletRequest request,HttpServletResponse response, String redirectfile) throws ServletException, IOException 
	{
		try 
		{ 
			
			   
			response.sendRedirect(redirectfile);
			 
		} 
		catch (Exception e) 
		{
			 
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		
		}
	}

	

}
