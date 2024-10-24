<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>
<title>:: INVENTORY ::</title> 
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

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	
	if( 
	 	checkNullSelect( "Group","Select Group",'0' )
		&& checkNull( "name","Enter Name" )
	  	&& checkNull( "desc","Enter Description" )
	    && checkNull('amount','Enter Budget Amount') 
	)
		return true;
	else
		return false;				
		
	
 } 	
</script>
<body    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block" /></td>
          <td width="412" valign="top">
		  <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
		    <table width="73%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center">Accessories Name 
                    <%
							String action=request.getParameter("action1");
							String id="",group="",Name="",actionS="",value="",amount="";
							String desc="";
							String sql="";
							if("Add".equals(action))
							{
								id="";Name="";group="";desc="";amount="";
								actionS="INVAccessoriesProductAdd";
								value="Add";
							}
							else
							{
								id="";Name="";group="";amount="";
								id=request.getParameter("id");
								      
								sql = " SELECT INT_PRODUCTID,INT_GROUPID,CHR_PRODUCTNAME,CHR_DESC,DOU_AMOUNT FROM inv_m_accessoriesproduct  WHERE INT_PRODUCTID= "+id;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								id=data[0][0];group=data[0][1];Name=data[0][2]; 
								desc=data[0][3];amount=data[0][4];
								actionS="INVAccessoriesProductEdit";
								value="Update";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td class="boldEleven">Group</td>
                <td class="boldEleven"><select name="Group" class="formText135" id="Group" >
                  <option value="0">Select</option>
                  <%

			String deptdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_GROUPID,CHR_GROUPNAME,CHR_DESC FROM  inv_m_accessoriesgroup  ORDER BY CHR_GROUPNAME");
			for(int x=0;x<deptdata.length;x++)
				out.println("<option value='"+deptdata[x][0]+"'>"+deptdata[x][1]+"</option>");
			%>
                </select>
				
				<%
				if(!"Add".equals(action))
				{
					%>
					<script language="javascript">setOptionValue('Group','<%=group%>')</script>
					<%
				}
				%>				</td>
              </tr>
              <tr>
                <td class="boldEleven"> Name</td>
                <td class="boldEleven"><input name="name" type="text" class="formText135" id="name" onBlur="upperMe(this), CheckUnique(this,'divunitname','inv_m_accessoriesproduct','CHR_PRODUCTNAME')"
				 onKeyUp="upperMe(this),CheckUnique(this,'divunitname','inv_m_accessoriesproduct','CHR_PRODUCTNAME')" value="<%=Name%>" maxlength="50">
				<div id='divunitname'></div>				</td>
              </tr>
              <tr>
                <td class="boldEleven">Desc</td>
                <td class="boldEleven"><textarea name="desc" cols="50" rows="5" class="formText135" id="desc"><%=desc%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">Amount</td>
                <td class="boldEleven"><input name="amount" type="text" class="formText135" id="amount" onKeyPress="doubleValue('amount','6')" size="6" style='text-align:right' value="<%=amount%>"></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="AccessoriesProduct" />
                <input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                    <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('AccessoriesEntry.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
		  </form></td>
          <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
      </tbody>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
