<jsp:root version="1.2" xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="urn:jsptld:http://java.sun.com/jstl/core"
	xmlns:display="urn:jsptld:http://displaytag.sf.net">
	<jsp:directive.page import="java.io.BufferedReader" />
	<jsp:directive.page import="java.io.FileReader" />
	<jsp:directive.page import="com.my.org.erp.bean.Attendance.TotalReport" />
	<jsp:directive.page contentType="text/html; charset=UTF-8" />
	<jsp:directive.page import="java.sql.*" />
	<jsp:directive.page import="java.util.*" />
	<jsp:declaration>
  	String reportHeader="";
  </jsp:declaration>
	<jsp:text>
		<![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]>
	</jsp:text>

	<jsp:text>
		<![CDATA[<html xmlns="http://www.w3.org/1999/xhtml" lang="en">]]>
	</jsp:text>
	<head>

	
<title> :: ATTENDANCE ::</title>


	<meta http-equiv="Expires" content="-1" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style>
	<link rel="stylesheet" href="../JavaScript/css/print.css"
		type="text/css" media="print" />
	</head>


	<jsp:text>
		<![CDATA[<body  onpaste="return false;" background="../Image/Smart%20Attendance/background1.jpg">
    <embed src="../Image/General/college.swf" width="1000" height="110"/>
    <br><br>
    ]]>
	</jsp:text>
	<jsp:text>
		<![CDATA[
     		<center>
  			<a href='ReportTotal.jsp'> Full View </a>
  			&nbsp;&nbsp;
     		<a href='../Mainscreen.jsp' target='_self'> Home </a>
  			&nbsp;&nbsp;
      		<a href="TotalReport.jsp"> Back </a>
      		&nbsp;&nbsp;
      		<a href="../Logout.jsp"> Logout </a>
    ]]>
	</jsp:text>
	<jsp:scriptlet>
  	String caption="Attendance Report";
  	ArrayList arrList =new ArrayList();	
	FileReader fr = new FileReader("Total.sys");
	BufferedReader br  = new BufferedReader(fr);
	String strfline ="";
	StringTokenizer filecontents;
	String sline="";	
	int fline=1;
	while((strfline=br.readLine())!= null )	
	{	
		if(fline==1) reportHeader=strfline;
		if(fline>=3)
		{
			filecontents = new StringTokenizer(strfline,"^");
			if (! strfline.equalsIgnoreCase("Record not found..."))
			{		
				TotalReport Rep=new TotalReport();
				while(filecontents.hasMoreElements())
				{
					String empId=""+filecontents.nextElement();
					if (empId.equalsIgnoreCase("Record not found..."))	break;
						Rep.setCHR_EMPID(empId);
					if(filecontents.hasMoreElements())
						Rep.setCHR_LEAVE1(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD1(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD1BALANCE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setCHR_LEAVE2(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD2(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD2BALANCE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setCHR_LEAVE3(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD3(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD3BALANCE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setCHR_LEAVE4(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD4(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD4BALANCE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setCHR_LEAVE5(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD5(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD5BALANCE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setCHR_LEAVE6(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD6(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD6BALANCE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setCHR_LEAVE7(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD7(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD7BALANCE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setCHR_LEAVE8(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD8(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD8BALANCE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setCHR_LEAVE9(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD9(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setINT_NOD9BALANCE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						Rep.setCHR_CARR(""+filecontents.nextElement());
					arrList.add(Rep);
				}
			}
		}
		fline = fline + 1;
	}	
	br.close();
	fr.close();
	pageContext.setAttribute("tableclass", "");
    request.setAttribute("results", arrList);
  </jsp:scriptlet>
	<display:table name="results" pagesize="15" export="true"
		id="currentRowObject">
		<display:caption>
			<jsp:scriptlet>	out.println(reportHeader);  </jsp:scriptlet>
		</display:caption>
		<display:setProperty name="export.pdf.filename" value="example.pdf" />
		<display:setProperty name="export.rtf.filename" value="example.rtf" />
		<display:column property="CHR_EMPID" title="ID" sortable="true"
			headerClass="sortable" />
		<display:column property="CHR_LEAVE1" title="Leave Type" />
		<display:column property="INT_NOD1" title="Eligible" />
		<display:column property="INT_NOD1BALANCE" title="Available" />
		<display:column property="CHR_LEAVE2" title="Leave Type" />
		<display:column property="INT_NOD2" title="Eligible" />
		<display:column property="INT_NOD2BALANCE" title="Available" />
		<display:column property="CHR_LEAVE3" title="Leave Type" />
		<display:column property="INT_NOD3" title="Eligible" />
		<display:column property="INT_NOD3BALANCE" title="Available" />
		<display:column property="CHR_LEAVE4" title="Leave Type" />
		<display:column property="INT_NOD4" title="Eligible" />
		<display:column property="INT_NOD4BALANCE" title="Available" />
		<display:column property="CHR_LEAVE5" title="Leave Type" />
		<display:column property="INT_NOD5" title="Eligible" />
		<display:column property="INT_NOD5BALANCE" title="Available" />
		<display:column property="CHR_LEAVE6" title="Leave Type" />
		<display:column property="INT_NOD6" title="Eligible" />
		<display:column property="INT_NOD6BALANCE" title="Available" />
		<display:column property="CHR_LEAVE7" title="Leave Type" />
		<display:column property="INT_NOD7" title="Eligible" />
		<display:column property="INT_NOD7BALANCE" title="Available" />
		<display:column property="CHR_LEAVE8" title="Leave Type" />
		<display:column property="INT_NOD8" title="Eligible" />
		<display:column property="INT_NOD8BALANCE" title="Available" />
		<display:column property="CHR_LEAVE9" title="Leave Type" />
		<display:column property="INT_NOD9" title="Eligible" />
		<display:column property="INT_NOD9BALANCE" title="Available" />
		<display:column property="CHR_CARR" title="Cary" />

	</display:table>
	<jsp:text>
		<![CDATA[
      		<center>
  			<a href='ReportTotal.jsp'> Full View </a>
  			&nbsp;&nbsp;
     		<a href='../Mainscreen.jsp' target='_self'> Home </a>
  			&nbsp;&nbsp;
      		<a href="TotalReport.jsp"> Back </a>
      		&nbsp;&nbsp;
      		<a href="../Logout.jsp"> Logout </a>
      		</center>
      	]]>
	</jsp:text>
</jsp:root>
