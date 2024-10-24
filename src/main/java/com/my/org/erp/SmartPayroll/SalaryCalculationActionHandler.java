package com.my.org.erp.SmartPayroll;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.setting.CommonData;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
public class SalaryCalculationActionHandler extends AbstractActionHandler 
{
	String month, year;
	String queryMonth, queryYear;
	String sql;
	String fdate, tdate;
	String repName, repHeader;
	int wrkDays;
	Statement st, allst, recst, pfesist, messst, advst,allnost;
	ResultSet rs, allrs, recrs, pfesirs, messrs, advrs,allnors;
	String date1, date2;
	String type;
	String sqlSel, empid, empname, pftype, esitype, percentpfamt, dectype,optPF, optESI;
	double preday, absday, leave, od, holiday, sunday, totalday, sub, add,onedaysal, lateday, extraloss, grosspay, netPay;
	int percentesiamt = 0;
	double pfValue, esiValue;
	int late, workingday, salary, pfamt, esiamt, messamt, advamt, dueamt,advbal, dectAmt;
	int lateDays=0;
	String fline;
	SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
	double cpypf=0.0;
	double cpypension=0.0;
	double cpyesi=0.0;
	String salarytype="";
	private void doCalculation(HttpServletRequest request,	HttpServletResponse response, String SQL, String repName,String repHeader) throws IOException 
	{
		try 
			{
				Statement st = con.createStatement();
				sql = SQL;
				workingday = wrkDays;
				fline = "";
				fline = fline + repName + "\n";
				fline = fline + repHeader + "\n";
				ResultSet rs = st.executeQuery(sql);
				Date date = new Date();			
				
				HttpSession session = request.getSession();
				String userId = (String) session.getAttribute("USRID");
				
				int i = 0;				
				SQL="SELECT INT_PERLIMIT,INT_LATELIMIT FROM att_m_basicsettings";
 				String lateValues[][]=com.my.org.erp.common.CommonFunctions.RecordSetArray(con,SQL);
 				if(lateValues.length>0)
 				{	
 					if(!"-".equals(lateValues[0][1]))
 						lateDays=Integer.parseInt(lateValues[0][1]);
 					else
 						lateDays=0;
 				}	
 				else
 					lateDays=0;
				
 				 
				while (rs.next()) 
				{					
					 
					empid = ""+rs.getString("CHR_EMPID");
					empname = ""+rs.getString("CHR_STAFFNAME");
					salary = (int)(rs.getDouble("INT_SALARY"));
					preday = rs.getDouble("DOU_PRESENT");
					absday = rs.getDouble("DOU_ABSENT");
					leave = rs.getDouble("DOU_LEAVE");
					od = rs.getDouble("DOU_OD");
					late =rs.getInt("INT_LATE");
					holiday = rs.getDouble("DOU_HOLIDAY");
					sunday = rs.getDouble("DOU_SUNDAY");
					optPF = ""+rs.getString("CHR_PF");
					optESI = ""+rs.getString("CHR_ESI");
					pftype = "" + rs.getString("CHR_PFTYPE");
					esitype = "" + rs.getString("CHR_ESITYPE");
					
					if (optPF.equals("Y"))
						pfValue = rs.getDouble("INT_PFAMT");
					if (optESI.equals("Y"))
						esiValue = rs.getDouble("INT_ESIAMT");
					if(preday>0)
						add = preday-sunday ;
					else
						add = preday;
					Double ppday= preday + holiday+sunday;
					
					
					double totalpresent = add;
					if (leave == 1) 
					{
						leave = 0;
						add = add + 1;
					} 
					else if (leave > 1) 
					{
						add = add + 1;
						leave = leave - 1;
					}
					double acworkingday = ((double)workingday) -(sunday); //- (int) sunday;
					double lossday = acworkingday-add;
					// LOSS OF PAY EXTRA DAYS CALCULATION
					onedaysal = salary / workingday;
					// LATE DAYS CALCULATION NPR
					if(late>lateDays&&lateDays!=0){						
						lateday=(late-lateDays)*(onedaysal/4);					
					}
					
					 
					
					//ALLOWANCE CALCULATION
					int noofallowance=com.my.org.erp.common.CommonFunctions.intRecordCount(con,"Select count(*) from pay_m_allowance");
					String kquery="";										
					for(int u=1; u<=noofallowance;u++)
						kquery =kquery+"A00" + u+",";
					kquery = kquery.substring(0,kquery.length()-1);
					allst = con.createStatement();
					String sql_allow_query = "SELECT "+kquery+" FROM PAY_T_ALLOWANCE WHERE CHR_EMPID='"+ empid + "'";
					boolean allenter = false;
					String all_sql = "INSERT INTO pay_t_salaryallowance VALUES('"+ empid + "',";
					allrs = allst.executeQuery(sql_allow_query);
					int a = 1; 
					double call=0;				
					if(allrs.next()) 
					{
						allenter = true;
						while (a <=noofallowance ) 
						{
							if(("null".equalsIgnoreCase(allrs.getString("A00" + a)) || " ".equalsIgnoreCase(allrs.getString("A00" + a))))
								call=0;	
							else
								call=Integer.parseInt(allrs.getString("A00" + a));
							all_sql = all_sql + call + ",";
							a++;
						}
						 
					}					
					if (allenter) 
					{
						while (a <= noofallowance) 
						{
							all_sql = all_sql + "0,";
							a++;
						}
						all_sql = all_sql + "'" + queryMonth + "'," + queryYear	+ ",'ADMIN','2006-01-01 00:00:00','Y')";
						sql = "DELETE FROM pay_t_salaryallowance WHERE CHR_EMPID='"	+ empid + "' AND CHR_MONTH='" + queryMonth+ "' AND INT_YEAR=" + queryYear;
						allst.execute(sql);
						allst.execute(all_sql);
						////System.out.println(all_sql);
					}
					allst.close();
					allrs.close();
					
					sql = "SELECT CHR_ANAME,CHR_FLAG FROM pay_m_allowance";
					String aname[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
					String sqlAllTran = "SELECT * FROM pay_t_salaryallowance ";
					sqlAllTran = sqlAllTran + " WHERE CHR_EMPID='" + empid + "'";
					sqlAllTran = sqlAllTran + " AND CHR_MONTH='" + queryMonth+ "' ";
					sqlAllTran = sqlAllTran + " AND INT_YEAR=" + year;
					String ssql = "SELECT count(*) FROM pay_t_salaryallowance ";
					ssql = ssql + " WHERE CHR_EMPID='" + empid + "'";
					ssql = ssql + " AND CHR_MONTH='" + queryMonth+ "' ";
					ssql = ssql + " AND INT_YEAR=" + year;
					String avalue[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sqlAllTran);
					double addedallowance=0.0;
					double extraallowance=0.0;
					if(com.my.org.erp.common.CommonFunctions.RecordExist(con, ssql))
						for(int f=0;f<aname.length;f++)
						{
							if("Y".equals(aname[f][1]))
								
								addedallowance = addedallowance+Double.parseDouble(avalue[0][(f+1)]);
							else
								extraallowance = extraallowance+Double.parseDouble(avalue[0][(f+1)]);
							
							
						}
					
					
					
					
					// RECOVERY CALCULATION
					int noofrecvery=com.my.org.erp.common.CommonFunctions.intRecordCount(con,"Select count(*) from pay_m_recovery");
					boolean Recenter = false;
					String rec_sql = "INSERT INTO pay_t_salaryrecovery VALUES('" + empid+ "',";
					recst = con.createStatement();
					String sql_recover_query = "SELECT * FROM PAY_T_RECOVERY WHERE CHR_EMPID='"	+ empid + "'";
					recrs = recst.executeQuery(sql_recover_query);
					int r = 1;  
					call=0;					
					while (recrs.next()) 
					{
						Recenter = true;
						while (r <= noofrecvery) 
						{
							call=recrs.getInt("R00" + r);
							rec_sql = rec_sql + recrs.getInt("R00" + r) + ",";
							r++;
						}
					}
					if (Recenter) 
					{
						while (r <= noofrecvery) 
						{
							rec_sql = rec_sql + "0,";
							r++;
						}
						rec_sql = rec_sql + "'" + queryMonth + "'," + queryYear	+ ",'ADMIN',now(),'Y')";
						recst.execute("DELETE FROM pay_t_salaryrecovery WHERE CHR_EMPID='"+ empid+ "' AND CHR_MONTH='"+ queryMonth+ "' AND INT_YEAR=" + queryYear);
						recst.execute(rec_sql);
						////System.out.println(rec_sql);
					}
					Recenter = false;	
					recst.close();
					recrs.close();
					
					
					
					
					
					
					int recovery=0;
					double recvalue=0.0;
					sql = "SELECT CHR_RNAME FROM pay_m_recovery";
					String rname[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
					String sqlRecTran = "SELECT * FROM pay_t_salaryrecovery ";
					sqlRecTran = sqlRecTran + " WHERE CHR_EMPID='" + empid + "'";
					sqlRecTran = sqlRecTran + " AND CHR_MONTH='" + queryMonth+ "' ";
					sqlRecTran = sqlRecTran + " AND INT_YEAR=" + year;
					ssql = "SELECT count(*) FROM pay_t_salaryrecovery ";
					ssql = ssql + " WHERE CHR_EMPID='" + empid + "'";
					ssql = ssql + " AND CHR_MONTH='" + queryMonth+ "' ";
					ssql = ssql + " AND INT_YEAR=" + year;
					
					String rvalue[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sqlRecTran);
					if(com.my.org.erp.common.CommonFunctions.RecordExist(con, ssql))
						for(int u=0;u<rname.length;u++)
							recvalue = recvalue+Double.parseDouble(rvalue[0][(u+1)]);
					
					
					// MESS BILL FROM PAY_M_MESSBILL
					messst = con.createStatement();
					String sql_mess_query = "SELECT * FROM PAY_M_MESSBILL WHERE CHR_EMPID='"+ empid	+ "' and CHR_MONTH='"+ queryMonth+ "' AND INT_YEAR=" + queryYear;
					messrs = messst.executeQuery(sql_mess_query);
					messamt = 0;
					if (messrs.next()) 
						messamt = messrs.getInt("INT_CASHAMT");
					
					// ADVANCE CALCULATION FROM PAY_M_ADVANCE
					advst = con.createStatement();
					String sql_adv_query = "SELECT * FROM PAY_M_ADVANCE "+ "WHERE CHR_EMPID='" + empid + "' "+ "AND DT_CLOSEDATE IS NULL" + " AND INT_BALAMT>0 "
						+" AND CHR_EMPID NOT IN  " +" (SELECT CHR_EMPID FROM pay_t_advance WHERE " +
						" Int_year="+queryYear+" AND Chr_Month='"+queryMonth+"')";
					
					advrs = advst.executeQuery(sql_adv_query);
					String dueSta="O";
					if (advrs.next()) 
					{
						String advId = advrs.getString("CHR_ADVID");
						sql_adv_query = "UPDATE PAY_M_ADVANCE SET ";
						dectype = advrs.getString("CHR_DECTYPE");
						if (dectype.equals("M")) 
						{
							advamt = advrs.getInt("INT_BALAMT");
							dueamt = 0;
							advbal = advamt - dueamt;
						} 
						else if (dectype.equals("A")) 
						{
							advamt = advrs.getInt("INT_BALAMT");
							dueamt = advrs.getInt("INT_DUE");
							if (advamt < dueamt)
							{
								advbal = 0;
								dueamt=advamt;
								dueSta="C";
							}
							else
								advbal = advamt - dueamt;
							int balins = advrs.getInt("INT_BALINS");
							balins = balins - 1;
							sql_adv_query = sql_adv_query + "INT_BALINS=" + balins+ ",";
						}
						sql_adv_query = sql_adv_query + "INT_BALAMT=" + advbal;
						if (advbal <= 0)
							sql_adv_query = sql_adv_query + ",DT_CLOSEDATE='" + dateformat.format(date) + "', CHR_DUESTATUS='"+dueSta+"' ";
							sql_adv_query = sql_adv_query + " WHERE CHR_EMPID='"
								+ empid + "' " + " AND DT_CLOSEDATE IS NULL"
								+ " AND CHR_ADVID='" + advId + "'"
								+ " AND INT_BALAMT>0";
						advst.execute(sql_adv_query);
						sql_adv_query = "INSERT INTO PAY_T_ADVANCE"
							+ "(CHR_EMPID,CHR_ADVID,INT_YEAR,CHR_MONTH,Int_BalAmt,INT_DUEAMT,Int_Balance,Chr_Status)"
							+ "VALUES('" + empid + "','" + advId + "',"
							+ queryYear + ",'" + queryMonth + "'," + advamt
							+ "," + dueamt + "," + advbal + ",'"+dueSta+"')";
						advst.execute(sql_adv_query);
					}
					else
					{
						sql_adv_query="SELECT * FROM pay_t_advance WHERE CHR_EMPID='" + empid + "' "+
						" AND Int_year="+queryYear+" AND Chr_Month='"+queryMonth+"'";						
						advrs = advst.executeQuery(sql_adv_query);					
						if (advrs.next()) 
						{
							advamt=advrs.getInt("Int_BalAmt");
							dueamt=advrs.getInt("Int_DueAmt");
							advbal=advrs.getInt("Int_Balance");
						}
					}
					
					
					
					// GROSS PAY CALCULATION
					extraloss = onedaysal * lossday * -1;
					grosspay = (salary + addedallowance) - (lateday + extraloss);
					
					
					//Start Author :: kalai---------------------
					//PF AND ESI CALCULATION FROM PAY_M_PF
					if (optPF.equals("C") || optESI.equals("C")) 
					{
						pfesist = con.createStatement();
						String sql_pfesi_query = "SELECT INT_PFAMT,INT_ESIAMT FROM M_INSTITUTION";
						pfesirs = pfesist.executeQuery(sql_pfesi_query);
						if (pfesirs.next()) 
						{
							if (optPF.equals("C")) 
							{
								pfValue = pfesirs.getDouble("INT_PFAMT");
								pftype = "P";
							}
							if (optESI.equals("C")) 
							{
								esiValue = pfesirs.getDouble("INT_ESIAMT");
								esitype = "P";
							}
						}
					}
					
					if (!optPF.equals("N")) 
						if (pftype.equals("P"))
						{	
							pfValue = salary * pfValue / 100;
						}	
					
					if (!optESI.equals("N")) {
						if (esitype.equals("P"))
						{	
							if(grosspay>=10000)
								esiValue = 0;
							else
								esiValue =  grosspay  * esiValue / 100;
						}	
					}
					
					//End Author :: kalai---------------------
					
					
					 
					//System.out.println(empid+"-"+salary +"-"+   "-"+lateday+"-" + extraloss+"-"+grosspay+"-"+esiValue+"-"+addedallowance+"-"+extraallowance);
					
					
					
					dectAmt = (int)recvalue + (int) pfValue + (int) esiValue + messamt+ dueamt;
					netPay = grosspay - dectAmt;
					if (lossday < 0)
						extraloss = onedaysal * lossday * -1;
					else
						extraloss = onedaysal * lossday;
					if (totalpresent == 0) 
					{
						lossday = 0;
						extraloss = 0;
						lateday = 0;
						grosspay = 0;
						advamt = 0;
						dueamt = 0;
						advbal = 0;
						dectAmt = 0;
						netPay = 0;
						esiValue = 0;
						pfValue = 0;
						grosspay = 0;
					}
					
					advst.execute("DELETE FROM pay_t_nsalarydetailspf WHERE CHR_EMPID='"
								+ empid
								+ "' AND CHR_MONTHS='"
								+ queryMonth
								+ "' AND INT_YEAR=" + queryYear);
					String sql = "INSERT INTO pay_t_nsalarydetailspf VALUES(";
					sql = sql + "'" + empid + "',";
					sql = sql + "'" + empname + "',";
					sql = sql + "'" + queryYear + "',";
					sql = sql + "'" + queryMonth + "',";
					sql = sql + salary + ",";
					sql = sql + ppday + ",";
					sql = sql + lossday + ",";
					sql = sql + extraloss + ",";
					sql = sql + lateday + ","; // Late days'
					sql = sql + lateday + ","; // Amount
					sql = sql + addedallowance + ",";
					sql = sql + extraallowance + ",";
					sql = sql + grosspay + ",";
					sql = sql + recovery + ",";
					sql = sql + (int)pfValue + ",";
					sql = sql + " 0, ";
					sql = sql + (int)esiValue + ",";
					sql = sql + " 0, ";
					sql = sql + messamt + ",";
					sql = sql + advamt + ",";
					sql = sql + dueamt + ",";
					sql = sql + advbal + ",";
					sql = sql + dectAmt + ",";
					sql = sql + Math.ceil(netPay) +",";
					sql = sql+ "'"+userId+"',";
					sql = sql+ "now(),'Y')";
					
					 
					advst.execute(sql);
					
					fline = fline + (i + 1) + "^";
					fline = fline + empid + "^";
					fline = fline + empname + "^";
					fline = fline + salary + "^";
					fline = fline + totalpresent + "^";
					fline = fline + lossday + "^";
					fline = fline + (int)extraloss + "^";
					fline = fline + lateday + "^";
					fline = fline + (double)(addedallowance) + "^";
					fline = fline + (double)(extraallowance) + "^";
					fline = fline + (int)grosspay + "^";
					fline = fline + (int)recovery + "^";
					fline = fline + (int)pfValue + "^";
					fline = fline + (int)esiValue + "^";
					fline = fline + messamt + "^";
					fline = fline + advamt + "^";
					fline = fline + dueamt + "^";
					fline = fline + advbal + "^";
					fline = fline + dectAmt + "^";
					fline = fline + Math.floor((int)netPay) + "\n";
					
					dueamt = 0;
					messamt = 0;
					pfValue = 0;
					esiValue = 0;
					recovery = 0;
					advamt = 0;
					dueamt = 0;
					advbal = 0;
					dectAmt = 0;
					lateday = 0;					
					i = i + 1;					
				}
				//System.out.println("END OF SAL CAL");

				String filename = "Report.sys";
				FileWriter fw = new FileWriter(filename);
				BufferedWriter bw = new BufferedWriter(fw);
				if (i < 1)
					fline = fline + "Record not found...^\n";
				bw.write(fline);
				bw.close();				
				session.setAttribute("Month", queryMonth);
				session.setAttribute("Year", queryYear);
				// -------------------------------
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			//System.out.println(e+"--"+e.getMessage());
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
	}

	
	
	
	
	
	private void detailedView(HttpServletRequest request,HttpServletResponse response, String SQL, String repName,String repHeader) throws IOException 
	{
		try 
			{
				
				HttpSession session=request.getSession();			
				String user=""+session.getAttribute("USRID");//System.out.println(user);
				Statement st = con.createStatement();
				sql = SQL;
				workingday = wrkDays;
				fline = "";
				fline = fline + repName + "\n";
				fline = fline + repHeader + "\n";
				ResultSet rs = st.executeQuery(sql);
				int i = 0;
				String empid = "-";
				String empname = "-";
				String salary = "0";
				String totalpresent = "0";
				int exlDays = 0;
				String lossday = "0";;
				String lateday = "0";;
				String pfValue = "0";;
				String esiValue = "0";;
				String messamt = "0";;
				String advamt = "0";;
				String dueamt = "0";;
				String advbal = "0";;
				String gpay="0";
				int othrs=0;
				double otamt=0.0;
				double sum=0.0;
				String sql="";
				String sallowansql="";
				String srecoverysql="";
				String insertsql="";
				sql = "SELECT CHR_ANAME,CHR_FLAG FROM pay_m_allowance";
				String aname[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con,sql);
				for(int a=0;a<aname.length;a++)
					sallowansql =sallowansql+aname[a][0]+" , ";
				
				sql = "SELECT CHR_RNAME FROM pay_m_recovery";
				String rname[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con,sql);
				for(int a=0;a<rname.length;a++)
					srecoverysql =srecoverysql+rname[a][0]+" , ";
				
				while (rs.next()) 
				{

					insertsql="";
					empid = rs.getString("CHR_EMPID");
					empname = rs.getString("CHR_STAFFNAME");
					salary = rs.getString("INT_BASIC");
					totalpresent = rs.getString("INT_TOTDAYS");
					exlDays = rs.getInt("INT_ELDAYS");
					lossday = rs.getString("CUR_ELAMT");
					lateday = rs.getString("INT_LATEAMT");
					pfValue = rs.getString("INT_PF");
					esiValue = rs.getString("INT_ESI");
					messamt = rs.getString("INT_MESS");
					advamt = rs.getString("INT_TOTADV");
					dueamt = rs.getString("INT_ADVREV");
					advbal = rs.getString("INT_ADVLEFT");
					gpay = rs.getString("CUR_GROSSPAY");
					////System.out.println(empid);
	
					// ALLOWANCE FROM PAY_T_SALARYALLOWANCE
					
					String sqlAllTran = "SELECT * FROM pay_t_salaryallowance ";
					sqlAllTran = sqlAllTran + " WHERE CHR_EMPID='" + empid + "'";
					sqlAllTran = sqlAllTran + " AND CHR_MONTH='" + queryMonth+ "' ";
					sqlAllTran = sqlAllTran + " AND INT_YEAR=" + year;
					String ssql = "SELECT count(*) FROM pay_t_salaryallowance ";
					ssql = ssql + " WHERE CHR_EMPID='" + empid + "'";
					ssql = ssql + " AND CHR_MONTH='" + queryMonth+ "' ";
					ssql = ssql + " AND INT_YEAR=" + year;
					String avalue[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con,sqlAllTran);
					String avalues="";
					String sqlavalues="";
					double addedallowance=0.0;
					double extraallowance=0.0;
					if(com.my.org.erp.common.CommonFunctions.RecordExist(con, ssql))
					{	
						for(int f=0;f<aname.length;f++)
						{
							if("Y".equals(aname[f][1]))
								
								addedallowance = addedallowance+Double.parseDouble(avalue[0][(f+1)]);
							else
								extraallowance = extraallowance+Double.parseDouble(avalue[0][(f+1)]);
							avalues = avalues+avalue[0][(f+1)]+"^"; 
							sqlavalues = sqlavalues+avalue[0][(f+1)]+" , ";
						}
					}
					else
					{
						for(int f=0;f<aname.length;f++)
						{	
							avalues = avalues+"0"+"^";
							sqlavalues = sqlavalues+"0"+" , ";
						}	
					}
					
					
					int sal = (int) Double.parseDouble(salary);
					int late = (int) Double.parseDouble(lateday);
					int exloss = (int) Double.parseDouble(lossday);
					
					if( CommonFunctions.RecordExist(con,"SELECT count(*)INT_MINS FROM att_t_ot WHERE CHR_EMPID='"+empid+"' AND CHR_MONTH='"+queryMonth+"' AND INT_YEAR= "+queryYear))
					{
						String otdata[][]= CommonFunctions.intRecordSetArray(con,"SELECT INT_MINS FROM att_t_ot WHERE CHR_EMPID='"+empid+"' AND CHR_MONTH='"+queryMonth+"' AND INT_YEAR= "+queryYear);
						othrs = Integer.parseInt(otdata[0][0])/60;
						int totalhrs = (wrkDays)*8;
						otamt =(sal/totalhrs)*othrs;
						otamt = Math.floor(otamt);
					}
					else
					{
						othrs = 0;
						otamt = 0;
					}
					
					double grosspay = (sal + addedallowance+otamt) - (late + exloss);

					
					
					
					int recovery=0;
					double recvalue=0.0;
					String sqlRecTran = "SELECT * FROM pay_t_salaryrecovery ";
					sqlRecTran = sqlRecTran + " WHERE CHR_EMPID='" + empid + "'";
					sqlRecTran = sqlRecTran + " AND CHR_MONTH='" + queryMonth+ "' ";
					sqlRecTran = sqlRecTran + " AND INT_YEAR=" + year;
					ssql = "SELECT count(*) FROM pay_t_salaryrecovery ";
					ssql = ssql + " WHERE CHR_EMPID='" + empid + "'";
					ssql = ssql + " AND CHR_MONTH='" + queryMonth+ "' ";
					ssql = ssql + " AND INT_YEAR=" + year;
					String rvalues="";
					String sqlrvalues="";
					String rvalue[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con,sqlRecTran);
					if(com.my.org.erp.common.CommonFunctions.RecordExist(con, ssql))
					{	
						for(int u=0;u<rname.length;u++)
						{	
							recvalue = recvalue+Math.round(Double.parseDouble(rvalue[0][(u+1)]));
							rvalues = rvalues+Math.round(Double.parseDouble(rvalue[0][(u+1)]))+"^";
							sqlrvalues = sqlrvalues+Math.round(Double.parseDouble(rvalue[0][(u+1)]))+" ,";
						}	
					}
					else
					{
						for(int u=0;u<rname.length;u++)
						{	
							rvalues = rvalues+"0"+"^";;
							sqlrvalues = sqlrvalues+"0"+" , ";;
						}	
					}
					recovery=(int)recvalue;
					
					 
					
					onedaysal = (int) Double.parseDouble(salary) / workingday;
					if (exlDays < 0)
						extraloss = onedaysal * exlDays * -1;
					else
						extraloss = onedaysal * exlDays;
					
					// GROSS PAY CALCULATION
					// extraloss=onedaysal*lossday *-1;
					dectAmt = recovery + (int) Double.parseDouble(pfValue)
							+ (int) Double.parseDouble(esiValue)
							+ (int) Double.parseDouble(messamt)
							+ (int) Double.parseDouble(dueamt);
					netPay = grosspay - dectAmt;
					//salarytype
					double CompanyPF1=(double)Double.parseDouble(salary)*(cpypension/100);
					CompanyPF1=Math.round(CompanyPF1);
					double CompanyPF2=(double)Double.parseDouble(salary)*(cpypf/100);
					CompanyPF2=Math.round(CompanyPF2);
					double CompanyESI=(double)Double.parseDouble(gpay)*(cpyesi/100);
					CompanyESI=Math.round(CompanyESI);
					//fline = fline + CompanyPF+"^";
				//PF^ESI^Loss of Day^OT in Hrs^ OT Amount^E/LD^E/LP^
				//Mess Amount^Advance Total^Advance Detection^A
				//dvance Left^Detection^NetPay^MonthPay^CpyPF1^CpyPF2^CpyESI^SUM^CTC";
					
					 
					 
					insertsql = " DELETE FROM pay_t_salary WHERE CHR_EMPID='"+empid+"'";
					insertsql=insertsql+" AND INT_YEAR="+year;
					insertsql=insertsql+" AND CHR_MONTH='"+queryMonth+"'";
					Statement sst = con.createStatement();
					sst.execute(insertsql);
					sst.close();
					 
					insertsql=""; 
					insertsql=insertsql+" INSERT INTO pay_t_salary VALUES (";
					insertsql=insertsql+"'"+empid+"' ,";
					insertsql=insertsql+"'"+empname+"' ,";
					insertsql=insertsql+year+",";
					insertsql=insertsql+"'"+queryMonth+"' ,";
					insertsql=insertsql+totalpresent+",";
					insertsql=insertsql+salary+",";
					insertsql=insertsql+sqlavalues ;
					insertsql=insertsql+Math.round(addedallowance)+"," ;
					insertsql=insertsql+Math.round(extraallowance)+"," ;
					insertsql=insertsql+Math.round(Double.parseDouble(gpay))+"," ;
					insertsql=insertsql+sqlrvalues ;
					insertsql=insertsql+Math.round(recovery)+",";
					insertsql=insertsql+Math.round(Double.parseDouble(pfValue))+",";
					insertsql=insertsql+Math.round(Double.parseDouble(esiValue))+",";
					insertsql=insertsql+exlDays+",";
					insertsql=insertsql+othrs+",";
					insertsql=insertsql+lateday+",";
					insertsql=insertsql+Math.round(extraloss )+",";
					insertsql=insertsql+Math.round(Double.parseDouble(messamt))+",";
					insertsql=insertsql+Math.round(Double.parseDouble(advamt))+",";
					insertsql=insertsql+Math.round(Double.parseDouble(dueamt))+",";
					insertsql=insertsql+Math.round(Double.parseDouble(advbal))+",";
					insertsql=insertsql+Math.round(dectAmt)+",";
					insertsql=insertsql+Math.round(netPay)+",";
					insertsql=insertsql+Math.round(netPay+extraallowance)+",";
					insertsql=insertsql+Math.round(CompanyPF1)+",";
					insertsql=insertsql+Math.round(CompanyPF2)+",";
					insertsql=insertsql+Math.round(CompanyESI)+",";
					insertsql=insertsql+Math.round(CompanyPF1+CompanyPF2+CompanyESI)+",";
					insertsql=insertsql+Math.round(Double.parseDouble(gpay)+CompanyPF1+CompanyPF2+CompanyESI)+", ";
					insertsql=insertsql+"'"+user+"' , now(),'Y')";
					Statement ssst = con.createStatement();
					ssst.execute(insertsql);
					ssst.close();
					////System.out.println(insertsql);
					
					fline = fline + (i + 1) + "^";
					fline = fline + empid + "^";
					fline = fline + empname + "^";
					fline = fline + totalpresent + "^";
					fline = fline + salary + "^";
					fline = fline +avalues;
					fline = fline +Math.round(addedallowance)+"^";
					fline = fline +Math.round(extraallowance)+"^";
					//fline = fline +Math.round(addedallowance+extraallowance) + "^";
					fline = fline + Math.round(Double.parseDouble(gpay)) + "^";
					fline = fline + rvalues ;
					fline = fline + Math.round(recovery) + "^";
					fline = fline + Math.round(Double.parseDouble(pfValue)) + "^";
					fline = fline + Math.round(Double.parseDouble(esiValue)) + "^";
					fline = fline + othrs + "^";
					fline = fline + Math.round( (otamt)) + "^";
					fline = fline + exlDays + "^";
					fline = fline + Math.round(extraloss )+ "^";
					fline = fline + lateday + "^";
					fline = fline + Math.round(Double.parseDouble(messamt)) + "^";
					fline = fline + Math.round(Double.parseDouble(advamt)) + "^";
					fline = fline + Math.round(Double.parseDouble(dueamt)) + "^";
					fline = fline + Math.round(Double.parseDouble(advbal)) + "^";
					fline = fline + Math.round(dectAmt) + "^";
					fline = fline + Math.round(netPay) + "^ ";
					fline = fline + Math.round(netPay+extraallowance) + "^";
					fline = fline + Math.round(CompanyPF1)+"^";
					fline = fline + Math.round(CompanyPF2)+"^";
					fline = fline + Math.round(CompanyESI)+"^";
					fline = fline + Math.round(CompanyPF1+CompanyPF2+CompanyESI)+"^";
					fline = fline + Math.round(Double.parseDouble(gpay)+CompanyPF1+CompanyPF2+CompanyESI)+"^\n";
					sum = sum+Math.round(netPay);
					i = i + 1;
				}
				
				//fline = fline+"^^^^^^^^^^^^^^^^^^^^^^Total sum :: &nbsp;&nbsp;&nbsp;&nbsp;Rs."+sum+"^";
				String s="../webapps/SmartCampus/SalaryReport/"+queryMonth+"_"+year+".sys";
				FileWriter rfw = new FileWriter(s);
				BufferedWriter rbw = new BufferedWriter(rfw);
				if (i < 1)
					fline = fline + "Record not found...^\n";
				rbw.write(fline);
				rbw.close();
				
				
				String q= " select sum(DOU_BASIC),sum(DOU_MONTHSAL),sum(DOU_CPYPF1),sum(DOU_CPYPF2),sum(DOU_CPYESI),sum(DOU_SUM),sum(DOU_CTC) from pay_t_salary "; 
				q = q+ " where INT_YEAR="+year;
				q = q+ " AND CHR_MONTH='"+queryMonth+"'";
				String salar[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(q);
				if(salar.length>0)
				{
					q = "\n Basic Salary :"+salar[0][0];
					q =q+"\n Month Salary :"+salar[0][1];
					q =q+"\n Company PF-1  :"+salar[0][2];
					q =q+"\n Company PF-2 :"+salar[0][3];
					q =q+"\n Company ESI :"+salar[0][4];
					q =q+"\n SUM :"+salar[0][5];
					q =q+"\n CTC :"+salar[0][0];
					
				}
							
				com.my.org.erp.General.General.SimpleMail( CommonData.mailid,  CommonData.mailid, " SALARY",q);
				//com.my.org.erp.General.General.SendMail("SALARY", s);
				String filename = "SReport.sys";
				FileWriter fw = new FileWriter(filename);
				BufferedWriter bw = new BufferedWriter(fw);
				if (i < 1)
					fline = fline + "Record not found...^\n";
				bw.write(fline);
				bw.close();
				session = request.getSession();
				session.setAttribute("Month", queryMonth);
				session.setAttribute("Year", queryYear);
				// -------------------------------
			} catch (Exception e) {
				 System.out.println(e.getMessage());
				response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			}
	}
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
			try 
			{
				String dId = null;
				String action = ""+request.getParameter("actionS");
				String type = ""+request.getParameter("CalculationNPF").trim();
				String repType = ""+request.getParameter("reportType");
				//System.out.println("CONTROL FROM SALARY CALCULATION ::" + action);
				
				String ssql="SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,CHR_SALARY FROM m_institution WHERE INT_ID=1";
				String basicdata[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con, ssql);
				cpypf=Double.parseDouble(basicdata[0][2]);
				cpypension=Double.parseDouble(basicdata[0][3]);
				cpyesi=Double.parseDouble(basicdata[0][4]);
				salarytype=basicdata[0][5];
				
				//cpypf,cpypension,cpyesi,salarytype
				
				if (repType.equals("Month")) 
				{
					month = request.getParameter("Month");
					year = request.getParameter("Year");
					wrkDays = DateUtil.totalDays(Integer.parseInt(month), Integer.parseInt(year));
					repName = "SALARY CALCULATION ";
					repName = repName + " ( " + DateUtil.getMonth(Integer.parseInt(month)) + " - ";
					repName = repName + year + " ) ";
					queryMonth = DateUtil.getMonth(Integer.parseInt(month));
					queryYear = year;
				} 
				String deptId = request.getParameter("Department");
				dId = deptId;
				if (deptId.equals("-1")) 
				{
					HttpSession session = request.getSession();
					@SuppressWarnings("rawtypes")
					java.util.ArrayList departmentList = (java.util.ArrayList) session.getAttribute("departmentList");
					for (int i = 0; i < departmentList.size(); i++) 
					{
						com.my.org.erp.bean.Department depart = (com.my.org.erp.bean.Department) departmentList.get(i);
						deptId = deptId + "," + depart.getDepartId();
					}
				}
				
				repHeader = "S.No^Emp Id^EmpName^BPay^WD^ELD^ELP^L D^AddedAllo^ExtraAllow^GPay^Recv^PF^ESI^Mess^ATot^ADec^ALeft^Dect^NetPay";
				sql = "SELECT A.*,B.*";
				sql = sql + " FROM  com_m_staff  A,ATT_T_ATTENDANCEDETAIL B ";
				sql = sql + " WHERE A.CHR_EMPID=B.CHR_EMPID ";
				sql = sql + " AND B.LOGMONTH='" + queryMonth + "' ";
				sql = sql + " AND B.LOGYEAR=" + Integer.parseInt(queryYear);
				sql = sql + " AND A.INT_SALARY >0  AND CHR_TYPE !='T' ";
				sql = sql + " AND A.INT_DEPARTID IN (" + deptId + ") ORDER BY A.CHR_STAFFNAME";
				 
				////System.out.println("SQL :"+sql);
				if (action.equals("PAYSalaryCalculationNPF")&&type.equals("Calculate")) 
				{
					 
					doCalculation(request, response, sql, repName, repHeader);
					 
					con.close();    
					response.sendRedirect("Smart Payroll/PayrollAllowanceUpdate.jsp?Month="+month+"&Year="+year);
					 
				}
				else if (action.equals("PAYSalaryCalculationNPF")&&type.equals("SalaryUpdate")) 
				{
					doCalculation(request, response, sql, repName, repHeader);
					con.close();    
					response.sendRedirect("Smart Payroll/ReportSalary.jsp?depid="+ dId + "&month=" + month);
				}
				else if (action.equals("PAYSalaryCalculationNPF")&& type.equals("Detailed View")) 
				{
					sql = "SELECT CHR_ANAME FROM pay_m_allowance";
					String aname[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
					String allowancecolumn="";
					for(int u=0;u<aname.length;u++)
						allowancecolumn=allowancecolumn+aname[u][0]+"^";
					sql = "SELECT CHR_RNAME FROM pay_m_recovery";
					String rname[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
					String recoverycolumn="";
					for(int u=0;u<rname.length;u++)
						recoverycolumn=recoverycolumn+rname[u][0]+"^";
					sql = "Select A.*,B.* from pay_t_nsalarydetailspf A, com_m_staff  B";
					sql = sql + " WHERE A.CHR_EMPID=B.CHR_EMPID ";
					sql = sql + " AND A.CHR_MONTHS='" + queryMonth + "' ";
					sql = sql + " AND A.INT_YEAR='" + queryYear + "'";
					sql = sql + " AND B.INT_DEPARTID IN (" + deptId + ") ORDER BY b.CHR_STAFFNAME";
					repHeader = "S.No^Emp Id^EmpName^Working Days^Basic Salary^"+allowancecolumn+"Allowance Total1^Allowance Total2^Grosspay Pay^"+recoverycolumn+"Recovery Total^PF^ESI^Loss of Day^OT in Hrs^ OT Amount^E/LD^E/LP^Mess Amount^Advance Total^Advance Detection^Advance Left^Detection^NetPay^MonthPay^CpyPF1^CpyPF2^CpyESI^SUM^CTC";
					detailedView(request, response, sql, repName, repHeader);
					con.close();    
					response.sendRedirect("Smart Payroll/ReportPrint.jsp?flag=Y&month="+queryMonth+"&year="+queryYear);
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
