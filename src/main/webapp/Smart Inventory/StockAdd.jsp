<%@ page import="java.sql.*,java.io.*,java.util.*"%>
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

<meta http-equiv="pragma" content="nocache">
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript"
	src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript"
	src="../JavaScript/Inventory/InventAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>



<script type="text/javascript">
var divi="";
function Loaditemproduct(ctr,div) 
{
	var url = "../inventory?actionS=INVItemProduct&id="+escape(ctr.value) ;
	divi = div;
	initRequest(url);
	req.onreadystatechange = itemproductRequest;
    req.open("GET", url, true);
    req.send(null);
}

function itemproductRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	itemproductMessages();
        }
    }
}

function itemproductMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("items")[0];   
   	var idposition = divi.replace("div","");
	s1 ='item'+idposition;
	var str="<select name='"+s1+"'  id='"+s1+"' size='1' class='formText135' onblur=\"assignValues(this,'"+idposition+"')\">"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Id= batch.getElementsByTagName("Id")[0];
	    	Idname= batch.getElementsByTagName("Idname")[0];
 			str = str+"<option value='"+Id.childNodes[0].nodeValue+"'>"+Idname.childNodes[0].nodeValue+"</option>";
       }
       str=str+"</select>";
	   var tb=document.getElementById(divi);
  	   tb.innerHTML=str  ; 
 }

 
function assignValues(ctr,pos) 
{
	
	var type = document.getElementById("itype"+pos).value;
	var typeid = ctr.value;
	document.getElementById("stock"+pos).value ="0";
	var url = "../inventory?actionS=INVItemProductAssignstock&type="+escape(type)+"&typeid="+typeid ;
	initRequest(url);
	req.onreadystatechange = itemproductpriceRequest;
    req.open("GET", url, true);
    req.send(null);

}

function itemproductpriceRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	itemproductpriceMessages();
        }
    }
}

function itemproductpriceMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Assigns")[0];   
   	var idposition = divi.replace("div","");
	s1 ='item'+idposition;
	document.getElementById("stock"+idposition).value ="";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    	var batch = batchs.childNodes[loop];
	    	var Stock= batch.getElementsByTagName("Stock")[0];
			document.getElementById("stock"+idposition).value = Stock.childNodes[0].nodeValue;
  	}
    
 }
</script>




<script language="JavaScript">
var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
 
 function Validate()
 {
  	if(checkNull("ename","Select Staff...") 
		&& checkNull("TxtInNo","Enter the Incentive Number...") 
		&& checkNull("TxtAmount","Enter the amount...") 
		&& checkNullSelect("paymentId","Select The Payment","select"))		
		return true;
	else
		return false;
 }
  
  //Loading item into Array using JSP
	<%
	String branchId=""+session.getAttribute("BRANCHID");
	String productid=request.getParameter("selProduct");	
  	String sql="Select * from inv_m_item where CHR_PRODUCTID='"+productid+"' AND  CHR_ITEMID NOT IN (SELECT CHR_ITEMID FROM inv_t_stock WHERE INT_BRANCHID="+branchId+")";
  	//System.out.println(sql);
	String itemData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	int ccount =com.my.org.erp.common.CommonInfo.intGetColumnCount(sql);
	String lvalue="";
	for(int x=0; x<itemData.length;x++)
	{
		for(int y=0; y<ccount;y++)
		{
			lvalue = lvalue+itemData[x][y]+",";
		}
		lvalue = lvalue+"~";	
	}

	%>

	//Intialise the Variables
	var cvalue = "<%=lvalue%>";
 	var cvalue1 =cvalue.split("~");
 	var row =1;
 	var r =1;
	var v1="";
 	var v2="";
 	var v3="";
 	var v4="";
 	var v5="";
 	var v6="";
 	var v7="";
 	var v8="";
 	var v9="";
 
 	//Dynamically insert a row in a table  -- ITEM
	function insRow()
	{
		var x=document.getElementById('myTable').insertRow(row)
		var s0= "itype"+r;
		var s1= "item"+r;
		var s2 = "desc"+r;
		var s3 ="qty"+r;
		var s4 = "stock"+r;
		var s5 = "discount"+r;
		var s6 = "unitdiscount"+r;
		var s7 = "total"+r;
		var div ="div"+r;
		var vf1 = "onKeyPress=\"numericValue('"+s3+"','5')\"";
		var vf2 = "onKeyPress=\"numericValue('"+s4+"','5')\"";
		var vf3 = "onKeyPress=\"numericValue('"+s5+"','5')\"";
		var vf4 = "onKeyPress=\"numericValue('"+s6+"','5')\"";
		var vf5 = "onKeyPress=\"numericValue('"+s7+"','10')\"";
	 	
		<%
	 		String sa="";
			for(int u=0; u<itemData.length; u++)
			sa = sa +"<option value='"+itemData[u][2]+"'>"+itemData[u][3]+"</option>";
	 	%>
		
		 x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onblur=Loaditemproduct(this,'"+div+"')> <option  value='1'>I</option><option  value='2'>P</option></select>";
		 x.insertCell(1).innerHTML="<div id='"+div+"'></div>";
		 x.insertCell(2).innerHTML="<input type='text' size=10  title='Stock in hand' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+" style='text-align:right' readonly=readonly  />";
		 
		 x.insertCell(3).innerHTML="<input type='text' size=10  title='Quantity' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf2+" style='text-align:right'  />";
		 
		 x.insertCell(4).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")'>";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
	}
	
	
		function paramAssign(svalue)
	{		
		document.getElementById(param).value=svalue;
	}	
	function display()
	{
		var hs="";
		var hs1="";
		var hs2="";
		for(u=0; u<itemArray.length; u++)
			hs = hs+itemArray[u]+",";
		for(u=0; u<deleteArray.length; u++)
			hs1 = hs1+deleteArray[u]+",";
		var Array1 = hs.split(",");
		var Array2 = hs1.split(",");
		for(u=0; u<Array2.length; u++)
		{
			var a1value = Array2[u];
			for(v=0; v<Array1.length; v++)
			{
				if(Array2[u] == Array1[v])
					Array1[v]="";
			}
		}
		hs2="";
		for(v=0; v<Array1.length; v++)
			if(Array1[v]!="")
				hs2 = hs2 +	Array1[v]+",";
		checkArray = hs2.split(",");	
		document.getElementById('param').value=hs2;	
	}	
	function deleteRow(i,rx)
	{
		document.getElementById('myTable').deleteRow(i);
		row = row-1;		
		deleteArray[drow] =rx;
		drow = drow+1;
		display();
		
	}
	
	function valid()
	{
   		display();
   		var svalue="";
   			
   		if(parseInt(checkArray.length-1)<1)
		{
			alert("Please Add Atleast One Item...");
			document.getElementById('buttonitemadd').focus();
			return false;
		}
		for(u=0; u<checkArray.length-1;u++)   		
   			svalue =svalue+ "qty"+checkArray[u]+",";	
		svalue =svalue+"TxtReference,TxtReceived,fromdt,";	
		 
		var v = svalue.split(",");
   		var flag =false;
		for( i=0; i<v.length-1; i++)
		{
			var chk =document.getElementById(v[i]).value;

			if (v[i]=="TxtReference")
				var ck = "Enter Stock Reference No...";
			else if (v[i]=="TxtReceived")
				var ck = "Enter Stock Received By...";
			else if (v[i]=="fromdt")
				var ck = "Enter Date...";
			else
				var ck = "Enter Data..."+v[i];	
				
			if(checkNull(v[i],ck))
			{
				d=1;
			}
			else
			{
				return false;				
			}	
		}
	}
 </script>
<title>:: INVENTORY ::</title> 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<body    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"><%@ include file="indexinv.jsp"%></td>
	</tr>
	<tr>
		<td width="100" height="29">&nbsp;</td>
	</tr>
	<tr>
		<td height="371">
		<form  AUTOCOMPLETE = "off"   name="onDutyAddfrm" method="post" action="../SmartLoginAuth">
		<table width="598" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="594">&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="591" border="0" align="center" cellpadding="0"
					cellspacing="0" bgcolor="#dce4f9" class="BackGround">
					<tbody>
						<tr>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TLCorner.gif" width="7" /></td>
							<td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TRCorner.gif" width="7" /></td>
						</tr>
						<tr>
							<td height="6"><spacer height="1" width="1" type="block" /></td>
						</tr>
						<tr>
							<td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
							<td width="6"><spacer height="1" width="1" type="block"></td>
							<td width="577" valign="top">
							<table width="577" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan="2">
									<div align="center" class="boldEleven"><strong>Stock</strong></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><span class="bolddeepred">*</span><span
										class="changePos">Mandatory</span></div>
									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="348" border="0" align="center" cellpadding="0"
										cellspacing="0">
										<tr>
											<td height="17" class="boldEleven">Stock Reference No. <span
												class="bolddeepred">* </span></td>
											<td colspan="2" align="left"><input name="TxtReference"
												type="text" class="formText135" id="TxtReference"
												maxlength="50"
												onKeyUp="upperMe(this), LoadUniqueCheck('TxtReference','idtable','inv_t_vendorgoodsreceived','CHR_PURCHASEORDERNO','Submit')">
											<div id="idtable"></div>
											</td>
										</tr>

										<tr>
											<td width="227" valign="middle"  
												class="bolddeepblue">Received Date <font color='red'>*</font></td>
											<td width="217"><input name="fromdt" type="text"
												class="tabledata" id="fromdt"
												onkeypress="dateOnly('fromdt')" value="" size="15">
											<a href="javascript:cal1.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a> <script
												language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['onDutyAddfrm'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			setCurrentDate('fromdt');			
		//-->
	</script></td>
										</tr>
										<tr>
											<td height="17" class="boldEleven">Received By <span
												class="bolddeepred">* </span></td>
											<td colspan="2" align="left"><input name="TxtReceived"
												type="text" class="formText135" id="TxtReceived"
												maxlength="50"     onBlur="upperMe(this)"     ></td>
										</tr>
										<tr>
											<td height="17" class="boldEleven">&nbsp;</td>
											<td colspan="2" align="left">&nbsp;</td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td>
									<table width="100%" border="0" bordercolor="#D4D0C8"
										cellpadding="1" cellspacing="1">
										<tr>
											<td width="157" class="boldEleven"><strong>Type</strong></td>
											<td width="150" class="boldEleven"><strong>Item
											/ Product </strong></td>
											<td width="105" class="boldEleven"><b>Stock In Hand</b></td>
											<td width="58" class="boldEleven"><b>Quantity</b></td>
											<td width="56" class="boldEleven"><b>Action</b></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td>
									<div id="divscroll"
										style="OVERFLOW:auto;width:100%;height:100px">
									<table width="100%" border="0" bordercolor="#EFEFEF"
										cellpadding="1" cellspacing="1" id="myTable">
										<td width="157" class="boldEleven"></td>
										<td width="150" class="boldEleven"></td>
										<td width="105" class="boldEleven"></td>
										<td width="58" class="boldEleven"></td>
										<td width="56" class="boldEleven"></td>
									</table>
									</div>
									</td>
								</tr>
								<tr>
									<td>
									<table width="134" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td width="56"><input type="button" id="buttonitemadd"
												class='buttonbold13' onClick="insRow()" value="Add"
												tabindex="8"></td>
											<td width="56"><input type="hidden" name="filename"
												value="StockInfo" /> <input name="param" type="hidden"
												id="leng" value='0,'> <input type="hidden"
												name="actionS" value="INVstockAdd" /></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="150" border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold13" value="Submit"   accesskey="s"   
												onClick="return valid()" /></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold13"  value="Close"   accesskey="c" 
												onClick="redirect('StockView.jsp')" /></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
							<td nowrap="nowrap" width="6"><spacer height="1" width="1"
								type="block" /></td>
							<td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
						</tr>
						<tr>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/BLCorner.gif" width="7" /></td>
							<td height="6"><spacer height="1" width="1" type="block" /></td>
							<td colspan="2" rowspan="2" valign="bottom">
							<div align="right"><img height="7"
								src="../Image/General/BRCorner.gif" width="7" /></div>
							</td>
						</tr>
						<tr>
							<td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
						</tr>
					</tbody>
				</table>
				</td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>