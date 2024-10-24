package com.my.org.erp.SmartPayroll;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
 
import com.my.org.erp.Date.Day;
import com.my.org.erp.SmartReport.OneSubReportFunctions;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JPFForm_3A extends AbstractActionHandler 
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
		System.out.println("insite Rept_JPFForm_5");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
						
			if (action.equals("PAYRept_JPFForm_10")) 
			{
			System.out.println("insite Rept_JPFForm_10");
				
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
		
				int byear=0,cyear=0;
				String form2A="0.00",form3A="0.00",form4A="0.00",form4bA="0.00";
				String form2M="0.00",form3M="0.00",form4M="0.00",form4bM="0.00";
				String form2J="0.00",form3J="0.00",form4J="0.00",form4bJ="0.00";
				String form2L="0.00",form3L="0.00",form4L="0.00",form4bL="0.00";
				String form2U="0.00",form3U="0.00",form4U="0.00",form4bU="0.00";
				String form2S="0.00",form3S="0.00",form4S="0.00",form4bS="0.00";
				String form2O="0.00",form3O="0.00",form4O="0.00",form4bO="0.00";
				String form2N="0.00",form3N="0.00",form4N="0.00",form4bN="0.00";
				String form2D="0.00",form3D="0.00",form4D="0.00",form4bD="0.00";
				String form21="0.00",form31="0.00",form41="0.00",form4b1="0.00";
				String form2F="0.00",form3F="0.00",form4F="0.00",form4bF="0.00";
				String form2R="0.00",form3R="0.00",form4R="0.00",form4bR="0.00";
				String cyend="",byend="";
				 
				double form2t=0.00,form3t=0.00,form4t=0.00,form4bt=0.00;
				
				String staffid="";
				String comid=request.getParameter("company");
				String branchid=request.getParameter("branch");
				String officeid=request.getParameter("Office");
				String year=request.getParameter("Year");
				int yr=Integer.parseInt(year);
				String staff[]=request.getParameterValues("staff");
				String empid="";
				for(int k=0;k<staff.length;k++)
				empid=empid+",'"+staff[k]+"'";
				
				staffid=empid.substring(1);
				
				
				
				
				byear=(Integer.parseInt(year));
				cyear=Integer.parseInt(year+1);
				cyend=year.substring(2,4);
				byend=((""+byear).trim()).substring(2,4);
					String sql="";
			sql=" SELECT b.CHR_EMPID, b.CHR_PFNO,a.CHR_EMPNAME ";
			sql = sql+"	FROM  com_m_staff b,pay_t_salary a ";                               
			sql = sql+"	WHERE b.CHR_TYPE!='T' AND b.CHR_HOLD!='Y'";
			
			if(!"Select".equals(comid))
				sql = sql+"	AND b.INT_COMPANYID = "+comid;
			
			if(!"0".equals(branchid))
				sql = sql+"	AND b.INT_BRANCHID = "+branchid;
			
			if(!"0".equals(officeid))
				sql = sql+"	AND b.INT_OFFICEID = "+officeid;
			 
			sql = sql+" AND a.CHR_EMPID=b.CHR_EMPID and a.CHR_EMPID in("+staffid+") group BY a.CHR_EMPID";
			System.out.println("sql:"+sql);
			String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			
			
			
			sql = " SELECT a.CHR_COMPANYNAME,a.CHR_STREET,f.CHR_CITYNAME,a.INT_PINCODE,a.CHR_PFNUMBER, ";
			sql = sql + " c.CHR_COUNTRYNAME,d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME  ";
			sql = sql + " FROM com_m_company a, com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
			sql = sql + " WHERE a.INT_COUNTRYID= c.INT_COUNTRYID ";
			sql = sql + " AND a.INT_STATEID = d.INT_STATEID ";
			sql = sql + " AND a.INT_DISTRICTID = e.INT_DISTRICTID ";
			sql = sql + " AND a.INT_CITYID = f.INT_CITYID ";
			sql = sql + " AND a.INT_COMPANYID="+comid;
			System.out.println("sql1:"+sql);
			String datac[][]=CommonFunctions.QueryExecute(sql);
			for(int i=0;i<data.length;i++)
			{
			
				form2A="0.00";form3A="0.00";form4A="0.00";form4bA="0.00";
				form2M="0.00";form3M="0.00";form4M="0.00";form4bM="0.00";
				form2J="0.00";form3J="0.00";form4J="0.00";form4bJ="0.00";
				form2L="0.00";form3L="0.00";form4L="0.00";form4bL="0.00";
				form2U="0.00";form3U="0.00";form4U="0.00";form4bU="0.00";
				form2S="0.00";form3S="0.00";form4S="0.00";form4bS="0.00";
				form2O="0.00";form3O="0.00";form4O="0.00";form4bO="0.00";
				form2N="0.00";form3N="0.00";form4N="0.00";form4bN="0.00";
				form2D="0.00";form3D="0.00";form4D="0.00";form4bD="0.00";
				form21="0.00";form31="0.00";form41="0.00";form4b1="0.00";
				form2F="0.00";form3F="0.00";form4F="0.00";form4bF="0.00";
				form2R="0.00";form3R="0.00";form4R="0.00";form4bR="0.00";
			
			
				sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
				sql = sql+"	FROM pay_t_salary a ";                               
				sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
				sql = sql+" AND a.CHR_MONTH ='Apirl' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
				System.out.println("sql2:"+sql);
				String data1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data1.length>0)
				{
				   form2A=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data1[0][1]));form3A=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data1[0][2]));form4A=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data1[0][3]));form4bA=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data1[0][4])); 
				}
				sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
				sql = sql+"	FROM pay_t_salary a ";                               
				sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
				sql = sql+" AND a.CHR_MONTH ='May' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
				System.out.println("sql2a:"+sql);
				String data2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data2.length>0)
				{
				   form2M=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data2[0][1]));form3M=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data2[0][2]));form4M=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data2[0][3]));form4bM=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data2[0][4])); 
				}
				sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
				sql = sql+"	FROM pay_t_salary a ";                               
				sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
				sql = sql+" AND a.CHR_MONTH ='June' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
				String data3[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data3.length>0)
				{
				   form2J=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data3[0][1]));form3J=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data3[0][2]));form4J=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data3[0][3]));form4bJ=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data3[0][4])); 
				}
				sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
				sql = sql+"	FROM pay_t_salary a ";                               
				sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
				sql = sql+" AND a.CHR_MONTH ='July' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
				String data4[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data4.length>0)
				{
				   form2L=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data4[0][1]));form3L=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data4[0][2]));form4L=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data4[0][3]));form4bL=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data4[0][4])); 
				}
				sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
				sql = sql+"	FROM pay_t_salary a ";                               
				sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
				sql = sql+" AND a.CHR_MONTH ='August' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
				String data5[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data5.length>0)
				{
				   form2U=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data5[0][1]));form3U=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data5[0][2]));form4U=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data5[0][3]));form4bU=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data5[0][4])); 
				}
				sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
				sql = sql+"	FROM pay_t_salary a ";                               
				sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
				sql = sql+" AND a.CHR_MONTH ='September' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
				String data6[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data6.length>0)
				{
				   form2S=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data6[0][1]));form3S=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data6[0][2]));form4S=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data6[0][3]));form4bS=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data6[0][4])); 
				}
				sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
				sql = sql+"	FROM pay_t_salary a ";                               
				sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
				sql = sql+" AND a.CHR_MONTH ='October' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
				String data7[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data7.length>0)
				{
				   form2O=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data7[0][1]));form3O=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data7[0][2]));form4O=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data7[0][3]));form4bO=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data7[0][4])); 
				}
				sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
				sql = sql+"	FROM pay_t_salary a ";                               
				sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
				sql = sql+" AND a.CHR_MONTH ='November' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
				String data8[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data8.length>0)
				{
				   form2N=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data8[0][1]));form3N=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data8[0][2]));form4N=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data8[0][3]));form4bN=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data8[0][4])); 
				}
				sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
				sql = sql+"	FROM pay_t_salary a ";                               
				sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
				sql = sql+" AND a.CHR_MONTH ='December' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
				String data9[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data9.length>0)
				{
				   form2D=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data9[0][1]));form3D=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data9[0][2]));form4D=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data9[0][3]));form4bD=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data9[0][4])); 
				}
				sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
				sql = sql+"	FROM pay_t_salary a ";                               
				sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
				sql = sql+" AND a.CHR_MONTH ='January' AND a.INT_YEAR="+cyear+" group by a.CHR_EMPID";
				String data10[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data10.length>0)
				{
				   form21=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data10[0][1]));form31=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data10[0][2]));form41=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data10[0][3]));form4b1=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data10[0][4])); 
				}
				sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
				sql = sql+"	FROM pay_t_salary a ";                               
				sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
				sql = sql+" AND a.CHR_MONTH ='February' AND a.INT_YEAR="+cyear+" group by a.CHR_EMPID";
				String data11[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data11.length>0)
				{
				   form2F=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data11[0][1]));form3F=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data11[0][2]));form4F=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data11[0][3]));form4bF=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data11[0][4])); 
				}
				sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
				sql = sql+"	FROM pay_t_salary a ";                               
				sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
				sql = sql+" AND a.CHR_MONTH ='March' AND a.INT_YEAR="+cyear+" group by a.CHR_EMPID";
				String data12[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data12.length>0)
				{
				   form2R=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data12[0][1]));form3R=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data12[0][2]));form4R=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data12[0][3]));form4bR=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data12[0][4])); 
				}
			}		
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
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