package com.my.org.erp.SmartPayroll;

import java.io.IOException;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunctions;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
 
public class EmpAdvanceActionHandler extends AbstractActionHandler 
{
	Statement st;
	ResultSet rs;
	PreparedStatement pstm;
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			if (action.equals("PAYStaffAdvanceAdd")) 
			{
				String staffid = "" + request.getParameter("ename");
				staffid.trim();
				String openDate = "" + request.getParameter("opendate");
				openDate=DateUtil.FormateDateSQL(openDate);
				String dt[] = openDate.split("-");
				String mont = DateUtil.getMonth(Integer.parseInt(dt[1]));
				String years = dt[0];
				String advAmount = "" + request.getParameter("advamount");
				String desc = "" + request.getParameter("desc");
				String authorised = "" + request.getParameter("authorised");
				asql ="";
				asql = "";
				asql = asql + "INSERT INTO PAY_M_ADVANCE (CHR_EMPID, DT_DATE, INT_YEAR, CHR_MONTH, INT_ADVAMT, CHR_DESC, ";
				asql = asql + "CHR_AUTHORITY, CHR_USRNAME, DT_UPDATEDATE, CHR_UPDATESTATUS)";
				asql = asql + " VALUES (?,?,?,?,?,?,?,?, NOW(),'Y')";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,staffid);
				apstm.setString(2,openDate);
				apstm.setString(3,years);
				apstm.setString(4,mont);
				apstm.setString(5,advAmount);
				apstm.setString(6,desc);
				apstm.setString(7,authorised);
				apstm.setString(8,userid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				 
				con.close();    
				response.sendRedirect("Smart Payroll/Advance.jsp");
			}  
			else if("PAYStaffAdvanceUpdate".equals(action))
			{
				String advAmount = "" + request.getParameter("advamount");
				String advid = "" + request.getParameter("advid");
				asql = "UPDATE pay_m_advance SET INT_ADVAMT =? WHERE INT_ADVANCEID=? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,advAmount);
				apstm.setString(2,advid);
				apstm.execute();
				apstm.close();
				
				/*String sql= "UPDATE pay_m_advance SET INT_ADVAMT ="+advAmount +" WHERE INT_ADVANCEID='"+advid+"' ";
				Statement ts = con.createStatement();
				ts.execute(sql);
				ts.close();
				*/
				con.close();    
				response.sendRedirect("Smart Payroll/Advance.jsp");
			}
			else if("PAYAdvanceDelete".equals(action))
			{
				
				String staffid = "" + request.getParameter("staffid");
				String sql="select max(INT_ADVANCEID) from pay_m_advance WHERE CHR_EMPID='"+staffid+"'";
				String data[][] =CommonFunctions.RecordSetArray(con, sql);
				
				asql = "DELETE FROM pay_m_advance WHERE INT_ADVANCEID= ? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,data[0][0]);
				apstm.execute();
				apstm.close();
				
				/*sql="DELETE FROM pay_m_advance WHERE INT_ADVANCEID= "+data[0][0];
				Statement ts = con.createStatement();
				ts.execute(sql);
				ts.close();*/
				con.close();    
				response.sendRedirect("Smart Payroll/Advance.jsp");
			}
			else if("PAYStaffAdvanceRecovery".equals(action))
			{
				
				String staffid = "" + request.getParameter("staffid");
				String Month = "" + request.getParameter("Month");
				String month= DateUtil.getMonth(Integer.parseInt(Month));
				String Year = "" + request.getParameter("Year");
				String advamount = "" + request.getParameter("advamount");
				asql = "SELECT COUNT(*) FROM pay_t_advance WHERE CHR_EMPID=";
				asql=asql+"'"+staffid+"' AND CHR_TYPE='Y' AND CHR_MONTH='"+month+"' AND INT_YEAR="+Year;
				if(!CommonFunctions.RecordExist(con, asql))
				{	
					asql="INSERT INTO pay_t_advance (CHR_EMPID,INT_YEAR,CHR_MONTH,INT_DUEAMT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (";
					asql = asql + " ?,?,?,?,?,now(),'Y' )";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,staffid );
					apstm.setString(2,Year );
					apstm.setString(3,month );
					apstm.setString(4,advamount );
					apstm.setString(5,userid );
					apstm.execute();
					apstm.close();
					
				}	
				con.close();    
				response.sendRedirect("Smart Payroll/Advance.jsp");
			}
			else if (action.equals("PAYAdvanceCashReturn")) 
			{
				String staffid =request.getParameter("staffid");
				String Month = request.getParameter("Month");
				String month= DateUtil.getMonth(Integer.parseInt(Month));
				String Year = request.getParameter("Year");
				String advamount = request.getParameter("advamount");
				
				asql="INSERT INTO pay_t_advance (CHR_EMPID,INT_YEAR,CHR_MONTH,INT_DUEAMT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_TYPE) VALUES (";
				asql = asql + " ?,?,?,?,?,now(),'Y','N' )";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,staffid );
				apstm.setString(2,Year );
				apstm.setString(3,month );
				apstm.setString(4,advamount );
				apstm.setString(5,userid );
				apstm.execute();
				apstm.close();
				con.close();    
				response.sendRedirect("Smart Payroll/AdvanceBalanceSheetres.jsp?ename="+staffid);
			}
			else if (action.equals("PAYAdvanceTotalRecovery")) 
			{
				String Month = request.getParameter("Month");
				String month= DateUtil.getMonth(Integer.parseInt(Month));
				String Year = request.getParameter("Year");
				String row=request.getParameter("totalrow");
				int rowid= Integer.parseInt(row);
				String staffid="",advamount="",sql="";
				for(int u=1;u<=rowid;u++)
				{
					staffid=request.getParameter("empid"+u);
					advamount=request.getParameter("advdeduction"+u);
					sql = "SELECT COUNT(*) FROM pay_t_advance WHERE CHR_EMPID=";
					sql=sql+"'"+staffid+"' AND CHR_TYPE='Y' AND CHR_MONTH='"+month+"' AND INT_YEAR="+Year;
					boolean f=CommonFunctions.RecordExist(con, sql);
					asql = "INSERT INTO pay_t_advance (CHR_EMPID,INT_YEAR,CHR_MONTH,INT_DUEAMT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_TYPE) VALUES ";
					asql = asql +"(?,?,?,?,?,now(),'Y','Y')";
					apstm = con.prepareStatement(asql);
					if(!f)
					{
						
						apstm.setString(1,staffid);
						apstm.setString(2,Year);
						apstm.setString(3,month);
						apstm.setString(4,advamount);
						apstm.setString(5,userid);
						if(Integer.parseInt(advamount)>0)
							apstm.addBatch();
						
					/*	sql="INSERT INTO pay_t_advance (CHR_EMPID,INT_YEAR,CHR_MONTH,INT_DUEAMT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_TYPE) VALUES (";
						sql=sql+"'"+staffid+"',";
						sql=sql+""+Year+",";
						sql=sql+"'"+month+"',";
						sql=sql+""+advamount+", ";
						sql=sql+"'"+userid+"',now(),'Y','Y')";
						Statement ts = con.createStatement();
						if(Integer.parseInt(advamount)>0)
							ts.execute(sql);
					ts.close();*/
					}
					apstm.executeBatch();
					apstm.close();
				}	
				con.close();    
				response.sendRedirect("Smart Payroll/Payrollmain.jsp");
			}
			else if("PAYSalaryDeductuinModify".equals(action))
			{
				String id= request.getParameter("rowid");
				 String Amount= request.getParameter("Amount");
				 String type= request.getParameter("type");
				 String empid= request.getParameter("empid");
				 String month= request.getParameter("month");
				 String year= request.getParameter("year");
				 String sql ="";
				 sql =" SELECT COUNT(*) FROM pay_t_salary WHERE  CHR_EMPID='"+empid+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year ;
				 if("Y".equals(type)) 
				 {
				 	if(!com.my.org.erp.common.CommonFunction.RecordExist(sql)  )
				 		com.my.org.erp.common.CommonFunctions.Execute(" UPDATE pay_t_advance SET INT_DUEAMT="+Amount+ " WHERE INT_ID="+id);
				 }
				 else
				 		com.my.org.erp.common.CommonFunctions.Execute(" UPDATE pay_t_advance SET INT_DUEAMT="+Amount+ " WHERE INT_ID="+id);
				 con.close();   
				 response.sendRedirect("Smart Payroll/AdvanceBalanceSheetres.jsp?ename="+empid);
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
