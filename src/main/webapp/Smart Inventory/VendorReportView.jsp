<jsp:root version="1.2" xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="urn:jsptld:http://java.sun.com/jstl/core"
	xmlns:display="urn:jsptld:http://displaytag.sf.net">
	<jsp:directive.page import="java.io.BufferedReader" />
	<jsp:directive.page import="java.io.FileReader" />
	<jsp:directive.page import="com.my.org.erp.SmartInventory.Vendor" />
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
	<link href="../Styles/styles.css" rel="stylesheet" type="text/css" />
	</head>
	<jsp:text>
		<![CDATA[<body    bgcolor="#EFEFEF">
    <embed src="../Image/General/college.swf" width="1000" height="110"/>
    <br><br>
    ]]>
	</jsp:text>
	<jsp:text>
		<![CDATA[<center><br/><br/>]]>
	</jsp:text>
	<jsp:scriptlet>
  	String caption="Vendors Report";
  	ArrayList arrList =new ArrayList();	
	FileReader fr = new FileReader("VendorReport.sys");
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
				Vendor custRep=new Vendor();
				while(filecontents.hasMoreElements())
				{
					String venId=""+filecontents.nextElement();
					if (venId.equalsIgnoreCase("Record not found..."))	break;
					custRep.setINT_VENDORID(venId);
					if(filecontents.hasMoreElements())
						custRep.setCHR_VENDORNAME(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
 						custRep.setCHR_STATE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						custRep.setCHR_PHONE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						custRep.setCHR_EMAIL(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
					{
				    	String temp=""+filecontents.nextElement();
					    String status="";
					    temp=temp.trim();
					    if(temp.equals("0"))
					  	  status="No";
					    else if(temp.equals("1"))
						  status="Yes";
						custRep.setINT_ACTIVE(""+status);
					}
						
					if(filecontents.hasMoreElements())
						custRep.setDAT_SINCE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						custRep.setCHR_ACCNO(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						custRep.setCHR_BANKNAME(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						custRep.setDOU_BALANCE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						custRep.setDAT_BALANCEASOF(""+filecontents.nextElement());
					
					arrList.add(custRep);
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
			<jsp:scriptlet>	out.println(reportHeader);</jsp:scriptlet>
		</display:caption>
		<display:setProperty name="export.pdf.filename" value="example.pdf" />
		<display:setProperty name="export.rtf.filename" value="example.rtf" />
		<display:column property="INT_VENDORID" title="ID" sortable="true"
			headerClass="sortable" />
		<display:column property="CHR_VENDORNAME" title="Vendor Name"
			sortable="true" headerClass="sortable" />
		<display:column property="CHR_STATE" title="State" />
		<display:column property="CHR_PHONE" title="Mobile" />
		<display:column property="CHR_EMAIL" title="Email" />
		<display:column property="INT_ACTIVE" title="Active" />
		<display:column property="DAT_SINCE" title="Since" />
		<display:column property="CHR_ACCNO" title="Acc No" />
		<display:column property="CHR_BANKNAME" title="Bank Name" />
		<display:column property="DOU_BALANCE" title="Balance" />
		<display:column property="DAT_BALANCEASOF" title="Balance Date" />

	</display:table>
	<jsp:text>
		<![CDATA[
     		<a href='ReportPrint.jsp' target='_blank'> HTML Print </a>
     		<br/>      		
      		<a href="Vendor Details.jsp"> Back </a>
      		</center>
      	]]>
	</jsp:text>
</jsp:root>
