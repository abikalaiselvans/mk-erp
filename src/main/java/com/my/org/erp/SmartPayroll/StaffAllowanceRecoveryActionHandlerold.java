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

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.CommonInfo;

public class StaffAllowanceRecoveryActionHandlerold extends AbstractActionHandler {
	Statement st;
	ResultSet rs;
	PreparedStatement pstm;
	 
	 

	private String collectAllowanceField() 
	{
		String fields = "";
		try 
		{
			String sql = "SELECT CHR_ACODE FROM PAY_M_ALLOWANCE ORDER  BY  INT_ALLOWANCEID";//ORDER  BY  CHR_ACODE
			st = con.createStatement();
			rs = st.executeQuery(sql);
			fields = "";
			while (rs.next())
				fields = fields + rs.getString(1) + "~";
			return fields;
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			//System.out.println("CONTROL FROM STAFF ALLOWANCE ACTION HANDLER :: "+ e);
		}
		return null;
	}

	private String collectRecoveryField() 
	{
		String fields = "";
		try 
		{
			String sql = "SELECT CHR_RCODE FROM PAY_M_RECOVERY ORDER BY INT_RECOVERYID";//ORDER BY CHR_RCODE
			st = con.createStatement();
			rs = st.executeQuery(sql);
			fields = "";
			while (rs.next())
				fields = fields + rs.getString(1) + "~";
			return fields;

		}
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			//System.out.println("CONTROL FROM STAFF ALLOWANCE ACTION HANDLER :: "+ e);
		}
		return null;
	}

	private void StaffDeletion(String staffid) 
	{
		try 
		{
			if (CommonFunctions.RecordExist(con, "SELECT COUNT(*) FROM pay_t_allowance WHERE CHR_EMPID = '"+ staffid + "'")) 
			{
				asql = " UPDATE pay_t_allowance SET A001=0,A002=0,A003=0,A004=0,A005=0,A006=0,A007=0,A008=0,A009=0,A0010=0,A0011=0,A0012=0,A0013=0,A0014=0,A0015=0 ,DAT_EFFECT=DATE(NOW())  WHERE CHR_EMPID = '"+ staffid + "'";
				apstm =con.prepareStatement(asql);
				apstm.execute();
				apstm.close();
				
			}
			if (CommonFunctions.RecordExist(con, "SELECT COUNT(*) FROM pay_t_recovery WHERE CHR_EMPID = '"+ staffid + "'")) 
			{
				
				asql = " UPDATE pay_t_recovery SET R001=0,R002=0,R003=0,R004=0,R005=0,R006=0,R007=0,R008=0 ,DAT_EFFECT=DATE(NOW())  WHERE CHR_EMPID = '"+ staffid + "'";
				apstm =con.prepareStatement(asql);
				apstm.execute();
				apstm.close();
			}
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date = new java.util.Date();
			@SuppressWarnings("unused")
			String updatedate = "" + datetime.format(date);
			String userId = (String) session.getAttribute("USRID");
			//System.out.println(action);
		 	if (action.equals("PAYStaffAdvanceUpdate")) 
			{
				String staffid = ""+request.getParameter("staffid");
				String advid = ""+request.getParameter("advid");
				double advAdvance=Double.parseDouble(request.getParameter("advAdvance"));;
				double advRecovery=Double.parseDouble(request.getParameter("advRecovery"));;
				double advBalance =advAdvance-advRecovery;
				String status = "";
				if(advBalance <=0)
					status="C";
				else
					status="";
				
				String sql=" INSERT INTO PAY_T_ADVANCE ";
				sql = sql +" (CHR_EMPID,CHR_ADVID,INT_YEAR,CHR_MONTH,Int_BalAmt,INT_DUEAMT,Int_Balance,Chr_Status) ";
				sql = sql +" VALUES('"+staffid+"','"+advid+"', year(now()),monthname(now()),";
				sql = sql +advAdvance+",";
				sql = sql +advRecovery+",";
				sql = sql +advBalance+",";
				sql = sql +"'"+status+"')";
				Statement st = con.createStatement();
				st.execute(sql);
				con.close();   
				response.sendRedirect("Smart Payroll/exit.jsp");
				
			}
			else if (action.equals("PAYStaffAllowanceRecoveryAdd")) 
			{
				String staff[] = request.getParameterValues("ename");
				String effectdt = request.getParameter("effectdt");
				effectdt = DateUtil.FormateDateSQL(effectdt);
				String staffid = "";
				boolean eflag=false;
				@SuppressWarnings("unused")
				String estaff="";
				for (int k = 0; k < staff.length; k++) 
				{
					staffid = staff[k];
					String allowanceFields = collectAllowanceField();
					String recoveryFields = collectRecoveryField();
					String afields[] = allowanceFields.split("~");
					String rfields[] = recoveryFields.split("~");
					String sql = "SELECT count(*) FROM PAY_T_ALLOWANCE CHR_EMPID";
					sql = sql + " WHERE  CHR_EMPID = '" + staffid + "'";
					boolean aflag =  CommonFunctions.RecordExist(con, sql);
					sql = "SELECT count(*) FROM PAY_T_RECOVERY CHR_EMPID";
					sql = sql + " WHERE  CHR_EMPID = '" + staffid + "'";
					boolean rflag =  CommonFunctions.RecordExist(con, sql);
					 
					String reqallowancefields = "";
					String reqrecoveryfields = "";
					String asqltrue = "";
					String rsqltrue = "";
					String asqlfalse = "";
					String rsqlfalse = "";
					String reqval = "";
					asqltrue = "UPDATE pay_t_allowance SET CHR_USRNAME='"+userId+"', DT_UPDATEDATE=DATE(NOW()), ";
					reqallowancefields = "";
					for (int i = 0; i < afields.length; i++) 
					{
						reqval = "";
						reqval = "" + request.getParameter(afields[i]);
						if (reqval.equals("") || reqval.equals("null"))
							reqval = "0";
						reqallowancefields = reqallowancefields	+ afields[i].toUpperCase() + " = '" + reqval+ "' ,";
					}
					reqallowancefields =reqallowancefields+" DAT_EFFECT ='"+effectdt+"',";
					reqallowancefields.trim();
					reqallowancefields = reqallowancefields.substring(0,reqallowancefields.length() - 1);
					asqltrue = asqltrue + reqallowancefields+ " WHERE CHR_EMPID = '" + staffid + "'";
					 
					asqlfalse = "INSERT INTO pay_t_allowance VALUES ( '"+ staffid + "' ,";
					reqallowancefields = "";
					for (int i = 0; i < afields.length; i++) 
					{
						reqval = "";
						reqval = "" + request.getParameter(afields[i]);
						if (reqval.equals("") || reqval.equals("null"))
							reqval = "0";
						reqallowancefields = reqallowancefields + "  '"	+ reqval + "' ,";
					}
					reqallowancefields =reqallowancefields+"  '"+effectdt+"',";
					reqallowancefields =reqallowancefields+" '"+userId+"', DATE(NOW()),'Y' ,";
					reqallowancefields.trim();
					reqallowancefields = reqallowancefields.substring(0,reqallowancefields.length() - 1);
					asqlfalse = asqlfalse + reqallowancefields + " )";
					 					
					
					rsqltrue = "UPDATE PAY_T_RECOVERY SET CHR_USRNAME='"+userId+"', DT_UPDATEDATE=DATE(NOW()), ";
					reqrecoveryfields = "";
					for (int i = 0; i < rfields.length; i++) 
					{
						reqval = "";
						reqval = "" + request.getParameter(rfields[i]);
						if (reqval.equals("") || reqval.equals("null"))
							reqval = "0";
						reqrecoveryfields = reqrecoveryfields+ rfields[i].toUpperCase() + " = '" + reqval+ "' ,";
					}
					reqrecoveryfields =reqrecoveryfields+" DAT_EFFECT ='"+effectdt+"',";
					reqrecoveryfields.trim();
					reqrecoveryfields = reqrecoveryfields.substring(0,reqrecoveryfields.length() - 1);
					rsqltrue = rsqltrue + reqrecoveryfields	+ " WHERE CHR_EMPID = '" + staffid + "'";
					 
					
					rsqlfalse = "INSERT INTO PAY_T_RECOVERY VALUES ( '"	+ staffid + "' ,";			
					reqrecoveryfields = "";
					for (int i = 0; i < rfields.length; i++) 
					{
						reqval = "";
						reqval = "" + request.getParameter(rfields[i]);
						if (reqval.equals("") || reqval.equals("null"))
							reqval = "0";
						reqrecoveryfields = reqrecoveryfields + "  '" + reqval	+ "' ,";
					}
					reqrecoveryfields =reqrecoveryfields+"  '"+effectdt+"',";
					reqrecoveryfields =reqrecoveryfields+" '"+userId+"', DATE(NOW()),'Y' ,";
					reqrecoveryfields.trim();
					reqrecoveryfields = reqrecoveryfields.substring(0,reqrecoveryfields.length() - 1);
					rsqlfalse = rsqlfalse + reqrecoveryfields + " )";
					 
					if (aflag) 
					{
						eflag=true;
						estaff=staffid;
						break;
					} 
					else 
					{
						st = con.createStatement();
						st.executeUpdate(asqlfalse);
						
					}
					if (rflag) 
					{
						eflag=true;
						estaff=staffid;
						break;
					} 
					else 
					{
						st = con.createStatement();
						st.executeUpdate(rsqlfalse);
						
					}

				}
				if (eflag)
				{	
					String sql = "SELECT B.CHR_EMPID, B.CHR_STAFFNAME FROM pay_t_allowance A, com_m_staff B WHERE A.CHR_EMPID = B.CHR_EMPID AND A.CHR_EMPID='"+staffid+"'";
					String Datas1[][]= CommonFunctions.QueryExecute(sql);
					String ID="", Name="";
					if (Datas1.length>0)
					{
						ID=Datas1[0][0];
						Name=Datas1[0][1];
					}
					else
					{
						sql = "SELECT B.CHR_EMPID, B.CHR_STAFFNAME FROM pay_t_allowance A, com_m_staff B WHERE A.CHR_EMPID = B.CHR_EMPID AND A.CHR_EMPID='"+staffid+"'";
						String Datas2[][]= CommonFunctions.QueryExecute(sql);
						if (Datas2.length>0)
						{
							ID=Datas2[0][0];
							Name=Datas2[0][1];
						}
					}
					con.close();    
					response.sendRedirect("Smart Payroll/AllowanceRecoveryAdd.jsp?ID="+ID+"&Name="+Name);
				}
				else
					response.sendRedirect("Smart Payroll/AllowanceTransView.jsp");
			} 
			else if (action.equals("PAYStaffAllowanceRecoveryUpdate")) 
			{
				String staffid = "" + request.getParameter("staffid");
				String effectdt = request.getParameter("effectdt");
				effectdt = DateUtil.FormateDateSQL(effectdt);
				staffid.trim();
				String allowanceFields = collectAllowanceField();
				String recoveryFields = collectRecoveryField();
				String afields[] = allowanceFields.split("~");
				String rfields[] = recoveryFields.split("~");
				///////////
				String sql = "SELECT count(*) FROM PAY_T_ALLOWANCE CHR_EMPID";
				sql = sql + " WHERE  CHR_EMPID = '" + staffid + "'";
				boolean aflag = CommonFunctions.RecordExist(con, sql);
				sql = "SELECT count(*) FROM PAY_T_RECOVERY CHR_EMPID";
				sql = sql + " WHERE  CHR_EMPID = '" + staffid + "'";
				boolean rflag =  CommonFunctions.RecordExist(con, sql);
				//System.out.println(aflag +"-"+rflag);
				String reqallowancefields = "";
				String reqrecoveryfields = "";
				String asqltrue = "";
				String rsqltrue = "";
				String asqlfalse = "";
				String rsqlfalse = "";
				String reqval = "";
				asqltrue = "UPDATE pay_t_allowance SET CHR_USRNAME='"+userId+"', DT_UPDATEDATE=DATE(NOW()), ";
				reqallowancefields = "";

				for (int i = 0; i < afields.length; i++) {
					reqval = "";
					reqval = "" + request.getParameter(afields[i]);
					if (reqval.equals("") || reqval.equals("null"))
						reqval = "0";
					reqallowancefields = reqallowancefields
							+ afields[i].toUpperCase() + " = '" + reqval
							+ "' ,";
				}
				reqallowancefields =reqallowancefields+" DAT_EFFECT ='"+effectdt+"',";
				reqallowancefields.trim();
				reqallowancefields = reqallowancefields.substring(0,reqallowancefields.length() - 1);
				asqltrue = asqltrue + reqallowancefields+ " WHERE CHR_EMPID = '" + staffid + "'";
				System.out.println("Allowance Updation :"+asqltrue);
				
				asqlfalse = "INSERT INTO pay_t_allowance VALUES ( '" + staffid	+ "' ,";
				reqallowancefields = "";
				for (int i = 0; i < afields.length; i++) {
					reqval = "";
					reqval = "" + request.getParameter(afields[i]);
					if (reqval.equals("") || reqval.equals("null"))
						reqval = "0";
					reqallowancefields = reqallowancefields + "  '" + reqval+ "' ,";
				}
				reqallowancefields =reqallowancefields+" '"+effectdt+"',";
				reqallowancefields =reqallowancefields+" '"+userId+"', DATE(NOW()),'Y' ,";
				reqallowancefields.trim();
				reqallowancefields = reqallowancefields.substring(0,reqallowancefields.length() - 1);
				asqlfalse = asqlfalse + reqallowancefields + " )";
				System.out.println("Allowance Insertion"+asqlfalse);
				
				

				rsqltrue = "UPDATE pay_t_recovery SET  CHR_USRNAME='"+userId+"', DT_UPDATEDATE=DATE(NOW()), ";
				reqrecoveryfields = "";
				for (int i = 0; i < rfields.length; i++) {
					reqval = "";
					reqval = "" + request.getParameter(rfields[i]);
					if (reqval.equals("") || reqval.equals("null"))
						reqval = "0";
					reqrecoveryfields = reqrecoveryfields
							+ rfields[i].toUpperCase() + " = '" + reqval
							+ "' ,";
				}
				reqrecoveryfields =reqrecoveryfields+" DAT_EFFECT ='"+effectdt+"',";
				reqrecoveryfields.trim();
				reqrecoveryfields = reqrecoveryfields.substring(0,reqrecoveryfields.length() - 1);
				rsqltrue = rsqltrue + reqrecoveryfields	+ " WHERE CHR_EMPID = '" + staffid + "'";
				System.out.println("Recovery Updation :"+rsqltrue);
				
				
				
				rsqlfalse = "INSERT INTO pay_t_recovery VALUES ( '" + staffid+ "' ,";
				reqrecoveryfields = "";
				for (int i = 0; i < rfields.length; i++) {
					reqval = "";
					reqval = "" + request.getParameter(rfields[i]);
					if (reqval.equals("") || reqval.equals("null"))
						reqval = "0";
					reqrecoveryfields = reqrecoveryfields + "  '" + reqval+ "' ,";
				}
				reqrecoveryfields =reqrecoveryfields+" '"+effectdt+"',";
				reqrecoveryfields =reqrecoveryfields+" '"+userId+"', DATE(NOW()),'Y' ,";
				reqrecoveryfields.trim();
				reqrecoveryfields = reqrecoveryfields.substring(0,reqrecoveryfields.length() - 1);
				rsqlfalse = rsqlfalse + reqrecoveryfields + " )";
				System.out.println("Recovery Insertion :"+rsqlfalse);
				
				st = con.createStatement();
				if (aflag) 
					st.execute(asqltrue);
				else 
					st.execute(asqlfalse);
				
				if (rflag) 
					st.execute(rsqltrue);
				else
					st.execute(rsqlfalse);
				
				System.out.println("***************************************************************************************");
				st.close();
				con.close();    
				response.sendRedirect("Smart Payroll/Refresh.jsp");
			} 
			else if (action.equals("PAYStaffAllowanceRecoveryDelete")) 
			{
				String staff[] = request.getParameterValues("staffid");
				String staffid = "";
				for (int i = 0; i < staff.length; i++) {
					staffid = staff[i];
					staffid.trim();
					StaffDeletion(staffid);
				}
				con.close();    
				response.sendRedirect("Smart Payroll/AllowanceTransView.jsp");
			}
			else if ("PAYRivisionDelete".equals(action)) 
			{
				String staff[] = request.getParameterValues("staffid");
				for (int i = 0; i < staff.length; i++) 
				{
					String staffid = staff[i];
					String ma[][] =CommonFunctions.QueryExecute("select max(INT_RIVISIONID) from pay_t_rivision WHERE CHR_EMPID ='"+staffid+"'");
					int maxid = Integer.parseInt(ma[0][0]);
					int alterid= maxid-1;
					boolean flag = false;
					if(maxid<2)
						flag = false;
					else
						flag = true;
					if(flag)
					{	
						String query = "Select CHR_ACODE,CHR_ANAME from pay_m_allowance order by CHR_ACODE";
						String Allowance[][] =  CommonFunctions.QueryExecute(query);
						query = "Select CHR_RCODE,CHR_RNAME from pay_m_recovery order by CHR_RCODE";
						String Recovery[][] =  CommonFunctions.QueryExecute(query);
						String fields="";
						for(int u=0;u<Allowance.length;u++)
							fields = fields +Allowance[u][0]+",";
						for(int u=0;u<Recovery.length;u++)
							fields = fields +Recovery[u][0]+",";
						fields = fields.substring(0, fields.trim().length()-1);
						
						String previousData[][] =  CommonFunctions.QueryExecute("SELECT "+fields+" FROM pay_t_rivision WHERE CHR_EMPID ='"+staffid+"' AND  INT_RIVISIONID ="+alterid);
						String sql ="DELETE FROM pay_t_rivision WHERE INT_RIVISIONID="+maxid +" AND CHR_EMPID='"+staffid+"'";
						Statement st = con.createStatement();
						st.execute(sql);
						
						
						sql = "UPDATE pay_t_allowance SET ";
						for(int u=0; u<Allowance.length;u++)
							sql = sql +" "+Allowance[u][0]+" = '"+previousData[0][u]+"' , ";
						sql = sql.substring(0, sql.trim().length()-1);
						sql=sql +" WHERE CHR_EMPID ='"+staffid+"'";
						st.execute(sql);
						
						
						sql = "UPDATE pay_t_recovery SET ";
						int id=Allowance.length; 
						for(int u=0; u<Recovery.length;u++)
						{	
							sql = sql +" "+Recovery[u][0]+" = '"+previousData[0][id]+"' , ";
							id= id+1;
						}
						sql = sql.substring(0, sql.trim().length()-1);
						sql=sql +" WHERE CHR_EMPID ='"+staffid+"'";
						st.execute(sql);
						
						String q =" SELECT INT_BASIC ,INT_INCREMENT  FROM pay_t_rivision WHERE CHR_EMPID='"+staffid+"' AND INT_RIVISIONID =(SELECT MAX(INT_RIVISIONID) FROM pay_t_rivision WHERE CHR_EMPID='"+staffid+"')";
				 		String bas[][] =  CommonFunctions.QueryExecute(q);
				 		double basic=0;
				 		if(!bas[0][0].equals("-"))
				 			basic=Double.parseDouble(bas[0][0]);
				 		double inc=0;
				 		if(!bas[0][1].equals("-"))
				 			inc=Double.parseDouble(bas[0][1]);
				 		sql = "UPDATE  com_m_staff  SET INT_SALARY ="+(basic+inc)+" WHERE CHR_EMPID = '"+staffid+"'";
						st.execute(sql);
				 		
					}	
				}
				con.close();    
				response.sendRedirect("Smart Payroll/Rivision.jsp");	
			}
			else if (action.equals("PAYAllowanceRecoveryRivision")) 
			{
				 		String  staffid= request.getParameter("ename");
				 		String  effectdt= request.getParameter("effectdt");
				 		effectdt = DateUtil.FormateDateSQL(effectdt);
				 		String increment =""+request.getParameter("increment");
				 		String bas[][] =  CommonFunctions.QueryExecute("SELECT INT_SALARY FROM  com_m_staff  WHERE CHR_EMPID='"+staffid+"'");
				 		if("".equals(increment)|| "null".equals(increment))
				 			increment="0";
				 		double basic=0;
				 		if(!bas[0][0].equals("-"))
				 			basic=Double.parseDouble(bas[0][0]);
				 		
				 		int allowancelength = Integer.parseInt(request.getParameter("allowancelength"));
				 		int recoverylength = Integer.parseInt(request.getParameter("recoverylength"));
				 		String [][] rivisionid =  CommonFunctions.QueryExecute("SELECT (MAX(INT_RIVISIONID)+1) FROM pay_t_rivision WHERE CHR_EMPID='"+staffid+"'");
				 		int rid=0;
				 		if("-".equals(rivisionid[0][0]))
				 			rid =1;
				 		else
				 			rid = Integer.parseInt(rivisionid[0][0]);
				 		
				 		String sql=" INSERT INTO pay_t_rivision ( CHR_EMPID,INT_RIVISIONID,";
				 		sql = sql +" INT_BASIC,INT_INCREMENT, DT_RIVISION,CHR_MONTH,INT_YEAR, ";
				 		for(int u=1; u<=allowancelength;u++)
				 			sql = sql +""+request.getParameter("Aname"+u)+" , ";
				 		for(int u=1; u<=recoverylength;u++)
				 			sql = sql +""+request.getParameter("Rname"+u)+" , ";
				 		sql = sql+" DAT_EFFECT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES (";
				 		sql = sql+"'"+staffid+"' ,"+rid+" , ";
				 		sql =sql+basic+"  ,"+Double.parseDouble(increment)+" , now(), monthname(now()), year(now()) , ";
				 		for(int u=1; u<=allowancelength;u++)
				 			sql = sql +" '"+""+request.getParameter("Alowance"+u)+"' , ";
				 		for(int u=1; u<=recoverylength;u++)
				 			sql = sql +" '"+""+request.getParameter("Recovery"+u)+"' , ";
				 		sql = sql +"'"+effectdt+"' , ";
				 		sql = sql +"'"+userId+"' , ";
				 		sql = sql +" now() , 'Y' )";
				 		System.out.println(sql);
				 		Statement st = con.createStatement();
				 		st.execute(sql);
				 		
				 		
				 		
				 		sql = "UPDATE  com_m_staff  SET INT_SALARY =?  WHERE CHR_EMPID = ?";
				 		apstm = con.prepareStatement(sql);
				 		apstm.setString(1,""+(basic+Double.parseDouble(increment)));
				 		apstm.setString(2,staffid);
				 		System.out.println(""+apstm);
				 		apstm.execute();
				 		apstm.close();
				 		
				 		
				 		/*
				 		 * ALLOWANCE CALCULATIONS 
				 		 */
						if( CommonInfo.RecordExist("SELECT count(*) FROM pay_t_allowance WHERE CHR_EMPID ='"+staffid+"'"))
						{
							sql = "UPDATE pay_t_allowance SET ";
							for(int u=1; u<=allowancelength;u++)
								sql = sql +" "+request.getParameter("Aname"+u)+" = '"+request.getParameter("Alowance"+u)+"' , ";
							sql=sql +" DAT_EFFECT='"+effectdt+"' ";
							sql=sql +" WHERE CHR_EMPID ='"+staffid+"'";
							System.out.println(sql);
							st.execute(sql);
						}
						else
						{
							sql = " INSERT INTO pay_t_allowance ( CHR_EMPID,";
							for(int u=1; u<=allowancelength;u++)
								sql = sql +" "+request.getParameter("Aname"+u)+" , ";
							sql=sql +" DAT_EFFECT) VALUES (";
							sql = sql +" '"+staffid+"' ,";
							for(int u=1; u<=allowancelength;u++)
								sql = sql +" '"+""+request.getParameter("Alowance"+u)+"' , ";
							sql= sql+"'"+effectdt+"') ";
							System.out.println(sql);
							st.execute(sql);

						}
						
						
						/*
				 		 * RECOVERY CALCULATIONS 
				 		 */
						if( CommonInfo.RecordExist("SELECT count(*) FROM pay_t_recovery WHERE CHR_EMPID ='"+staffid+"'"))
						{
							sql = "UPDATE pay_t_recovery SET ";
							for(int u=1; u<=recoverylength;u++)
								sql = sql +" "+request.getParameter("Rname"+u)+" = '"+request.getParameter("Recovery"+u)+"' , ";
							sql=sql +" DAT_EFFECT='"+effectdt+"' ";
							sql=sql +" WHERE CHR_EMPID ='"+staffid+"'";
							System.out.println(sql);
							st.execute(sql);
						}
						else
						{
							sql = " INSERT INTO pay_t_recovery ( CHR_EMPID,";
							for(int u=1; u<=recoverylength;u++)
								sql = sql +" "+request.getParameter("Rname"+u)+" , ";
							sql=sql +" DAT_EFFECT) VALUES (";
							sql = sql +" '"+staffid+"' ,";
							for(int u=1; u<=recoverylength;u++)
								sql = sql +" '"+""+request.getParameter("Recovery"+u)+"' , ";
							sql= sql+"'"+effectdt+"') ";
							System.out.println(sql);
							st.execute(sql);
						}
						
						 
						response.sendRedirect("Smart Payroll/AllowanceRecoveryRivisionConfirm.jsp?staffid="+staffid);
						
			}
			else if ("PAYAllowanceRecoveryRivisionUpdate".equals(action)) 
			{
				 	String  staffid= request.getParameter("staffid");
					int allowancelength = Integer.parseInt(request.getParameter("allowancelength"));
					int recoverylength = Integer.parseInt(request.getParameter("recoverylength"));
					int maxid =Integer.parseInt(request.getParameter("maxid"));
					String increment =""+request.getParameter("increment");
					String q =" SELECT INT_BASIC FROM pay_t_rivision WHERE CHR_EMPID='"+staffid+"' AND INT_RIVISIONID =(SELECT MAX(INT_RIVISIONID) FROM pay_t_rivision WHERE CHR_EMPID='"+staffid+"')";
					String bas[][] =  CommonFunctions.QueryExecute(q);
			 		if("".equals(increment)|| "null".equals(increment))
			 			increment="0.0";
			 		double basic=0;
			 		if(!bas[0][0].equals("-"))
			 			basic=Double.parseDouble(bas[0][0]);
			 		
					
					
					String sql = "UPDATE pay_t_rivision  SET  ";
					sql =sql+" DT_RIVISION= now(), CHR_MONTH=monthname(now()), INT_YEAR=year(now()) , ";
					sql = sql +" INT_INCREMENT = "+Double.parseDouble(increment)+" ,";
					for(int u=1; u<=allowancelength;u++)
						sql = sql +" "+request.getParameter("Aname"+u)+" = '"+request.getParameter("Alowance"+u)+"' , ";
					for(int u=1; u<=recoverylength;u++)
						sql = sql +" "+request.getParameter("Rname"+u)+" = '"+request.getParameter("Recovery"+u)+"' , ";
					sql = sql.substring(0, sql.trim().length()-1)+" ";
					sql = sql +" WHERE CHR_EMPID ='"+staffid+"' AND INT_RIVISIONID="+maxid;
					Statement st = con.createStatement();
					st.execute(sql);
					sql = "UPDATE pay_t_recovery SET ";
					for(int u=1; u<=recoverylength;u++)
						sql = sql +" "+request.getParameter("Rname"+u)+" = '"+request.getParameter("Recovery"+u)+"' , ";
					sql = sql.substring(0, sql.trim().length()-1);
					sql=sql +" WHERE CHR_EMPID ='"+staffid+"'";
					st.execute(sql);
					sql = "UPDATE pay_t_allowance SET ";
					for(int u=1; u<=allowancelength;u++)
						sql = sql +" "+request.getParameter("Aname"+u)+" = '"+request.getParameter("Alowance"+u)+"' , ";
					sql = sql.substring(0, sql.trim().length()-1);
					sql=sql +" WHERE CHR_EMPID ='"+staffid+"'";
					st.execute(sql);
					sql = "UPDATE  com_m_staff  SET INT_SALARY ="+(basic+Double.parseDouble(increment))+" WHERE CHR_EMPID = '"+staffid+"'";
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart Payroll/Rivision.jsp");					
			}
			else if("PAYStaffAllowanceRecoveryAddManual".equals(action)) 
			{

				try 
				{
					String staffid = request.getParameter("staffid");
					String effectdt = request.getParameter("effectdt");
					String flag = request.getParameter("flag");
					
					effectdt = DateUtil.FormateDateSQL(effectdt);
					String allowanceFields = collectAllowanceField();
					String recoveryFields = collectRecoveryField();
					String afields[] = allowanceFields.split("~");
					String rfields[] = recoveryFields.split("~");
					String reqallowancefields = "";
					String reqrecoveryfields = "";
					String asqlfalse = "";
					String rsqlfalse = "";
					String reqval = "";
						
					asqlfalse = "INSERT INTO pay_t_allowance VALUES ( '"+ staffid + "' ,";
					reqallowancefields = "";
					for (int i = 0; i < afields.length; i++) 
					{
						reqval = "";
						reqval = "" + request.getParameter(afields[i]);
						if (reqval.equals("") || reqval.equals("null"))
							reqval = "0";
						reqallowancefields = reqallowancefields + "  '"	+ reqval + "' ,";
					}
					reqallowancefields =reqallowancefields+"  '"+effectdt+"', '"+userId+"', DATE(NOW()),'Y' ,";
					reqallowancefields.trim();
					reqallowancefields = reqallowancefields.substring(0,reqallowancefields.length() - 1);
					asqlfalse = asqlfalse + reqallowancefields + " )";
					System.out.println("\n\nSatff Allowance"+asqlfalse);
					apstm = con.prepareStatement(asqlfalse);
					apstm.execute();
					apstm.close();
					//st = con.createStatement();
					//st.executeUpdate(asqlfalse); 					
					
					rsqlfalse = "INSERT INTO PAY_T_RECOVERY VALUES ( '"	+ staffid + "' ,";			
					reqrecoveryfields = "";
					for (int i = 0; i < rfields.length; i++) 
					{
						reqval = "";
						reqval = "" + request.getParameter(rfields[i]);
						if (reqval.equals("") || reqval.equals("null"))
							reqval = "0";
						reqrecoveryfields = reqrecoveryfields + "  '" + reqval	+ "' ,";
					}
					reqrecoveryfields =reqrecoveryfields+"  '"+effectdt+"',  '"+userId+"', DATE(NOW()),'Y' ,";
					reqrecoveryfields.trim();
					reqrecoveryfields = reqrecoveryfields.substring(0,reqrecoveryfields.length() - 1);
					rsqlfalse = rsqlfalse + reqrecoveryfields + " )";
					System.out.println("\n\nSatff Allowance"+rsqlfalse);
					apstm = con.prepareStatement(rsqlfalse);
					apstm.execute();
					apstm.close();
		
					//st = con.createStatement();
					//st.executeUpdate(rsqlfalse);
					
					if("Y".equals(flag))
					{	
						asql = "UPDATE com_m_staff SET CHR_APPROVED = 'N' WHERE CHR_EMPID =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,staffid );
						apstm.execute();
						apstm.close();
					}
					
					response.sendRedirect("Smart Common/StaffRegistrationView.jsp");
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
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}
}
