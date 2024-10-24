package com.my.org.erp.SmartPayroll;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
 
import com.my.org.erp.Date.Day;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.SmartReport.ReportFunctions2;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JPaySlipActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	String logoImgExpression="";
	String bkImgExpression="";
	String RsImgExpression="";
	int columncount1;
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("inside PAYRept_JPaySlip handle");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String subRptfilename = request.getParameter("subRptfilename");
			String reporttype = request.getParameter("reportType");
			if (action.equals("PAYRept_JPaySlip")) 
			{
			System.out.println("inside PAYRept_JPaySlip");
			System.out.println("Path:");
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				System.out.println("Path:");
				System.out.println("Path:"+Path);
				System.out.println("reportDir:"+reportDir);
				File subReport1Dir = new File(Path + "/report/SmartPayroll/" + subRptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				List<Hashtable> al=new ArrayList<Hashtable>();
			
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				File logoImage = new File(Path + "/images/logo.jpg");
				File backgroundImage = new File(Path + "/images/payslip.jpg");
				File rupeesImage = new File(Path + "/Image/report/Rupee.jpeg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
				logoImgExpression=(logoImage.exists())?"../../images/logo.jpg":null;
				bkImgExpression=(backgroundImage.exists())?"../../images/payslip.jpg":null;
				RsImgExpression=(rupeesImage.exists())?"../../Image/report/Rupee.jpeg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				map.put("logoImgExpression", logoImgExpression);
				map.put("bkImgExpression", bkImgExpression);
				map.put("RsImgExpression", RsImgExpression);
				
				try
				{
					String staffid = "" + request.getParameter("ename");
					String mth = "" + request.getParameter("Month");
					String mont = DateUtil.getMonth(Integer.parseInt(mth));
					String Year = "" + request.getParameter("Year");
					 
					String staffname="";
					String cpyname="";
					String desig="";
					String office="";
					String esinumber="";
					String pfnumber="";
					String bank="";
					String sql="";
					String sallowansql="";
					String srecoverysql="";
					String addedallowance="";
					String extraallowance="";
					String addedallowancetitle="";
					String extraallowancetitle="";
					String recovery="";
					String recoverytitle="";
					String addedsum="";
					String extrasum="";
					String recsum="";
					double basic=0;
					double grosspay=0.0;
					double pf=0;
					double esi =0;
					double advance=0;
					double wrkdays=0;
					double ramount=0;
					double deduction=0;
					double originalbasic=0;
					double originalgross=0;
					double earninggross=0;
					double originalextraallowance=0;
					double extraallowances=0;
					double taxvalue=0;
					sql = " SELECT b.CHR_STAFFNAME,f.CHR_COMPANYNAME,e.CHR_DESIGNAME,d.CHR_OFFICENAME,FIND_A_BANKGROUP_NAME(b.CHR_BANK) , b.CHR_ACCNO    ";
					sql = sql + " ,b.CHR_PFNO, b.CHR_ESINO ,b.INT_SALARY,f.CHR_PFNUMBER FROM com_m_staff b, com_m_office  d,com_m_desig e ,com_m_company f ";
					sql = sql + " WHERE b.CHR_EMPID='"+staffid+"'    ";
					sql = sql + " AND b.INT_OFFICEID=d.INT_OFFICEID      ";
					sql = sql + " AND b.INT_DESIGID=e.INT_DESIGID     ";
					sql = sql + " AND f.INT_COMPANYID = b.INT_COMPANYID    ";
					
					sql = " SELECT b.CHR_STAFFNAME,c.CHR_COMPANYNAME,d.CHR_DESIGNAME,e.CHR_OFFICENAME,FIND_A_BANKGROUP_NAME(b.CHR_BANK),a.CHR_ACCNO,    ";
					sql = sql + " b.CHR_PFNO, b.CHR_ESINO ,b.INT_SALARY,c.CHR_PFNUMBER ,concat(c.CHR_PFNUMBER,b.CHR_PFNO)    ";
					sql = sql + " FROM  pay_t_salary  a ,com_m_staff b,com_m_company c,com_m_desig d,com_m_office e    ";
					sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID    ";
					sql = sql + " AND a.INT_COMPANYID = c.INT_COMPANYID    ";
					sql = sql + " AND a.INT_DESIGID = d.INT_DESIGID    ";
					sql = sql + " AND a.INT_OFFICEID = e.INT_OFFICEID    ";
					sql = sql + " AND	a.CHR_EMPID='"+staffid+"'    ";
					sql = sql+" AND  a.INT_YEAR ="+Year;
					sql = sql+" AND a.CHR_MONTH='"+mont+"'";

					System.out.println(sql);
					String basicdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
					sql = " SELECT INT_SALARY FROM pay_t_salarybasic";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					String basics[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

					sql=" SELECT DOU_BASIC,DOU_ATOTAL1,DOU_GROSSPAY,(DOU_BASIC+DOU_ATOTAL1),DOU_ATOTAL2 FROM pay_t_salary  ";
				 	sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					String earning[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						
					if(basicdata.length>0)
					{
						staffname=basicdata[0][0];
						cpyname=basicdata[0][1];
						desig=basicdata[0][2];
						office=basicdata[0][3];
						esinumber=basicdata[0][7];
						pfnumber=basicdata[0][6];
						bank=basicdata[0][4] +" - " +basicdata[0][5];
						originalbasic = Double.parseDouble(basics[0][0]);
						earninggross  = Double.parseDouble(earning[0][2]);
						extraallowances=Double.parseDouble(earning[0][4]);
						ramount=0;
						deduction=0;
						originalgross=0;
						originalextraallowance=0;
						
						sql = "SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM pay_m_allowance  ORDER BY INT_ALLOWANCEID";
						String aname[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						for(int a=0;a<aname.length;a++)
							if("Y".equals(aname[a][2]))
							{
								addedallowance =addedallowance+aname[a][0]+",";
								addedallowancetitle=addedallowancetitle+aname[a][1]+",";
								addedsum = addedsum+aname[a][0]+"+";
							}
							else
							{
								extraallowance =extraallowance+aname[a][0]+",";
								extraallowancetitle=extraallowancetitle+aname[a][1]+",";
								extrasum = extrasum+aname[a][0]+"+";
							}
							
							addedallowance = addedallowance.trim();
							addedallowance = addedallowance.substring(0,addedallowance.length()-1);
							addedallowancetitle = addedallowancetitle.trim();
							addedallowancetitle = addedallowancetitle.substring(0,addedallowancetitle.length()-1);
							addedsum = addedsum.trim();
							addedsum = addedsum.substring(0,addedsum.length()-1);
							
							extraallowance = extraallowance.trim();
							extraallowance = extraallowance.substring(0,extraallowance.length()-1);
							extraallowancetitle = extraallowancetitle.trim();
							extraallowancetitle = extraallowancetitle.substring(0,extraallowancetitle.length()-1);
							extrasum = extrasum.trim();
							extrasum = extrasum.substring(0,extrasum.length()-1);
							
							 
							
							sql="SELECT ROUND(DOU_BASIC),ROUND(DOU_PF),ROUND(DOU_ESI),ROUND(DOU_ADVANCE),DOU_WORKDAYS,DOU_PAYTAX FROM pay_t_salary  ";
							sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
							sql = sql+" AND  INT_YEAR ="+Year;
							sql = sql+" AND CHR_MONTH='"+mont+"'";
							String salarydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							if(salarydata.length>0)
							{
							 	basic=Double.parseDouble(salarydata[0][0]);
								pf=Double.parseDouble(salarydata[0][1]);
								esi=Double.parseDouble(salarydata[0][2]);
								advance=Double.parseDouble(salarydata[0][3]);
								wrkdays=Double.parseDouble(salarydata[0][4]);
								taxvalue=Double.parseDouble(salarydata[0][5]);
				  
			String MON=	mont.toUpperCase();
			String reportHeader="PAY SLIP FOR "+MON +" - " +Year;
			map.put("reportHeader", reportHeader);
			map.put("staffname", staffname); 
			map.put("cpy", cpyname);
			map.put("eid", staffid);
			map.put("desig", desig);
			map.put("office", office);
			map.put("esino", esinumber);
			map.put("pfnumber", pfnumber);
			map.put("bank", bank.split("-")[0]);
			map.put("accno", bank.split("-")[1]);
			map.put("wrkdays", wrkdays);
			map.put("basic", basic);
			
									sql = "Select "+addedallowance+" FROM pay_t_salaryallowance  ";
									sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
									sql = sql+" AND  INT_YEAR ="+Year;
									sql = sql+" AND CHR_MONTH='"+mont+"'";
									String data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
									int columncount1 = com.my.org.erp.common.CommonFunctions.intGetColumnCount(sql);
									addedallowancetitle=addedallowancetitle+"";
									String titledata1[] = addedallowancetitle.split(",");
									
									
									if(columncount1>1)
									{
										for(int x=0;x<columncount1;x++)
										{
											if((Integer.parseInt(data1[0][x]))>0)
											{
												originalgross = originalgross+Integer.parseInt(data1[0][x]);
											}
											
										}	
										
									}
									originalgross = originalgross+originalbasic;
									
									sql = "Select "+extraallowance+" FROM pay_t_salaryallowance  ";
									sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
									sql = sql+" AND  INT_YEAR ="+Year;
									sql = sql+" AND CHR_MONTH='"+mont+"'";
									
									String data2[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
									int columncount2 = com.my.org.erp.common.CommonFunctions.intGetColumnCount(sql);
									extraallowancetitle=extraallowancetitle+"";
									String titledata2[] = extraallowancetitle.split(",");
								 
									if(columncount2>1)
									{
										for(int x=0;x<columncount2;x++)
											if((Integer.parseInt(data2[0][x]))>0)
												originalextraallowance = originalextraallowance+Integer.parseInt(data2[0][x]);
									}
									
								  	sql = " SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery ";
									String rname[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								
									String rallowansql="";
									 
									for(int a=0;a<rname.length;a++)
										rallowansql =rallowansql+rname[a][0]+" , ";
										
									rallowansql=rallowansql.trim();	
									rallowansql = rallowansql.substring(0,rallowansql.length()-1);
									sql= " SELECT "+rallowansql+" FROM pay_t_salary  ";
									sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
									sql = sql+" AND  INT_YEAR ="+Year;
									sql = sql+" AND CHR_MONTH='"+mont+"'";
									String recoverydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
									int columncount3 = com.my.org.erp.common.CommonFunctions.intGetColumnCount(sql);
									
									int colCount=(columncount1+columncount2+2)>columncount3+6?(columncount1+columncount2+2):columncount3+6;
										for(int u=0;u<rname.length;u++)
										{
										 ramount=0.0;
										 ramount=Double.parseDouble(recoverydata[0][u]);	;
										 deduction=deduction+ramount;
										}
										
										deduction=deduction+advance;
										deduction=deduction+pf;
										deduction=deduction+esi;
										deduction=deduction+taxvalue;
										map.put("netAmount",(int)((earninggross-deduction)+extraallowances));
										int namt=(int)((earninggross-deduction)+extraallowances);
										String nAmt=""+namt;
										map.put("netAmountWord",CommonFunctions.numberWord1(nAmt));
										int rdata[] = new int[colCount];
										int adata[] = new int[colCount];
										String deductiontitle[] = {"Advance","PF","ESI","Tax Value","Loss Of Pay","Total Deduction"};
										int deductionamount[] = {(int)advance,(int)pf,(int)esi,(int)taxvalue,(int)(originalgross-earninggross),(int)(deduction+(originalgross-earninggross))};
										String adatatitle[] = new String[colCount];
										String rdatatitle[] = new String[colCount];
										int i=0;
										for(int u=0;u<columncount1;u++)
										{
											if(	Integer.parseInt(data1[0][u])>0){
												adatatitle[i]=titledata1[u];
												adata[i]=Integer.parseInt(data1[0][u]);
												i++;
											}
										}
										adatatitle[i]="Gross Pay";
										adata[i]=(int)originalgross;
										i++;
										System.out.println("after gross pay i:"+i);
										for(int u=0;u<columncount2;u++)
										{
											if(	Integer.parseInt(data2[0][u])>0)
											{
											adatatitle[i]=titledata2[u];
											adata[i]=Integer.parseInt(data2[0][u]);
											i++;
											}
										}
										adatatitle[i]="Total";
										adata[i]=(int)(originalgross+originalextraallowance);
										i++;
										System.out.println("arter tot i:"+i);
										int j=0;
										for(int u=0;u<columncount3;u++)
										{
											if(	Integer.parseInt(recoverydata[0][u])>0)
											{
												rdatatitle[j]=rname[u][1];
												rdata[j]=Integer.parseInt(recoverydata[0][u]);
												j++;
											}
										}
										int k=j+deductiontitle.length;
										for(int u=1;u<deductiontitle.length;u++)
										{
											if(deductionamount[0]>0 && u==1)
												{
													System.out.println("deductionamount: "+deductionamount[0]);
													rdatatitle[j]=deductiontitle[0];
													rdata[j]=deductionamount[0];
													j++;
												}
											rdatatitle[j]=deductiontitle[u];
											rdata[j]=deductionamount[u];
											j++;
											
										}
										System.out.println("i:"+i);
										System.out.println("j:"+j);
										int maxlen=i>j?i:j;
									
										for(int u=0;u<maxlen;u++)
										{
											Hashtable h3 = new Hashtable();
											System.out.println("u:"+u);
											if(i>u)
											{
											h3.put("d1", adatatitle[u]);
											h3.put("d2", adata[u]);
											}
											else{
												h3.put("d1", "");
												h3.put("d2", 0);
											}
											if(j>u)
											{
											h3.put("d5", rdatatitle[u]);
											h3.put("d6", rdata[u]);	
											}
											else
											{
												h3.put("d5", "");
												h3.put("d6", 0);
											}
											al.add(h3);
									}
							}
						 else
						 {
						 	//out.println("Data not found...");
						 }
					}
				   
				}
				catch(Exception e)
				{
					System.out.println(e.getMessage());
				}
				jasperPrint=ReportFunctions2.createReportUsingListDS(jasperPrint, request, response, reportDir, rptfilename, al, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
			}
			
		
		}
		
		 catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}
}