<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%><html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

 <style type="text/css">
@import url("../bootstrap/css/bootstrap.min.css");
@import url("../JavaScript/SmartStyles.css");
</style>
<script src="../bootstrap/js/jquery.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript" src="../JavaScript/Inventory/PurchaseRequest.js"></script>
<script language="JavaScript">
	function getDBPath()
	{
		var pathname = window.location.pathname;
		var iPos = window.location.pathname.toString().toLowerCase().lastIndexOf('.nsf');
		if(iPos>0) return pathname.substring(0, iPos+4);
		alert(pathname);
		return pathname; 
	} 

    function Add()
	{ 
		document.frm.action="PurchaseRequestAdd.jsp";		
 	}

	function Edit()
 	{		
		obj = findObj("Requestno"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}



		var count;
		count=0;
		coffee1=document.forms[0].Requestno;
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
			if (document.forms[0].Requestno.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="PurchaseRequestEdit.jsp";
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
		try
		{
			obj = findObj("Requestno"); 
			if(obj == null)
			{
				alert("Delete not available");
				return false;
			}
	


			var count;
			count=0;
			coffee1=document.forms[0].Requestno;
			txt=""
			var id="";
			for (i=0;i<coffee1.length;++ i)
			{
				if (coffee1[i].checked)
				{
				count=count+1;
				id=i;
				}
			}
			if(count==0)
			{
				if (document.forms[0].Requestno.checked) { count=1;}
			}
			
			if(count>1)
			{
				alert("Kindly select one value");
				return false;
			}
			if(count==1)
			{	 
					
					var r=confirm("ARE YOU SURE YOU WANT TO DELETE THE PURCHASE REQUEST   ..."+coffee1[id].value);
					if (r==true)
					{
						var reason=prompt("Reason for Delete :: ","For e.g - Value has to be change."); 
						if (reason!=null && reason!="")
						{
							var d ="../SmartLoginAuth?Requestno="+coffee1[id].value+"&reason="+reason;
							document.frm.action=d; 
							
						}	
					}			
	
			}
			else
			{
				alert("Select Atleast One Value");
				return false;
			}		
		}
		catch(err)
		{
			alert(err);
			return false;
		}
 	}
	
	
	
</script>

<body    onLoad="loadPurchaseRequest('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth"  >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	 
	<tr>
	  <td>	  </td>
	</tr>
	<tr>
		<td height="291"><table width="90%" height="189" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
          <tr  >
            <td height="31"  > <div align="center">PURCHASE REQUEST</div></td>
          </tr>
          <tr  >
            <td height="31" align="center"  ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
              <tr>
                <td>Branch
                  <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				 
			%>                </td>
                <td><span class="boldThirteen">
                  <select name="Branch" class="formText135" style="width:200"
							id="Branch" tabindex="6"  onChange="loadPurchaseRequest('0')">
                    <%
								
				String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
				if(usertype.equals("F") || usertype.equals("B") )
				 	out.println("<option value='0'>All</option>");
				  
				 for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
					
							%>
                  </select>
                  <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						  </script>
                </span></td>
                <td>Customer</td>
                <td><span class="boldThirteen">
                  <select name="customer" style="width:200"
							id="customer" class="formText135"  onChange="loadPurchaseRequest('0')">
                    <option value="0">All</option>
                    <jsp:include page="LoadCustomer.jsp" />                  
</select>
                </span></td>
                <td>Status</td>
                <td><select name="status" class="formText135" id="status"
							 onChange="loadPurchaseRequest('0')">
                  <option value="0">All</option>
                  <option value="Y">Accepted</option>
                  <option value="R">Rejected</option>
                  <option value="N" selected>Pending</option>
                </select></td>
                </tr>
              
              <tr>
                <td height="31" colspan="6" align="center" valign="top"><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                  <tr>
                    <td  height="31">Division</td>
                    <td  ><span class="boldThirteen">
                      <select name="divis"
							class="formText135" id="divis" tabindex="1"  onChange="loadPurchaseRequest('0')"
							>
                        <option value='0'>All</option>
                        <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
						%>
                      </select>
					  
					  
					  
                    </span></td>
                    <td    >Day</td>
                    <td    ><select name="day" class="formText135" id="day"  onBlur="loadPurchaseRequest('0') ">
                        <option value="0" selected>All</option>
                        <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                      </select>
                    </td>
                    <td  >Month</td>
                    <td  ><select name="month" class="formText135" id="month" onChange="loadPurchaseRequest('0')">
					<option value="0" selected>All</option>
                      <%@ include file="../JavaScript/Inventory/month.jsp"%>
                    </select></td>
                    <td  >Year</td>
                    <td  ><select name="year" class="formText135" id="year"
							 onChange="loadPurchaseRequest('0')">
                      <%@ include file="../JavaScript/Inventory/year.jsp"%>
                    </select>
                   
					    <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						//setOptionValue('day',day);	
						//setOptionValue('month',month1);
						setOptionValue('year',year1);	
				//-->
          </script></td>
                  </tr>
                </table>                  </td>
              </tr>
            </table></td>
          </tr>

          
          <tr class="MRow1">
            <td height="127" valign="top" class="footermenu">
			<div id="PurchaseRequest" style="OVERFLOW:auto;width:100%;height:300px"  > </div>
			 <br>						 
				<div align="center" id="totRec"></div>	<br>			</td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table  border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('0')">All</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('A')">A</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('B')">B</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('C')">C</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('D')">D</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('E')">E</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('F')">F</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('G')">G</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('H')">H</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('I')">I</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('J')">J</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('K')">K</a></div></td> 
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('L')">L</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('M')">M</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('N')">N</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('O')">O</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('P')">P</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('Q')">Q</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('R')">R</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('S')">S</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('T')">T</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('U')">U</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('V')">V</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('W')">W</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('X')">X</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('Y')">Y</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadPurchaseRequest('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	 
	<tr>
	  <td height="15"><input name="filename" type="hidden" value="PurchaseRequest" />
      <input
			name="actionS" type="hidden" value="INVPurchaseRequestDelete" /></td>
    </tr>
	<tr>
	  <td> <div align="center">
        <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'InventoryMains.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
      </div></td>
    </tr>
</table>


<%
	/*try
	{
		String ksql =   " SELECT  count(*),CHR_EMPID,CHR_STAFFNAME ,CHR_STAFFFNAME,DATE_FORMAT(DT_DOB,'%d-%b-%Y') ,CHR_MOBILE   FROM com_m_staff    GROUP BY CHR_STAFFNAME , DT_DOB ";
		String kdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ksql);
		if(kdata.length>0)
		{
			for(int k=0;k<kdata.length;k++)
			{
				if(Integer.parseInt(kdata[k][0])>1)
				{
					ksql = "SELECT   CHR_EMPID,CHR_STAFFNAME ,CHR_STAFFFNAME,DATE_FORMAT(DT_DOB,'%d-%b-%Y') ,CHR_MOBILE   FROM com_m_staff  WHERE CHR_STAFFNAME ='"+kdata[k][2]+"' ";
					String kkdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ksql);
					if(kkdata.length>0)
						for(int j=0;j<kkdata.length;j++)
							out.println(kkdata[j][0]+","+kkdata[j][1]+","+kkdata[j][2]+","+kkdata[j][3]+","+kkdata[j][4]+",<br>");
				}
			}
		}
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}*/
%>
 <%@ include file="../footer.jsp"%></form>
</body>
</html>
