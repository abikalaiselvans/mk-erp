package com.my.org.erp.SmartPayroll;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;
 
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.SmartReport.ReportFunctions2;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.CommonInfo;

public class Rept_JAppointmentOrderWithAnnexureActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";

	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			String SubRptfilename1 = request.getParameter("subRptfilename1");
			String SubRptfilename2 = request.getParameter("subRptfilename2");
			if (action.equals("PAYRept_JAppointmentOrderWithAnnexure")) 
			{
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				File subReport1Dir = new File(Path + "/report/SmartPayroll/" + SubRptfilename1+".jrxml");
				File subReport2Dir = new File(Path + "/report/SmartPayroll/" + SubRptfilename2+".jrxml");
				
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				
				List<Hashtable> al=new ArrayList<Hashtable>();
				
				String staffid=""+request.getParameter("ename");
				asql="select A.CHR_STAFFNAME,CONCAT(if(a.CHR_GENDER='Male','Mr. ',(if(a.CHR_MARITALSTATUS ='M','Mrs.' ,'Ms.'))),' ',a.CHR_STAFFNAME),A.DT_DOJCOLLEGE,A.CHR_SADD1,A.CHR_SADD2,A.CHR_SCITY,A.CHR_SSTATE,A.CHR_SPIN, ";
				asql=asql+"B.CHR_DESIGNAME,C.CHR_COMPANYNAME,A.CHR_GENDER,A.CHR_MARITALSTATUS , RIGHT(CHR_EMPID,6),A.CHR_PERMAILID ,D.CHR_DEPARTNAME,E.CHR_OFFICENAME,A.CHR_PF,A.CHR_ESI  ";
				asql=asql+"from com_m_staff A, com_m_desig B,com_m_company C,com_m_depart D,  com_m_office  E  ";
				asql=asql+" where A.CHR_EMPID='"+staffid+"' AND A.INT_DESIGID=B.INT_DESIGID ";
				asql=asql+" AND A.INT_COMPANYID=C.INT_COMPANYID   AND A.INT_DEPARTID = D.INT_DEPARTID AND A.INT_OFFICEID = E.INT_OFFICEID ";
								
				String staffdata[][]= CommonFunctions.QueryExecute(asql);
				String appointed=DateUtil.FormateDateSys(staffdata[0][2]);
				String app= CommonFunctions.Appointmentyear(appointed);
				String id[]=app.split("~");
				String apdate=DateUtil.FormateDateSys(DateUtil.getCurrentDBDate());
				String dateid[]=apdate.split("-");
				String appdate=dateid[0]+" "+ DateUtil.getMonth(Integer.parseInt(dateid[1]))+" "+dateid[2]; 
			
				map.put("ref1", id[0]);
				map.put("date", appdate);
				map.put("eid", staffid);
				map.put("staffname", staffdata[0][0]);	
				map.put("empRespect", staffdata[0][1]);	
				map.put("doj", staffdata[0][2]);
				map.put("add1", staffdata[0][3]);
				map.put("add2", staffdata[0][4]);
				String cy= CommonInfo.stringGetAnySelectField("select CHR_CITYNAME from com_m_city where int_cityid="+staffdata[0][5],"CHR_CITYNAME");
				map.put("city", cy);
				
				String st= CommonInfo.stringGetAnySelectField("select CHR_STATENAME from com_m_state where int_stateid="+staffdata[0][6],"CHR_STATENAME");
				map.put("stateWpin", st+" - "+staffdata[0][7]);
				map.put("desig", staffdata[0][8]);
				map.put("cpy", staffdata[0][9]);
				map.put("eidR6", staffdata[0][12]);
					
				String institutionData[][] =  CommonFunctions.QueryExecute("SELECT  INT_PFAMT,INT_ESIAMT,INT_ESILIMIT,INT_PFLIMIT,INT_PFLIMITMINIMUM ,INT_CPY_ESIAMT FROM m_institution WHERE INT_ID=1");
				double pfpercentage = Double.parseDouble( institutionData[0][0]);
				double esipercentage = Double.parseDouble( institutionData[0][1]);
				double esilimitamount = Double.parseDouble( institutionData[0][2]);
				double pfmaximumlimit = Double.parseDouble( institutionData[0][3]);
				double pfminimumlimit = Double.parseDouble( institutionData[0][4]);
				double esicomapnypercentage = Double.parseDouble( institutionData[0][5]);
	
				String pf="",esi="";
				String sql="select A.CHR_STAFFNAME,A.DT_DOJCOLLEGE,A.CHR_SADD1,A.CHR_SADD2,A.CHR_SCITY,A.CHR_SSTATE,A.CHR_SPIN, ";
				sql=sql+"B.CHR_DESIGNAME,C.CHR_COMPANYNAME,A.CHR_GENDER,A.CHR_MARITALSTATUS , RIGHT(CHR_EMPID,6),A.CHR_PERMAILID ,D.CHR_DEPARTNAME,E.CHR_OFFICENAME,A.CHR_PF,A.CHR_ESI  ";
				sql=sql+"from com_m_staff A, com_m_desig B,com_m_company C,com_m_depart D,  com_m_office  E  ";
				sql=sql+" where A.CHR_EMPID='"+staffid+"' AND A.INT_DESIGID=B.INT_DESIGID ";
				sql=sql+" AND A.INT_COMPANYID=C.INT_COMPANYID   AND A.INT_DEPARTID = D.INT_DEPARTID AND A.INT_OFFICEID = E.INT_OFFICEID ";
				pf=staffdata[0][16];esi=staffdata[0][17];
			 

				String AllowanceData[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
				String ExtraAllowanceData[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='N' ORDER BY INT_ALLOWANCEID");
				String salaryband="   ";
				String grossband="";
				String extraAllowanceBand="";
				String totband="";
				
				for(int u=0; u<AllowanceData.length;u++)
				{
					salaryband = salaryband+"  b."+AllowanceData[u][0]+",( b."+AllowanceData[u][0]+" *12) ,"; 
					grossband = grossband+"  b."+AllowanceData[u][0]+"+";
				}	
				salaryband=salaryband.trim();
				salaryband = salaryband.substring(0,salaryband.length()-1);	
								
				grossband=grossband.trim();
				grossband = grossband.substring(0,grossband.length()-1);	
				
				for(int u=0; u<ExtraAllowanceData.length;u++)
				{
					extraAllowanceBand = extraAllowanceBand+"  b."+ExtraAllowanceData[u][0]+",( b."+ExtraAllowanceData[u][0]+" *12) ,"; 
					totband=totband+"  b."+ExtraAllowanceData[u][0]+"+";
				}	
				extraAllowanceBand=extraAllowanceBand.trim();
				extraAllowanceBand = extraAllowanceBand.substring(0,extraAllowanceBand.length()-1);	
				
				totband=totband.trim();
				totband = totband.substring(0,totband.length()-1);	
				
				sql="";	
				sql = " SELECT ROUND(a.INT_SALARY),ROUND(INT_SALARY*12),"+salaryband+" ,ROUND(a.INT_SALARY+("+grossband+")),ROUND( (a.INT_SALARY+("+grossband+"))*12 ),"+extraAllowanceBand+"," +
						"ROUND("+totband+"),ROUND( (a.INT_SALARY+("+grossband+")+("+totband+"))*12 ),ROUND(a.INT_SALARY*12/100) ,ROUND((a.INT_SALARY*12/100)*12)," +
						"ROUND( (a.INT_SALARY+("+grossband+"))  + (a.INT_SALARY*12/100) ) , ROUND(( (a.INT_SALARY+("+grossband+"))  " +
						"+ (a.INT_SALARY*12/100) )*12),ROUND( (a.INT_SALARY+("+grossband+")) - (a.INT_SALARY*12/100) )  " +
						"FROM com_m_staff a,pay_t_allowance b ";
				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_EMPID='"+staffid+"' ";
				System.out.println();
				System.out.println();
				System.out.println(sql);
				String payData[][] = CommonFunctions.QueryExecute(sql);
				double monthbasic=0;
				double monthgross=0;
				double tot=0;
				double monthpf=0;
				double monthesi=0;
				double monthctc=0;
				
				double staffpf=0;
				double staffesi=0;
				double takehome=0;
				
				map.put("office", staffdata[0][15]);
				map.put("dept", staffdata[0][14]);
				
				if(payData.length>0)
				{
					monthbasic=Double.parseDouble(payData[0][0]);
					Hashtable h1 = new Hashtable();
					h1.put("f1", "Basic");
					h1.put("f2", Double.parseDouble(payData[0][0]));
					h1.put("f3", Double.parseDouble(payData[0][1]));
					al.add(h1);
					
					 int g=1;
					 int v=1;
					 
					 for(int u=0; u<AllowanceData.length;u++)
					 {
						 g = g+2;
						 Hashtable h2 = new Hashtable();
						 v=v+1;
						 if(Integer.parseInt(payData[0][v])>0)
							h2.put("f1", AllowanceData[u][1]);
						 if(Integer.parseInt(payData[0][v])>0)
							h2.put("f2", Double.parseDouble(payData[0][v]));
							v=v+1;
							if(Integer.parseInt(payData[0][v])>0)
							h2.put("f3", Double.parseDouble(payData[0][v]));
							al.add(h2);
					 }
					 monthgross=Double.parseDouble(payData[0][(g+1)]);
					
						Hashtable h3 = new Hashtable();
						h3.put("f1", "Gross Pay");
						h3.put("f2", monthgross);
						h3.put("f3", monthgross*12);
						al.add(h3);
							
					 int i=(AllowanceData.length*2)+3;
					 
					 
					 // Employeer 
					 if("C".equals(pf))
					 {
						if(monthbasic < pfminimumlimit)
						{
							monthpf = (pfminimumlimit*pfpercentage/100); 
							staffpf = (pfminimumlimit*pfpercentage/100); 
						}
						else if( (monthbasic>=pfminimumlimit)  && (monthbasic <=pfmaximumlimit))	
						{
							monthpf = (monthbasic*pfpercentage/100); 
							staffpf = (monthbasic*pfpercentage/100); 
						}
						else
						{
							monthpf = (pfmaximumlimit*pfpercentage/100);
							staffpf = (pfmaximumlimit*pfpercentage/100);
						}	
					}
					else
					{
						monthpf = 0;
						staffpf = 0;
					}
					 
					 
					 
					Hashtable h4 = new Hashtable();
					h4.put("f1", "Employeer PF");
					h4.put("f2", monthpf);
					h4.put("f3", monthpf*12);
					al.add(h4);
					 
					if("C".equals(esi) && monthgross <=esilimitamount)
					{
							monthesi=(monthgross*esicomapnypercentage/100);
							staffesi=(monthgross*esipercentage/100);
					}
					else
					{
							monthesi=0;
						 	staffesi=0;
					}
				    Hashtable h5 = new Hashtable();
				    h5.put("f1", "Employeer ESI");
				    h5.put("f2", monthesi);
				    h5.put("f3", monthesi*12);
				    al.add(h5);
				    
					monthctc=monthgross+monthpf+monthesi;
					 
					Hashtable h6 = new Hashtable();
					h6.put("f1", "Total Cost To Company (TCTC)");
					h6.put("f2", monthctc);
					h6.put("f3", (monthctc)*12);
					al.add(h6);
					 
					 
					 
					 
					 int k=0;
					 for(int u=0; u<ExtraAllowanceData.length;u++)
					 {
						 g = g+2;
						 Hashtable h2 = new Hashtable();
						 ++i;
						 if(Integer.parseInt(payData[0][i])>0)
						 {
							 ++k;
							 if(k==1)
							 {
								 Hashtable h = new Hashtable();
								 h.put("f1", "Added Allowance");
								 al.add(h);
								 ++k;
							 }
							 	 h2.put("f1", ExtraAllowanceData[u][1]);
							 	 h2.put("f2", Double.parseDouble(payData[0][i])); 
						 }
							 ++i;
							 if(Integer.parseInt(payData[0][i])>0)
							 h2.put("f3", Double.parseDouble(payData[0][i]));
							 al.add(h2);
					 }
						
					tot=Double.parseDouble(payData[0][(g+3)]);
					if(tot>0)
					{
						 Hashtable h8 = new Hashtable();
						 h8.put("f1", "Added Allowance Total");
						 h8.put("f2", tot);
						 h8.put("f3", tot*12);
						 al.add(h8);	
					}
					
					takehome = tot + monthgross - (staffpf + staffesi);
					 
					Hashtable h7 = new Hashtable();
					h7.put("f1", "Take Home Salary");
					map.put("takehome", "" + Math.round(takehome));
					h7.put("f2", takehome);
					h7.put("f3", takehome * 12);
					System.out.println("h3:" + h7);
					System.out.println("al:" + al);
					al.add(h7);
					
				}
				
				jasperPrint=ReportFunctions2.createReportUsingListDSWithSub(jasperPrint, request, response, reportDir, rptfilename, al, Path,map,subReport1Dir,subReport2Dir);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				
			}
		
		} catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}
}