  <%@ page import="java.sql.*,java.util.*,java.io.*"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
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
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id,payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
{
	try
	{

			if( 
			
				 checkNull( "itemname","Enter The itemname ..." ) 
				 && checkNull( "pprice","Enter The purchase price ..." )
				 && checkIsNumeric('pprice','Invalid purchase price...')
				 && checkNull( "sprice","Enter The sales price ..." )
				 && checkIsNumeric('sprice','Invalid sales price...')
				 && checkNullSelect( "itemgroup","Select Item Group...",'0' )  
				 && checkNullSelect( "model","Select model...",'0' )
				 && checkNullSelect( "color","Select color...",'0' )
				 && checkNullSelect( "division","Select division...",'0' )
				 && checkNullSelect( "tax","Select tax...",'0' )
				&& checkNull( "description","Enter The description   ..." ) 
				 
				 && checkNullSelect( "warranty","Select warranty...",'0' )  
			
			)
				return true;
			else
				return false;				
				
	}
	catch(err)
	{	
		alert(err);
		return false;
		
	}
} 	


</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="index.jsp"%>
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
    <td>
	 <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
		 
		    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"> Model 
				
				    <%
							String action=request.getParameter("action1");
							String id="",actionS="",value="";
							String link="";
							String itemname="",pprice="",sprice="",active="",itemgroup="";
							String model="",color="",division="",tax="",description="";
							String pdescription="",sdescription="",warranty="" ;
							String sql ="";
							String active1="checked='checked'";
							String active2=""; 
	  
	
							if("Add".equals(action))
							{
								id=""; 
								actionS="INVItemAdd";
								value="Add"; 
								active1="checked='checked'";
								itemname="";pprice="";sprice="";active="";itemgroup="0";
							   	model="0";color="0";division="0";tax="0";description="";
							  	pdescription="";sdescription="";warranty="0"; 
								link=" onBlur=\"upperMe(this), CheckUnique(this,'divunitname','inv_m_item','CHR_ITEMNAME')\"  onKeyUp=\"upperMe(this),CheckUnique(this,'divunitname','inv_m_item','CHR_ITEMNAME')\" ";
								
							}
							else
							{
								id="";  
								id=request.getParameter("rowid");
								sql =  "SELECT INT_ITEMID, CHR_ITEMNAME,DOU_PURCHASEPRICE,DOU_SALESPRICE,INT_ACTIVE  "+
	  	",INT_ITEMGROUPID,INT_MODELCODE ,INT_COLORCODE,INT_DIVIID,INT_TAXID,CHR_DES,CHR_PURCHASEDES,CHR_SALESDES,CHR_WARRANTY "+
	  	",INT_STOCKINHAND  FROM inv_m_item WHERE INT_ITEMID=" +id;
		 
								String data[][]=CommonFunctions.QueryExecute(sql);
								active1 ="";
								active2="";
								id =data[0][0];
								itemname=data[0][1];
								pprice=data[0][2];
								sprice=data[0][3];
								active=data[0][4];
								itemgroup=data[0][5];
							   	model=data[0][6];
								color=data[0][7];
								division=data[0][8];
								tax=data[0][9];
								description=data[0][10];
							  	pdescription=data[0][11];
								sdescription=data[0][12];
								warranty=data[0][13];
								if(active.equals("1"))
									active1="checked='checked'";
								else
									active2="checked='checked'";	
								actionS="INVItemEdit";
								value="Update";
								link=" onBlur=\"upperMe(this)\"";
							}
							
						%>			
				
				</div></td>
                </tr>
               
              <tr>
                <td class="boldEleven">Item Name <span
									class="bolddeepred">* </span></td>
                <td class="boldEleven"><input name="itemname"
									value="<%=itemname %>" size="30" type="text"
									class="formText135" id="itemname" maxlength="50"
									onKeyUp="upperMe(this), CheckUnique(this,'soValid','inv_m_item','CHR_ITEMNAME')"
									onBlur="upperMe(this), CheckUnique(this,'soValid','inv_m_item','CHR_ITEMNAME')"></td>
              </tr>
              <tr>
                <td class="boldEleven">Purchase Price <span
									class="bolddeepred">*</span></td>
                <td class="boldEleven"><input name="pprice"  id="pprice" value="<%=pprice %>" size="30" type="text" class="formText135" maxlength="7" onKeyPress="return numeric_only(event,'purPrice','10')"  ></td>
              </tr>
              <tr>
                <td class="boldEleven">Sales Price <span
									class="bolddeepred">*</span></td>
                <td class="boldEleven">
<input name="sprice" id="sprice" value="<%=sprice %>" size="30" type="text" class="formText135" maxlength="7" onKeyPress="return numeric_only(event,'salesPrice','10')"></td>
              </tr>
              <tr>
                <td class="boldEleven">Active <span
									class="bolddeepred"> </span></td>
                <td class="boldEleven"><table width="100" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><input name="active" type="radio" class="formText135" value="1" id="active" <%=active1 %>></td>
                      <td><font class="boldEleven">True</font></td>
                      <td><input name="active" type="radio" class="formText135" value="0" id="radio" <%=active2 %>></td>
                      <td><font class="boldEleven">False</font></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Item Group <span class="bolddeepred">* </span></td>
                <td class="boldEleven">
<select name="itemgroup" id="itemgroup" style="width: 200" class="newsarticlesmall">
  <option value="0">Select</option>
  <%
 
String itemgroupData1[][] =  CommonFunctions.QueryExecute("SELECT INT_ITEMGROUPID,CHR_GROUPNAME  FROM inv_m_itemgroup ORDER BY CHR_GROUPNAME");
for(int i=0;i<itemgroupData1.length;i++)
	out.println("<option value='"+itemgroupData1[i][0]+"'>"+itemgroupData1[i][1]+"</option>");
	
	%>
</select>
<script language="javascript">setOptionValue('itemgroup','<%=itemgroup%>')</script>

				</td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Model<span class="bolddeepred"> *</span></td>
                <td class="boldEleven">
<select name="model" id="model" style="width: 200" class="formText135">
  <option value="0">Select</option>
  <%

String modelData[][] =  CommonFunctions.QueryExecute("SELECT INT_MODELID,CHR_MODELCODE  FROM inv_m_model  ORDER BY CHR_MODELCODE");
for(int i=0;i<modelData.length;i++)
	out.println("<option value='"+modelData[i][0]+"'>"+modelData[i][1]+"</option>");

	%>
</select>
<script language="javascript">setOptionValue('model','<%=model%>')</script>
				</td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Color <span
									class="bolddeepred">*</span></td>
                <td class="boldEleven">
<select name="color" id="color" style="width: 200" class="formText135">
  <option value="0">Select</option>
  <%
String colorData[][] =  CommonFunctions.QueryExecute("SELECT INT_COLORID,CHR_COLORCODE  FROM inv_m_color  ORDER BY CHR_COLORCODE");
for(int i=0;i<colorData.length;i++)
	out.println("<option value='"+colorData[i][0]+"'>"+colorData[i][1]+"</option>");
		       
	%>
</select>
<script language="javascript">setOptionValue('color','<%=color%>')</script>
				</td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Division <span class="bolddeepred">* </span></td>
                <td class="boldEleven">
<select	name="division" id="division" style="width: 200"class="formText135">
<option value="0">Select</option>
<%
 
String divData[][] =  CommonFunctions.QueryExecute("SELECT INT_DIVIID,CHR_DIVICODE  FROM inv_m_division ORDER BY CHR_DIVICODE");
for (int i = 0; i < divData.length; i++)
	out.println("<option value='" + divData[i][0] + "'>"+ divData[i][1] + "</option>");

				%>
</select>
<script language="javascript">setOptionValue('division','<%=division%>')</script>				
				</td>
</tr>
              <tr>
                <td valign="top" class="boldEleven">Tax <span
									class="bolddeepred">*</span></td>
                <td class="boldEleven"> 
<select name="tax" id="tax" style="width: 200" class="formText135">
<%
String taxdata[][] =  CommonFunctions.QueryExecute("SELECT INT_TAXID,CHR_TAXNAME,DOU_VALUE FROM inv_m_tax ORDER BY CHR_TAXNAME");
for(int u=0;u<taxdata.length;u++)
	out.println("<option value='"+taxdata[u][0]+"'>"+taxdata[u][1]+"</option>");
%>
</select>
<script language="javascript"> setOptionValue("tax","<%=tax%>")  </script></td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Item
                  Description <span
									class="bolddeepred">*</span></td>
                <td class="boldEleven">
				<textarea rows="3" cols="30" class="formText135" name="description"id="description"><%=description %></textarea></td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Purchase
                  Description</td>
                <td class="boldEleven">
				<textarea rows="3" cols="30" class="formText135" name="pdescription"
				id="pdescription"><%=pdescription %></textarea></td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Sales
                  Description</td>
                <td class="boldEleven">
				<textarea rows="3" cols="30" class="formText135" name="sdescription"id="sdescription"><%=sdescription %></textarea></td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Warranty
                  Info <span
									class="bolddeepred">*</span></td>
                <td class="boldEleven">
				<select name="warranty" id="warranty" style="width: 200"class="formText135">
                  <jsp:include page="Warranty.jsp" flush="true" />                
				</select><script language="javascript">setOptionValue('warranty','<%=warranty%>')</script>	
</td>
              </tr>
              <tr>
                 
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="Items" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">				 </td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('ItemView.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
		 </td>
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
    </table> </form></td>
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

 <%	
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
</body>
</html>
