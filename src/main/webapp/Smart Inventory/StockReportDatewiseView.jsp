<jsp:root version="1.2" xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="urn:jsptld:http://java.sun.com/jstl/core"
	xmlns:display="urn:jsptld:http://displaytag.sf.net">
	<jsp:directive.page import="java.io.BufferedReader" />
	<jsp:directive.page import="java.io.FileReader" />
	<jsp:directive.page import="com.my.org.erp.SmartInventory.StockDatewise" />
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
  	String caption="Stock Report Datewise";
  	ArrayList arrList =new ArrayList();	
	FileReader fr = new FileReader("StockReportDate.sys");
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
				StockDatewise stockRep=new StockDatewise();
				while(filecontents.hasMoreElements())
				{
					String purId=""+filecontents.nextElement();
					if (purId.equalsIgnoreCase("Record not found..."))	break;
					stockRep.setOrderId(purId);
					if(filecontents.hasMoreElements())
						stockRep.setOrderDate(""+filecontents.nextElement());					
					if(filecontents.hasMoreElements())
						stockRep.setItemId(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
 						stockRep.setQuantity(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						stockRep.setUnitPrice(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						stockRep.setDiscount(""+filecontents.nextElement());
					if(filecontents.hasMoreElements())
						stockRep.setPrice(""+filecontents.nextElement());
					arrList.add(stockRep);
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
		<display:column property="orderId" title="ID" sortable="true"
			headerClass="sortable" />
		<display:column property="orderDate" title="Order Date"
			sortable="true" headerClass="sortable" />
		<display:column property="itemId" title="Item Id" />
		<display:column property="quantity" title="Quantity" />
		<display:column property="unitPrice" title="Unit Price" />
		<display:column property="discount" title="Discount" />
		<display:column property="price" title="Price" />


	</display:table>
	<jsp:text>
		<![CDATA[
     		<a href='ReportPrint.jsp' target='_blank'> HTML Print </a>
     		<br/>      		
      		<a href="StockDatewise.jsp"> Back </a>
      		</center>
      	]]>
	</jsp:text>
</jsp:root>
