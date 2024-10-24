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
<script language="javascript" src="../JavaScript/Stock/BankBranchview.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="BankBranchAction.jsp";
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].BankBranchid
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
			if (document.forms[0].BankBranchid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="BankBranchAction.jsp";
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
		coffee1=document.forms[0].BankBranchid
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
			if (document.forms[0].BankBranchid.checked) { count=1;}
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadBankBranch('0')">
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
                  <td height="31" class="BackGround"><div align="center" class="boldThirteen">BANK BRANCH </div></td>
                </tr>
                <tr class="BackGround">
                  <td height="31" class="BackGround"><table width="331" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td class="boldEleven"><div align="right">Bank </div></td>
                        <td class="boldEleven"><select name="bankgroup" id="bankgroup" class="formText135" onChange="LoadBankBranch('0')">
                            <option value="0">All</option>
                            <%
						  	String ss="SELECT INT_BANKID,CHR_BANKNAME,CHR_SHORTNAME FROM con_inv_m_bankname  ORDER BY CHR_BANKNAME";
							String bankdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ss);
							for(int y=0;y<bankdata.length;y++)
								out.println("<option value='"+bankdata[y][0]+"'>"+bankdata[y][2]+"</option>");
						  %>
                          </select>
                        </td>
                      </tr>
                    </table></td>
                </tr>
                <tr class="BackGround">
                  <td height="31" class="BackGround"><table width="100%"    border='0' class='boldEleven' cellspacing=1 cellpadding=2>
                      <tr  class='MRow1'>
                        <td  class='bold1' align='center'><div align='center'>S.No</div></td>
                        <td  class='bold1' align='center'><div align='center'>Bank</div></td>
                        <td  class='bold1' align='center'><div align='center'>Branch Name</div></td>
                        <td  class='bold1' align='center'><div align='center'>Code</div></td>
                        <td  class='bold1' align='center'><div align='center'>Phone</div></td>
                        <td  class='bold1' align='center'><div align='center'>Email</div></td>
						<td  class='bold1' align='center'><div align='center'>Swift</div></td>
                      </tr>
                    </table></td>
                </tr>
                
                <tr>
                  <td height="127" valign="top" class="footermenu">
				  <div id="divscroll" style="OVERFLOW:auto;width:100%;height:250" class="boldEleven"></div>
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
					href="javascript:LoadBankBranch('0')">All</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('A')">A</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('B')">B</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('C')">C</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('D')">D</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('E')">E</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('F')">F</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('G')">G</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('H')">H</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('I')">I</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('J')">J</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('K')">K</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('L')">L</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('M')">M</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('N')">N</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('O')">O</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('P')">P</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('Q')">Q</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('R')">R</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('S')">S</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('T')">T</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('U')">U</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('V')">V</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('W')">W</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('X')">X</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('Y')">Y</a></div></td>
                  <td class="boldEleven"><div align="center"><a
					href="javascript:LoadBankBranch('Z')">Z</a></div></td>
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
                  <td width="56" valign="top"><input type="hidden" name="filename" value="BankBranch" />
                    <input type="hidden" name="actionS" value="STKBankBranchDelete" /></td>
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
