<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='STK' ")[0][0]%></title></title>
 
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

</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Stock/Stockview.js"></script>
<script language="JavaScript">



    function Add()
	{ 
		document.frm.action="DivisionAction.jsp";
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].Divisionid
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
			if (document.forms[0].Divisionid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="DivisionAction.jsp";
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
		var count;
		count=0;
		coffee1=document.forms[0].Divisionid
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
			if (document.forms[0].Divisionid.checked) { count=1;}
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
 	
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadStock('0')">
<%
try
{
%>
<%@ include file="indexstock.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>

	<tr>
	  <td height="19"><form  method="post" name="frm" id="frm">
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><table width="100%" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 >
              <tr class="BackGround">
                <td height="31" class="BackGround"><div align="center" class="boldThirteen">Stock</div></td>
              </tr>
              <tr class="BackGround">
                <td height="31" class="BackGround"><table width="100%"    border='0' class='boldEleven' cellspacing=1 cellpadding=2>
                    <tr  class='BackGround'>
                      <td colspan="4" align='center'  class='bold1'><table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <th width="11%" scope="col"><div align="left" class="bold1">Branch :: </div></th>
                          <th width="18%" scope="col"><div align="left">
                            <select name="branch" class="boldEleven" id="branch" onChange="LoadStock('0')">
							  <option value="0">All</option>
							  <%
							  String branchid=""+session.getAttribute("BRANCHID");
								String usertype=""+session.getAttribute("USRTYPE");
								String user= ""+session.getAttribute("USRID"); 						
								String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
								if(usertype.equals("F"))
								{
								  for(int u=0; u<shipids.length; u++)
									out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
								}
								else
								{
									if(!"000021".equals(user))
									{
									 for(int u=0; u<shipids.length; u++)
										if(shipids[u][0].equals(branchid))
											out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
									}
									else
									{
									 for(int u=0; u<shipids.length; u++)
										out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
									}							
								}
							  /*String braql="SELECT INT_BRANCHID,CHR_BRANCHNAME FROM com_m_branch";
	String bradata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(braql);
	
	for(int u=0; u<bradata.length; u++)
		out.println("<option value="+bradata[u][0]+">"+bradata[u][1] +"</option>");*/
							  %>
                            </select>
                            </div></th>
                          <th width="16%" scope="col"><div align="left" class="bold1">Item Group :: </div></th>
                          <th width="24%" scope="col"><div align="left">
                            <select name="group" class="boldEleven" id="group" onChange="Loaditemproduct(this,'item')" onBlur="LoadStock('0')">
                              <option value="0">All</option>
                              <%
							  String itemsql="SELECT a.INT_GROUPID,a.CHR_GROUPNAME FROM con_inv_m_itemgroup  a , con_inv_m_itemlist b WHERE a.INT_GROUPID = b.INT_GROUPID GROUP BY a.INT_GROUPID ORDER BY a.CHR_GROUPNAME ";
	String itemdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(itemsql);
	String itemdatas=" ";
	for(int u=0; u<itemdata.length; u++)
		out.println("<option value="+itemdata[u][0]+">"+itemdata[u][1] +"</option>");
							  %>
                                  </select>
                          </div></th>
                          <th width="14%" scope="col"><div align="left" class="bold1">Item List :: </div></th>
                          <th width="17%" scope="col"><div align="left" id="item">
                            <select name="iteml" class="boldEleven" id="iteml" onChange="LoadStock('0')">
                              <option value="0">All</option>
                                  </select>
                          </div></th>
                        </tr>
                      </table>                        </td>
                      </tr>
                    <tr  class='MRow1'>
                      <td width="6%" align='center'  class='bold1'><div align='center'>S.No</div></td>
                      <td width="48%" align='center'  class='bold1'><div align='center'> Item Name </div></td>
                      <td width="46%" align='center'  class='bold1'><div align='center'>No of Quantity </div></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td class="bolddeepblue">
                  </td>
              </tr>
              <tr>
                <td height="127" valign="top" class="footermenu">
				
				<div id="divscroll" style="OVERFLOW:auto;width:100%;height:250px" class="boldEleven"></div>
				<br><div id='totalrecord' align="center"></div><br>
				</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="100%" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
              <tr class="para">
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('0')">All</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('A')">A</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('B')">B</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('C')">C</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('D')">D</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('E')">E</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('F')">F</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('G')">G</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('H')">H</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('I')">I</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('J')">J</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('K')">K</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('L')">L</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('M')">M</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('N')">N</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('O')">O</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('P')">P</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('Q')">Q</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('R')">R</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('S')">S</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('T')">T</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('U')">U</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('V')">V</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('W')">W</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('X')">X</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('Y')">Y</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDivision('Z')">Z</a></div></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="296" border="0" align="center" cellpadding="1"
			cellspacing="1">
              <!--DWLayoutTable-->
              <tr>
                <td width="56" valign="top"><input type="hidden" name="filename" value="Division" />
                    <input type="hidden" name="actionS" value="STKDivisionDelete" /></td>
                <td width="56" valign="top"><input type="submit"	class="buttonbold13" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
                <td width="56" valign="top"><input type="submit"	class="buttonbold13" id="btnEdit" name="action1"   value="Edit"	onclick="return Edit()" /></td>
                <%
	  if("F".equals(usertype))
	  {
	  %>
                <td width="56" valign="top"><input type="submit"	class="buttonbold13" name="Submit"  id="btnDelete"   value="Delete"		onclick="return Delete()" /></td>
                <%
	   }
	   %>
                <td width="56"><input type="button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('StockMain.jsp')" /></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
	  </form>	  </td>
	   
	  
	  	  
  </tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	
	
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
<%
}
catch(Exception e)
{
}
%>
</body>
</html>
