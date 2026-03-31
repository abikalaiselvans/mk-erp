<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage=""%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 
<%
try
{
	String usertypes=""+session.getAttribute("USRTYPE");	
%>



<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<title> :: MARKETING ::</title>

<script language="javascript" src="../JavaScript/comfunction.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %> 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>




</head>
<script language="javascript" src="../JavaScript/Marketing/MyFunnelinfo.js"  ></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="MyFunnelAction.jsp";
 	}

	function Edit()
 	{		
		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}



		var count;
		count=0;
		coffee1=document.forms[0].rowid
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].rowid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="MyFunnelAction.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function Delete()
 	{		
		
		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].rowid
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].rowid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
 	
//onselectstart="return false" onpaste="return false;" onCopy="return false"  onLoad="LoadMyFunnelinfo('0')"  
  
</script>
<body  onLoad="LoadMyFunnelinfo('0')"  >
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td> <div align="center">
        <%
			out.println("<table   border='0' align='center' cellpadding='5' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_MKT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_MKT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_MKT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	 
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'MarketingMain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
      </div></td>
	</tr>
	 
	<tr>
	  <td><!--<div align="right" class="copyright"><a href="MyFunnel_Upload.jsp">Upload</a></div>--></td>
    </tr>
	 
	<tr>
	  <td><table width="90%" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
        <tr  >
          <td height="31"  ><div align="center">CUSTOMER INFORMATION </div></td>
        </tr>
        <tr  >
          <td height="31" align="center" valign="middle"  ><table width="90%" border="0" align="center" cellpadding="2" cellspacing="2" class="whiteMedium">
               
              <tr>
              <td  >Day</td>
              <td  ><select name="day" id="day"  onBlur="LoadMyFunnelinfo('0') ">
                <option value="0" selected>All</option>
                <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
              </select></td>
              <td >Month</td>
              <td ><select name="month" class="formText135" id="month" onBlur="LoadMyFunnelinfo('0')">
                <%
java.util.Date dt = new java.util.Date();
int m = dt.getMonth();
%>
                <%@ page import="java.util.Date"%>
                <option value="0">All</option>
                <option value="01">January</option>
                <option value="02">February</option>
                <option value="03">March</option>
                <option value="04">April</option>
                <option value="05">May</option>
                <option value="06">June</option>
                <option value="07">July</option>
                <option value="08">August</option>
                <option value="09">September</option>
                <option value="10">October</option>
                <option value="11">November</option>
                <option value="12">December</option>
              </select></td>
              <td >Year</td>
              <td ><select name="year" class="formText135" id="year" onBlur="LoadMyFunnelinfo('0')">
                <%
java.util.Date dts = new java.util.Date();
int ms = dts.getYear();
%>
                <option value="1999" selected="selected">1999</option>
                <%
      for(int i=2000;i<=2050;i++)
      {
       out.println("<option value="+i+">"+i+"</option>");
      }
  %>
              </select>
                <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						//setOptionValue('day',day);	
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
				//-->
            </script></td>
              </tr>
              <tr>
                <td>M.E</td>
                <td>
                  <select name="me" class="formText135" id="me" style="width:175"  onBlur="LoadMyFunnelinfo('0')" >
                    <option value="0">All</option>
                    <%
				  if(!"F".equals(usertypes))
				  {
			  		String datad[][] =CommonFunctions.getReportingEmployeeIdNames(""+session.getAttribute("EMPID"));
					for(int u=0;u<datad.length;u++)
						out.println("<option value='"+datad[u][0]+"'>"+datad[u][1]+" / " +datad[u][0]+"</option>");
				  }
				  else
				  {
					  String datad[][] = CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE CHR_TYPE != 'T' ORDER BY CHR_STAFFNAME");
						for(int u=0;u<datad.length;u++)
							out.println("<option value='"+datad[u][0]+"'>"+datad[u][1]+" / " +datad[u][0]+"</option>");
				  }
			  %>
                  </select></td>
                <td>Search</td>
                <td><input name="search" type="text" id="search" maxlength="10" onKeyUp="LoadMyFunnelsearchinfo()"></td>
                </tr>
          </table></td>
        </tr>
        <tr class="MRow1">
          <td class="bolddeepblue"><div id="GroupTable" style="OVERFLOW:auto;width:100%;height:300px" class="boldEleven"></div>
              <br>
            <div id="totalrec"></div></td>
        </tr>
        
	    <tr>        </tr>
      </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
	    <tr class="para">
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('0')">All</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('A')">A</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('B')">B</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('C')">C</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('D')">D</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('E')">E</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('F')">F</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('G')">G</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('H')">H</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('I')">I</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('J')">J</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('K')">K</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('L')">L</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('M')">M</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('N')">N</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('O')">O</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('P')">P</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('Q')">Q</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('R')">R</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('S')">S</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('T')">T</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('U')">U</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('V')">V</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('W')">W</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('X')">X</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('Y')">Y</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadMyFunnelinfo('Z')">Z</a></div></td>
	      </tr>
      </table></td>
    </tr>
	<tr>
	  <td><span class="boldEleven">
	    <input type="hidden" name="filename" value="MyFunnel" />
        <input type="hidden" name="actionS" value="MKTMyFunnelDelete" />
      </span></td>
    </tr>
	
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
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