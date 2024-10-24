<%@ taglib uri="http://java.sun.com/jstl/xml" prefix="x"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>

<jsp:root version="1.2" xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="urn:jsptld:http://java.sun.com/jstl/core"
	xmlns:display="urn:jsptld:http://displaytag.sf.net">
	<jsp:directive.page import="java.io.BufferedReader" />
	<jsp:directive.page import="java.io.FileReader" />
	<jsp:directive.page import="com.my.org.erp.bean.Attendance.AttendanceReport" />
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

	<title>:: INVENTORY ::</title>	<meta http-equiv="Expires" content="-1" />
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
		<![CDATA[<body    background="../Image/Smart%20Attendance/background1.jpg">
    <embed src="../Image/General/college.swf" width="1000" height="110"/>
    <br><br>
    ]]>
	</jsp:text>
	<jsp:text>
		<![CDATA[
     		<center>
  				
  					<a href='../Mainscreen.jsp' > Home </a>&nbsp;&nbsp;&nbsp;
  					<a href="javascript:history.back()"> Back </a>&nbsp;&nbsp;&nbsp;
  					<a href="../Logout.jsp"> Logout </a>
  				
  			</center>
     		
    ]]>
	</jsp:text>
	<jsp:scriptlet>
  	 	String repName = request.getParameter("repName");
  		String repHeader = request.getParameter("repHeader");
  		String host = request.getParameter("type");
  		host=host+".xml";

  		<c:import url="../192.168.1.100ReportVendor.xml" var="webXml" />
  		<x:parse xml="${webXml}" var="doc" />

  		<x:forEach select="$doc//context-param">
  		    <x:out select="param-name" />: <x:out select="param-value" />
  		</x:forEach>

 		
 </jsp:scriptlet>








	<jsp:text>
		<![CDATA[
      
      		<center>
  				<a href='#'> 1 </a>&nbsp;&nbsp;&nbsp;
  				<a href="#"> 2 </a>&nbsp;&nbsp;&nbsp;
  				<a href="#"> 3 </a>&nbsp;&nbsp;&nbsp;
  				</table>
  			</center>
      		 
      	]]>
	</jsp:text>
</jsp:root>
