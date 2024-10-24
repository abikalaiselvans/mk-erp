package com.my.org.erp.SmartReport;
import java.io.File;
import java.io.FileNotFoundException;
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
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import ar.com.fdvs.dj.domain.Style;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JServiceCardActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	protected JasperReport jr;
	JRExporter exporter;
	String hImageExpression="";
	String fImageExpression="";
	HashMap<Integer, String> titleMap=new HashMap<Integer, String>();
	HashMap<Integer, Integer> widthMap=new HashMap<Integer, Integer>();
	HashMap<Integer, Style> styleMap=new HashMap<Integer, Style>();


	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 


			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String subrptfilename1 = request.getParameter("subrptfilename1");
			String reporttype = request.getParameter("reportType");

			if (action.equals("RPTRept_JServiceCard")) 
			{
				
				System.out.println("=============================================================");
				System.out.println("ACTION HANDLER FROM SERVICE CARD");
				List<Hashtable<String,String>> al=new ArrayList<Hashtable<String,String>>();
				String path=Path + "/report/SmartCommon/" + rptfilename+".jrxml";
				String path1=Path + "/report/SmartCommon/" + subrptfilename1+".jrxml";

				File reportDir = new File(path);
				File reportDir1 = new File(path1);
				HashMap<Object,Object> map = new HashMap<Object,Object>();

				if (!reportDir.exists() ) 
				{
					throw new FileNotFoundException(String.valueOf(reportDir));
				}
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");

				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;

				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);


				String id = request.getParameter("ename");
				String sql=""; 
				sql = "   SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,a.CHR_GENDER,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y')," ;
				sql = sql +" DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),IF(a.CHR_MARITALSTATUS='M','Married','Unmarried')," ;
				sql = sql +" DATE_FORMAT(a.DT_WEDDATE,'%d-%m-%Y'),g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME," ;
				sql = sql +" i.CHR_DESIGNAME,b.CHR_OFFICENAME ,e.CHR_QUALIFICATIONNAME ,j.CHR_GROUPNAME," ;
				sql = sql +" FUN_GET_ADDRESS(a.CHR_EMPID,'P','\n') Paddress,FUN_GET_ADDRESS(a.CHR_EMPID,'C','\n') Caddress," ;
				sql = sql +" a.CHR_EMAILID, a.CHR_MOBILE,a.INT_SALARY,a.CHR_PF,g.CHR_PFNUMBER,a.CHR_PFNO,a.CHR_ESI,a.CHR_ESINO," ;
				sql = sql +" FIND_A_BANKGROUP_NAME(a.CHR_BANK) ,a.CHR_ACCNO  ,round(datediff(now(),a.DT_DOJCOLLEGE)/365), " ;
				sql = sql +" FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE), ";
				
				//sql = sql +" FUN_GET_ESIAMOUNT('STAFF',a.CHR_ESI,FUN_PAY_GET_ORIGINAL_GROSS(a.CHR_EMPID) ), ";
				//sql = sql +" FUN_GET_ESIAMOUNT('CPY',a.CHR_ESI,FUN_PAY_GET_ORIGINAL_GROSS(a.CHR_EMPID) ),  ";
				
				sql = sql + " FUN_PAY_GET_ESI_CALCULATION('STAFF',a.CHR_EMPID,a.CHR_ESI) STAFFESI ,";
				sql = sql + " FUN_PAY_GET_ESI_CALCULATION('CPY',a.CHR_EMPID,a.CHR_ESI) ESI ,";
				
				sql = sql +" FIND_A_INSTITUTION_NAME(),  "; 
				sql = sql +" FUN_PAY_GET_ORIGINAL_PROFESSIONAL_TAX_AMOUNTS(a.CHR_EMPID,FUN_PAY_GET_ORIGINAL_GROSS(a.CHR_EMPID)  ) ";
				sql = sql +" FROM com_m_staff a , com_m_office b ,com_m_depart c ,pay_t_allowance d ,com_m_qualification e ," ;
				sql = sql +" com_m_branch f , com_m_company g,  com_m_desig i,com_m_bloodgroup j,com_m_country k,com_m_state l," ;
				sql = sql +" com_m_district m,com_m_city n WHERE a.INT_DEPARTID = c.INT_DEPARTID AND a.INT_OFFICEID= " ;
				sql = sql +" b.INT_OFFICEID AND a.CHR_EMPID =d.CHR_EMPID AND a.CHR_QUALIFICATION =e.INT_QUALIFICATIONID " ;
				sql = sql +" AND a.INT_BRANCHID =f.INT_BRANCHID AND a.INT_COMPANYID =g.INT_COMPANYID " ;
				sql = sql +" AND a.INT_DESIGID= i.INT_DESIGID AND a.CHR_BG=j.INT_BLOODGROUPID " ;
				sql = sql +" AND a.CHR_PCITY = n.INT_CITYID AND a.INT_PDISTRICTID=m.INT_DISTRICTID " ;
				sql = sql +" AND a.CHR_PSTATE=l.INT_STATEID AND a.INT_PCOUNTRYID =k.INT_COUNTRYID " ;
				sql = sql +" AND a.CHR_SCITY = n.INT_CITYID AND a.INT_CDISTRICTID=m.INT_DISTRICTID " ;
				sql = sql +" AND a.CHR_SSTATE=l.INT_STATEID AND a.INT_CCOUNTRY  =k.INT_COUNTRYID " ;
				sql = sql +" AND a.CHR_EMPID='"+id+"'";
				sql = sql + " ORDER BY a.CHR_EMPID  ";
				System.out.print(sql);
				System.out.println();
				String empdata[][]=CommonFunctions.QueryExecute(sql);
				if(empdata.length>0)
				{
					map.put("empid", empdata[0][0]);		
					@SuppressWarnings("deprecation")
					String staffphoto = request.getRealPath("/")+"uploadfiles\\StaffPhoto\\"+id.trim() +".jpg";
					System.out.println(staffphoto);
					
					File f = new File(staffphoto);
					boolean ff = f.exists(); 
					if (ff)
						staffphoto = request.getRealPath("/")+"uploadfiles\\StaffPhoto\\"+id.trim() +".jpg";
					else	
						staffphoto = request.getRealPath("/")+"uploadfiles\\StaffPhoto\\default.jpg"; 
				 
						 
					
					 
					map.put("empphotopath", staffphoto.toString());

					
					
					@SuppressWarnings("deprecation")
					String RupeeSymbol = request.getRealPath("/")+"Image/report/Rupee.jpeg";
					String photo1=null;
					File f1 = new File(RupeeSymbol);	 
					if (f1.exists())
						photo1 ="../../Image/report/Rupee.jpeg";
					map.put("rupeeImg", photo1);

					map.put("empname", empdata[0][1]);
					map.put("empfathername", empdata[0][2]);
					map.put("gender", empdata[0][3]);
					map.put("dob", empdata[0][4]);
					map.put("doj", empdata[0][5]);
					map.put("maritalStatus", empdata[0][6]);
					map.put("weddate", empdata[0][7]);
					map.put("cpy", empdata[0][31]);
					map.put("branch", empdata[0][9]);
					map.put("depart", empdata[0][10]);
					map.put("desig", empdata[0][11]);
					map.put("office", empdata[0][12]);
					map.put("qualification", empdata[0][13]);
					map.put("bloodgroup", empdata[0][14]);
					map.put("paddr", empdata[0][15]);
					map.put("caddr", empdata[0][16]);
					map.put("email", empdata[0][17]);
					map.put("mobile", empdata[0][18]);
					map.put("salary", empdata[0][19]);

					if("C".equals(empdata[0][20]))
						map.put("pftype", "Common");
					else if("Y".equals(empdata[0][20]))
						map.put("pftype", "Yes");
					else if("N".equals(empdata[0][20]))
						map.put("pftype", "No");

					map.put("pfstaticnumber", empdata[0][21]);
					map.put("pfno", empdata[0][22]);

					if("C".equals(empdata[0][23]))
						map.put("esitype","Common");
					else if("Y".equals(empdata[0][23]))
						map.put("esitype","Yes");
					else if("N".equals(empdata[0][23]))
						map.put("esitype","No");

					map.put("esino", empdata[0][24]);
					map.put("bankname", empdata[0][25]);
					map.put("accno", empdata[0][26]);


					String AllowanceData[][] =CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
					String salaryband="   ";
					String grossband="";
					for(int u=0; u<AllowanceData.length;u++)
					{
						salaryband = salaryband+"  b."+AllowanceData[u][0]+",( b."+AllowanceData[u][0]+" *12) ,"; 
						grossband = grossband+"  b."+AllowanceData[u][0]+"+";
					}	
					salaryband=salaryband.trim();
					salaryband = salaryband.substring(0,salaryband.length()-1);		

					grossband=grossband.trim();
					grossband = grossband.substring(0,grossband.length()-1);		

					sql = " SELECT ROUND(a.INT_SALARY),ROUND(INT_SALARY*12),"+salaryband+" ,ROUND(a.INT_SALARY+("+grossband+")),ROUND( (a.INT_SALARY+("+grossband+"))*12 ),ROUND(a.INT_SALARY*12/100) ,ROUND((a.INT_SALARY*12/100)*12),ROUND( (a.INT_SALARY+("+grossband+"))  + (a.INT_SALARY*12/100) ) , ROUND(( (a.INT_SALARY+("+grossband+"))  + (a.INT_SALARY*12/100) )*12),ROUND( (a.INT_SALARY+("+grossband+")) - (a.INT_SALARY*12/100) )  FROM com_m_staff a,pay_t_allowance b ";
					sql = sql +" 	WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_EMPID='"+id+"' ";
					System.out.println(sql);
					
					String payData[][] =CommonFunctions.QueryExecute(sql);
					 
					double monthgross=0;
					double monthpf=0;
					double monthesi=0;
					double monthctc=0;

					double staffpf=0;
					double staffesi=0;
					double takehome=0;

					System.out.println();
					System.out.println();
					if(payData.length>0)
					{
						Hashtable<String,String> h1 = new Hashtable<String,String>();
						h1.put("f1", "BASIC");
						h1.put("f2", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(payData[0][0])));
						h1.put("f3", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(payData[0][1])));
						al.add(h1);
						int g=1;
						int v=2;
						
						for(int u=0; u<AllowanceData.length;u++)
						{ 
							g = g+2;
							Hashtable<String,String> h2 = new Hashtable<String,String>();
							if(Integer.parseInt(payData[0][v])>0)
							{	
								h2.put("f1", AllowanceData[u][1].toUpperCase());
								h2.put("f2", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(payData[0][v])));
								v=v+1;
								h2.put("f3", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(payData[0][v])));
								v=v+1;
								al.add(h2);
							}
							else
							{
								v=v+2;
							}
							 	
						}
						 
						monthgross=Double.parseDouble(payData[0][(g+1)]);

						Hashtable<String,String> h3 = new Hashtable<String,String>();
						h3.put("f1", "GROSS PAY");
						h3.put("f2", CommonFunctions.indianCurrencyFormat().format(monthgross));
						h3.put("f3", CommonFunctions.indianCurrencyFormat().format(monthgross*12));
						al.add(h3);

						  
						
						//Calculation for added allowance 
						String otherallowanceData[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='N' ORDER BY INT_ALLOWANCEID");
					    String otherallowancefield="";
					    String otherallowancefield1="";
						if(otherallowanceData.length>0)
							for(int u=0; u<otherallowanceData.length;u++)
							{
								otherallowancefield = otherallowancefield+"  b."+otherallowanceData[u][0]+",( b."+otherallowanceData[u][0]+" *12) ,"; 
								otherallowancefield1 = otherallowancefield1+"  b."+otherallowanceData[u][0]+"+";
							}	
						
						asql = " SELECT "+otherallowancefield+ " ( "+otherallowancefield1+" 0) , ( ( "+otherallowancefield1+" 0)   *12) "; 
						asql = asql + "FROM com_m_staff a,pay_t_allowance b ";
						asql = asql +" WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_EMPID='"+id+"' ";
						System.out.println(asql);
						String oaData[][] = CommonFunctions.QueryExecute(asql); 
						int or=-1;
						double otherallowancetotal=0;
						
						if(oaData.length>0)
						{	
							boolean oaflag =false;
							for(int u=0; u<otherallowanceData.length;u++)
							{	
								or=or+1;
								or=or+1;
								if(Double.parseDouble(oaData[0][or])>0)
									oaflag = true;
							}		
							
							or =-1;	
							if(oaflag)
							{	
								Hashtable rh = new Hashtable();
								rh.put("f1", "Other Allowance");
								al.add(rh);
							}	
						 
							for(int u=0; u<otherallowanceData.length;u++)
							{
								Hashtable rh2 = new Hashtable();
								rh2.put("f1", otherallowanceData[u][1]);
								or=or+1;
								rh2.put("f2", Double.parseDouble(oaData[0][or]));
								otherallowancetotal = otherallowancetotal+Double.parseDouble(oaData[0][or]);
								or=or+1;
								rh2.put("f3", Double.parseDouble(oaData[0][or]));
								
								//Recovery not equal zero
								if(Double.parseDouble(oaData[0][or])>0)
									al.add(rh2);
							}
							
							if(oaflag)
							{	
								Hashtable rh8 = new Hashtable();
								rh8.put("f1", "Added allowance total");
								rh8.put("f2", otherallowancetotal);
								rh8.put("f3", otherallowancetotal*12);
								al.add(rh8);
							}	
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
						asql = asql +" WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_EMPID='"+id+"' ";
						System.out.println(asql);
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
						
						
						
						
						
						 
						
						monthpf = Double.parseDouble( empdata[0][28]);
						staffpf = Double.parseDouble( empdata[0][28]);
						 
						Hashtable<String,String> h4 = new Hashtable<String,String>();
						h4.put("f1", "EMPLOYER PF");
						h4.put("f2", CommonFunctions.indianCurrencyFormat().format(monthpf));
						h4.put("f3", CommonFunctions.indianCurrencyFormat().format(monthpf*12));
						al.add(h4);

 
						staffesi = Double.parseDouble( empdata[0][29]);
						monthesi = Double.parseDouble( empdata[0][30]);

						Hashtable<String,String> h5 = new Hashtable<String,String>();
						h5.put("f1", "EMPLOYER ESI");
						h5.put("f2", CommonFunctions.indianCurrencyFormat().format(monthesi));
						h5.put("f3", CommonFunctions.indianCurrencyFormat().format(monthesi*12));
						al.add(h5);


						monthctc=monthgross+monthpf+monthesi-recoverytotal+otherallowancetotal;
						Hashtable<String,String> h6 = new Hashtable<String,String>();
						h6.put("f1", "CTC");
						h6.put("f2", CommonFunctions.indianCurrencyFormat().format(monthctc));
						h6.put("f3", CommonFunctions.indianCurrencyFormat().format(monthctc*12));
						al.add(h6);

						double professiontax = Double.parseDouble(empdata[0][32]);
						Hashtable<String,String> ph6 = new Hashtable<String,String>();
						ph6.put("f1", "Professional Tax");
						ph6.put("f2", CommonFunctions.indianCurrencyFormat().format(professiontax));
						ph6.put("f3", CommonFunctions.indianCurrencyFormat().format(professiontax*12));
						al.add(ph6);
						 
						 
						Hashtable<String,String> h7 = new Hashtable<String,String>();
						h7.put("f1", "As Applicable to your   Current Role");
						h7.put("f2", " ");
						h7.put("f3", " ");
						al.add(h7);


						//takehome=monthgross-(staffpf+staffesi+professiontax+recoverytotal);
						takehome = monthctc-monthpf- monthesi- staffpf-staffesi-professiontax; 
						
						Hashtable<String,String> h8 = new Hashtable<String,String>();
						h8.put("f1", "TAKEHOME = "+CommonFunctions.indianCurrencyFormat().format(takehome));
						h8.put("f2"," " );
						h8.put("f3"," ");
						al.add(h8);

						int th=(int)takehome;
						map.put("numberWord",CommonFunctions.numberWord1(Integer.toString(th)));
						System.out.println(map);
						System.out.println(al);
					}
				}
				jasperPrint=ReportFunctions.createAppraisalLetterReport(jasperPrint, request, response, reportDir, rptfilename, al, Path,map,reportDir1);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
			}

		} 
		catch (Exception e) 
		{
			 
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request,response);
		}
	}

}