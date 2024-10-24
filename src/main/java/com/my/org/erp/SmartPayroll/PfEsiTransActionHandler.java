package com.my.org.erp.SmartPayroll;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.CallableStatement;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.payroll.PfEsiTranscation;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class PfEsiTransActionHandler extends AbstractActionHandler
{
	String empId = null, enpName = null, msg = null, empName = null;
	String courseName,repName,repHeader;
	String compId,branchId,sql;
	ResultSet rs;
	
	
	private void PfEsiList(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		try {

			ArrayList<PfEsiTranscation> pfesiList = new ArrayList<PfEsiTranscation>();
			Statement st = con.createStatement();
			empId = request.getParameter("ename");
			ResultSet rs = st
					.executeQuery("SELECT A.*,B.CHR_STAFFNAME FROM PAY_M_PF A, com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND A.CHR_EMPID='"
							+ empId + "'");
			if (rs.next()) {
				empId = rs.getString("CHR_EMPID");
				String pfType = rs.getString("CHR_PFTYPE");
				int pfAmt = rs.getInt("INT_PFAMT");
				String pfNo = rs.getString("CHR_PFNO");
				String esiType = rs.getString("CHR_ESITYPE");
				int esiAmt = rs.getInt("INT_ESIAMT");
				String esiNo = rs.getString("CHR_ESINO");
				empName = rs.getString("CHR_STAFFNAME");

				PfEsiTranscation pfesitransaction = new PfEsiTranscation();
				pfesitransaction.setEmpId(empId);
				pfesitransaction.setPfType(pfType);
				pfesitransaction.setPfAmt(pfAmt);
				pfesitransaction.setPfNo(pfNo);
				pfesitransaction.setEsiType(esiType);
				pfesitransaction.setEsiAmt(esiAmt);
				pfesitransaction.setEsiNo(esiNo);

				pfesiList.add(pfesitransaction);
				msg = "List";
				HttpSession session = request.getSession();
				session.setAttribute("pfesiList", pfesiList);
			} else
				msg = "No Record Found";
			HttpSession session = request.getSession();
			session.removeAttribute("pfesiList");
			session.setAttribute("pfesiList", pfesiList);
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void PfEsiAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String empid, Optpf, TxtPfNo, optesi, TxtEsiNo, TxtPfValue, TxtEsiValue;
			
			// String sql_Insert_Query ="INSERT INTO PAY_M_PF
			// values(?,?,?,?,?,?,?,?,?,?)";
			empid = request.getParameter("ename");
			Optpf = request.getParameter("optpf");
			TxtPfNo = request.getParameter("TxtPfNo");
			//System.out.println("pf no:" + TxtPfNo);
			// if(TxtPfNo.equals("null"))
			// TxtPfNo="";
			TxtPfValue = request.getParameter("TxtPfValue");
			//System.out.println("pf no:" + TxtPfValue);
			// if(TxtPfValue.equals("null"))
			// /TxtPfValue="";
			optesi = request.getParameter("optesi");
			TxtEsiNo = request.getParameter("TxtEsiNo");
			//System.out.println("esi no:" + TxtEsiNo);
			// if(TxtEsiNo.equals("null"))
			// TxtEsiNo="";
			TxtEsiValue = request.getParameter("TxtEsiValue");
			//System.out.println("esi vALUE:" + TxtEsiValue);
			// if(TxtEsiValue.equals("null"))
			// TxtEsiValue="";

			// pstm = con.prepareStatement(sql_Insert_Query);
			// st.execute("DELETE FROM PAY_M_PF WHERE CHR_EMPID='"+empid+"'");

			CallableStatement cs = con
					.prepareCall("{call PAY_PRO_PFESI(?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, empid);
			cs.setString(3, Optpf);
			cs.setString(4, TxtPfValue);
			cs.setString(5, TxtPfNo);
			cs.setString(6, optesi);
			cs.setString(7, TxtEsiValue);
			cs.setString(8, TxtEsiNo);
			cs.setString(9, "ADMIN");
			cs.execute();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void PfEsiUpdate(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String empid, Optpf, TxtPfNo, optesi, TxtEsiNo, TxtPfValue, TxtEsiValue;
			empid = request.getParameter("empId");
			Optpf = request.getParameter("optpf");
			TxtPfNo = request.getParameter("TxtPfNo");
			// if(TxtPfNo.equals("null"))
			// TxtPfNo="0";
			TxtPfValue = "" + request.getParameter("TxtPfValue");
			if (TxtPfValue.equals("null") || TxtPfValue.equals(""))
				TxtPfValue = "0";
			optesi = request.getParameter("optesi");
			TxtEsiNo = request.getParameter("TxtEsiNo");
			TxtEsiValue = "" + request.getParameter("TxtEsiValue");
			if (TxtEsiValue.equals("null") || TxtEsiValue.equals(""))
				TxtEsiValue = "0";
			empid = empid.trim();
			CallableStatement cs = con
					.prepareCall("{call PAY_PRO_PFESI(?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2, empid);
			cs.setString(3, Optpf);
			cs.setString(4, TxtPfValue);
			cs.setString(5, TxtPfNo);
			cs.setString(6, optesi);
			cs.setString(7, TxtEsiValue);
			cs.setString(8, TxtEsiNo);
			cs.setString(9, "ADMIN");
			cs.execute();

		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String sumAct = null;
			String action = request.getParameter("actionS");
			if (action.equals("PAYPfEsiAdd")) {
				sumAct = request.getParameter("Submit");
				sumAct = sumAct.trim();
			}
			if (action.equals("PAYPfEsiList")) {
				PfEsiList(request, response);
				response
						.sendRedirect("Smart Payroll/PfEsiTransView.jsp?message=View");
			} else if (action.equals("PAYPfEsiAdd")
					&& sumAct.equalsIgnoreCase("Submit")) {

				PfEsiAdd(request, response);
				// PfEsiView(request,response);
				response.sendRedirect("Smart Payroll/PfEsiTransView.jsp?message=PF AND ESI Added Sucessfully");
			} else if (action.equals("PAYPfEsiAdd")
					&& sumAct.equalsIgnoreCase("List")) {
				empId = request.getParameter("ename");
				PfEsiList(request, response);
				response.sendRedirect("Smart Payroll/PfEsiTransView.jsp?message="
						+ msg
						+ "&empId="
						+ empId
						+ "&empName="
						+ empName);
			}
			else if (action.equals("PAYPfEsiAdd")	&& sumAct.equalsIgnoreCase("Update"))
			{
				empId = request.getParameter("empId");
				//System.out.println("update 123123 :" + empId);
				PfEsiUpdate(request, response);
				response.sendRedirect("Smart Payroll/PfEsiTransView.jsp?message=View");
			}
			else if(action.equals("PAYESIREPORT"))
			{
				
				String fline="";
				Statement st=con.createStatement();
				String month=request.getParameter("Month");
				String year=request.getParameter("Year");
				String compId =request.getParameter("company");
				String branchId =request.getParameter("branch");
				String mon=com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month));
				
				repName=" ESI  Reports of "+mon+" - "+year;
				repHeader="Esi NO^Staff Id^Staff Name^GrossPay^Employee^Employer";
				fline="";
				fline=fline+repName+"\n";
				fline=fline+repHeader+"\n";
				
				sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,A.CHR_ESINO,B.CUR_GROSSPAY FROM COM_M_STAFF A, PAY_T_SALARYDETAILS B"; 
				sql=sql+" WHERE A.CHR_EMPID=B.CHR_EMPID AND B.CHR_MONTHS='"+mon+"' AND";
				sql = sql + " A.INT_COMPANYID="+compId +" AND (A.CHR_ESI='C' OR A.CHR_ESI='Y') AND B.CUR_GROSSPAY>0 ";
				if(!branchId.equals("-1"))	sql=sql+" AND A.INT_BRANCHID="+branchId;
			 
				rs=st.executeQuery(sql); 	
				    
				int rcount=0;
				while(rs.next())
				{
					for(int y=1;y<=4;y++)
					fline = fline +" " +rs.getString(y) +"^";
					fline = fline +"^\n";
					rcount=rcount+1;
				}
				if(rcount <1)
					fline = fline +"Record not found...";					
				String filename="EsiReport.sys";			
				FileWriter fws = new FileWriter(filename);
				BufferedWriter bws = new BufferedWriter(fws);					
				bws.write(fline);
				bws.close();	
				response.sendRedirect("Smart Payroll/ReportViewESI.jsp");
			}
	
			else if(action.equals("PAYPFREPORT"))
			{
				
				String fline="";
				Statement st=con.createStatement();
				String month=request.getParameter("Month");
				String year=request.getParameter("Year");
				String compId =request.getParameter("company");
				String branchId =request.getParameter("branch");
				
				String mon=com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month));
				
				repName=" PF Reports of "+mon+" - "+year;
				repHeader="NO^PF No^Staff Name^Basic Pay^PF Amount^Employee^Employer";
				fline="";
				fline=fline+repName+"\n";
				fline=fline+repHeader+"\n";
				
				sql="SELECT CHR_EMPID,CHR_STAFFNAME,CHR_PFNO,INT_SALARY FROM COM_M_STAFF "; 
				sql = sql + "WHERE INT_COMPANYID="+compId+" AND (CHR_PF='C' OR CHR_PF='Y') AND INT_SALARY>0 ";
				if(!branchId.equals("-1"))	sql=sql+" AND INT_BRANCHID="+branchId;			 
				rs=st.executeQuery(sql); 					    
				int rcount=0;					
				while(rs.next())
				{
					for(int y=1;y<=4;y++)
					fline = fline +" " +rs.getString(y) +"^";
					fline = fline +"^\n";
					rcount=rcount+1;
				}
				if(rcount <1)
					fline = fline +"Record not found...";					
				
				String filename="PfReport.sys";			
				FileWriter fws = new FileWriter(filename);
				BufferedWriter bws = new BufferedWriter(fws);					
				bws.write(fline);
				bws.close();	
				response.sendRedirect("Smart Payroll/ReportViewPF.jsp");
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
