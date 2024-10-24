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
 
import com.my.org.erp.common.CommonFunctions;
 

public class Rept_JAppointmentAnnexureActionHandler extends AbstractActionHandler 
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
			String empid = request.getParameter("ename");
			 
			if (action.equals("PAYAppointmentAnnexure")) 
			{
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				List<Hashtable> al=new ArrayList<Hashtable>();
				
				
				asql = asql + "select A.CHR_STAFFNAME, B.CHR_DESIGNAME, E.CHR_OFFICENAME, ";
				asql = asql + "D.CHR_DEPARTNAME,DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%b-%Y'),  ";
				asql = asql + "A.CHR_PF,A.CHR_ESI,C.CHR_COMPANYNAME ,  ";
				asql = asql +" FUN_PAY_GET_PF_CALCULATION(A.CHR_EMPID,A.INT_SALARY,A.CHR_PFCALCULATIONTYPE), ";
				//asql = asql +" FUN_GET_ESIAMOUNT('STAFF',A.CHR_ESI,FUN_PAY_GET_ORIGINAL_GROSS(A.CHR_EMPID) ), ";
				asql = asql + " FUN_PAY_GET_ESI_CALCULATION('STAFF',A.CHR_EMPID,A.CHR_ESI) ESI ,";
				//asql = asql +" FUN_GET_ESIAMOUNT('CPY',A.CHR_ESI,FUN_PAY_GET_ORIGINAL_GROSS(A.CHR_EMPID) ),  ";
				asql = asql + " FUN_PAY_GET_ESI_CALCULATION('CPY',A.CHR_EMPID,A.CHR_ESI) CPYESI ,";
				asql = asql +"  FIND_A_INSTITUTION_NAME()  "; 
				asql = asql + "from com_m_staff A, com_m_desig B,com_m_company C,com_m_depart D,  com_m_office  E ";  
				asql = asql + "where A.CHR_EMPID='"+empid+"' AND A.INT_DESIGID=B.INT_DESIGID  ";
				asql = asql + "AND A.INT_COMPANYID=C.INT_COMPANYID   AND A.INT_DEPARTID = D.INT_DEPARTID AND A.INT_OFFICEID = E.INT_OFFICEID "; 
				String staffdata[][]= CommonFunctions.QueryExecute(asql);
				    
				map.put("empid", empid);
				map.put("staffname", staffdata[0][0]);	
				map.put("desig", staffdata[0][1]);
				map.put("office", staffdata[0][2]);
				map.put("dept", staffdata[0][3]);
				map.put("doj", staffdata[0][4]);
				map.put("cpy", staffdata[0][11]);
				 
				 
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
				
				 	
				asql = " SELECT ROUND(a.INT_SALARY),ROUND(INT_SALARY*12),"+salaryband+" ,ROUND(a.INT_SALARY+("+grossband+")),ROUND( (a.INT_SALARY+("+grossband+"))*12 ),"+extraAllowanceBand+"," +
						"ROUND("+totband+"),ROUND( (a.INT_SALARY+("+grossband+")+("+totband+"))*12 ),ROUND(a.INT_SALARY*12/100) ,ROUND((a.INT_SALARY*12/100)*12)," +
						"ROUND( (a.INT_SALARY+("+grossband+"))  + (a.INT_SALARY*12/100) ) , ROUND(( (a.INT_SALARY+("+grossband+"))  " +
						"+ (a.INT_SALARY*12/100) )*12),ROUND( (a.INT_SALARY+("+grossband+")) - (a.INT_SALARY*12/100) )  " +
						"FROM com_m_staff a,pay_t_allowance b ";
				asql = asql +" WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_EMPID='"+empid+"' ";
				System.out.println();
				System.out.println();
				System.out.println(asql);
				String payData[][] = CommonFunctions.QueryExecute(asql);
				 
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
					
					//Calculation for Recovery 
					String recoveryData[][] = CommonFunctions.QueryExecute("SELECT CHR_RCODE,CHR_RNAME  FROM pay_m_recovery   ORDER BY INT_RECOVERYID");
				    String recoveryfield="";
				    String recoveryfield1="";
					if(recoveryData.length>0)
						for(int u=0; u<recoveryData.length;u++)
						{
							recoveryfield = recoveryfield+"  b."+recoveryData[u][0]+",( b."+recoveryData[u][0]+" *12) ,"; 
							recoveryfield1 = recoveryfield1+"  b."+recoveryData[u][0]+"+";
						}	
					
					asql = " SELECT "+recoveryfield+ " ( "+recoveryfield1+" 0) , ( ( "+recoveryfield1+" 0)   *12) "; 
					asql = asql + "FROM com_m_staff a,pay_t_recovery b ";
					asql = asql +" WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_EMPID='"+empid+"' ";
					String rcyData[][] = CommonFunctions.QueryExecute(asql); 
					int r=-1;
					double recoverytotal=0;
					
					if(rcyData.length>0)
					{	
						boolean rflag =false;
						for(int u=0; u<recoveryData.length;u++)
						{	
							r=r+1;
							r=r+1;
							if(Double.parseDouble(rcyData[0][r])>0)
								rflag = true;
						}		
						
						r =-1;	
						if(rflag)
						{	
							Hashtable rh = new Hashtable();
							rh.put("f1", "Recovery");
							al.add(rh);
						}	
					 
						for(int u=0; u<recoveryData.length;u++)
						{
							Hashtable rh2 = new Hashtable();
							rh2.put("f1", recoveryData[u][1]);
							r=r+1;
							rh2.put("f2", Double.parseDouble(rcyData[0][r]));
							recoverytotal = recoverytotal+Double.parseDouble(rcyData[0][r]);
							r=r+1;
							rh2.put("f3", Double.parseDouble(rcyData[0][r]));
							
							//Recovery not equal zero
							if(Double.parseDouble(rcyData[0][r])>0)
								al.add(rh2);
						}
						
						if(rflag)
						{	
							Hashtable rh8 = new Hashtable();
							rh8.put("f1", "Recovery Total");
							rh8.put("f2", recoverytotal);
							rh8.put("f3", recoverytotal*12);
							al.add(rh8);
						}	
					}
					
					
					 // Employeer & Employee PF 
					 monthpf = Double.parseDouble( staffdata[0][8]);
					 staffpf = Double.parseDouble( staffdata[0][8]);
					 
					 
					 
					Hashtable h4 = new Hashtable();
					h4.put("f1", "Employeer PF");
					h4.put("f2", monthpf);
					h4.put("f3", monthpf*12);
					al.add(h4);
					 
					staffesi = Double.parseDouble( staffdata[0][9]);
					monthesi = Double.parseDouble( staffdata[0][10]);

				    Hashtable h5 = new Hashtable();
				    h5.put("f1", "Employeer ESI");
				    h5.put("f2", monthesi);
				    h5.put("f3", monthesi*12);
				    al.add(h5);
				    
				 
					monthctc=monthgross+monthpf+monthesi+tot-recoverytotal; 
					Hashtable h6 = new Hashtable();
					h6.put("f1", "Total Cost To Company (TCTC)");
					h6.put("f2", monthctc);
					h6.put("f3", (monthctc)*12);
					al.add(h6);
					 
					 
					 
					 
					
					
					//Calculating Profession tax
					asql = "SELECT FUN_PAY_GET_ORIGINAL_PROFESSIONAL_TAX_AMOUNTS('"+empid+"', "+monthgross+" ) " ;
					System.out.println(asql);
					String professtionalData[][] = CommonFunctions.QueryExecute(asql); 
					double professionaltax=0;
					if(professtionalData.length>0)
						professionaltax = Double.parseDouble( professtionalData[0][0]);
					
					Hashtable ph6 = new Hashtable();
					ph6.put("f1", "Professional Tax");
					ph6.put("f2", professionaltax);
					ph6.put("f3", (professionaltax)*12);
					al.add(ph6);
					
					takehome = monthctc-monthpf- monthesi- staffpf-staffesi-professionaltax; 
					Hashtable h7 = new Hashtable();
					h7.put("f1", "Take Home Salary");
					map.put("takehome", "" + Math.round(takehome));
					h7.put("f2", takehome);
					h7.put("f3", takehome * 12);
					al.add(h7);
					
				}
				
				
				jasperPrint=ReportFunctions2.createReportUsingListDS(jasperPrint, request, response, reportDir, rptfilename, al, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				System.out.println();
				
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