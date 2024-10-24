<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%
try
{
	String sql="";
	String salno= request.getParameter("salno");
	String type= request.getParameter("type");
	String header ="";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>:: INVENTORY ::</title>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>

<body onLoad="javascript:window.print()">
<p>&nbsp;</p>
 
<table width="90%" height="175" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000" class="boldEleven" style="border-style:dotted; bor">
  <tr>
    <td width="53%" height="167" valign="bottom"><table   border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td class="bold1"> 
            <%
sql = " SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
sql = sql +" a.CHR_FAX,a.CHR_EMAIL  FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_city e ";
sql = sql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
sql = sql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
sql = sql +" AND a.INT_STATEID =d.INT_STATEID ";
sql = sql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
sql = sql +" AND a.INT_BRANCHID="+ session.getAttribute("INVBRANCH");
String cpydata[][]=CommonFunctions.QueryExecute(sql);
					   
 header="<h1>FROM : <br><br>"+cpydata[0][0]+"</h1>";
if(!"-".equals(cpydata[0][2]))
	header=header+""+cpydata[0][2]+",<br>";
if(!"-".equals(cpydata[0][3]))	
	header=header+""+cpydata[0][3]+",<br>";
if(!"-".equals(cpydata[0][4]))
	header=header+""+cpydata[0][4]+",<br>";
if(!"-".equals(cpydata[0][5]))
	header=header+""+"PIN :"+cpydata[0][5]+",<br>";	
if(!"-".equals(cpydata[0][6]))
	header=header+""+"PHONE :"+cpydata[0][6]+",<br>";	
if(!"-".equals(cpydata[0][7]))
	header=header+""+"FAX :"+cpydata[0][7]+".<br>";	
	
out.println(header+" <br>");
	%>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
    </table></td>
    <td width="47%" valign="top"  >
	<table  border="0" align="left" cellpadding="0" cellspacing="0" >
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td class="bold1"><%
	
	if("directsales".equals(type))
	{
		
		sql = "SELECT INT_CUSTOMERID,CHR_SHIPPING,CHR_SHIPPINGADDRESS FROM inv_t_directsales WHERE CHR_SALESNO ='"+salno+"'";
		String invData[][]  = CommonFunctions.QueryExecute(sql);
		sql="SELECT  f.CHR_NAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2,a.CHR_ADDRESS3, e.CHR_CITYNAME,d.CHR_DISTRICT,";
		sql = sql +" c.CHR_STATENAME, a.INT_PINCODE ,a.CHR_AREACODE,a.CHR_PHONE, ";
		sql = sql +" a.CHR_MOBILE ,a.CHR_EMAIL ";
		sql = sql +" FROM inv_m_customerinfo a,com_m_country b,com_m_state c,com_m_district d,com_m_city e,inv_m_customergroup f";
		sql = sql +" WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID ";
		sql = sql +" AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   ";
		sql = sql +" AND a.INT_CITYID =e.INT_CITYID ";
		sql = sql +" AND a.INT_CUSTOMERID="+invData[0][0];
		 
		String vendor[][] =  CommonFunctions.QueryExecute(sql);
		if("S".equals(invData[0][1]))
		{
			 
			header="<h1>TO : <br><br> "+vendor[0][0]+"</h1> ";
			if(!"-".equals(vendor[0][1]))
				header=header+""+vendor[0][1]+",<br>";
			if(!"-".equals(vendor[0][2]))
				header=header+""+vendor[0][2]+",<br>";
			if(!"-".equals(vendor[0][3]))
				header=header+""+vendor[0][3]+",<br>";
			if(!"-".equals(vendor[0][4]))
				header=header+""+vendor[0][4]+",<br>";
			if(!"-".equals(vendor[0][5]))
				header=header+""+vendor[0][5]+",<br>";
			if(!"-".equals(vendor[0][6]))
				header=header+""+vendor[0][6]+",<br>";
			if(!"-".equals(vendor[0][7]))
				header=header+"PIN :"+vendor[0][7]+",<br>";
			if((!"-".equals(vendor[0][8])) && (!"-".equals(vendor[0][9]))  )
				header=header+"PHONE : "+vendor[0][8]+" - "+vendor[0][9]+",<br>";
			if(!"-".equals(vendor[0][10]))
				header=header+"MOBILE :"+vendor[0][10]+",<br>";
			/*if(!"-".equals(vendor[0][11]))
				header=header+"MAIL :"+vendor[0][11]+",<br>";
			*/
			out.println(header+" <br>");
		 							
							
		}	
		else
		{
			header = "<h1>TO : </h1><br>"+invData[0][2].replaceAll(",", "<br>");
			out.println(header+" <br>");
		}			 			
	}
	%></td>
      </tr>
      <tr>
        <td >&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}

%>