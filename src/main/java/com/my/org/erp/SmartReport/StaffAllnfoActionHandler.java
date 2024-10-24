package com.my.org.erp.SmartReport;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class StaffAllnfoActionHandler extends AbstractActionHandler 
{
	 
	JasperPrint jasperPrint;
	JRExporter exporter;
	public String getSqlQuery(String cmpy, String branch, String office, String dept, String sorting, String ss,String resigned)
	{
		
		asql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME," +
				"c.CHR_BRANCHNAME,d.CHR_DEPARTNAME,e.CHR_DESIGNAME,f.CHR_OFFICENAME," +
				"j.CHR_CATEGORYNAME,a.CHR_GENDER,g.CHR_GROUPNAME,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y')," +
				" DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),a.CHR_TYPE," +
				"if(a.CHR_MARITALSTATUS='M','Married','Unmarried')," +
				"DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y'),i.CHR_QUALIFICATIONNAME," +
				"a.CHR_REPTO,if(a.CHR_REP='N','No','Yes'),if(a.CHR_CONVEYANCECLEAR='N','No','Yes')," +
				" CONCAT(a.CHR_PADD1,',',a.CHR_PADD2,',',n.CHR_CITYNAME,',',m.CHR_DISTRICT,',',l.CHR_STATENAME,',',k.CHR_COUNTRYNAME,', Pincode : ',a.CHR_PPIN,', Phone : ',a.CHR_PPHONE), " +
				"CONCAT(a.CHR_SADD1,',',a.CHR_SADD2,',',n.CHR_CITYNAME,',',m.CHR_DISTRICT,',',l.CHR_STATENAME,',',k.CHR_COUNTRYNAME,', Pincode : ',a.CHR_SPIN,', Phone : ',a.CHR_SPHONE) ," +
				"a.INT_SALARY,a.INT_GROSSSALARY,if(a.CHR_PFTYPE='A','Amount',if(a.CHR_PFTYPE='P','Percentage','-')),a.INT_PFAMT,if(a.CHR_PF='Y','Yes',if(a.CHR_PF='N','No','Common'))," +
				"CONCAT(b.CHR_PFNUMBER,a.CHR_PFNO),DATE_FORMAT(a.DAT_PFESIDATE,'%d-%b-%Y')," +
				"if(a.CHR_ESITYPE='A','Amount',if(a.CHR_ESITYPE='P','Percentage','-'))," +
				"a.INT_ESIAMT,if(a.CHR_ESI='Y','Yes',if(a.CHR_ESI='N','No','Common'))," +
				"CONCAT(b.CHR_PFNUMBER,a.CHR_ESINO),DATE_FORMAT(a.DAT_PFESIDATE,'%d-%b-%Y')," +
				"FIND_A_BANKGROUP_NAME(a.CHR_BANK) ,a.CHR_ACCNO,a.CHR_PAN,a.CHR_PASSPORT," +
				"a.CHR_DRIVING,a.CHR_EMAILID,a.CHR_PERMAILID,a.CHR_MOBILE,a.CHR_PREVIOUSDETAILS, " +
				"if(a.CHR_ADDRESSPROOFSTATUS='Y','Yes','No'),if(a.CHR_PFCLAIMSTATUS='Y','Yes','No')," +
				"DATE_FORMAT(a.DAT_PFCLIAMDATE,'%d-%b-%Y'),a.CHR_PFCLIAMDESCRIPTION," +
				"DATE_FORMAT(a.DAT_PFRESIGNDATE,'%d-%b-%Y'),a.CHR_NOMINEE,if(a.CHR_INTERVIEW='Y','Yes','No')," +
				"if(a.CHR_REJOIN='Y','Yes','No') FROM com_m_staff a, com_m_company b, com_m_branch c,com_m_depart d," +
				"com_m_desig e,com_m_office f,com_m_bloodgroup g, com_m_qualification i," +
				"com_m_employeecategory j,com_m_country k,com_m_state l,com_m_district m,com_m_city n " +
				"WHERE a.INT_COMPANYID =b.INT_COMPANYID AND a.INT_BRANCHID =c.INT_BRANCHID " +
				"AND a.INT_DEPARTID = d.INT_DEPARTID AND a.INT_DESIGID = e.INT_DESIGID " +
				"AND a.INT_OFFICEID= f.INT_OFFICEID AND a.CHR_BG=g.INT_BLOODGROUPID " +
				" AND a.CHR_QUALIFICATION =i.INT_QUALIFICATIONID " +
				"AND a.CHR_CATEGORY = j.INT_EMPLOYEECATEGORYID AND a.CHR_PCITY = n.INT_CITYID " +
				"AND a.INT_PDISTRICTID=m.INT_DISTRICTID AND a.CHR_PSTATE=l.INT_STATEID " +
				"AND a.INT_PCOUNTRYID =k.INT_COUNTRYID AND a.CHR_SCITY = n.INT_CITYID " +
				"AND a.INT_CDISTRICTID=m.INT_DISTRICTID AND a.CHR_SSTATE=l.INT_STATEID " +
				"AND a.INT_CCOUNTRY =k.INT_COUNTRYID";
		 if(!"0".equals(cmpy))
			 	asql = asql +" AND a.INT_COMPANYID="+cmpy;
			 if(!"0".equals(branch))
			 	asql = asql +" AND a.INT_BRANCHID="+branch;
			 if(!"0".equals(office))
			 	asql = asql +" AND a.INT_OFFICEID="+office;
			 if(!"0".equals(dept))
				 	asql = asql +" AND a.INT_DEPARTID="+dept;
				 
			 
			 
		 if(!"Y".equals(resigned))
			 asql = asql +" AND  a.CHR_TYPE!='T' ";
		
		 System.out.println(asql);
		return asql;
	}
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("inside staff all info handle");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			String cmpy=request.getParameter("company");
			String branch=request.getParameter("branch");
			String Office = request.getParameter("Office");
			String dept = request.getParameter("dept");
			String sorting = request.getParameter("sorting");
			String ss = request.getParameter("ss");
			String resigned = request.getParameter("resigned");
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			if(action.equals("RPTStaffAllInfo")) 
			{
				asql=getSqlQuery(cmpy,branch,Office,dept,sorting,ss,resigned);
				File reportsDir = new File(Path + "/report/SmartCommon/" + rptfilename+".jrxml");
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
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
