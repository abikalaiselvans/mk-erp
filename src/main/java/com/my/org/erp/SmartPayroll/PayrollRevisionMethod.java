package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class PayrollRevisionMethod 
{
	//Automatic
	static String asql ="";
	static String sql ="";
	public static void revisionAutoUpdate(HttpServletRequest request,HttpServletResponse response,double newgross,Connection con, PreparedStatement apstm, String auserid )throws ServletException, IOException
	{
		try
		{
			String Staffid = request.getParameter("Staffid");
			String Revision = request.getParameter("Revision");
			String rivisiontype = request.getParameter("rivisiontype");
			String rdescription = request.getParameter("rdescription");
			String dor = request.getParameter("dor");
			String doj = request.getParameter("doj");
			String doa = request.getParameter("doa");
			String doa1 = request.getParameter("doa1");
			String PF  = request.getParameter("pf");
			String optpf  = request.getParameter("optpf");
			String TxtPfNo  = request.getParameter("TxtPfNo");
			String TxtPfValue  = request.getParameter("TxtPfValue");
			String ESI  = request.getParameter("ESI");
			String optesi  = request.getParameter("optesi");
			String TxtEsiNo  = request.getParameter("TxtEsiNo");
			String TxtEsiValue  = request.getParameter("TxtEsiValue");
			String pfcalculationtype  =  ""+request.getParameter("pfcalculationtype") ;
			double pfminimumlimit,pfmaximumlimit,esilimitamount;
			
			asql = " SELECT INT_PFMINIMUM_LIMIT,INT_PFMAXIMUM_LIMIT,INT_ESILIMIT FROM m_pf_setting WHERE INT_ROWID = "+pfcalculationtype;
			String pfData[][] = CommonFunctions.QueryExecute(asql);
			if(pfData.length>0)
			{
				pfminimumlimit = Double.parseDouble( pfData[0][0]);
				pfmaximumlimit = Double.parseDouble( pfData[0][1]);
				esilimitamount = Double.parseDouble( pfData[0][2]);
			}
			
			 
			
			 
			con.close();   
			response.sendRedirect("Smart Payroll/PayRollRevisionNext.jsp?staffid="+Staffid+"&dor="+DateUtil.FormateDateSQL(dor));
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
		}
	}
 

	
	public static void apparaisalsalaryBandInGrossAllowance(String staffid,double gross, String dor,Connection con, PreparedStatement apstm, String auserid)
	{
		 
		try
		{
			 
			String AllowanceData[][] = CommonFunctions.QueryExecute("SELECT INT_ALLOWANCEID,CHR_ACODE,CHR_ANAME FROM  pay_m_allowance WHERE CHR_FLAG='Y'  ORDER BY INT_ALLOWANCEID");
			String recoveryData[][] = CommonFunctions.QueryExecute("  SELECT CHR_RCODE FROM pay_m_recovery  ORDER BY  INT_RECOVERYID ");
			String sql ="";
			 
			String salaryData[][] = CommonFunctions.QueryExecute(" SELECT INT_SALARYBANDID,INT_STARTINGSALARY,INT_ENDINGSALARY,CHR_SPLITUPIN FROM  pay_m_salaryband  ORDER BY INT_SALARYBANDID ");
			int rowid=0;
			boolean flag = false;
			 
			for(int u=0; u<salaryData.length;u++)
				if( ((int)gross >=Integer.parseInt(salaryData[u][1])) && ((int)gross <=Integer.parseInt(salaryData[u][2]) ) )
				{	 
					rowid = Integer.parseInt(salaryData[u][0]);
					flag = true;
				}
			 
				 
			if(flag)
			{
				String salaryband="";
 			 	salaryband=" SELECT ("+gross+" *(INT_BASIC/100)) , ";
			 	for(int u=0; u<AllowanceData.length;u++)
					salaryband = salaryband+"("+gross+" * ( "+AllowanceData[u][1]+"/100) ) , ";
				
				salaryband=salaryband.trim();
				salaryband = salaryband.substring(0,salaryband.length()-1);
				salaryband = salaryband+"  FROM  pay_m_salaryband  WHERE INT_SALARYBANDID= "+rowid;
			  
				 
				String Data[][] = CommonFunctions.QueryExecute(salaryband);
				
				
				 
				
				//insert into  Basic 
				asql = " INSERT INTO pay_t_appraisal_basic (CHR_EMPID,CHR_MONTH,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES  (?,MONTHNAME('"+DateUtil.FormateDateSQL(dor)+"'),YEAR('"+DateUtil.FormateDateSQL(dor)+"'),?,DATE(NOW()),'Y' ) ";
				apstm  = con.prepareStatement(asql);
				apstm.setString(1, staffid);
				apstm.setString(2, auserid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
						
			 	
				//insert into Allowance data
				sql=" INSERT  INTO pay_t_salaryallowance  ( CHR_EMPID , ";
				for(int u=0; u<AllowanceData.length;u++)
					sql = sql+AllowanceData[u][1]+", ";
				sql= sql +" DAT_EFFECT ) VALUES ( ";
				sql = sql+" '"+staffid+"' , ";
				for(int u=0; u<AllowanceData.length;u++)
					sql = sql+Data[0][(u+1)]+", ";
				sql = sql+" '"+dor+"' ";
				sql = sql + " )";
				System.out.println(sql);
				CommonFunctions.Execute(sql);
				 
				
				//Delete the old record
				CommonFunctions.Execute("DELETE FROM pay_t_recovery WHERE CHR_EMPID='"+staffid+"'");
				
				 //Insert into recovery Values
				sql=" INSERT  INTO pay_t_salaryrecovery  ( CHR_EMPID , ";
				for(int u=0; u<recoveryData.length;u++)
					sql = sql+recoveryData[u][0]+", ";
				sql= sql +" DAT_EFFECT ) VALUES ( ";
				sql = sql+" '"+staffid+"' , ";
				for(int u=0; u<recoveryData.length;u++)
					sql = sql+"0, ";
				sql = sql+" '"+dor+"' ";
				sql = sql + " )";
				System.out.println(sql);
				CommonFunctions.Execute(sql);
			}
			 
			
			 
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		 
	}
	
}
