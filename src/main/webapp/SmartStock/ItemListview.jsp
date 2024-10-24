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
<script language="javascript" src="../JavaScript/Stock/itemlist.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="ItemListAction.jsp";
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].itemlistid
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
			if (document.forms[0].itemlistid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ItemListAction.jsp";
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
		coffee1=document.forms[0].itemlistid
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
			if (document.forms[0].itemlistid.checked) { count=1;}
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadItemList('0')">
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
                  <td height="31" class="BackGround"><div align="center" class="boldThirteen">Item</div></td>
                </tr>
                <tr class="BackGround">
                  <td height="31" class="BackGround"><table width="331" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td class="boldEleven"><div align="right">Item Group </div></td>
                        <td class="boldEleven"><select name="itemgroup" id="itemgroup" class="formText135" onChange="LoadItemList('0')">
                            <option value="0">All</option>
                            <%
						  	String ss="SELECT INT_GROUPID,CHR_GROUPNAME FROM  con_inv_m_itemgroup  ORDER BY CHR_GROUPNAME";
							String unitdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ss);
							for(int y=0;y<unitdata.length;y++)
								out.println("<option value='"+unitdata[y][0]+"'>"+unitdata[y][1] +"</option>");
						  %>
                          </select>
                          <%
						request.setAttribute("kalai",new String("ABIAARTHI"));
						
					%>
                          <%=""+request.getAttribute("kalai") %> </td>
                      </tr>
                    </table></td>
                </tr>
                <tr class="BackGround">
                  <td height="31" class="BackGround"><table width="100%"    border='0' class='boldEleven' cellspacing=1 cellpadding=2>
                      <tr  class='MRow1'>
                        <td  class='bold1' align='center'><div align='center'>S.No</div></td>
                        <td  class='bold1' align='center'><div align='center'>Item Name</div></td>
                        <td  class='bold1' align='center'><div align='center'>Group Name</div></td>
                        <td  class='bold1' align='center'><div align='center'>Description</div></td>
                        <td  class='bold1' align='center'><div align='center'>Purchase Price</div></td>
                        <td  class='bold1' align='center'><div align='center'>Sales Price</div></td>
                      </tr>
                    </table></td>
                </tr>
                
                <tr>
                  <td height="127" valign="top" class="footermenu">
				  
				  <div id="divscroll" style="OVERFLOW:auto;width:100%;height:130px" class="boldEleven"></div>
				  <br><div id='totalrecord' align="center"></div>
				  <br>
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
					href="javascript:LoadItemList('0')">All</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('A')">A</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('B')">B</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('C')">C</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('D')">D</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('E')">E</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('F')">F</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('G')">G</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('H')">H</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('I')">I</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('J')">J</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('K')">K</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('L')">L</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('M')">M</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('N')">N</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('O')">O</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('P')">P</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('Q')">Q</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('R')">R</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('S')">S</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('T')">T</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('U')">U</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('V')">V</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('W')">W</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('X')">X</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('Y')">Y</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadItemList('Z')">Z</a></div></td>
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
                  <td width="56" valign="top"><input type="hidden" name="filename" value="ItemList" />
                    <input type="hidden" name="actionS" value="STKItemListDelete" /></td>
                  <td width="56" valign="top"><input type="submit"	class="buttonbold13" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
                  <td width="56" valign="top"><input type="submit"	class="buttonbold13" name="action1"   value="Edit"	onclick="return Edit()" /></td>
                  <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
                  <td width="56" valign="top"><input type="submit"	class="buttonbold13" name="Submit"   value="Delete"		onclick="return Delete()" /></td>
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
      </form></td>
    </td>
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
