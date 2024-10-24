<jsp:root version="1.2" xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="urn:jsptld:http://java.sun.com/jstl/core"
	xmlns:display="urn:jsptld:http://displaytag.sf.net">
	<jsp:directive.page import="java.io.BufferedReader" />
	<jsp:directive.page import="java.io.FileReader" />
	<jsp:directive.page import="com.my.org.erp.SmartInventory.Purchase" />
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
  	String caption="Purchase Report";
  	ArrayList arrList =new ArrayList();	
	FileReader fr = new FileReader("PurchaseReport.sys");
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
				Purchase custRep=new Purchase();
				while(filecontents.hasMoreElements())
				{
					String purId=""+filecontents.nextElement();
					if (purId.equalsIgnoreCase("Record not found..."))	break;
					custRep.setINT_PURCHASEORDERID(purId);
					if(filecontents.hasMoreElements())
						custRep.setCHR_VENDORNAME(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
 						custRep.setDAT_REQUESTDATE(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						custRep.setINT_PAYMENTTERMID(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						custRep.setDOU_AMOUNT(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						custRep.setDOU_TAXAMOUNT(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						custRep.setDOU_TOTALAMOUNT(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
					{
						String temp=""+filecontents.nextElement();
						temp=temp.trim();
						String status="";
						if(temp.equals("0"))
							status="Received";
						else if(temp.equals("1"))
							status="Pending";
						custRep.setINT_PURCHASESTATUS(""+status);
					}	
					
					if(filecontents.hasMoreElements())
					{
						String temp=""+filecontents.nextElement();
						temp=temp.trim();
						
						String status="";
						if(temp.equals("0"))
							status="Closed";
						else if(temp.equals("1"))
							status="Balance";
						custRep.setINT_PAYMENTSTATUS(""+status);
					}
						
						
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
		<display:column property="INT_PURCHASEORDERID" title="ID"
			sortable="true" headerClass="sortable" />
		<display:column property="CHR_VENDORNAME" title="Vendor Name"
			sortable="true" headerClass="sortable" />
		<display:column property="DAT_REQUESTDATE" title="Request Date" />
		<display:column property="INT_PAYMENTTERMID" title="Payment Mode" />
		<display:column property="DOU_AMOUNT" title="Amount" />
		<display:column property="DOU_TAXAMOUNT" title="Tax Amount" />
		<display:column property="DOU_TOTALAMOUNT" title="Total Amount" />
		<display:column property="INT_PURCHASESTATUS" title="Purchase Status" />
		<display:column property="INT_PAYMENTSTATUS" title="Payment Status" />

	</display:table>
	<jsp:text>
		<![CDATA[
     		<a href='ReportPrint.jsp' target='_blank'> HTML Print </a>
     		<br/>      		
      		<a href="Purchase Details.jsp"> Back </a>
      		</center>
      	]]>
	</jsp:text>
</jsp:root>
