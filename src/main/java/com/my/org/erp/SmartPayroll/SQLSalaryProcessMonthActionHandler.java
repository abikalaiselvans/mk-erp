	package com.my.org.erp.SmartPayroll;


import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.SmartAttendance.AttendanceFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class SQLSalaryProcessMonthActionHandler extends AbstractActionHandler 
{ 

	Statement st, pfesist, messst, advst,allnost;
	ResultSet rs, allrs, recrs, pfesirs, messrs, advrs,allnors;
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			String loginempid = (String) session.getAttribute("EMPID");
 			String bsql="SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,CHR_SALARY,CHR_PAYTAXDEDUCTION,CHR_PAYTAXVALUE,INT_PFLIMIT,INT_ESILIMIT,CHR_TAXDEDUCTIONEMP,INT_PFLIMITMINIMUM FROM m_institution WHERE INT_ID=1";
			String basicdata[][] =  CommonFunctions.RecordSetArray(con, bsql);
			double cpypension=Double.parseDouble(basicdata[0][3]);
			double dbpflimit=Double.parseDouble(basicdata[0][8]);
			double dbminimumpflimit=Double.parseDouble(basicdata[0][11]);
			String sql="";
			
			int noofdaysinamonth=0;
			 
			String attendanceTable="";
 			if ("PAYSalary".equals(action)) 
			{
	 				
 				System.out.println("==========================");
 				System.out.println("SALARY PROCESSING START");
 				String month=request.getParameter("Month");
 				String mon= DateUtil.getMonth(Integer.parseInt(month));
 				String year=request.getParameter("Year");
 				String Office=request.getParameter("Office");
 				String dept=request.getParameter("dept");
 				String Category=request.getParameter("Category");
 				String attendancecheck=request.getParameter("attendancecheck");
 				if(!"Y".equals(attendancecheck))
 					attendancecheck ="N";
 				String attendancecycle=request.getParameter("attendancecycle");
 				
 				if("1".equals(attendancecycle))
 					attendanceTable = " att_t_register ";
 				else
 					attendanceTable=" att_t_register_cycle2 ";
 						
 				
 				
 				//Record is available or Not
 				sql=" SELECT COUNT(*) ";
				sql=sql+" FROM "+attendanceTable+" a ,com_m_staff b , pay_t_salarybasic c";
				sql = sql+" WHERE a.DOU_TOTALDAYS >0 AND a.CHR_MONTH='"+mon+"' ";
				sql = sql+" AND a.INT_YEAR= "+year;
				sql = sql+" AND a.CHR_EMPID=b.CHR_EMPID AND a.CHR_EMPID=c.CHR_EMPID  ";
				sql = sql+" AND c.CHR_MONTH='"+mon+"' "; 
				sql = sql+" AND c.INT_YEAR=  "+year;
				if("1".equals(attendancecycle))
					sql = sql+" AND b.INT_ATTENDANCECYCLE =1 ";
				else
					sql = sql+" AND b.INT_ATTENDANCECYCLE =2 ";
				sql = sql+" AND b.DT_DOJCOLLEGE<='"+year+"-"+month+"-31"+"'";
				if(!"0".equals(dept))
					sql = sql+" AND b.INT_DEPARTID="+dept +" ";
 				if(!"0".equals(Office))
					sql = sql+" AND b.INT_OFFICEID="+Office +" ";  
				if(!"0".equals(Category))
					sql = sql+" AND b.CHR_CATEGORY='"+Category +"' "; 
				sql = sql+" ORDER BY b.CHR_STAFFNAME " ;
				System.out.println(sql+"\n");
				boolean flag = CommonFunctions.RecordExist(con, sql);
				
			 	
				boolean  attflag  = false;
				if("Y".equals(attendancecheck))
				{	
					sql = " SELECT a.CHR_EMPID  ";
					sql = sql+" FROM "+attendanceTable+" a ,com_m_staff b , pay_t_salarybasic c";
					sql = sql+" WHERE a.DOU_TOTALDAYS >0 AND a.CHR_MONTH='"+mon+"' ";
					sql = sql+" AND a.INT_YEAR= "+year;
					sql = sql+" AND a.CHR_EMPID=b.CHR_EMPID AND a.CHR_EMPID=c.CHR_EMPID  ";
					sql = sql+" AND c.CHR_MONTH='"+mon+"' "; 
					sql = sql+" AND c.INT_YEAR=  "+year;
					if("1".equals(attendancecycle))
						sql = sql+" AND b.INT_ATTENDANCECYCLE =1 ";
					else
						sql = sql+" AND b.INT_ATTENDANCECYCLE =2 ";
					
					sql = sql+" AND b.DT_DOJCOLLEGE<='"+year+"-"+month+"-31"+"'";
					if(!"0".equals(dept))
						sql = sql+" AND b.INT_DEPARTID="+dept +" ";
	 				if(!"0".equals(Office))
						sql = sql+" AND b.INT_OFFICEID="+Office +" ";  
					if(!"0".equals(Category))
						sql = sql+" AND b.CHR_CATEGORY='"+Category +"' "; 
					sql = sql+" ORDER BY b.CHR_STAFFNAME " ;
					String attendanceData[][] = CommonFunctions.QueryExecute(sql);
					attflag = AttendanceFunctions.attendanceRegisterCheck(con, Integer.parseInt(month), year, attendanceData);
				}
				else
				{
					attflag =true;
				}
				
				
				
				if(attflag)
				{
					if(flag)
	 				{
						
						
						if("1".equals(attendancecycle))
							noofdaysinamonth=Integer.parseInt( CommonFunctions.QueryExecute(" SELECT day(last_day('"+year+"-"+month+"-12' )) ")[0][0]);
						else
							noofdaysinamonth=Integer.parseInt( CommonFunctions.QueryExecute("SELECT FUN_PAY_SALARY_NOOFDAYSINAMONTH('"+year+"','"+month+"') ")[0][0]);
						
						String salsql = "";
						String BASIC ="";
						String grossfield="";
						String extrafield ="";
						String GROSS ="";
						String recoveryfield ="";
						salsql = " SELECT a.CHR_EMPID,b.CHR_STAFFNAME, ";
						salsql = salsql + "b.INT_COMPANYID,b.INT_BRANCHID,  "; 
						salsql = salsql + " b.INT_DEPARTID,b.INT_DESIGID,b.INT_OFFICEID, ";
						salsql = salsql + " b.CHR_BANK,b.CHR_ACCNO ,c.CHR_PF,c.CHR_ESI, ";
						salsql = salsql + " a.DOU_TOTALDAYS ,";
						
						//Basic
						BASIC =" (c.INT_SALARY - ((c.INT_SALARY/"+noofdaysinamonth+")* a.DOU_ABSENT)) "; 
						salsql = salsql + " ROUND("+BASIC+"  , 2 ) basic, ";
						
						 
						
		 				sql = "SELECT CHR_ACODE,CHR_FLAG FROM pay_m_allowance ORDER BY INT_ALLOWANCEID ";
		 				String aname[][] =  CommonFunctions.RecordSetArray(con,sql);
		 				grossfield =" ";
		 				extrafield =" ";
		 				for(int a=0;a<aname.length;a++)
		 				{
		 					//Allowance field
		 					salsql = salsql + " ROUND( ("+aname[a][0]+" - (("+aname[a][0]+"/"+noofdaysinamonth+")* a.DOU_ABSENT)) , 2 ) A"+(a+1)+", ";
		 					
		 					//Gross Field 
		 					if("Y".equals(aname[a][1] ))
		 						grossfield = grossfield + "("+aname[a][0]+" - (("+aname[a][0]+"/"+noofdaysinamonth+")* a.DOU_ABSENT)) + ";
		 					
		 					if("N".equals(aname[a][1] ))
		 						extrafield = extrafield + "("+aname[a][0]+" - (("+aname[a][0]+"/"+noofdaysinamonth+")* a.DOU_ABSENT)) + ";
		 				}
		 				grossfield = grossfield + "  0  ";
		 				extrafield = extrafield + "  0  "; 	
		 				GROSS = "( "+  BASIC +" +  " + grossfield + ")  ";
		 				
		 				// ADDED ALLOWANCE 
		 				salsql = salsql + "ROUND( ("+grossfield+") ,2) addedallowance , ";
		 				
		 				// EXTRA ALLOWANCE 
		 				salsql = salsql + "ROUND( ("+extrafield+") ,2) extraallowance , ";
		 				
		 				//GROSS
		 				salsql = salsql + "ROUND( "+GROSS +" ,2) gross , ";
						
		 				
		 				 
		 				//Recovery
		 				sql = "SELECT CHR_RCODE FROM pay_m_recovery ORDER BY INT_RECOVERYID";
		 				String rname[][] =  CommonFunctions.RecordSetArray(con,sql);
		 				recoveryfield ="";
		 				for(int a=0;a<rname.length;a++)
		 				{
		 					//Recovery field
		 					//salsql = salsql + " ROUND( ("+rname[a][0]+" - (("+rname[a][0]+"/"+noofdaysinamonth+")* a.DOU_ABSENT)) , 2 ) R"+(a+1)+", ";
		 					salsql = salsql + " ROUND(  "+rname[a][0]+"  , 2 ) R"+(a+1)+", ";
		 					
		 					//Recovery Sum
		 					//recoveryfield = recoveryfield + "("+rname[a][0]+" - (("+rname[a][0]+"/"+noofdaysinamonth+")* a.DOU_ABSENT)) + ";
		 					recoveryfield = recoveryfield + "  ("+rname[a][0]+") + ";
		 					
		 				}
		 				recoveryfield = recoveryfield + "  0  ";
		 				
		 				// RECOVERY 
		 				salsql = salsql + "ROUND( ("+recoveryfield+") ,2) RValues , ";
		 				
		 				//PF
		 				salsql = salsql + " if(c.CHR_PF ='C', FUN_GET_PFAMOUNT (c.CHR_PF,( "+BASIC+" )), ";
		 				salsql = salsql + "  if(c.CHR_PF ='Y',c.INT_PFAMT,'0') ";
		 				salsql = salsql +" 	  ) PFvalue, ";
		 					  
		 				 	  
		 					  
		 				salsql = salsql +" 	if(c.CHR_ESI ='C', FUN_GET_ESIAMOUNT('STAFF' , c.CHR_ESI ,ROUND( "+GROSS+" ,2) ),";  
		 				salsql = salsql +" 	if(c.CHR_ESI ='Y',c.INT_ESIAMT,'0') ) ESIvalue, ";
		 				
		 				salsql = salsql +" 	FUN_PAY_SALARY_ADVANCE(a.CHR_EMPID,'"+mon+"','"+year+"') advance, "; 

		 				
		 				//totalrecovery
		 				
		 				salsql = salsql +" 	 ROUND( ("+recoveryfield+") + ";
		 				salsql = salsql +" 	if(c.CHR_PF ='C', FUN_GET_PFAMOUNT (c.CHR_PF,(  "+BASIC+" )), if(c.CHR_PF ='Y',c.INT_PFAMT,'0')  ) + ";
		 				salsql = salsql +" 	if(c.CHR_ESI ='C', FUN_GET_ESIAMOUNT('STAFF' , c.CHR_ESI ,ROUND( "+GROSS+" ,2) ), ";  
		 				salsql = salsql +" 	if(c.CHR_ESI ='Y',c.INT_ESIAMT,'0')    ";
		 				salsql = salsql +" 	 )  ,2) totalrecovery  , ";
		 				
		 				salsql = salsql +" 	ROUND( FUN_PAY_SALARY_PROFESSIONAL_TAX(a.CHR_EMPID ,"+GROSS+",'"+mon+"','"+year+"') ,2)   professionaltax,   ";
		 				
		 				salsql = salsql +" 	ROUND(  ";
		 				salsql = salsql +" 		     if(c.CHR_PF ='C',  "; 
		 				salsql = salsql +" 		     FUN_GET_COMPANY_PF1_AMOUNT (c.CHR_PF, ("+BASIC+")),  ";
		 				salsql = salsql +" 		  if(c.CHR_PF ='Y',(c.INT_PFAMT*3.67/100),'0')  ";
		 				salsql = salsql +" 		  )  ";
		 				salsql = salsql +" 		,2)   CompanyPF1,  ";

		 				salsql = salsql +" 	ROUND(  ";
		 				salsql = salsql +" 		     if(c.CHR_PF ='C',  "; 
		 				salsql = salsql +" 		     FUN_GET_COMPANY_PF1_AMOUNT (c.CHR_PF, ("+BASIC+")),  ";
		 				salsql = salsql +" 		  if(c.CHR_PF ='Y',(c.INT_PFAMT*8.33/100),'0')  ";
		 				salsql = salsql +" 		  )  ";
		 				salsql = salsql +" 		,2)   CompanyPF2,  ";

		 				salsql = salsql +" ROUND(    ";
		 				salsql = salsql +"         if(c.CHR_ESI ='C',   ";
		 				salsql = salsql +"              FUN_GET_ESIAMOUNT('CPY' , c.CHR_ESI ,  "; 
		 				salsql = salsql +"                                         ROUND( "+GROSS+"  ,2)    ";
		 				salsql = salsql +"                                        ),  ";
		 				salsql = salsql +"           if(c.CHR_ESI ='Y',c.INT_ESIAMT,'0')  ";
		 				salsql = salsql +"            )"; 
		 				salsql = salsql +"  ,2) CompanyESI   ,  ";
		 				salsql = salsql +"   a.DOU_ABSENT absent , ";
		 				salsql = salsql +" 	ROUND(FUN_PAY_GET_ORIGINAL_CTC (a.CHR_EMPID),2) orginalctc ,";
		 				salsql = salsql +" 	 c.INT_SALARY basic  ";
		 				salsql = salsql +" FROM  "+attendanceTable+"  a ,com_m_staff b , pay_t_salarybasic c, pay_t_salaryallowance d,  ";
		 				salsql = salsql +" pay_t_salaryrecovery e  ";
		 				salsql = salsql +" WHERE a.DOU_TOTALDAYS >0   ";
		 				salsql = salsql +" AND a.CHR_EMPID = b.CHR_EMPID  ";
		 				salsql = salsql +" AND a.CHR_EMPID = d.CHR_EMPID  ";
		 				salsql = salsql +" AND a.CHR_EMPID = e.CHR_EMPID  ";
		 				salsql = salsql +" AND a.CHR_MONTH ='"+mon+"' ";
		 				salsql = salsql +" AND a.INT_YEAR = "+year;
		 				salsql = salsql +" AND c.CHR_MONTH = '"+mon+"' ";
		 				salsql = salsql +" AND c.INT_YEAR = "+year;
		 				salsql = salsql +" AND d.CHR_MONTH = '"+mon+"' "; 
		 				salsql = salsql +" AND d.INT_YEAR = "+year;
		 				salsql = salsql +" AND e.CHR_MONTH = '"+mon+"' ";
		 				salsql = salsql +" AND e.INT_YEAR= "+year;
		 				if("1".equals(attendancecycle))
		 					salsql = salsql+" AND b.INT_ATTENDANCECYCLE =1 ";
						else
							salsql = salsql+" AND b.INT_ATTENDANCECYCLE =2 ";
		 				salsql = salsql +" AND a.CHR_EMPID=c.CHR_EMPID  "; 
		 				salsql = salsql+" AND b.DT_DOJCOLLEGE<='"+year+"-"+month+"-31"+"'";
		 				if(!"0".equals(dept))
		 					salsql = salsql+" AND b.INT_DEPARTID="+dept +" ";
		 				if(!"0".equals(Office))
		 					salsql = salsql+" AND b.INT_OFFICEID="+Office +" ";  
						if(!"0".equals(Category))
							salsql = salsql+" AND b.CHR_CATEGORY='"+Category +"' "; 
						salsql = salsql+" ORDER BY b.CHR_STAFFNAME " ;
		 				
		 				 
						System.out.println();
						System.out.println("----------------");
						System.out.println(salsql);
						System.out.println("----------------");
						System.out.println();
						
						String attdata[][]= CommonFunctions.RecordSetArray(con, salsql);
						if(attdata.length<1)
							response.sendRedirect("Smart Payroll/Salary Process.jsp?er=Kindly migrate the Allowance and Recovery");
				 
						
						String id="";
						for(int v=0;v<attdata.length;v++)
							id =id+"'"+attdata[v][0].trim()+"' , ";
						asql = " DELETE FROM pay_t_salary WHERE CHR_MONTH='"+mon+"' AND INT_YEAR="+year;
						asql = asql +" AND CHR_EMPID IN ("+id+" '0' )";
						System.out.println(asql+"\n");
						apstm = con.prepareStatement(asql);
						apstm.execute();
					 
						 
						
						 
						 
						
						 
						String actualcompany="";
						String actualbranch="";
						String actualdepart="";
						String actualdesign="";
						String actualoffice="";
						String actualpftype="";
						String actualesitype="";
						String actualbank="";
						String actualaccountno="";
						String empid="";
						String empname="";
						double totaldays=0.0;
						double basic=0.0;
						double grosspay=0.0;
						double addedallowance=0.0;
						double extraallowance=0.0;
						double recvalue=0.0;
						double pfValue=0.0, esiValue=0.0;
						double mess=0.0,advance=0.0;
						double CompanyPF1=0.0;
						double CompanyPF2=0.0;
						double CompanyESI=0.0;
						double totalsal=0.0;
						double monthsal=0.0;
						double ctcsal=0.0;
						double totalrecovery=0.0;
						
						double absent=0.0;
						double originalbasic=0;
					 	double originalctc=0;
						double lop=0.0;
						double penbasic=0;
						double admincharge=0;
						double edli=0;
						double admincharge1=0;
						
						double pension=0;
						double taxvalue=0;
						pension=0;
						System.out.println("Total Employees :"+attdata.length);
						for(int v=0;v<attdata.length;v++)
						{

							empid=attdata[v][0].trim();
							empname= attdata[v][1];
							actualcompany=attdata[v][2];
							actualbranch=attdata[v][3];
							actualdepart=attdata[v][4];
							actualdesign=attdata[v][5];
							actualoffice=attdata[v][6];
							actualbank=attdata[v][7];
							actualaccountno=attdata[v][8];
							actualpftype=attdata[v][9];
							actualesitype=attdata[v][10];
							totaldays = Double.parseDouble(attdata[v][11]) ;
							basic = Double.parseDouble(attdata[v][12]) ;
							addedallowance = Double.parseDouble(attdata[v][28]) ;
							extraallowance = Double.parseDouble(attdata[v][29]) ;
							grosspay = Double.parseDouble(attdata[v][30]) ;
							recvalue= Double.parseDouble(attdata[v][39]) ;
							pfValue= Double.parseDouble(attdata[v][40]) ;
							esiValue= Double.parseDouble(attdata[v][41]) ;
							advance= Double.parseDouble(attdata[v][42]) ;
							totalrecovery= Double.parseDouble(attdata[v][43]) ;
							taxvalue= Double.parseDouble(attdata[v][44]) ;
							CompanyPF1= Double.parseDouble(attdata[v][45]) ;
							CompanyPF2= Double.parseDouble(attdata[v][46]) ;
							CompanyESI= Double.parseDouble(attdata[v][47]) ;
							absent= Double.parseDouble(attdata[v][48]) ;
							originalctc = Double.parseDouble(attdata[v][49]) ;
							originalbasic= Double.parseDouble(attdata[v][50]) ;
							
							totalrecovery=recvalue+pfValue+esiValue+taxvalue;
							totalsal=(grosspay-(recvalue+pfValue+esiValue+mess+advance+taxvalue));
							monthsal=((grosspay-(recvalue+pfValue+esiValue+mess+advance+taxvalue))+extraallowance);
							ctcsal=(grosspay+CompanyPF1+CompanyPF2+CompanyESI);
							lop = (originalctc-ctcsal);
							
							
							penbasic=0;admincharge=0;edli=0;admincharge1=0;pension=0;
							if(!actualpftype.equals("N"))
							{
								
								if(originalbasic<dbminimumpflimit)
								{
									penbasic = dbminimumpflimit;//3200 changed to month basic
									penbasic =( dbminimumpflimit-( (dbminimumpflimit/noofdaysinamonth)*absent));
									pension = (( dbminimumpflimit-((dbminimumpflimit/noofdaysinamonth)*absent) )  *cpypension/100);
								 
								}
								else
								{
									if(basic>dbpflimit)
									{
										penbasic = dbpflimit; 
										pension = (dbpflimit*cpypension/100); 
									}
									else
									{
									
										penbasic = (basic); 
										pension =(basic*cpypension/100);
									}
								}
								
								 
								if(pfValue>=0)
								{
									admincharge =penbasic*(1.1/100);
									edli =penbasic*(0.5/100);
									admincharge1 =(penbasic*(0.01/100));
								}
							}
							else
							{
								penbasic=0;admincharge=0;edli=0;admincharge1=0;pension=0;
							}
							
							
							sql = "INSERT INTO pay_t_salary VALUES";
							sql=sql+"(";
							sql=sql+"'"+empid+"' , ";
							sql=sql+"'"+empname+"' , ";
							sql=sql+"'"+mon+"' , ";
							sql=sql+year+" , ";
							sql=sql+attendancecycle+" , ";
							sql=sql+"  "+actualcompany+"  , ";
							sql=sql+"  "+actualbranch+"  , ";
							sql=sql+"  "+actualdepart+"  , ";
							sql=sql+"  "+actualdesign+"  , ";
							sql=sql+"  "+actualoffice+"  , ";
							sql=sql+"  '"+actualbank+"'  , ";
							sql=sql+"  '"+actualaccountno+"'  , ";
							sql=sql+"'"+actualpftype+"' , ";
							sql=sql+"'"+actualesitype+"' , ";
							sql=sql+noofdaysinamonth+" , ";
							sql=sql+totaldays+" , ";
							sql=sql+basic+" , ";
							sql=sql+attdata[v][13]+" , ";
							sql=sql+attdata[v][14]+" , ";
							sql=sql+attdata[v][15]+" , ";
							sql=sql+attdata[v][16]+" , ";
							sql=sql+attdata[v][17]+" , ";
							sql=sql+attdata[v][18]+" , ";
							sql=sql+attdata[v][19]+" , ";
							sql=sql+attdata[v][20]+" , ";
							sql=sql+attdata[v][21]+" , ";
							sql=sql+attdata[v][22]+" , ";
							sql=sql+attdata[v][23]+" , ";
							sql=sql+attdata[v][24]+" , ";
							sql=sql+attdata[v][25]+" , ";
							sql=sql+attdata[v][26]+" , ";
							sql=sql+attdata[v][27]+" , ";
							sql=sql+addedallowance+" , ";
							sql=sql+extraallowance+" , ";
							sql=sql+grosspay+" , ";
							sql=sql+attdata[v][31]+" , ";
							sql=sql+attdata[v][32]+" , ";
							sql=sql+attdata[v][33]+" , ";
							sql=sql+attdata[v][34]+" , ";
							sql=sql+attdata[v][35]+" , ";
							sql=sql+attdata[v][36]+" , ";
							sql=sql+attdata[v][37]+" , ";
							sql=sql+attdata[v][38]+" , ";
							sql=sql+recvalue+",";
							sql=sql+(pfValue)+",";//Math.round
							sql=sql+(esiValue)+",";//Math.round
							sql=sql+mess+",";
							sql=sql+advance+",";
							
							
							sql=sql+totalrecovery+",";
							
							sql=sql+totalsal+",";
							sql=sql+monthsal+",";
							sql=sql+CompanyPF1+",";
							sql=sql+CompanyPF2+",";
							sql=sql+CompanyESI+",";
							sql=sql+(CompanyPF1+CompanyPF2+CompanyESI)+",";
							sql=sql+ctcsal+",";
							sql=sql+originalctc+"," ;
							sql=sql+absent+"," ;
							sql=sql+lop+"," ;
							sql=sql+penbasic+"," ;
							sql=sql+(pfValue-Math.round(pension))+"," ;//3.67=12%-8.33%
							sql=sql+Math.round(pension)+"," ;
							sql=sql+admincharge+"," ;
							sql=sql+edli+"," ;
							sql=sql+admincharge1+"," ;
							sql=sql+taxvalue+"," ;
							sql=sql+" null,'0',null,null,'"+loginempid+"' ,'"+userid+"' , DATE(NOW()),'Y' ";
							sql=sql+")";
							apstm = con.prepareStatement(sql);
							//System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							System.out.println("Emp id : " +empid +" / "+ v+" @ "+ attdata.length);
							 
						
						}
						con.close(); 
						response.sendRedirect("Smart Payroll/Salary Report.jsp?er=Salary processed for  employees ...");
					}
					else
					{
						con.close(); 
						response.sendRedirect("Smart Payroll/Salary Process.jsp?er=Salary process not possible...");
					}
				}
				else
				{
					con.close(); 
					response.sendRedirect("Smart Payroll/Salary Process.jsp?er=Salary process not done due to incompletion of attendance...");
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
