<jsp:root version="1.2" xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="urn:jsptld:http://java.sun.com/jstl/core"
	xmlns:display="urn:jsptld:http://displaytag.sf.net">
	<jsp:directive.page import="java.io.BufferedReader" />
	<jsp:directive.page import="java.io.FileReader" />
	<jsp:directive.page import="com.my.org.erp.bean.Attendance.MusterRollReport" />
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
		<![CDATA[<body  onpaste="return false;"  >
     
    <br><br>
    ]]>
	</jsp:text>

	<jsp:text>
		<![CDATA[
			<center>
  			<a href='ReportViewMusterFView.jsp'> Full View </a>
  			&nbsp;&nbsp;
     		<a href='../Mainscreen.jsp' target='_self'> Home </a>
  			&nbsp;&nbsp;
      		<a href="Muster Details.jsp"> Back </a>
      		&nbsp;&nbsp;
      		<a href="../Logout.jsp"> Logout </a>
    ]]>
	</jsp:text>

	<jsp:scriptlet>
  	String caption="Attendance Report";
  	ArrayList arrList =new ArrayList();	
	FileReader fr = new FileReader("Report.sys");
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
				MusterRollReport attenRep=new MusterRollReport();
				while(filecontents.hasMoreElements())
				{
					String empId=""+filecontents.nextElement();
					if (empId.equalsIgnoreCase("Record not found..."))	break;
					attenRep.setEmpId(empId);
					if(filecontents.hasMoreElements())
						attenRep.setEmpName(""+filecontents.nextElement());					
					if(filecontents.hasMoreElements())
 						attenRep.setPresent(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setAbsent(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setLeave(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setOd(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setLate(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay1(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay2(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay3(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay4(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay5(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay6(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay7(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay8(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay9(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay10(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay11(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay12(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay13(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay14(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay15(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay16(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay17(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay18(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay19(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay20(""+filecontents.nextElement());					
					if(filecontents.hasMoreElements())
						attenRep.setDay21(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay22(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay23(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay24(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay25(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay26(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay27(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay28(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay29(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						attenRep.setDay30(""+filecontents.nextElement());					
					if(filecontents.hasMoreElements())
						attenRep.setDay31(""+filecontents.nextElement());					
					arrList.add(attenRep);
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
		<display:column property="empId" title="ID" sortable="true"
			headerClass="sortable" />
		<display:column property="empName" title="Name" sortable="true"
			headerClass="sortable" />
		<display:column property="day1" title="1" />
		<display:column property="day2" title="2" />
		<display:column property="day3" title="3" />
		<display:column property="day4" title="4" />
		<display:column property="day5" title="5" />
		<display:column property="day6" title="6" />
		<display:column property="day7" title="7" />
		<display:column property="day8" title="8" />
		<display:column property="day9" title="9" />
		<display:column property="day10" title="10" />
		<display:column property="day11" title="11" />
		<display:column property="day12" title="12" />
		<display:column property="day13" title="13" />
		<display:column property="day14" title="14" />
		<display:column property="day15" title="15" />
		<display:column property="day16" title="16" />
		<display:column property="day17" title="17" />
		<display:column property="day18" title="18" />
		<display:column property="day19" title="19" />
		<display:column property="day20" title="20" />
		<display:column property="day21" title="21" />
		<display:column property="day22" title="22" />
		<display:column property="day23" title="23" />
		<display:column property="day24" title="24" />
		<display:column property="day25" title="25" />
		<display:column property="day26" title="26" />
		<display:column property="day27" title="27" />
		<display:column property="day28" title="28" />
		<display:column property="day29" title="29" />
		<display:column property="day30" title="30" />
		<display:column property="day31" title="31" />
		<display:column property="present" title="P" />
		<display:column property="absent" title="A" />
		<display:column property="leave" title="L*" />
		<display:column property="od" title="OD" />
		<display:column property="late" title="LA" />
	</display:table>
	<jsp:text>
		<![CDATA[
     		<a href='ReportViewMusterFView.jsp' target='_self'> FullView </a>
  			&nbsp;&nbsp;
     		<a href='ReportPrint.jsp' target='_self'> HTML Print </a>
  			&nbsp;&nbsp;        		
      		<a href="Muster Details.jsp"> Back </a>
      		</center>
      	]]>
	</jsp:text>
</jsp:root>
