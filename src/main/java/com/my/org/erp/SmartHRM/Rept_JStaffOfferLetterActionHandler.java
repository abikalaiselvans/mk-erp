package com.my.org.erp.SmartHRM;

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

public class Rept_JStaffOfferLetterActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";

	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("export");
			String appid = request.getParameter("appid");
			String pf="",esi="";
			
			if (action.equals("HRMRept_JStaffOfferLetter")) 
			{
			
				File reportDir = new File(Path + "/jasper_report_files/hrm/" + rptfilename+".jrxml");
				String logopath=Path +"images\\logo.jpg"; 
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				List<Hashtable> al=new ArrayList<Hashtable>();
				
				asql = " SELECT  offer.INT_OFFERID,ecat.CHR_CATEGORYNAME,CONCAT(year(CURRENT_TIMESTAMP), "; 
				asql = asql + " CONCAT('-',year(CURRENT_TIMESTAMP)+1)) ayear, ";
				asql = asql + " DATE_FORMAT(CURRENT_DATE,'%d-%b-%y'), ";
				asql = asql + " CONCAT( if(app.CHR_GENDER='Male','Mr. ', if(app.CHR_MARITALSTATUS ='M','Mrs.' ,'Ms.') ),' ',app.CHR_APPNAME) salute, ";
				asql = asql + " office.CHR_OFFICENAME,desig.CHR_DESIGNAME, ";
				asql = asql + " DATE_FORMAT(DATE_ADD(CURDATE(),INTERVAL 3 DAY),'%d-%b-%Y') joining, ";
				asql = asql + " FUN_GET_takehome(hal.INT_APPID) takehome,offer.CHR_PF,offer.CHR_ESI  ";
				asql = asql + " FROM hrm_t_allowance hal,hrm_m_application app,hrm_t_offerletter offer,com_m_office office, ";
				asql = asql + " com_m_desig desig,com_m_employeecategory ecat ";
				asql = asql + " WHERE hal.INT_APPID=offer.INT_APPID AND app.INT_APPID=offer.INT_APPID "; 
				asql = asql + " AND offer.INT_DESIGID=desig.INT_DESIGID AND ";
				asql = asql + " offer.INT_OFFICEID=office.INT_OFFICEID AND hal.INT_APPID= "+appid;
				asql = asql + " AND ecat.INT_EMPLOYEECATEGORYID=offer.INT_CATEGORY ";
				System.out.println(asql);
				String applicantdata[][]= CommonFunctions.QueryExecute(asql);
				
				 
				 
				map.put("appid", Integer.parseInt(appid));
				map.put("logopath", logopath);
				map.put("t1", "CARE/OFFER-"+applicantdata[0][0]+"/"+applicantdata[0][1]+"/"+applicantdata[0][2]);
				map.put("t2", applicantdata[0][3]);
				map.put("salute", applicantdata[0][4]);
				map.put("office", applicantdata[0][5]);
				map.put("designation", applicantdata[0][6]);
				map.put("doj", applicantdata[0][7]);
				pf=applicantdata[0][9];
				esi=applicantdata[0][10];
				
				map.put("companyname", CommonFunctions.QueryExecute("SELECT UPPER(CHR_NAME) FROM m_company")[0][0]);	 
				
				String institutionData[][] =  CommonFunctions.QueryExecute("SELECT  INT_PFAMT,INT_ESIAMT,INT_ESILIMIT,INT_PFLIMIT,INT_PFLIMITMINIMUM ,INT_CPY_ESIAMT FROM m_institution WHERE INT_ID=1");
				double pfpercentage = Double.parseDouble( institutionData[0][0]);
				double esipercentage = Double.parseDouble( institutionData[0][1]);
				double esilimitamount = Double.parseDouble( institutionData[0][2]);
				double pfmaximumlimit = Double.parseDouble( institutionData[0][3]);
				double pfminimumlimit = Double.parseDouble( institutionData[0][4]);
				double esicomapnypercentage = Double.parseDouble( institutionData[0][5]);

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
				
				String sql="";	
				sql = " SELECT ROUND(b.INT_BASIC),ROUND(INT_BASIC*12),"+salaryband+" ,ROUND(b.INT_BASIC+("+grossband+")),ROUND( (b.INT_BASIC+("+grossband+"))*12 ),"+extraAllowanceBand+"," +
						"ROUND("+totband+"),ROUND( (b.INT_BASIC+("+grossband+")+("+totband+"))*12 ),ROUND(b.INT_BASIC*12/100) ,ROUND((b.INT_BASIC*12/100)*12)," +
						"ROUND( (b.INT_BASIC+("+grossband+"))  + (b.INT_BASIC*12/100) ) , ROUND(( (b.INT_BASIC+("+grossband+"))  " +
						"+ (b.INT_BASIC*12/100) )*12),ROUND( (b.INT_BASIC+("+grossband+")) - (b.INT_BASIC*12/100) )  " +
						"FROM hrm_m_application a,hrm_t_allowance b ";
				sql = sql +" WHERE a.INT_APPID = b.INT_APPID AND a.INT_APPID="+appid;
				
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
				
				if(payData.length>0)
				{
					monthbasic=Double.parseDouble(payData[0][0]);
					Hashtable h1 = new Hashtable();
					h1.put("F1", "Basic");
					h1.put("F2", Double.parseDouble(payData[0][0]));
					h1.put("F3", Double.parseDouble(payData[0][1]));
					al.add(h1);
					
					 int g=1;
					 int v=1;
					 
					 for(int u=0; u<AllowanceData.length;u++)
					 {
						 g = g+2;
						 Hashtable h2 = new Hashtable();
						 v=v+1;
						 if(Integer.parseInt(payData[0][v])>0)
							h2.put("F1", AllowanceData[u][1]);
						 if(Integer.parseInt(payData[0][v])>0)
							h2.put("F2", Double.parseDouble(payData[0][v]));
							v=v+1;
							if(Integer.parseInt(payData[0][v])>0)
							h2.put("F3", Double.parseDouble(payData[0][v]));
							al.add(h2);
					 }
					 monthgross=Double.parseDouble(payData[0][(g+1)]);
					
						Hashtable h3 = new Hashtable();
						h3.put("F1", "Gross Pay");
						h3.put("F2", monthgross);
						h3.put("F3", monthgross*12);
						al.add(h3);
							
					 int i=(AllowanceData.length*2)+3;
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
								 h.put("F1", "Added Allowance");
								 al.add(h);
								 ++k;
							 }
							 	 h2.put("F1", ExtraAllowanceData[u][1]);
							 	 h2.put("F2", Double.parseDouble(payData[0][i])); 
						 }
							 ++i;
							 if(Integer.parseInt(payData[0][i])>0)
							 h2.put("f3", Double.parseDouble(payData[0][i]));
							 al.add(h2);
					 }
						
					tot=Double.parseDouble(payData[0][(g+3)]);
					map.put("Performanceallowance", ""+tot);
					map.put("tot", tot);
					if(tot>0)
					{
						 Hashtable h8 = new Hashtable();
						 h8.put("F1", "Added Allowance Total");
						 h8.put("F2", tot);
						 h8.put("F3", tot*12);
						 al.add(h8);	
					}
					 
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
					 h4.put("F1", "Employeer PF");
					 h4.put("F2", monthpf);
					 h4.put("F3", monthpf*12);
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
				   h5.put("F1", "Employeer ESI");
				   h5.put("F2", monthesi);
				   h5.put("F3", monthesi*12);
				   al.add(h5);
				   
				   
					 
					 monthctc=monthgross+monthpf+monthesi;
					 
					 Hashtable h6 = new Hashtable();
					 h6.put("F1", "Total Cost To Company (TCTC)");
					 h6.put("F2", monthctc);
					 h6.put("F3", (monthctc)*12);
					 al.add(h6);
					 
					 
					takehome = tot + monthgross - (staffpf + staffesi);
					String s1 = "" + takehome;
					Hashtable h7 = new Hashtable();
					h7.put("F1", "Take Home Salary");
					h7.put("F2", takehome);
					h7.put("F3", takehome * 12);
					map.put("takehome", "" + Math.round(takehome));
					map.put("takehomesalary", "" + Math.round(takehome));
					al.add(h7);
					
				}
				
				System.out.println(al);
				 
				jasperPrint=ReportFunctions2.createReportUsingListDS(jasperPrint, request, response, reportDir, rptfilename, al, Path,map);
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