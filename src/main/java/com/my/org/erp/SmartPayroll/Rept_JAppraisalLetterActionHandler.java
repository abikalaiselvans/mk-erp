package com.my.org.erp.SmartPayroll;
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
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;


public class Rept_JAppraisalLetterActionHandler extends AbstractActionHandler 
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
			System.out.println("ACTION HANDLER FROM APPARAISAL LETTER ");
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String subrptfilename1 = request.getParameter("subrptfilename1");
			String reporttype = request.getParameter("reportType");
			String apparaisalid = request.getParameter("apparaisalid");
			
			if (action.equals("PAYRept_JAppraisalLetter")) 
			{	
				System.out.println("inside action");
				String path=Path + "/report/SmartPayroll/" + rptfilename+".jrxml";
				String path1=Path + "/report/SmartPayroll/" + subrptfilename1+".jrxml";
				File reportDir = new File(path);
				File reportDir1 = new File(path1);
				HashMap<Object,Object> map = new HashMap<Object,Object>();
								
				if (!reportDir.exists() || !reportDir1.exists()) 
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
				
				String sql= "";
				List<Hashtable<String,String>> al=new ArrayList<Hashtable<String,String>>();
				
				String Staffid= request.getParameter("staffid");
				String month= request.getParameter("month");
				String year= request.getParameter("year");
				sql=sql+" SELECT h.CHR_SHORTNAME,i.INT_APPRAISALID,DATE_FORMAT(i.DAT_DOR,'%d-%b-%Y'),i.INT_OLDCTC,i.INT_CTC,g.INT_SALARY,";
				sql=sql+" CONCAT(if(a.CHR_GENDER='Male','Mr.',(if(a.CHR_MARITALSTATUS ='M','Mrs.' ,'Ms.'))),' ',a.CHR_STAFFNAME),"; 
				sql=sql+" a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_DESIGNAME, ";
				sql=sql+" DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y') ,DATE_FORMAT( g.DAT_RIVISION,'%d-%b-%Y'),  ";
				sql=sql +" FIND_A_INSTITUTION_NAME()  "; 
				sql=sql+" FROM com_m_staff a  ,com_m_company b,com_m_branch c, com_m_office d,com_m_depart e,com_m_desig f,";
				sql=sql+" pay_t_appraisal_basic g,m_institution h,pay_t_appraisal i  ";
				sql=sql+" WHERE a.INT_COMPANYID = b.INT_COMPANYID ";
				sql=sql+" AND a.INT_BRANCHID = c.INT_BRANCHID ";
				sql=sql+" AND a.INT_OFFICEID = d.INT_OFFICEID ";
				sql=sql+" AND a.INT_DEPARTID = e.INT_DEPARTID AND a.CHR_EMPID = i.CHR_EMPID ";
				sql=sql+" AND a.INT_DESIGID = f.INT_DESIGID  AND a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y'   ";
				sql=sql+" AND  a.CHR_EMPID = g.CHR_EMPID  AND  a.CHR_EMPID = '"+Staffid+"' ";
				sql=sql+" AND g.INT_APPRAISALID = i.INT_APPRAISALID ";
				sql=sql+" AND CHR_MONTH = '"+DateUtil.getMonth(Integer.parseInt(month))+"' AND INT_YEAR ="+year;
				sql=sql+"  AND  i.INT_APPRAISALID = "+apparaisalid; 
				sql=sql+" ORDER BY a.CHR_STAFFNAME "; 
				System.out.println(sql);
				String data1[][] =  CommonFunctions.QueryExecute(sql);
			
				map.put("instiShortName",data1[0][0]);
				map.put("refno",data1[0][1]);	
				String yr=CommonFunctions.AccountjYear();
				map.put("accountYear",yr);
				String apdate=DateUtil.FormateDateSys(DateUtil.getCurrentDBDate());
				String dateid[]=apdate.split("-");
				String appdate=dateid[0]+" "+ DateUtil.getMonth(Integer.parseInt(dateid[1]))+" "+dateid[2]; 
				map.put("date", appdate);
				map.put("cpy",data1[0][16]);
				map.put("desig",data1[0][12]);
				map.put("desigWCodes","\""+data1[0][12]+"\"");
				map.put("office",data1[0][10]);
				map.put("empRespect",data1[0][6]);
				map.put("staffname",data1[0][8] +" [ "+ Staffid + "  ]");	
				map.put("basic",CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(data1[0][5])));
				map.put("oldctc","Rs."+CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(data1[0][3]))+"/-");
				map.put("ctc","Rs."+CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(data1[0][4]))+"/-");
				map.put("dor","\""+data1[0][2]+"\"");

				String allowancefield[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
				String sumgrossallowancefield="";
				String sumothersallowancefield="";
				String allowancefields="";
				String grossallowancefield="";
				String othersallowancefield="";
				String grossallowancename="";
				String otherallowancename="";
				double totalctc =0.0;
				double basic =0.0;
				double grossallowance =0.0;
				double gross =0.0;
				double otherallowance =0.0;
				double recoverytotal=0;
				double emploeerpf =0;
				double emploeerpf1 =0;
				double emploeeresi =0;
				double staffpf =0;
				double staffesi =0;
				double takehome=0;
				
				if(allowancefield.length>0)
				{
					for(int u=0;u<allowancefield.length;u++)
					{
						if("Y".equals(allowancefield[u][2]))
						{
							sumgrossallowancefield =sumgrossallowancefield+ " ROUND(b."+allowancefield[u][0]+",2)+";
							grossallowancefield =grossallowancefield+ " ROUND(b."+allowancefield[u][0]+",2),";
							grossallowancename = grossallowancename +allowancefield[u][1]+",";
						}
						else
						{
							sumothersallowancefield =sumothersallowancefield+ " ROUND(b."+allowancefield[u][0]+",2)+";
							othersallowancefield =othersallowancefield+ " ROUND(b."+allowancefield[u][0]+",2),";	
							otherallowancename = otherallowancename +allowancefield[u][1]+",";
						}	
						allowancefields =allowancefields+ " ROUND( b."+allowancefield[u][0]+",2),";
					}
				}
				
				String recoveryfield[][] =  CommonFunctions.QueryExecute("SELECT CHR_RCODE,CHR_RNAME  FROM  pay_m_recovery ORDER BY INT_RECOVERYID");
				String sumrecoveryfield="";
				String recoveryfields="";
				String recoveryname="";
				if(recoveryfield.length>0)
				{
					for(int u=0;u<recoveryfield.length;u++)
					{
						sumrecoveryfield =sumrecoveryfield+ "ROUND( c."+recoveryfield[u][0]+",2)+";
						recoveryfields =recoveryfields+ " ROUND(c."+recoveryfield[u][0]+",2),";
						recoveryname =recoveryname+ recoveryfield[u][1]+",";
						
					}
				}

				String bsql="SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,INT_PFLIMITMINIMUM ,  INT_PFLIMIT,INT_ESILIMIT FROM m_institution WHERE INT_ID=1";
				String basicdata[][] =  CommonFunctions.QueryExecute(bsql);

				double pf=Double.parseDouble(basicdata[0][0]);
				double esi=Double.parseDouble(basicdata[0][1]);
				double cpypf=Double.parseDouble(basicdata[0][2]);
				double cpypension=Double.parseDouble(basicdata[0][3]);
				double cpyesi=Double.parseDouble(basicdata[0][4]);
				double dbminimumpflimit=Double.parseDouble(basicdata[0][5]);
				double dbpmaximumflimit=Double.parseDouble(basicdata[0][6]);
				double dbesilimit=Double.parseDouble(basicdata[0][7]);			
				
				sql =  "SELECT a.CHR_EMPID,a1.CHR_STAFFNAME,DATE_FORMAT(a1.DT_DOJCOLLEGE,'%d-%m-%Y'),   "; 
				sql = sql +  "a.CHR_PF,a.CHR_PFTYPE,a.CHR_ESI,a.CHR_ESITYPE,      ";
				sql = sql +  " ROUND(a.INT_SALARY,2) ,        ";
				sql = sql +  "  "+grossallowancefield;
				sql = sql +  "  ( "+sumgrossallowancefield+" 0) ,   ";
				sql = sql +  "  ( a.INT_SALARY +  "+sumgrossallowancefield+" 0),     ";
				sql = sql +  "    "+othersallowancefield;
				sql = sql +  "   (  "+sumothersallowancefield+"0),     ";
				sql = sql +  "(a.INT_SALARY +  ("+sumgrossallowancefield+" 0)   ";
				sql = sql +  "  +   ("+sumothersallowancefield+"0)  ),    ";
				sql = sql +  " "+recoveryfields;
				sql = sql +  " ( "+sumrecoveryfield+"0) ,    ";




				//sql = sql +  " ## EMPLOYEE PF CALCULATION    "; 
				sql = sql +  " FUN_PAY_GET_REVISION_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE ,a.INT_APPRAISALID  )   staffpf, ";
   
				//sql = sql +  " ## EMPLOYEE ESI CALCULATION    ";  
				sql = sql +  "  FUN_GET_ESIAMOUNT('STAFF',a.CHR_ESI,d.INT_GROSS )   staffesi ,  ";

				//sql = sql +  " ## EMPLOYEE PF  "+cpypf + " % CALCULATION   ";
				sql = sql +  " ( FUN_PAY_GET_REVISION_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE,a.INT_APPRAISALID   )/"+pf+" * "+cpypf+" ) cpypf,   ";
				 
				//sql = sql +  " ## EMPLOYEE PF " + cpypension +" % CALCULATION  ";
				sql = sql +  " (FUN_PAY_GET_REVISION_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE,a.INT_APPRAISALID   )/"+pf+"* "+cpypension+" ) cpypf,   ";

				//sql = sql +  "## COMPANY ESI CALCULATION  ";        
				sql = sql +  "  FUN_GET_ESIAMOUNT('COMPANY',a.CHR_ESI,d.INT_GROSS )    cpyesi ,a.CHR_PFCALCULATIONTYPE  ";
				 
				sql = sql +  " FROM com_m_staff a1 ,pay_t_appraisal_basic a,pay_t_appraisal_allowance b,pay_t_appraisal_recovery c   , pay_t_appraisal d  ";  
				sql = sql +  " WHERE  a1.CHR_EMPID =  b.CHR_EMPID  AND a.CHR_EMPID =  b.CHR_EMPID   "; 
				sql = sql +  " AND a.CHR_EMPID =  c.CHR_EMPID    "; 
				sql = sql +  "  AND d.INT_APPRAISALID = a.INT_APPRAISALID ";
				sql = sql +  "  AND d.INT_APPRAISALID = b.INT_APPRAISALID ";
				sql = sql +  "  AND d.INT_APPRAISALID = c.INT_APPRAISALID ";
				sql = sql +  " AND  a.CHR_EMPID='"+Staffid+"'   "; 
				sql = sql +  " AND  a.INT_APPRAISALID =  "+apparaisalid;
				sql = sql +  " AND  b.INT_APPRAISALID =  "+apparaisalid;
				sql = sql +  " AND  c.INT_APPRAISALID =  "+apparaisalid;

				System.out.println(sql);
				String takeupdatas[][] =  CommonFunctions.QueryExecute(sql);
				if(takeupdatas.length>0)  
					if(!"-".equals(takeupdatas[0][0]))
					{
						Hashtable<String,String> h1 = new Hashtable<String,String>();
						int getrow=8;
						totalctc =0.0;
						h1.put("f1", "Basic");
						h1.put("f2", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(takeupdatas[0][7])));
						basic = Double.parseDouble(takeupdatas[0][7]);
						al.add(h1);
						
						totalctc = totalctc+Double.parseDouble(takeupdatas[0][7]);
					
			
						String grossdata[] = grossallowancename.split(",");
						if(grossdata.length>0)
						{
							for(int u=0;+u<grossdata.length;u++)
							{
								 Hashtable<String,String> h2 = new Hashtable<String,String>();
									h2.put("f1", grossdata[u]);
									if(!takeupdatas[0][(getrow+u)].equals("0.00"))
									{
										h2.put("f2", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(takeupdatas[0][(getrow+u)])));
										al.add(h2);
									}
									grossallowance =grossallowance+Double.parseDouble(takeupdatas[0][(getrow+u)]);
								
							}
						}
						
						
						getrow = getrow+grossdata.length;	
						totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
						
						getrow = getrow+1;	
						
						Hashtable<String,String> h7 = new Hashtable<String,String>();
						h7.put("f1", "Gross Pay");
						h7.put("f2", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(takeupdatas[0][getrow])));
						gross = basic + grossallowance;//manual calculation
						gross = Double.parseDouble(takeupdatas[0][getrow]);//sql calculation
						al.add(h7);
					 	

						getrow = getrow+1;
						Hashtable ah = new Hashtable();
						ah.put("f1", "Added Allowance");
						ah.put("f2", "");
						al.add(ah); 
						
						String othersdata[] = otherallowancename.split(",");
						if(othersdata.length>0)
							for(int u=0;+u<othersdata.length;u++)
							{
								 Hashtable<String,String> h2 = new Hashtable<String,String>();
								if(!takeupdatas[0][(getrow+u)].equals("0.00"))
								{
								h2.put("f1", othersdata[u]);
								h2.put("f2", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(takeupdatas[0][(getrow+u)])));
								otherallowance = otherallowance+Double.parseDouble(takeupdatas[0][(getrow+u)]);
								al.add(h2);
								}
								
							}
							
							
						getrow = getrow+othersdata.length;
						totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
						getrow = getrow+1;	
						getrow = getrow+1;	
						String recdata[] = recoveryname.split(",");
						
						int r=-1;
						if(recdata.length>0)
						{	
							Hashtable rh = new Hashtable();
							rh.put("f1", "Recovery");
							rh.put("f2", "");
							al.add(rh); 
								
							for(int u=0;+u<recdata.length;u++)
							{
								 Hashtable<String,String> h2 = new Hashtable<String,String>();
								 if(!takeupdatas[0][(getrow+u)].equals("0.00"))
								 {
									 h2.put("f1",recdata[u]);
									 h2.put("f2", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(takeupdatas[0][(getrow+u)])));
									 al.add(h2);
									  recoverytotal = recoverytotal+Double.parseDouble(takeupdatas[0][(getrow+u)]);
								 }
							}	
							
							 Hashtable rh8 = new Hashtable();
							rh8.put("f1", "Recovery Total");
							rh8.put("f2", CommonFunctions.indianCurrencyFormat().format(recoverytotal));
							rh8.put("f3", CommonFunctions.indianCurrencyFormat().format(recoverytotal*12));
							al.add(rh8); 
						}
						getrow = getrow+recdata.length;	 
						
						//STAFF CONTRIBUTION
						getrow = getrow+1;		
						Hashtable<String,String> h8 = new Hashtable<String,String>();
						h8.put("f1", "Employee PF");
						h8.put("f2", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(takeupdatas[0][getrow])));
						staffpf = Double.parseDouble(takeupdatas[0][getrow]);
						//al.add(h8);
 
						getrow = getrow+1;	
						Hashtable<String,String> h9 = new Hashtable<String,String>();
						h9.put("f1", "Employee ESI");
						h9.put("f2", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(takeupdatas[0][getrow])));
						staffesi = Double.parseDouble(takeupdatas[0][getrow]);
						//al.add(h9);
 					
						
						//COMPANY CONTRUBUTION
						getrow = getrow+1;
						Hashtable<String,String> h10 = new Hashtable<String,String>();
						h10.put("f1", "Employer PF1");
						h10.put("f2", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(takeupdatas[0][getrow])));
						emploeerpf = Double.parseDouble(takeupdatas[0][getrow]);
						//al.add(h10);
						
						
 						totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
						
						getrow = getrow+1;	
						Hashtable<String,String> h11 = new Hashtable<String,String>();
						h11.put("f1", "Employer PF2");
						h11.put("f2", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(takeupdatas[0][getrow])));
						emploeerpf1 = Double.parseDouble(takeupdatas[0][getrow]);
						//al.add(h11);
 						
						
						Hashtable<String,String> ph10 = new Hashtable<String,String>();
						ph10.put("f1", "Employer PF");
						ph10.put("f2", CommonFunctions.indianCurrencyFormat().format(emploeerpf+emploeerpf1));
						al.add(ph10);
						
						
						getrow = getrow+1;	
						Hashtable<String,String> h4 = new Hashtable<String,String>();
						h4.put("f1", "Employer ESI");
						h4.put("f2", CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(takeupdatas[0][getrow])));
						emploeeresi= Double.parseDouble(takeupdatas[0][getrow]);
						al.add(h4);
						
						
						//CTC = gross + cpypf +cpyesi + added allowance - recovery total
						totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
 						totalctc = totalctc+Double.parseDouble(takeupdatas[0][getrow]);
 						
 						totalctc = gross+emploeerpf+emploeerpf1+emploeeresi+otherallowance-recoverytotal;
					    Hashtable<String,String> h6 = new Hashtable<String,String>();
						h6.put("f1", "Total Cost To Company (TCTC)");
						h6.put("f2", CommonFunctions.indianCurrencyFormat().format(totalctc));
						
						
						//Calculating Profession tax
						asql = "SELECT FUN_PAY_GET_ORIGINAL_PROFESSIONAL_TAX_AMOUNTS('"+Staffid+"', "+gross+" ) " ;
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
						
						//Take Home = ctc-cpypf -cpyesi -staffpf-staffesi-professionaltax
						takehome= totalctc - emploeerpf-emploeerpf1-emploeeresi-staffpf-staffesi-professionaltax  ;
						map.put("takehome", ""+takehome);
						
						/*Hashtable th6 = new Hashtable();
						th6.put("f1", "Takehome");
						th6.put("f2", takehome);
						th6.put("f3", (takehome)*12);
						al.add(th6);
						*/
						al.add(h6);
						
					}
				System.out.println("al:"+al);
				jasperPrint=ReportFunctions.createAppraisalLetterReport(jasperPrint, request, response, reportDir, rptfilename, al, Path,map,reportDir1);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
			}
			
		} catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request,response);
		}
	}
	
}