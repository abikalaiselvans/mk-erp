<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
  
</head>
 <body >
<%@ include file="indexinv.jsp"%>
<% 

	String dcno = request.getParameter("dcno");
	//String dcno = "DC/201314000009/CHE/DAC";
	//out.print("CHR_DCNO:"+dcno);
	String perdata[][]=CommonFunctions.QueryExecute("SELECT CHR_ADJUSTMENTNO,DAT_ADJUSTMENTDATE,INT_TO_BRANCHID,CONCAT('-'),FIND_A_EMPLOYEE_ID_NAME(CHR_REF),CHR_OTHERREF,CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,CHR_DESTINATION,CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,CHR_DES,FUN_INV_DIVISION(INT_DIVIID),INT_DIVIID FROM inv_t_stockadjustment WHERE CHR_ADJUSTMENTNO='"+dcno+"'");
	
	
%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
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
		<td height="291"><table width="80%" border="0"
			align="center" cellpadding="0" cellspacing="0" class="BackGround1">
          <tbody>
            <tr>
              <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
              <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
              <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
            </tr>
            <tr>
              <td height="6"><spacer height="1" width="1" type="block" /></td>
            </tr>
            <tr>
              <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
              <td width="6"><spacer height="1" width="1" type="block" /></td>
              <td><table width="100%"
						border="0" align="center" cellpadding="2" cellspacing="2">
                
                  <tbody>
                    <tr>
                      <td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">STOCK ADJUSTMENT SERIAL NUMBER DETAIL </td>
                    </tr>
                    <tr>
                      <td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory </span></td>
                    </tr>
                    <tr>
                      <td height="17" colspan="4" valign="top" class="errormessage"><div align="center">
                       
                      </div></td>
                    </tr>
                    <tr>
                      <td width="139" height="17" valign="top" class="bold1"  >Number   </td>
                      <td width="293" align="left" valign="top"><span class="boldEleven"><%=perdata[0][0]%>&nbsp;</span></td>
                      <td width="172" class="bold1"  >Order Reference  </td>
                      <td width="150" class="boldEleven"><span class="boldEleven"><%=perdata[0][5]%></span></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="bold1"  >Date    </td>
                      <td align="left"><span class="boldEleven"><%=perdata[0][1]%></span></td>
                      <td class="bold1"  >Delivery Note   </td>
                      <td class="boldEleven"><span class="boldEleven"><%=perdata[0][6]%></span></td>
                    </tr>
                    <tr>
                      <td class="bold1"  >&nbsp; </td>
                      <td class="boldEleven">&nbsp; </td>
                      <td class="bold1"  ><div align="left">Despatch Thru   </div></td>
                      <td class="boldEleven"><span class="boldEleven"><%=perdata[0][7]%></span></td>
                    </tr>
                    <tr>
                      <td rowspan="3" valign="top" class="bold1"  >&nbsp; </td>
                      <td rowspan="3" class="boldEleven"><table width="38%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <%--<td width="9%"><input name="Shipping" type="radio" onClick="return resoffval()"
												value="S" checked /></td>
                            <td width="15%" class="boldEleven">Same</td>
                            <td width="52%" class="boldEleven"><input
												onclick="return resoffval()" name="Shipping" type="radio"
												value="D"></td>--%>
                            <td width="24%" class="boldEleven"></td>
                          </tr>
                        </table>
                            </td>
                      <td class="bold1"  >Destinaion   </td>
                      <td class="boldEleven"><span class="boldEleven"><%=perdata[0][8]%></span></td>
                    </tr>
                    <tr>
                      <td class="bold1"  >Terms of Delivery   </td>
                      <td class="boldEleven"><span class="boldEleven"><%=perdata[0][9]%></span></td>
                    </tr>
                    <tr>
                      <td class="bold1"  >Contact Person   </td>
                      <td class="boldEleven"><span class="boldEleven"><%=perdata[0][10]%></span></td>
                    </tr>
                    <tr>
                      <td valign="top" class="bold1"  >Division</td>
                      <td class="boldEleven"><%=perdata[0][14]%>
                        <input name="division" type="hidden" id="division" value="<%=perdata[0][15]%>"></td>
                      <td class="bold1"  >Contact No.   </td>
                      <td class="boldEleven"><span class="boldEleven"><%=perdata[0][11]%></span></td>
                    </tr>

                    <tr>
                      <td height="17" valign="top" class="bold1"  >Reference   </td>
                      <td align="left"><span class="boldEleven"><%=perdata[0][4]%></span></td>
                      <td valign="top" class="bold1"  >Others Description</td>
                      <td valign="top" class="boldEleven"><span class="boldEleven"><%=perdata[0][12]%></span></td>
                    </tr>

                    <tr>
                      <td height="17" colspan="4" valign="top" class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
                      <td height="17" colspan="4" valign="top" class="boldEleven">
					  <!--<div id="divscroll" style="OVERFLOW:auto;width:'100%';height:100px">-->
					  <!--</div>-->
					  <%
			
					String itemdtl[][]=CommonFunctions.QueryExecute("SELECT if(CHR_TYPE='I','ITEM','PRODUCT'), if(CHR_TYPE='I',(SELECT d.CHR_ITEMNAME FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID),(SELECT e.CHR_PRODUCTCODE  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)), if(a.CHR_TYPE='I',(SELECT d1.CHR_DES FROM inv_m_item d1 WHERE d1.CHR_ITEMID=a.CHR_ITEMID),(SELECT e1.CHR_PRODUCTDESC  FROM inv_m_produtlist  e1 WHERE e1.CHR_PRODUCTID=a.CHR_ITEMID)),INT_QTY FROM inv_t_stockadjustmentitem a WHERE CHR_ADJUSTMENTNO='"+dcno+"'");
						
					out.println("<table  width='80%' cellpadding=2 cellspacing=1 bgcolor='#9900CC' align='center'>");
					out.println("<tr class='MRow1'><th class='boldEleven'><strong>Type</strong></td>");
                    out.println("<td class='boldEleven'><strong >Item / Product Code</strong></td>");
					out.println("<td class='boldEleven'><strong >Description</strong></td>");
					out.println("<td class='boldEleven'><strong >Quantity/Units</strong></td>");
					 
					for(int v=0;v<itemdtl.length; v++)
					{	
						if(v%2==0)
							out.print("<tr class='MRow1'>");
						else
							out.print("<tr class='MRow2'>");	
						out.println("<td  class='boldEleven'  align='right' >"+itemdtl[v][0] );
						out.println("<td  class='boldEleven'  align='right'>"+itemdtl[v][1] );
						out.println("<td  class='boldEleven'  align='right'>"+itemdtl[v][2] );
						out.println("<td  class='boldEleven'  align='right'>"+itemdtl[v][3] );
					}	
					out.println("</table>");	
					  %></td>
                    </tr>
                    <tr>
                      <td height="17" colspan="4" valign="top" class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
						
                      <td height="17" colspan="4" valign="top" class="boldEleven">
					   
					  <%
			
					String sql="SELECT if(CHR_TYPE='I','ITEM','PRODUCT'), if(CHR_TYPE='I',(SELECT d.CHR_ITEMNAME FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID),(SELECT e.CHR_PRODUCTCODE  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)),  if(a.CHR_TYPE='I',(SELECT d1.CHR_DES FROM inv_m_item d1 WHERE d1.CHR_ITEMID=a.CHR_ITEMID),(SELECT e1.CHR_PRODUCTDESC  FROM inv_m_produtlist  e1 WHERE e1.CHR_PRODUCTID=a.CHR_ITEMID)),CHR_SERIALNO,INT_ROWID,CHR_TYPE,CHR_ITEMID,a.INT_ROWID,CHR_CLOSED FROM inv_t_stockadjustmentitemserial a WHERE a.CHR_CLOSED='N' AND  a.CHR_ADJUSTMENTNO='"+dcno+"'";
					// out.println(sql);
					String srNodtl[][]=CommonFunctions.QueryExecute(sql);
					int seriallength=0;
					if(srNodtl.length>0)
						seriallength =srNodtl.length;
					
					if(srNodtl.length>0)
						for(int v=0;v<srNodtl.length; v++)
							if("-".equals(srNodtl[v][3]))
								srNodtl[v][3]="";
					if(srNodtl.length>0)
					{
						out.println("<table  width='80%' cellpadding=2 cellspacing=1 bgcolor='#9900CC' align='center'>");
						out.println("<tr class='MRow1'><th class='boldEleven'><strong>Type</strong></td>");
						out.println("<td class='boldEleven'><b>Item / Product Code</b></td>");
						out.println("<td class='boldEleven'><b>Description</b></td>");
						out.println("<td class='boldEleven'><b>Serial Number</b></td>");
						out.println("<td class='boldEleven'><b>");
						
						out.println("<table width='169' height='22' border='0' cellpadding='0' cellspacing='0' align='center'>");
						out.println("<tr>");
						out.println("<td width='20' class='boldEleven'> ");
						
					out.println("<input id='Astatus' name='status' type='checkbox' value='A' onClick=\"Acceptall('Astatus')\" >");
						out.println("</label></td>");
						out.println("</td>");
						out.println("</table>");
						
						out.println("</tr>");
						int a=srNodtl.length;
						for(int v=0;v<srNodtl.length; v++)
						{	
							if(v%2==0)
								out.print("<tr class='MRow1'>");
							else
								out.print("<tr class='MRow2'>");
							
							out.println("<td  class='boldEleven'  align='right' >"+srNodtl[v][0]+"</td>");
							out.println("<td  class='boldEleven'  align='right'>"+srNodtl[v][1]+"</td>");
							out.println("<td  class='boldEleven'  align='right'>"+srNodtl[v][2]+"</td>");
							out.println("<td  class='boldEleven'  align='right'>"+srNodtl[v][3]+"</td>");
						    out.println("<td class='boldEleven' ><input type='checkbox' id='accept"+v+"' name='accept"+v+"'  onclick=Accept('accept"+v+"')> ");
							out.println("<input type='hidden' name='rowid"+v+"' id='rowid"+v+"' value='"+srNodtl[v][7]+"'>");
							out.println("<input type='hidden' name='serial"+v+"' id='serial"+v+"' value='"+srNodtl[v][3]+"'>");
			out.println("</td>");
		 				}	
						out.println("</table>");	
					}
					  %>
					  <input name='dec' type='hidden' class='formText135' id='dec' size='15' maxlength='100' value=<%=srNodtl.length%>></td>
                    </tr>
                    <tr>
                      <td height="17" colspan="4" valign="top" class="boldEleven"><div align="center" id="error" class="bolddeepred"></div></td>
                    </tr>
                    <tr>
                      <td height="17" colspan="4" valign="top" class="boldEleven">&nbsp; </td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td colspan="3" align="left"><input name="filename" type="hidden" value="StockAdjustment" />
                        <input
			name="actionS" type="hidden" value="INVStockAdjustmentPartiallyClosed" />
                        <input name="dcno" type="hidden"  value="<%=perdata[0][0]%>">
                        <input name="param" type="hidden" id="param" value="0"><input name="checkserialflag" type="hidden" id="checkserialflag"
								value="false"></td>
                    </tr>
                    <tr>
                      <td height="17" colspan="4" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit" id="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"    ></td>
									<script language="javascript">		
											
function Validate()
{
	var len=document.getElementById("dec").value;
	var acount=0;
	 
	for(var i=0;i<len;i++)
	 if(document.getElementById("accept"+i).checked)	  	
	 	acount=acount+1;
	 
	if( acount<=0 )
	{
		alert("Select Atleast One  Accept ");
		return false;
	}	
	else
	{
		return true;
	}	
}	


</script>
                            <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('Deliverychallan.jsp')"></td>
                          </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    </tr>
                  </tbody>
                  <input type="hidden" name="mobileBookingOption" />
              </table></td>
              <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
              <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
            </tr>
            <tr>
              <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
              <td height="6"><spacer height="1" width="1" type="block" /></td>
              <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
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
	  <td>
	  
<script language="javascript">

function Acceptall(ctr)
	{
		var len=document.getElementById("dec").value;
		if(document.getElementById(ctr).checked)
		{
			 
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				document.getElementById(fline).checked=true;
	    	}
		}
		else
		{
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				document.getElementById(fline).checked=false;
	    	}
		}
		 
	}
</script>
	  </td>
	</tr>
</table>

<%@ include file="../footer.jsp"%>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</body>

</html>

