package com.my.org.erp.SmartPayroll;

import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.batik.bridge.DynamicGVTBuilder;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.CustomExpression;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.Style;
import ar.com.fdvs.dj.domain.builders.ColumnBuilder;
import ar.com.fdvs.dj.domain.builders.DynamicReportBuilder;
import ar.com.fdvs.dj.domain.constants.Border;
import ar.com.fdvs.dj.domain.constants.Font;
import ar.com.fdvs.dj.domain.constants.HorizontalAlign;
import ar.com.fdvs.dj.domain.constants.VerticalAlign;
import ar.com.fdvs.dj.domain.entities.columns.AbstractColumn;

import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JOriginalSalaryActionHandler extends AbstractActionHandler 
{

	
	JRExporter exporter;
	protected JasperReport jr;
	protected JasperPrint jp;
	JRDataSource ds;
	String cmpyname="";
	String brname="";
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("inside Rept_JOriginalSalaryInfo handle");
		try 
		{ 
			String action = request.getParameter("actionS");
			if(action.equals("PAYRept_JOriginalSalary")) 
			{
				System.out.println("inside PAYRept_JOriginalSalaryInfo handle");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			String path=Path + "/report/SmartPayroll/" + rptfilename+".jrxml";
			File reportsDir = new File(path);
			
			
			 if (!reportsDir.exists()) 
	          {
	        	  throw new FileNotFoundException(String.valueOf(reportsDir));
	          }
		 	
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
			
	          String sql ="";
	      	String  company  = request.getParameter("company");
	      	String  branch  = request.getParameter("branch");
	      	String  Office  = request.getParameter("Office");
	      	String Dept= request.getParameter("Dept");
	      	String orderby= request.getParameter("orderby");
	      	String Category=request.getParameter("Category");
	      	String resigned= request.getParameter("resigned");
	      	
	      	String allowancefield[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
	      	String sumgrossallowancefield="";
	      	String sumothersallowancefield="";
	      	String allowancefields="";
	      	
	      	if(allowancefield.length>0)
	      	{
	      		for(int u=0;u<allowancefield.length;u++)
	      		{
	      			if("Y".equals(allowancefield[u][2]))
	      				sumgrossallowancefield =sumgrossallowancefield+ " o."+allowancefield[u][0]+"+";
	      			else
	      				sumothersallowancefield =sumothersallowancefield+ " o."+allowancefield[u][0]+"+";
	      				
	      			allowancefields =allowancefields+ " o."+allowancefield[u][0]+",";
	      		}
	       	}
	      	
	      	
	      	 
	      	 
	      	String recoveryfield[][] = CommonFunctions.QueryExecute("SELECT CHR_RCODE,CHR_RNAME  FROM  pay_m_recovery ORDER BY INT_RECOVERYID");
	      	String sumrecoveryfield="";
	      	String recoveryfields="";
	      	if(recoveryfield.length>0)
	      	{
	      		for(int u=0;u<recoveryfield.length;u++)
	      		{
	      			sumrecoveryfield =sumrecoveryfield+ " p."+recoveryfield[u][0]+"+";
	      			recoveryfields =recoveryfields+ " p."+recoveryfield[u][0]+",";
	      			
	      		}
	       	}
	      	

	       
	      asql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,";
	      asql = asql + " c.CHR_DEPARTNAME,i.CHR_DESIGNAME,b.CHR_OFFICENAME , ";
	      asql = asql + " q.CHR_CATEGORYNAME, a.INT_SALARY, ";
	      asql = asql + allowancefields ;
	      asql = asql + " ( " +sumgrossallowancefield +" 0 ) , " ;
	      asql = asql + " ( " +sumothersallowancefield +" 0 ) , " ;
	      asql = asql + " ( a.INT_SALARY +" +sumgrossallowancefield +" 0 ) , " ; 
	      asql = asql + recoveryfields;
	      asql = asql + " ( " +sumrecoveryfield +" 0 ) , " ; 

	      asql = asql + "  if(a.CHR_PF ='C' ,'COMMON', if(a.CHR_PF ='Y' , 'YES', 'NO') ) ,IF(a.CHR_PF ='C',CONCAT(g.CHR_PFNUMBER,a.CHR_PFNO),'NIL') , ";
	      asql = asql + "  FUN_GET_PFAMOUNT(a.CHR_PF,a.INT_SALARY) employeePF,";

	      asql = asql + "  if(a.CHR_ESI ='C' ,'COMMON', if(a.CHR_ESI ='Y' , 'YES', 'NO') ) ,IF(a.CHR_ESI ='C' ,a.CHR_ESINO,'NIL'), ";
	      asql = asql + "  FUN_GET_ESIAMOUNT('STAFF', a.CHR_ESI,  (a.INT_SALARY +" +sumgrossallowancefield +" 0)    ) employeeesi ,";

	      asql = asql + "  FUN_GET_PFAMOUNT(a.CHR_PF,a.INT_SALARY) employerPF,";
	      asql = asql + "  FUN_GET_ESIAMOUNT('EMP', a.CHR_ESI,  (a.INT_SALARY +" +sumgrossallowancefield +" 0)    ) employeresi ,";

	      asql = asql + " (a.INT_SALARY+"+sumgrossallowancefield +"0)   -(  FUN_GET_PFAMOUNT(a.CHR_PF,a.INT_SALARY)  +    FUN_GET_ESIAMOUNT('STAFF', a.CHR_ESI,(a.INT_SALARY +" +sumgrossallowancefield +" 0)) +   (" +sumrecoveryfield +"0)   ) tot," ; 

	      asql = asql + " (a.INT_SALARY+"+sumgrossallowancefield +"0)   +(  FUN_GET_PFAMOUNT(a.CHR_PF,a.INT_SALARY)  +    FUN_GET_ESIAMOUNT('EMP', a.CHR_ESI,(a.INT_SALARY +" +sumgrossallowancefield +" 0)) +  ( " +sumothersallowancefield +" 0 )   ) ctc," ; 

	      asql = asql + " a.CHR_GENDER, DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'), ";
	      asql = asql + " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y') doj,if(a.CHR_MARITALSTATUS='U','UNMARRIED','MARRIED'), ";
	      asql = asql + " DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y'), e.CHR_QUALIFICATIONNAME ,j.CHR_GROUPNAME,  ";
	      asql = asql + " FUN_GET_ADDRESS(a.CHR_EMPID,'P',','), ";
	      asql = asql + " FUN_GET_ADDRESS(a.CHR_EMPID,'C',','), ";
	      asql = asql + " a.CHR_EMAILID, a.CHR_MOBILE,   ";
	      asql = asql + " FIND_A_BANKGROUP_NAME(a.CHR_BANK),CONCAT('A/c : ',a.CHR_ACCNO)  ,   "; 
	      asql = asql +"   FLOOR(PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM NOW()),EXTRACT(YEAR_MONTH FROM a.DT_DOJCOLLEGE))/ 12) , ";
	      asql = asql + " IF(a.CHR_TYPE='T' ,'RESIGNED', IF(a.CHR_TYPE ='H' ,'HOLD','LIVE') ) FROM com_m_staff a , com_m_office b ,com_m_depart c ,pay_t_allowance d , ";
	      asql = asql + " com_m_qualification e , com_m_branch f , com_m_company g, ";
	      asql = asql + " com_m_desig i,com_m_bloodgroup j,  ";
	      asql = asql + " pay_t_allowance o ,pay_t_recovery p ,com_m_employeecategory q ";
	      asql = asql + " WHERE a.INT_DEPARTID = c.INT_DEPARTID     ";//AND a.CHR_TYPE!='T'   AND a.CHR_HOLD !='Y' 
	      asql = asql + " AND a.INT_OFFICEID= b.INT_OFFICEID  ";
	      asql = asql + " AND a.CHR_EMPID =d.CHR_EMPID  ";
	      asql = asql + " AND a.CHR_QUALIFICATION =e.INT_QUALIFICATIONID  ";
	      asql = asql + " AND a.INT_BRANCHID =f.INT_BRANCHID  ";
	      asql = asql + " AND a.INT_COMPANYID =g.INT_COMPANYID  ";
	      asql = asql + " AND a.INT_DESIGID= i.INT_DESIGID  ";
	      asql = asql + " AND a.CHR_BG=j.INT_BLOODGROUPID  ";
	      asql = asql + " AND a.CHR_EMPID =p.CHR_EMPID  ";
	      asql = asql + " AND a.CHR_EMPID =o.CHR_EMPID  ";
	      asql = asql + " AND a.CHR_CATEGORY= q.INT_EMPLOYEECATEGORYID ";
	      if(!"0".equals(Office))
	      	asql = asql + " AND a.INT_OFFICEID="+Office;
	      if(!"0".equals(Dept))
	      	asql = asql + " AND a.INT_DEPARTID= "+Dept;
	      if(!"0".equals(Category))
	      	asql = asql + "  AND a.CHR_CATEGORY='"+Category +"' ";
	      if("Y".equals(resigned))
	      	asql = asql + "   AND a.CHR_TYPE='T'";
	      else	
	      	asql = asql + "   AND a.CHR_TYPE !='T'";
	      	
	      asql = asql + " ORDER BY  "+orderby;

	      System.out.println(asql);
	      String Data[][] =CommonFunctions.QueryExecute(asql);

			 if(Data.length>0){
				 System.out.println("inside for");
				 System.out.println("data[0][0]:"+Data[0][0]);
				 
				/* for(int s=1;s<=Data.length;s++){
					 String sno=new Integer(s).toString();
			
				 AbstractColumn SnoCol = ColumnBuilder.getInstance()
				  .setColumnProperty(sno, String.class.getName())
		          .setTitle("S.No").setWidth(50)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(SnoCol);
				 }*/
				  				 
		          AbstractColumn EMPID = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_EMPID", String.class.getName())
		          .setTitle("Employee Id").setWidth(90)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(EMPID);
		          
		          AbstractColumn EmpName = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_STAFFNAME", String.class.getName())
		          .setTitle("Name").setWidth(150)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(EmpName);
		          
		          AbstractColumn FatherName = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_STAFFFNAME", String.class.getName())
		          .setTitle("Father Name").setWidth(150)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(FatherName);
		          
		          AbstractColumn comName = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_COMPANYNAME", String.class.getName())
		          .setTitle("Company Name").setWidth(150)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(comName);
		          
		          AbstractColumn Branch = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_BRANCHNAME", String.class.getName())
		          .setTitle("Branch Name").setWidth(90)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(Branch);
		          
		          AbstractColumn dept = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_DEPARTNAME", String.class.getName())
		          .setTitle("Department").setWidth(100)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(dept);
		          
		          AbstractColumn desig = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_DESIGNAME", String.class.getName())
		          .setTitle("Designation").setWidth(150)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(desig);
		          
		          AbstractColumn office = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_OFFICENAME", String.class.getName())
		          .setTitle("Office").setWidth(100)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(office);
		          
		          AbstractColumn category = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_CATEGORYNAME", String.class.getName())
		          .setTitle("Category").setWidth(80)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(category);
		          
		          AbstractColumn salary = ColumnBuilder.getInstance()
				  .setColumnProperty("INT_SALARY", String.class.getName())
		          .setTitle("Salary").setWidth(50)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(salary);
		          
		          if(allowancefield.length>0)
		      	{
		      		for(int u=0;u<allowancefield.length;u++)
		      		{
		      		
		      		   AbstractColumn AllowanceCol = ColumnBuilder.getInstance()
						  .setColumnProperty(allowancefield[u][0], String.class.getName())
				          .setTitle(allowancefield[u][1]).setWidth(90)
				          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
				          drb.addColumn(AllowanceCol);
		      			
		      		}
		      		 AbstractColumn sumgrossallowance = ColumnBuilder.getInstance()
					  .setColumnProperty("( "+sumgrossallowancefield+" 0 )", String.class.getName())
			          .setTitle("SUM OF GROSS ALLOWANCE").setWidth(80)
			          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
			          drb.addColumn(sumgrossallowance);
			          
			          AbstractColumn sumothersallowance = ColumnBuilder.getInstance()
					  .setColumnProperty("( "+sumothersallowancefield+" 0 )", String.class.getName())
			          .setTitle("SUM OF REIMBURSEMENT").setWidth(80)
			          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
			          drb.addColumn(sumothersallowance);
			          
			          AbstractColumn gross = ColumnBuilder.getInstance()
					  .setColumnProperty("( a.INT_SALARY +" +sumgrossallowancefield +" 0 )", String.class.getName())
			          .setTitle("GROSS").setWidth(80)
			          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
			          drb.addColumn(gross);
		      		
		       	}
		      	if(recoveryfield.length>0)
		      	{
		      		for(int u=0;u<recoveryfield.length;u++)
		      		{
		      			//sumrecoveryfield =sumrecoveryfield+ " p."+recoveryfield[u][0]+"+";
		      			//recoveryfields =recoveryfields+ " p."+recoveryfield[u][0]+",";
		      			
		      			 AbstractColumn recoverycol = ColumnBuilder.getInstance()
						  .setColumnProperty(recoveryfield[u][0], String.class.getName())
				          .setTitle(recoveryfield[u][1]).setWidth(90)
				          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
				          drb.addColumn(recoverycol);
		      			
		      		}
		      		AbstractColumn sumrecovery = ColumnBuilder.getInstance()
					  .setColumnProperty("( "+sumrecoveryfield+" 0 )", String.class.getName())
			          .setTitle("SUM OF RECOVERY").setWidth(80)
			          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
			          drb.addColumn(sumrecovery);
		       	}
		      	AbstractColumn pftype = ColumnBuilder.getInstance()
				  .setColumnProperty("if(a.CHR_PF ='C' ,'COMMON', if(a.CHR_PF ='Y' , 'YES', 'NO') )", String.class.getName())
		          .setTitle("PF Type").setWidth(70)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(pftype);
		          
		          AbstractColumn pfno = ColumnBuilder.getInstance()
				  .setColumnProperty("IF(a.CHR_PF ='C',CONCAT(g.CHR_PFNUMBER,a.CHR_PFNO),'NIL')", String.class.getName())
		          .setTitle("PF Number").setWidth(80)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(pfno);
		          
		          AbstractColumn pfcontribution = ColumnBuilder.getInstance()
				  .setColumnProperty("employeePF", String.class.getName())
		          .setTitle("PF EMPLOYEE CONTRIBUTION").setWidth(80)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(pfcontribution);
		          
		          AbstractColumn esitype = ColumnBuilder.getInstance()
				  .setColumnProperty("if(a.CHR_ESI ='C' ,'COMMON', if(a.CHR_ESI ='Y' , 'YES', 'NO') )", String.class.getName())
		          .setTitle("ESI Type").setWidth(80)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(esitype);
		          
		          AbstractColumn esino = ColumnBuilder.getInstance()
				  .setColumnProperty("IF(a.CHR_ESI ='C' ,a.CHR_ESINO,'NIL')", String.class.getName())
		          .setTitle("ESI Number").setWidth(80)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(esino);
		          
		          AbstractColumn esicontribution = ColumnBuilder.getInstance()
				  .setColumnProperty("employeeesi", String.class.getName())
		          .setTitle("ESI EMPLOYEE CONTRIBUTION").setWidth(80)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(esicontribution);
		          
		          AbstractColumn employerpf = ColumnBuilder.getInstance()
				  .setColumnProperty("employerPF", String.class.getName())
		          .setTitle("PF EMPLOYEER CONTRIBUTION").setWidth(80)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(employerpf);
		          
		          AbstractColumn employeresi = ColumnBuilder.getInstance()
				  .setColumnProperty("employeresi", String.class.getName())
		          .setTitle("ESI EMPLOYEER CONTRIBUTION").setWidth(80)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(employeresi);
		          
		          AbstractColumn total = ColumnBuilder.getInstance()
				  .setColumnProperty("tot", String.class.getName())
		          .setTitle("TOTAL").setWidth(50)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(total);
		          
		          AbstractColumn ctc = ColumnBuilder.getInstance()
				  .setColumnProperty("ctc", String.class.getName())
		          .setTitle("CTC").setWidth(50)
		          .setStyle(amountStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(ctc);
		          
		          AbstractColumn gender = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_GENDER", String.class.getName())
		          .setTitle("Gender").setWidth(60)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(gender);
		          
		          AbstractColumn dob = ColumnBuilder.getInstance()
				  .setColumnProperty("DATE_FORMAT(a.DT_DOB,'%d-%b-%Y')", String.class.getName())
		          .setTitle("Date of Birth").setWidth(80)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(dob);
		          
		          AbstractColumn doj = ColumnBuilder.getInstance()
				  .setColumnProperty("doj", String.class.getName())
		          .setTitle("Date of Joining").setWidth(80)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(doj);
		          
		          AbstractColumn maritalstatus = ColumnBuilder.getInstance()
				  .setColumnProperty("if(a.CHR_MARITALSTATUS='U','UNMARRIED','MARRIED')", String.class.getName())
		          .setTitle("Marital Status").setWidth(80)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(maritalstatus);
		          
		          AbstractColumn weddingdt = ColumnBuilder.getInstance()
				  .setColumnProperty("DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y')", String.class.getName())
		          .setTitle("Wedding Date").setWidth(80)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(weddingdt);
		          
		          AbstractColumn quali = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_QUALIFICATIONNAME", String.class.getName())
		          .setTitle("Qualification").setWidth(100)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(quali);
		          
		          AbstractColumn bg = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_GROUPNAME", String.class.getName())
		          .setTitle("Blood Group").setWidth(60)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(bg);
		          
		          AbstractColumn padd = ColumnBuilder.getInstance()
				  .setColumnProperty("FUN_GET_ADDRESS(a.CHR_EMPID,'P',',')", String.class.getName())
		          .setTitle("PERMANENT ADDRESS").setWidth(200)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(padd);
		          
		          AbstractColumn cadd = ColumnBuilder.getInstance()
				  .setColumnProperty("FUN_GET_ADDRESS(a.CHR_EMPID,'C',',')", String.class.getName())
		          .setTitle("COMMUNICATION ADDRESS").setWidth(200)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(cadd);
		          
		          AbstractColumn mail = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_EMAILID", String.class.getName())
		          .setTitle("EMAIL").setWidth(100)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(mail);
		          
		          AbstractColumn mobile = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_MOBILE", String.class.getName())
		          .setTitle("Mobile").setWidth(80)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(mobile);
		          
		          AbstractColumn bank = ColumnBuilder.getInstance()
				  .setColumnProperty("FIND_A_BANKGROUP_NAME(a.CHR_BANK)", String.class.getName())
		          .setTitle("Bank").setWidth(120)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(bank);
		          
		          AbstractColumn accno = ColumnBuilder.getInstance()
				  .setColumnProperty("CONCAT('A/c : ',a.CHR_ACCNO)", String.class.getName())
		          .setTitle("Account Number").setWidth(100)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(accno);
		          
		          AbstractColumn experience = ColumnBuilder.getInstance()
				  .setColumnProperty("FLOOR(PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM NOW()),EXTRACT(YEAR_MONTH FROM a.DT_DOJCOLLEGE))/ 12)", String.class.getName())
		          .setTitle("Experience").setWidth(60)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(experience);
		          
		          AbstractColumn status = ColumnBuilder.getInstance()
				  .setColumnProperty("IF(a.CHR_TYPE='T' ,'RESIGNED', IF(a.CHR_TYPE ='H' ,'HOLD','LIVE') )", String.class.getName())
		          .setTitle("Status").setWidth(50)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(status);
		         
			 }
				 
			// }
			 
			  drb.setUseFullPageWidth(true);
	          
	          drb.setTemplateFile(path);
	          DynamicReport dr = drb.build();
	          jr = DynamicJasperHelper.generateJasperReport(dr, new ClassicLayoutManager(),map);
	          
	          ResultSet rs = null;
   		   
			    try{
			                Statement stmt = con.createStatement();
			                rs = stmt.executeQuery(asql); 
			                
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
//						JasperExportManager.exportReportToPdfFile(jp,"C:/report-out.pdf");
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
