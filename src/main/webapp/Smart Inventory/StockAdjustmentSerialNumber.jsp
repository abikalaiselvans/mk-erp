<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
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
<script language="javascript" src="../JavaScript/Inventory/deliverychallanserialcheck.js"></script>

<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">
<script language="javascript">

function DCserailcheck(ctr)
{
	var position  = ""+ctr;
	position = position.replace("itype","");
	var r = position;
	var r1=document.getElementById("itype"+r).value;
	if(r1=="1")
		r1="I";
	else if	(r1=="2")
		r1="P";
	var r2=document.getElementById("item"+r).value;
	var sss = "serial"+r;
	var ddd="Valid"+r;
	LoadDCUniqueCheckSales(sss,ddd,'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit',r1,r2);
}


  function assignrandomserial1()
 {
 	
 	var randomss = document.getElementById('randomserials').value;
	if(randomss=="")
	{
		alert("Enter Random Serial Number...");
		document.getElementById('randomserials').focus();
	}
	else
	{
		var arrayarandomserial = randomss.split(",");
		if(arrayarandomserial.length<1)
		{
			alert("Check Random Serial Number...");
		}
		else
		{
			var seriallength = parseInt(arrayarandomserial.length);

			if(duplicateCheckreturn1(randomss,'error' , 'Submit')==false)
		{
		alert("Remove Duplicate");
		}
		else{

			for(u=0;u<seriallength;u++)
				{
					var ty="serial"+(u+1);
					var obj = findObj(ty);
					if(obj != null)
						document.getElementById(ty).value=trim(arrayarandomserial[u]);
					
				}
				document.getElementById('serial1').focus();
			}
				
		}
	}	
 }  
 function assignrandomserial2()
 {
 	
 	var randomss = document.getElementById('randomserials').value;
	if(randomss=="")
	{
		alert("Enter Random Serial Number...");
		document.getElementById('randomserials').focus();
	}
	else
	{
		var arrayarandomserial = randomss.split("\n");
		if(arrayarandomserial.length<1)
		{
			alert("Check Random Serial Number...");
		}
		else
		{
			var seriallength = parseInt(arrayarandomserial.length);

			if(duplicateCheckreturn2(randomss,'error' , 'Submit')==false)
		{
		alert("Remove Duplicate");
		}
		else{

			for(u=0;u<=seriallength;u++)
				{
					var ty="serial"+(u+1);
					var obj = findObj(ty);
					if(obj != null)
						document.getElementById(ty).value=trim(arrayarandomserial[u]);
					
				}
				document.getElementById('serial1').focus();
			}
				
		}
	}	
 }  
 
 

function checkserialnumbers()
{
	if(checkNull('randomserials','Enter the serial numbers'))
	{
		var query="CheckSerialnumberResponse.jsp?serials="+document.getElementById('randomserials').value;
		var width="800", height="400";
		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
		 
	}
}

						  
							  


  function getValues1(name,length,divname,buttonname)
	 {
	 	var validstring="";
	 	for( i=0;i<length;i++)
	 	{
	 		s=name+(i+1);
	 		s =document.getElementById(s).value;
	 		if(!( s ==""))
			{
	 		  validstring= validstring+s+",";
			}
			  else
			  {
				   alert("Enter Serial Number ");	
				  
		   document.getElementById(name+(i+1)).focus();
		   return false;
				  }
	 		  
	 	}
	 	return duplicateCheckreturn1(validstring,name,divname,buttonname);
	 }
	 
	  function getValues2(name,length,divname,buttonname)
	 {
	 	var validstring="";
	 	for( i=0;i<length;i++)
	 	{
	 		s=name+i;
	 		s =document.getElementById(s).value;
	 		if(!( s ==""))
	 		  validstring= validstring+s+",";
	 		  
	 	}
	 	duplicateCheck(validstring,name,divname,buttonname);
	 }


		function duplicateCheckreturn1(string ,divname,buttonname) 
	{
		 
		var primaryArray = new Array();
		var secondaryArray = new Array();
		primaryArray = string.split(",");	
		secondaryArray = string.split(",");	
	
		var s = "";
		
		ss="";
		lens = primaryArray.length-1;
		var position="";
		for(i=0;i<lens;i++)
		{
			for(j=i+1;j<=lens;j++)
				if(primaryArray[i] == secondaryArray[j])
				{
					ss = ss+"true" +",";
					position=j;
				}	
				
			
		}
		var d=ss.length;
		if(d >1)
		{
			return false;
		}
		else
		{
			return true;
		}	
	}
//End	 
function duplicateCheckreturn2(string ,divname,buttonname) 
	{
		 
		var primaryArray = new Array();
		var secondaryArray = new Array();
		
		if(document.all) { // IE
primaryArray = string.split("\r\n");
secondaryArray = string.split("\r\n");
}
else { //Mozilla
primaryArray = string.split("\n");
secondaryArray = string.split("\n");
}
		var s = "";
		
		ss="";
		lens = primaryArray.length-1;
		var position="";
		for(i=0;i<lens;i++)
		{
			
			for(j=i+1;j<=lens;j++)
			{
				
				if(primaryArray[i] == secondaryArray[j])
				{
					
					ss = ss+"true" +",";
					position=j;
				}	
				
			}
		}
		var d=ss.length
		
		if(d >1)
		{
			return false;
		}
		else
		{
			return true;
		}	
	}
//End	

</script>
</head>
 <body >
<%@ include file="indexinv.jsp"%>
<% 

	String dcno = request.getParameter("salesid");
	String perdata[][]=CommonFunctions.QueryExecute("SELECT CHR_ADJUSTMENTNO,DAT_ADJUSTMENTDATE,CONCAT('-'),CONCAT('-'),FIND_A_EMPLOYEE_ID_NAME(CHR_REF),CHR_OTHERREF,CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,CHR_DESTINATION,CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,CHR_DES,FUN_INV_DIVISION(INT_DIVIID),INT_DIVIID FROM inv_t_stockadjustment WHERE CHR_ADJUSTMENTNO='"+dcno+"'");
	
	
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
									class="boldThirteen">STOCK ADJUSTMENT  SERIAL NUMBER DETAIL </td>
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
                      <td width="139" height="17" valign="top" class="bold1"  >Ref.Number   </td>
                      <td width="293" align="left" valign="top"><span class="boldEleven"><%=perdata[0][0]%>&nbsp;</span></td>
                      <td width="172" class="bold1"  >Order Reference  </td>
                      <td width="150" class="boldEleven"><span class="boldEleven"><%=perdata[0][5]%></span></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="bold1"  >date    </td>
                      <td align="left"><span class="boldEleven"><%=perdata[0][1]%></span></td>
                      <td class="bold1"  >Delivery Note   </td>
                      <td class="boldEleven"><span class="boldEleven"><%=perdata[0][6]%></span></td>
                    </tr>
                    <tr>
                      <td class="bold1"  >Division </td>
                      <td class="boldEleven"><%=perdata[0][14]%>
                        <input name="division" type="hidden" id="division" value="<%=perdata[0][15]%>"></td>
                      <td class="bold1"  ><div align="left">Despatch Thru   </div></td>
                      <td class="boldEleven"><span class="boldEleven"><%=perdata[0][7]%></span></td>
                    </tr>
                    <tr>
                      <td rowspan="3" valign="top" class="bold1"  >Reference </td>
                      <td rowspan="3" class="boldEleven"><%=perdata[0][4]%>
                        <table width="38%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <%--<td width="9%"><input name="Shipping" type="radio" onClick="return resoffval()"
												value="S" checked /></td>
                            <td width="15%" class="boldEleven">Same</td>
                            <td width="52%" class="boldEleven"><input
												onclick="return resoffval()" name="Shipping" type="radio"
												value="D"></td>--%>
                            <td width="24%" class="boldEleven"></td>
                          </tr>
                        </table>                            </td>
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
                      <td valign="top" class="bold1"  >&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="bold1"  >Contact No.   </td>
                      <td class="boldEleven"><span class="boldEleven"><%=perdata[0][11]%></span></td>
                    </tr>

                    <tr>
                      <td height="17" valign="top" class="bold1"  >&nbsp;</td>
                      <td align="left">&nbsp;</td>
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
					  <div align="center" id="error" class="bolddeepred"></div>
					  <%
			
					String sql="SELECT if(CHR_TYPE='I','ITEM','PRODUCT'), if(CHR_TYPE='I',(SELECT d.CHR_ITEMNAME FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID),(SELECT e.CHR_PRODUCTCODE  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)),  if(a.CHR_TYPE='I',(SELECT d1.CHR_DES FROM inv_m_item d1 WHERE d1.CHR_ITEMID=a.CHR_ITEMID),(SELECT e1.CHR_PRODUCTDESC  FROM inv_m_produtlist  e1 WHERE e1.CHR_PRODUCTID=a.CHR_ITEMID)),CHR_SERIALNO,INT_ROWID,CHR_TYPE,CHR_ITEMID FROM inv_t_stockadjustmentitemserial a WHERE CHR_ADJUSTMENTNO='"+dcno+"'";
					//out.println(sql);
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
						out.println("<td class='boldEleven'>&nbsp;</td>");
						out.println("<td class='boldEleven'><b>Warranty</b></td>");
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
							out.println("<td  class='boldEleven'  align='right'>");
							String h1 = " onBlur=\"getValues('serial','"+(v+1)+"' ,'error' , 'Submit')\" ";
							String h2 = " onKeyUp=\"DCserailcheck('itype"+(v+1)+"')\" ";
	
							out.println("<input name='serial"+(v+1)+"' id='serial"+(v+1)+"' type='text' class='formText135' id='serial' title='please enter the Serial Number' value='"+srNodtl[v][3]+"'  "+h1+h2+" >");
						   out.println("<input name='rowid"+(v+1)+"' id='rowid"+(v+1)+"' type='hidden' value='"+srNodtl[v][4]+"'>");
						  out.println("<input name='itype"+(v+1)+"' id='itype"+(v+1)+"' type='hidden' value='"+srNodtl[v][5]+"'>");
							out.println("<input name='item"+(v+1)+"' id='item"+(v+1)+"' type='hidden' value='"+srNodtl[v][6]+"'>");
							out.println("<input name='Warrantys"+(v+1)+"' id='Warrantys"+(v+1)+"' type='hidden' value=''>");
							
							out.println("</td>");
							
							out.println("<td class='boldEleven'><div id='Valid"+(v+1)+"'></div></td>");
							out.println("<td class='boldEleven'><div id='Warranty"+(v+1)+"'></div></td>");
							
		 				}	
						out.println("</table>");	
					}
					  %>
					  <input type="hidden" name="seriallength" id="seriallength" value="<%=seriallength%>"></td>
                    </tr>
                    <tr>
                      <td height="17" colspan="4" valign="top" class="boldEleven"><div align="center" id="error" class="bolddeepred"></div></td>
                    </tr>
                    <tr>
                      <td height="17" colspan="4" valign="top" class="boldEleven"><table width="500" border="0" align="center" cellpadding="5" cellspacing="0">
                        <tr><td colspan='3'>Note:Use this Textarea to enter bulk Serial Numbers&nbsp;</td></tr>
                        <tr>
                          <td width="267" rowspan="2" valign="top" class="bolddeeplogin"><div align="right">
                              <textarea name="randomserials" cols="45" rows="5" id="randomserials"></textarea>
                          </div></td>
                          <td width="317" valign="top" class="bolddeeplogin" ><a href='javascript:assignrandomserial1()'>Serialnumber Assign </a><br>
                            (E.g S12,S10,S5,)</td>
						 <td width="317" valign="top" class="bolddeeplogin" ><a href='javascript:assignrandomserial2()'>Serialnumber Assign </a><br>		(Note:Assign value line by line)</td>
                        </tr>
                        <tr>
                          <td valign="top" class="bolddeeplogin" ><a     href='javascript:checkserialnumbers()' >check serialnumber</a>
                              <script language="javascript">
							  function checkserialnumbers()
							  {
							  	if(checkNull('randomserials','Enter the serial numbers'))
								{
									var query="CheckSerialnumberResponse.jsp?serials="+document.getElementById('randomserials').value;
									var width="800", height="400";
									var left = (screen.width/2) - width/2;
									var top = (screen.height/2) - height/2;
									var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
									newWindow = window.open(query,"subWind",styleStr);
									newWindow.focus( );
								}
								
							  }
							  
							  </script>                          </td>
                        </tr>
						
                      </table></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td colspan="3" align="left"><input name="filename" type="hidden" value="StockAdjustment" />
                        <input
			name="actionS" type="hidden" value="INVStockAdjustmentEdit" />
                        <input name="dcno" type="hidden" id="checkserialflag2"
								value="<%=perdata[0][0]%>">
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
	var len="<%=srNodtl.length%>";
	return getValues1('serial',len ,'error' , 'Submit');
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
	  <td>&nbsp;</td>
	</tr>
</table>

<%@ include file="../footer.jsp"%>

</body>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
</html>

