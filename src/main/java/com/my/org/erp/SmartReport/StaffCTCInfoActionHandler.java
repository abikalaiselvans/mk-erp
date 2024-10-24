package com.my.org.erp.SmartReport;

import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.Style;
import ar.com.fdvs.dj.domain.builders.ColumnBuilder;
import ar.com.fdvs.dj.domain.builders.DynamicReportBuilder;
import ar.com.fdvs.dj.domain.constants.Border;
import ar.com.fdvs.dj.domain.constants.Font;
import ar.com.fdvs.dj.domain.constants.HorizontalAlign;
import ar.com.fdvs.dj.domain.constants.VerticalAlign;
import ar.com.fdvs.dj.domain.entities.columns.AbstractColumn;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class StaffCTCInfoActionHandler extends AbstractActionHandler 
{

	
	JRExporter exporter;
	protected JasperReport jr;
	protected JasperPrint jp;
	JRDataSource ds;
	String cmpyname="";
	String brname="";
	String officename="";
	String deptname="";
	String categoryName="";
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("inside CTC handle");
		try 
		{ 
			String action = request.getParameter("actionS");
			if(action.equals("RPTStaffCTCInfo")) 
			{
			
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			File reportsDir = new File(Path + "/report/SmartCommon/" + rptfilename+".jrxml");
			String path=Path + "/report/SmartCommon/" + rptfilename+".jrxml";
			 
			String cmpy=request.getParameter("company");
			String branch=request.getParameter("branch");
			String office = request.getParameter("Office");
			String dept = request.getParameter("dept");
			String category=request.getParameter("Category");
			String sorting = request.getParameter("sorting");
			String Resigned = request.getParameter("Resigned");
			String ss = request.getParameter("ss");
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

			if(!"0".equals(cmpy))
				cmpyname = CommonFunctions.QueryExecutecon(con,"SELECT CHR_COMPANYNAME FROM  com_m_company  WHERE INT_COMPANYID="+cmpy)[0][0];
			else
				cmpyname="ALL";
			if(!"0".equals(branch))
			{	brname = CommonFunctions.QueryExecutecon(con,"SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+branch)[0][0];
			}
			else
				brname="ALL";
			
			if(!"0".equals(office))
				officename = CommonFunctions.QueryExecutecon(con, "select CHR_OFFICENAME  FROM com_m_office WHERE INT_OFFICEID="+office)[0][0];
			else
				officename = "ALL";
			if(!"0".equals(dept))
				deptname = CommonFunctions.QueryExecutecon(con, "select chr_departname FROM com_m_depart WHERE INT_DEPARTID="+dept)[0][0];
			else
				deptname = "ALL";
			if(!"0".equals(category))
				categoryName = CommonFunctions.QueryExecutecon(con, "select chr_categoryname FROM com_m_employeecategory WHERE INT_EMPLOYEECATEGORYID="+category)[0][0];
			else
				categoryName = "ALL";
	
		
				
				 if (!reportsDir.exists()) 
		          {
		        	  throw new FileNotFoundException(String.valueOf(reportsDir));
		          }
		          map.put("company",cmpyname);
		          map.put("branch", brname);
		          map.put("office", officename);
		          map.put("dept", deptname);
		          map.put("category", categoryName);
		          DynamicReportBuilder drb = new DynamicReportBuilder();
		          Font font = new Font(8,"Times New Roman",true);
		          Style headerStyle = new Style();
		          headerStyle.setFont(font);
		          headerStyle.setHorizontalAlign(HorizontalAlign.CENTER);
		          headerStyle.setVerticalAlign(VerticalAlign.MIDDLE);
		          headerStyle.setBorder(Border.PEN_1_POINT);
		          Color veryLightGrey = new Color(230, 230, 230);
		          headerStyle.setBackgroundColor(veryLightGrey);
		          font = new Font(7,"Verdana",false);
		          Style detailStyle = new Style();
		          detailStyle.setFont(font);
		          detailStyle.setHorizontalAlign(HorizontalAlign.LEFT);
		          detailStyle.setVerticalAlign(VerticalAlign.MIDDLE);
		          detailStyle.setBorder(Border.THIN);
		          detailStyle.setBackgroundColor(Color.cyan);
		          
		          Style amountStyle = new Style();
		          amountStyle.setFont(font);
		          amountStyle.setHorizontalAlign(HorizontalAlign.RIGHT);
		          amountStyle.setVerticalAlign(VerticalAlign.MIDDLE);
		          amountStyle.setBorder(Border.THIN);
		          amountStyle.setBackgroundColor(Color.cyan);
		          
		          AbstractColumn EMPID = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_EMPID", String.class.getName())
		          .setTitle("Employee Id").setWidth(250)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(EMPID);
		          
		          AbstractColumn NAME = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_STAFFNAME", String.class.getName())
		          .setTitle("Name").setWidth(300)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(NAME);
		          
		          AbstractColumn STAFFFNAME = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_STAFFFNAME", String.class.getName())
		          .setTitle("Father Name").setWidth(300)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(STAFFFNAME);
		          
		          AbstractColumn COMPANY = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_COMPANYNAME", String.class.getName())
		          .setTitle("Company").setWidth(400)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(COMPANY);
		          
		          AbstractColumn BRANCH = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_BRANCHNAME", String.class.getName())
		          .setTitle("Branch").setWidth(200)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(BRANCH);
		          
		          AbstractColumn OFFICE = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_OFFICENAME", String.class.getName())
		          .setTitle("Office").setWidth(200)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(OFFICE);
		          
		          AbstractColumn DEPARTMENT = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_DEPARTNAME", String.class.getName())
		          .setTitle("Department").setWidth(200)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(DEPARTMENT);
		          
		          AbstractColumn Designation = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_DESIGNAME", String.class.getName())
		          .setTitle("Designation").setWidth(300)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(Designation);
		          
		          AbstractColumn Category1 = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_CATEGORYNAME", String.class.getName())
		          .setTitle("Category").setWidth(200)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(Category1);
		          
		          AbstractColumn Gender = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_GENDER", String.class.getName())
		          .setTitle("Gender").setWidth(100)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(Gender);
		          
		          AbstractColumn dob = ColumnBuilder.getInstance()
		          .setColumnProperty("DATE_FORMAT(a.DT_DOB,'%d-%b-%Y')", String.class.getName())
		          .setTitle("Date of Birth").setWidth(150)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(dob);
		          
		          AbstractColumn doj = ColumnBuilder.getInstance()
		          .setColumnProperty("DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y')", String.class.getName())
		          .setTitle("Date of Joining").setWidth(150)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(doj);
		          
		          AbstractColumn workType = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_TYPE", String.class.getName())
		          .setTitle("Work Type").setWidth(200)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(workType);
		          
		         AbstractColumn exp = ColumnBuilder.getInstance()
		          .setColumnProperty("FIND_A_DATE_EXPERIENCE(a.DT_DOJCOLLEGE)", String.class.getName())
		          .setTitle("Experience").setWidth(300)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(exp);
		          
		          AbstractColumn repTo = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_REPTO", String.class.getName())
		          .setTitle("Reporting To").setWidth(250)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(repTo);
		          
		          AbstractColumn repHead = ColumnBuilder.getInstance()
		          .setColumnProperty("if(a.CHR_REP='Y', 'Reporting Head', ' ' )", String.class.getName())
		          .setTitle("Reporting Head").setWidth(200)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(repHead);
		          
		          
		          AbstractColumn PermanentAdd = ColumnBuilder.getInstance()
		          .setColumnProperty("FUN_GET_ADDRESS(a.CHR_EMPID,'P',',')", String.class.getName())
		          .setTitle("Permanent Address").setWidth(400)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(PermanentAdd);
		          
		          AbstractColumn communicationAdd = ColumnBuilder.getInstance()
		          .setColumnProperty("FUN_GET_ADDRESS(a.CHR_EMPID,'C',',')", String.class.getName())
		          .setTitle("Communication Address").setWidth(400)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(communicationAdd);
		          
		          AbstractColumn basicSalary = ColumnBuilder.getInstance()
		          .setColumnProperty("INT_SALARY", String.class.getName())
		          .setTitle("Basic Salary").setWidth(150)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(basicSalary);
		          
		          String aname[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM pay_m_allowance  ORDER BY INT_ALLOWANCEID");
					for(int a=0;a<aname.length;a++)
					{
						if("Y".equals(aname[a][2]))
						{
							addedallowance =addedallowance+"j."+aname[a][0]+",";
							addedallowancetitle=addedallowancetitle+aname[a][1]+",";
							addedsum = addedsum+"j."+aname[a][0]+"+";
							
							
							AbstractColumn addedallowancecol = ColumnBuilder.getInstance()
					          .setColumnProperty(aname[a][0], String.class.getName())
					          .setTitle(aname[a][0]).setWidth(80)
					          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
					          drb.addColumn(addedallowancecol); 
					          
					          
						}
						else
						{
							extraallowance =extraallowance+"j."+aname[a][0]+",";
							extraallowancetitle=extraallowancetitle+aname[a][1]+",";
							extrasum = extrasum+"j."+aname[a][0]+"+";
							
							 AbstractColumn extraallowancecol = ColumnBuilder.getInstance()
					          .setColumnProperty(aname[a][0], String.class.getName())
					          .setTitle(aname[a][0]).setWidth(80)
					          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
					          drb.addColumn(extraallowancecol);
					          
							
					      
						}
						
					
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
			         
						
					AbstractColumn addedsumcol = ColumnBuilder.getInstance()
			          .setColumnProperty("("+addedsum+")", String.class.getName())
			          .setTitle("Sum of Gross Allowance").setWidth(80)
			          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
			          drb.addColumn(addedsumcol);
		          
			          AbstractColumn extrasumcol = ColumnBuilder.getInstance()
			          .setColumnProperty("("+extrasum+")", String.class.getName())
			          .setTitle("Sum of Reimbursement").setWidth(80)
			          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
			          drb.addColumn(extrasumcol);
			          
			       AbstractColumn GrossSal = ColumnBuilder.getInstance()
		          .setColumnProperty("( a.INT_SALARY+ "+addedsum+" )", String.class.getName())
		          .setTitle("Gross Salary").setWidth(80)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(GrossSal);
		          
		          
		          String rname[][] = CommonFunctions.QueryExecute("SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery ORDER BY INT_RECOVERYID");;
				 	for(int a=0;a<rname.length;a++)
					{
						recovery =recovery+"k."+rname[a][0]+",";
						recoverytitle=recoverytitle+rname[a][1]+",";
						recsum=recsum+"k."+rname[a][0]+"+";
						
						AbstractColumn recoverycol = ColumnBuilder.getInstance()
				          .setColumnProperty(rname[a][0], String.class.getName())
				          .setTitle(rname[a][0]).setWidth(80)
				          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
				          drb.addColumn(recoverycol); 
					}
				 	
					recovery = recovery.trim();
					recovery = recovery.substring(0,recovery.length()-1);
					recoverytitle = recoverytitle.trim();
					recoverytitle = recoverytitle.substring(0,recoverytitle.length()-1);
					recsum = recsum.trim();
					recsum = recsum.substring(0,recsum.length()-1);
					
					AbstractColumn recoverysumcol = ColumnBuilder.getInstance()
			          .setColumnProperty("("+recsum+")", String.class.getName())
			          .setTitle("Sum of Recovery").setWidth(80)
			          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
			          drb.addColumn(recoverysumcol);
		          
		          
		          AbstractColumn pfType = ColumnBuilder.getInstance()
		          .setColumnProperty("if(a.CHR_PF = 'C' , 'Common' , 'No')", String.class.getName())
		          .setTitle("PF Type").setWidth(80)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(pfType);
		          
		        
		          
		          AbstractColumn pfNo = ColumnBuilder.getInstance()
		          .setColumnProperty("CONCAT(b.CHR_PFNUMBER,a.CHR_PFNO)", String.class.getName())
		          .setTitle("PF Number").setWidth(200)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(pfNo);
		          
		          AbstractColumn pfAmt = ColumnBuilder.getInstance()
		          .setColumnProperty("FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE  )", String.class.getName())
		          .setTitle("PF Amount").setWidth(80)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(pfAmt);
		          
		          
		          AbstractColumn ESIType = ColumnBuilder.getInstance()
		          .setColumnProperty("if(a.CHR_ESI = 'C' , 'Common' , 'No')", String.class.getName())
		          .setTitle("ESI Type").setWidth(80)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(ESIType);
		          
		        
		          
		          AbstractColumn ESINo = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_ESINO", String.class.getName())
		          .setTitle("ESI Number").setWidth(200)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(ESINo);
		          
		          AbstractColumn ESIAmt = ColumnBuilder.getInstance()
		          .setColumnProperty("FUN_PAY_GET_ESI_CALCULATION('CPY',a.CHR_EMPID,a.CHR_ESI)", String.class.getName())
		          .setTitle("ESI Amount").setWidth(80)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(ESIAmt);
		          
		          AbstractColumn total = ColumnBuilder.getInstance()
		          .setColumnProperty("FIND_A_EMPLOYEE_CTC_TOTAL("+addedsum+","+recsum+",a.CHR_EMPID)", String.class.getName())
		          .setTitle("Total").setWidth(80)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(total);
		          
		          AbstractColumn ctc = ColumnBuilder.getInstance()
		          .setColumnProperty("FIND_A_EMPLOYEE_CTC("+addedsum+","+recsum+","+extrasum+",a.CHR_EMPID)", String.class.getName())
		          .setTitle("CTC").setWidth(80)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(ctc);
		          
		          AbstractColumn bankName = ColumnBuilder.getInstance()
		          .setColumnProperty("FIND_A_BANKGROUP_NAME(a.CHR_BANK)", String.class.getName())
		          .setTitle("Bank Name").setWidth(300)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(bankName);
		          
		          AbstractColumn accNo = ColumnBuilder.getInstance()
		          .setColumnProperty("CHR_ACCNO", String.class.getName())
		          .setTitle("Account Number").setWidth(200)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(accNo);
		          
		          AbstractColumn status = ColumnBuilder.getInstance()
		          .setColumnProperty("IF(a.CHR_TYPE='T' ,'RESIGNED', IF(a.CHR_TYPE ='H' ,'HOLD','LIVE') )", String.class.getName())
		          .setTitle("Status").setWidth(100)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(status);
		          
		          
		          drb.setUseFullPageWidth(true);
		          
		          drb.setTemplateFile(path);
		          DynamicReport dr = drb.build();
		          jr = DynamicJasperHelper.generateJasperReport(dr, new ClassicLayoutManager(),map);
			 
			sql = sql + " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME, ";
			sql = sql + " f.CHR_DESIGNAME,h.CHR_CATEGORYNAME, a.CHR_GENDER ,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y') , ";
			sql = sql + " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),a.CHR_TYPE, ";

			sql = sql + " FIND_A_DATE_EXPERIENCE(a.DT_DOJCOLLEGE),";
				
			sql = sql + " a.CHR_REPTO, ";
			sql = sql + " if(a.CHR_REP='Y', 'Reporting Head', ' ' ), ";
			sql = sql + " FUN_GET_ADDRESS(a.CHR_EMPID,'P',','), ";
			sql = sql + " FUN_GET_ADDRESS(a.CHR_EMPID,'C',','), ";
			sql = sql + " a.INT_SALARY, ";
			sql = sql + addedallowance +","; //gross allowance
			sql = sql + extraallowance+","; // extra allowance
			sql = sql + "("+addedsum+"),"; // sum of gross allowance
			sql = sql + "("+extrasum+"),";// sum of other allowance
			sql = sql + "( a.INT_SALARY+ "+addedsum+" ) ,"; //Gross
			sql = sql + recovery+","; // recovery
			sql = sql + "("+recsum+"),"; // sum of recovery
			sql = sql + " if(a.CHR_PF = 'C' , 'Common' , 'No'),CONCAT(b.CHR_PFNUMBER,a.CHR_PFNO),FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE  ), ";
			sql = sql + " if(a.CHR_ESI = 'C' , 'Common' , 'No'),a.CHR_ESINO,FUN_PAY_GET_ESI_CALCULATION('CPY',a.CHR_EMPID,a.CHR_ESI), ";

			sql=sql+" FIND_A_EMPLOYEE_CTC_TOTAL("+addedsum+","+recsum+",a.CHR_EMPID),";
			sql = sql + " FIND_A_EMPLOYEE_CTC("+addedsum+","+recsum+","+extrasum+",a.CHR_EMPID) ,";

			sql = sql + " FIND_A_BANKGROUP_NAME(a.CHR_BANK) ,a.CHR_ACCNO,IF(a.CHR_TYPE='T' ,'RESIGNED', IF(a.CHR_TYPE ='H' ,'HOLD','LIVE') )      ";
			sql = sql + " FROM com_m_staff a,com_m_company b,com_m_branch c, com_m_office d,com_m_depart e,com_m_desig f, ";
			sql = sql + " com_m_employeecategory h, pay_t_allowance j,pay_t_recovery k  ";
			sql = sql + " WHERE a.CHR_HOLD!='Y' ";
			if("N".equals(Resigned))
				sql = sql + " AND a.CHR_TYPE !='T'  ";
			else
				sql = sql + " AND a.CHR_TYPE ='T'  ";
				
			sql = sql + " AND a.INT_COMPANYID = b.INT_COMPANYID  ";
			sql = sql + " AND a.INT_BRANCHID = c.INT_BRANCHID ";
			sql = sql + " AND a.INT_OFFICEID = d.INT_OFFICEID  ";
			sql = sql + " AND a.INT_DEPARTID = e.INT_DEPARTID  ";
			sql = sql + " AND a.INT_DESIGID = f.INT_DESIGID  ";
			sql = sql + " AND a.CHR_CATEGORY= h.INT_EMPLOYEECATEGORYID ";
			sql = sql + " AND a.CHR_EMPID =j.CHR_EMPID  ";
			sql = sql + " AND a.CHR_EMPID =k.CHR_EMPID  ";
			 
			if(!"0".equals(cmpy))
				sql = sql + " AND  a.INT_COMPANYID= "+cmpy;
			 if(!"0".equals(branch))
				 	sql = sql +" AND  a.INT_BRANCHID= "+branch;
				
			if(!"0".equals(office))
				sql = sql + " AND  a.INT_OFFICEID= "+office;
			if(!"0".equals(dept))
				sql = sql + " AND  a.INT_DEPARTID= "+dept;	
			if(!"0".equals(category))
				sql = sql + " AND  CHR_CATEGORY= "+category;	
				
			sql = sql + " ORDER BY  "+ sorting +" "+ss; 
			System.out.println("sql ssssssss:"+sql); 
			 
			
			ResultSet rs = null;
		    		   
		    try{
		                Statement stmt = con.createStatement();
		                rs = stmt.executeQuery(sql);  
		                ds = new JRResultSetDataSource(rs);
		        }
		        catch(Exception e)
		        {
		        	request.setAttribute("error", e.getMessage() );
					RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    		dispatchers.forward(request, response);
		        }
		       
		          if (ds != null) {
		        	  jp = JasperFillManager.fillReport(jr, map, ds);
		          } else {
		        	  jp = JasperFillManager.fillReport(jr, map);
		          } 
		          ReportFunctions.generateAllReport(exporter, jp, request, response, reporttype, Path, rptfilename);
		          System.out.println("build report ended");
			
				
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
