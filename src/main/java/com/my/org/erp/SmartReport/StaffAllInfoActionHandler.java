package com.my.org.erp.SmartReport;
import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
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

public class StaffAllInfoActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	String hImageExpression="";
	String fImageExpression="";
	
	public String getSqlQuery(String cmpy, String branch, String office, String dept, String sorting, String ss,String resigned)
	{
		asql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME," +
				"c.CHR_BRANCHNAME,f.CHR_OFFICENAME,j.CHR_CATEGORYNAME,d.CHR_DEPARTNAME,e.CHR_DESIGNAME," +
				"a.CHR_GENDER,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'),g.CHR_GROUPNAME,"
				+ "if(a.CHR_MARITALSTATUS='M','Married','Unmarried'),DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y')," +
				" i.CHR_QUALIFICATIONNAME,CONCAT(a.CHR_PADD1,',',a.CHR_PADD2,',',n.CHR_CITYNAME,',',m.CHR_DISTRICT,',',l.CHR_STATENAME,',',k.CHR_COUNTRYNAME,', Pincode : ',a.CHR_PPIN,', Phone : ',a.CHR_PPHONE), " +
				"CONCAT(a.CHR_SADD1,',',a.CHR_SADD2,',',n.CHR_CITYNAME,',',m.CHR_DISTRICT,',',l.CHR_STATENAME,',',k.CHR_COUNTRYNAME,', Pincode : ',a.CHR_SPIN,', Phone : ',a.CHR_SPHONE) ," +
				"a.CHR_MOBILE,a.CHR_EMAILID,a.CHR_PERMAILID,"+
				 "DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),a.CHR_TYPE," +
				"a.CHR_REPTO,if(a.CHR_REP='N','No','Yes'),if(a.CHR_CONVEYANCECLEAR='N','No','Yes')," +
				"a.INT_SALARY,a.INT_GROSSSALARY,if(a.CHR_PF='Y','Yes',if(a.CHR_PF='N','No','Common')),"
				+ "if(a.CHR_PFTYPE='A','Amount',if(a.CHR_PFTYPE='P','Percentage','-')),a.INT_PFAMT," +
				"CONCAT(b.CHR_PFNUMBER,a.CHR_PFNO),DATE_FORMAT(a.DAT_PFESIDATE,'%d-%b-%Y')," +
				"if(a.CHR_ESI='Y','Yes',if(a.CHR_ESI='N','No','Common')),"
				+ "if(a.CHR_ESITYPE='A','Amount',if(a.CHR_ESITYPE='P','Percentage','-')),a.INT_ESIAMT," +
				"CONCAT(b.CHR_PFNUMBER,a.CHR_ESINO),DATE_FORMAT(a.DAT_PFESIDATE,'%d-%b-%Y')," +
				"FIND_A_BANKGROUP_NAME(a.CHR_BANK) ,a.CHR_ACCNO,a.CHR_PAN,a.CHR_PASSPORT," +
				"a.CHR_DRIVING,a.CHR_PREVIOUSDETAILS, " +
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
		 	asql = asql +" AND  a.INT_COMPANYID= "+cmpy;
		if(!"0".equals(branch))
		 	asql = asql +" AND  a.INT_BRANCHID= "+branch;
		if(!"0".equals(office))
		 	asql = asql +" AND  a.INT_OFFICEID= "+office;
		 if(!"0".equals(dept))
			 asql = asql +" AND  a.INT_DEPARTID= "+dept;
		 if(!"Y".equals(resigned))
			 asql = asql +" AND  a.CHR_TYPE!='T' ";
		 asql = asql+"  ORDER BY "+ sorting +" "+ss;
		System.out.println("sql:"+asql);
		return asql;
	}

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String action = request.getParameter("actionS");
		if (action.equals("RPTStaffAllInfo")) 
		{	
			String reportTile="Staff All Detail";
			List<HashMap<String,String>> al=new ArrayList<HashMap<String,String>>();
			try 
			{ 
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

				asql=getSqlQuery(cmpy,branch,Office,dept,sorting,ss,resigned);
				String path=Path + "/report/SmartCommon/" + rptfilename+".jrxml";
				File reportDir = new File(path);

				if (!reportDir.exists()) 
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
				String data1[][] = CommonFunctions.QueryExecute(asql);
				int columnCount=CommonFunctions.intGetColumnCount(asql);
				if(data1.length>0)
					for(int i=0;i<data1.length;i++)
					{
						HashMap<String,String> h3 = new HashMap<String,String>();

						for(int j=0;j<=columnCount;j++)
						{
							if(j==0)
							{
								h3.put("d"+j,Integer.toString(i+1)+".");
							}
							else if(j==26)
							{
								h3.put("d"+j,CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(data1[i][j-1])));
							}
							else if(j==27)
							{
								h3.put("d"+j,CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(data1[i][j-1])));
							}
							else if(j==30)
							{
								h3.put("d"+j,CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(data1[i][j-1])));
							}
							else if(j==35)
							{
								h3.put("d"+j,CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(data1[i][j-1])));
							}
							else
								h3.put("d"+j,data1[i][j-1]);
						}
						al.add(h3);
					}
				
				DynamicReportBuilder drb = new DynamicReportBuilder();
				Font font = new Font(8,"Times New Roman",true);
				Style headerStyle = new Style();
				headerStyle.setFont(font);
				headerStyle.setHorizontalAlign(HorizontalAlign.CENTER);
				headerStyle.setVerticalAlign(VerticalAlign.MIDDLE);
				headerStyle.setBorder(Border.PEN_1_POINT);
				//Color veryLightGrey = new Color(230, 230, 230);
				headerStyle.setBackgroundColor(Color.LIGHT_GRAY);
				font = new Font(7,"Verdana",false);
				Style detailstyle = new Style();
				detailstyle.setFont(font);
				detailstyle.setHorizontalAlign(HorizontalAlign.LEFT);
				detailstyle.setVerticalAlign(VerticalAlign.MIDDLE);
				detailstyle.setBorder(Border.THIN);
				//detailstyle.setBackgroundColor(veryLightGrey);
				//detailstyle.setTransparent(false);
				
				Style amountstyle = new Style();
				amountstyle.setFont(font);
				amountstyle.setHorizontalAlign(HorizontalAlign.RIGHT);
				amountstyle.setVerticalAlign(VerticalAlign.MIDDLE);
				amountstyle.setBorder(Border.THIN);
				
				Style numberstyle = new Style();
				numberstyle.setFont(font);
				numberstyle.setHorizontalAlign(HorizontalAlign.CENTER);
				numberstyle.setVerticalAlign(VerticalAlign.MIDDLE);
				numberstyle.setBorder(Border.THIN);
				if(data1.length>0)
				for(int u=0;u<=columnCount;u++)
				{
					if(u==0)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance()
						.setColumnProperty("d"+u, String.class.getName())
						.setTitle("S.No.").setWidth(25)
						.setStyle(detailstyle).setHeaderStyle(headerStyle)
						.build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==1)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Staff Id").setWidth(90).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==2)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Staff Name").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==3)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Father Name").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==4)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Company").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}

					else if(u==5)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Branch").setWidth(70).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==6)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Office").setWidth(70).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==7)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Category").setWidth(60).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==8)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Department").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==9)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Designation").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==10)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Gender").setWidth(40).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==11)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("DOB").setWidth(60).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}

					else if(u==12)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Blood Group").setWidth(40).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==13)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Marital Status").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==14)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Wedding Date").setWidth(50).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==15)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Qualification").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==16)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Permanent Address").setWidth(150).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==17)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Communication Address").setWidth(150).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==18)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Mobile No").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==19)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("EMail Id").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==20)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Permanent Mail Id").setWidth(90).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==21)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Date of Joining").setWidth(60).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==22)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Job Period Type").setWidth(60).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==23)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Reporting To").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}

					else if(u==24)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("As Reporting Head").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==25)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Conveyance Clear Status").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==26)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Salary").setWidth(60).setStyle(amountstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==27)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Gross Pay").setWidth(60).setStyle(amountstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==28)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("PF Presence Status").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==29)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("PF Type").setWidth(60).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==30)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("PF Amount").setWidth(60).setStyle(amountstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==31)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("PF Number").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==32)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("PF Date").setWidth(60).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==33)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("ESI Presence Status").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==34)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("ESI Type").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==35)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("ESI amount").setWidth(80).setStyle(amountstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==36)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("ESI Number").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==37)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("ESI Date").setWidth(60).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==38)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Bank Nmae").setWidth(120).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==39)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("A/c No.").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==40)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("PAN No.").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==41)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Passport").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==42)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Driving License").setWidth(80).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==43)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Previous Exp").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==44)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Address Proof Status").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==45)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("PF Claim Status").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==46)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("PF Claim Date").setWidth(60).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==47)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("PF Claim Description").setWidth(80).setStyle(amountstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==48)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("PF Resig Date").setWidth(60).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==49)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Nominee").setWidth(60).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==50)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Interview Head").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==51)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Rejoin").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
				}
				
				String scompany="",sbranch="",soffice="",sdept="",sorderby="",ssortby="",sresignersIncluded="";
				if(!"0".equals(cmpy))
				{
						data1= CommonFunctions.QueryExecute("SELECT CHR_COMPANYNAME FROM com_m_company where INT_COMPANYID="+cmpy);
					if(data1.length>0)
						scompany=data1[0][0];
				}
				else
					scompany="All Companies";
				if(!"0".equals(branch))
				{
						data1= CommonFunctions.QueryExecute("SELECT CHR_BRANCHNAME FROM com_m_branch where INT_BRANCHID="+branch);
					if(data1.length>0)
						sbranch=data1[0][0];
				}
				else
					sbranch="All Branches";
				if(!"0".equals(Office))
				{
						data1= CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME FROM com_m_office where INT_OFFICEID="+Office);
					if(data1.length>0)
						soffice=data1[0][0];
				}
				else
					soffice="All Offices";
				if(!"0".equals(dept))
				{
						data1= CommonFunctions.QueryExecute("SELECT CHR_DEPARTNAME FROM COM_M_DEPART where INT_DEPARTID="+dept);
					if(data1.length>0)
						sdept=data1[0][0];
				}
				else
					sdept="All Departments";
				if("a.CHR_STAFFNAME".equals(sorting))
					sorderby="Staff Name";
				else if("a.CHR_EMPID".equals(sorting))
					sorderby="Staff Id";
				
				if("Y".equals(resigned))
					sresignersIncluded="Yes";
				else if("N".equals(resigned))
					sresignersIncluded="No";
				if("asc".equals(ss))
					ssortby="Ascending";
				else if("desc".equals(ss))
					ssortby="Descending";
				String reportFilter="Company / Branch / Office / Department / Order By / Sort By / Resigners Included :: "+scompany+" / "+sbranch+" / "+soffice+" / "+sdept+" / "+sorderby+" / "+ssortby+" / "+sresignersIncluded;
				map.put("reportTitle", reportTile);
				map.put("reportFilters", reportFilter);
				jasperPrint =ReportFunctions.createDynamicJasperReport(drb, path, map, al);
				ReportFunctions.generateJasperReport(jasperPrint, request, response, reporttype, Path, rptfilename, reportTile);
			}
			catch (Exception e) 
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
				RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
				dispatchers.forward(request, response);
			}
			finally
			{
				al=null;
			}
		}
	}
}
