<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
	
	
							
String taxids[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax");
String optiontaxname="";
for(int u=0; u<taxids.length; u++)
optiontaxname =optiontaxname+"<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>";


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
<title> :: MARKETING ::</title><script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">
  
function  validate()
  {
	if( 
	   
	   	checkNullSelect( "itype","Select itype" ,'0')
		&& checkNullSelect( "pgroup","Select  item/product group" ,'0')
		&& checkNullSelect( "item","Select item/product code" ,'0')
		
	) 
		return true;		
	 else
		return false;		
 } 	
 


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
	var str="<select name='"+s1+"'  style='width:100' id='"+s1+"' size='1' class='formText135' onblur=\"assignValues(this,'"+idposition+"')\">"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Id= batch.getElementsByTagName("Id")[0];
	    	Idname= batch.getElementsByTagName("Idname")[0];
 			str = str+"<option value='"+Id.childNodes[0].nodeValue+"' title='"+Idname.childNodes[0].nodeValue+"'>"+Idname.childNodes[0].nodeValue+"</option>";
       }
       str=str+"</select>";
	   var tb=document.getElementById(divi);
  	   tb.innerHTML=str  ; 
 }

 
 
function assignValues(ctr,pos) 
{
	
	var type = document.getElementById("itype"+pos).value;
	var typeid = ctr.value;
	var url = "../inventory?actionS=INVItemProductAssign&type="+escape(type)+"&typeid="+typeid ;
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
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    	var batch = batchs.childNodes[loop];
	    	Desc= batch.getElementsByTagName("Desc")[0].childNodes[0].nodeValue;
	    	Price= batch.getElementsByTagName("Price")[0].childNodes[0].nodeValue;
			PPrice= batch.getElementsByTagName("PPrice")[0].childNodes[0].nodeValue;
			Ptype= batch.getElementsByTagName("Ptype")[0].childNodes[0].nodeValue;
			Ptax= batch.getElementsByTagName("Ptax")[0].childNodes[0].nodeValue;
			document.getElementById("desc"+idposition).value = Desc;
			document.getElementById("qty"+idposition).value = "1";
			document.getElementById("uprice"+idposition).value = PPrice;
			document.getElementById("discount"+idposition).value ="0";
			document.getElementById("unitdiscount"+idposition).value = "0";
			document.getElementById("consumables"+idposition).value =  Ptype;
			setOptionValue("stax"+idposition , Ptax); 
			totals1.style.visibility="visible";
			 
   }
   
    
 }
 
 
 
 

 
</script>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>

<script language="javascript" src="../JavaScript/Marketing/Loaditemproductgroup.js"></script>

</head>

<body onselectstart="return false" onpaste="return false;" onCopy="return false"    >
<%@ include file="index.jsp"%>
 <form  AUTOCOMPLETE = "off"   action="" method="post" name="frm" id="frm" onSubmit="return validate()">  
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
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="800"
			align="center" border="0">
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
				  <td ><table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
				    <tr>
				      <td colspan="6"><div align="center"><span class="boldgre">FUNNEL</span>
				        <%
							String id="",Name="",actionS="",value="",dt="";
							String from="";
							String to="";
							String customerid="0";
							String customername="";
							String active="";
							String sql="",sql1="",sql2="";
							String calltype="";
							String desc ="";
							String status="";
							String nextcall ="";
							String Nfrom = "";
							String Nto = "";
							String dbvalue = "";
							String type="";
							String callvalue="";
							int rowid=0,previousrowid=0;
								id=request.getParameter("rowid");
								sql = "SELECT a.INT_CALLID,a.INT_CUSTOMERID,d.CHR_NAME,c.INT_CALLTYPEID,a.CHR_DESC,DATE_FORMAT(a.DAT_START,'%d-%m-%Y %H:%i:%s'),DATE_FORMAT(a.DAT_END,'%d-%m-%Y %H:%i:%s'),a.CHR_STATUS,DOU_VALUE FROM mkt_t_daillycalls a,mkt_m_customerinfo b,mkt_k_calltype c,mkt_m_customername d WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_CALLTYPE=c.INT_CALLTYPEID AND b.INT_CUSTOMERNAMEID =d.INT_CUSTOMERNAMEID AND a.INT_CALLID= "+id;
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								customerid=data[0][1];
								customername=data[0][2];
								calltype=data[0][3];
								desc=data[0][4];
								Nfrom=data[0][5];
								Nto=data[0][6];
								status= data[0][7];
								callvalue=data[0][8];
								actionS="MKTScheduleEntryEdit";
								value="Update";
						%>
				      </div></td>
			        </tr>
				    <tr>
				      <td>&nbsp;</td>
				      <td class="bold1">Customer </td>
				      <td class="boldEleven"><%=customername%></td>
				      <td class="bold1"> Call Type<span class="spc"> </span></td>
				      <td class="boldEleven"><%
							String ctdata[][]= CommonFunctions.QueryExecute("SELECT CHR_CALLTYPE FROM mkt_k_calltype WHERE INT_CALLTYPEID="+calltype );
							if(ctdata.length>0)
								out.println(ctdata[0][0]);
						%></td>
				      <td>&nbsp;</td>
			        </tr>
				     
				    <tr>
				      <td>&nbsp;</td>
				      <td class="bold1">Starting Date<span class="spc"> </span></td>
				      <td class="boldEleven"><%=Nfrom%></td>
				      <td class="bold1">Ending Date<span class="spc"> </span></td>
				      <td class="boldEleven"><%=Nto%></td>
				      <td>&nbsp;</td>
			        </tr>
				    <tr>
				      <td>&nbsp;</td>
				      <td class="bold1"> Opportunity Value <span class="spc"></span></td>
				      <td class="boldEleven"><%=callvalue%></td>
				      <td class="bold1"> Call Closed <span class="spc"></span></td>
				      <td><%
					   		String grd="";
							String grd1="";
							if("Y".equals(status.trim()))
								out.println("<font class='boldgreen'>Closed</font>");
							else
								out.println("<font class='bolddeepred'>Pending</font>");
					 %></td>
				      <td>&nbsp;</td>
			        </tr>
				    <tr>
				      <td>&nbsp;</td>
				      <td><span class="bold1">Description</span></td>
				      <td><span class="boldEleven"><%=desc%></span></td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
			        </tr>
				    <tr>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
			        </tr>
				    <tr>
				      <td colspan="6">
                      
<script type="text/javascript"><!--
	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	
	
	//Intialise the Variables
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
		var s4 = "uprice"+r;
		var s5 = "discount"+r;
		var s6 = "unitdiscount"+r;
		var s7 = "total"+r;
		var s8 = "consumables"+r;
		
		var s9 = "stax"+r;
		var s10 = "staxpercentage"+r;
		var s11 = "staxamount"+r;
		
		
		var div ="div"+r;
		var vf1 = "onKeyPress=\"numericValue('"+s3+"','7')\"";
		var vf2 = "onKeyPress=\"isNumberFloat('"+s4+"')\"";
		var vf3 = "onKeyPress=\"isNumberFloat('"+s5+"')\"";
		var vf4 = "onKeyPress=\"isNumberFloat('"+s6+"')\"";
		var vf5 = "onKeyPress=\"isNumberFloat('"+s7+"')\"";
	 	 
		
		 x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onblur=Loaditemproduct(this,'"+div+"')><option  value='1'>I</option><option  value='2'>P</option></select>";
		 x.insertCell(1).innerHTML="<div id='"+div+"'></div>";
		
		 x.insertCell(2).innerHTML="<input type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		x.insertCell(3).innerHTML="<input type='text' size=10    onblur=\"calculateValue('"+s3+"')\" title='Quantity' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf1+" style='text-align:right' value='1'/>";
		x.insertCell(4).innerHTML="<input type='text' size=10    onblur=\"calculateValue('"+s3+"')\" title='Unit Price' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+"  style='text-align:right' value='0'/>";
		x.insertCell(5).innerHTML="<input type='text' size=10    onblur=\"calculateDiscount('"+s3+"')\" title='Discount' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf3+"  style='text-align:right'/>";
		x.insertCell(6).innerHTML="<input type='text' size=10    title='UnitDiscount' class='formText135'  name='"+s6+"' id ='"+s6+"' " +vf4+" readonly='readonly' style='text-align:right'/>";
		
		x.insertCell(7).innerHTML="<select class='formText135'  name='"+s9+"' id ='"+s9+"' onBlur=assignTaxValue('"+s9+"') ><%=optiontaxname%></select>";
		x.insertCell(8).innerHTML="<input type='text' size=10 class='formText135'  name='"+s10+"' id ='"+s10+"'  readonly='readonly' style='text-align:right' value='0'/>";
		x.insertCell(9).innerHTML="<input type='text' size=10 class='formText135'  name='"+s11+"' id ='"+s11+"'  readonly='readonly' style='text-align:right'/>";
		
		x.insertCell(10).innerHTML="<input type='text' size=10    title='Total' class='formText135'  name='"+s7+"' id ='"+s7+"' " +vf5+"   readonly='readonly' style='text-align:right'/> <input type='hidden' name='"+s8+"' id ='"+s8+"' />";
		
		x.insertCell(11).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")'>";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
	}
 
 
	//If any changes in Combobox then the corresponding values are assign to corresponding controls
	function assignValue(itm)
	{
  		var idname = itm.name;
  		//var idposition = (idname.substring(4,(idname.length-4)));
  		var idposition = idname.replace("item","");
 		var  itemid = itm.value;
 		for(i=0; i<cvalue1.length-1; i++)
 		{
   			var rowvalue = cvalue1[i].split(",")
			if(rowvalue[2]=== itemid)
   			{
   				document.getElementById('desc'+idposition).value = rowvalue[4];
   				document.getElementById('uprice'+idposition).value = rowvalue[7];
 				document.getElementById('total'+idposition).value = rowvalue[7];			
				document.getElementById('discount'+idposition).value = 0;
   				document.getElementById('unitdiscount'+idposition).value = 0;
   				document.getElementById('qty'+idposition).value = 1;
   			}	
 		}
		
 	}

	

	
	//Calculate Nettotal in Quantity Changes
	function calculateValue(ctr)
	{
		try
		{
			var quantity = document.getElementById(ctr).value;
			var idposition = ctr.replace("qty","");
			var productcode= parseInt(document.getElementById("item"+idposition).value);
			if(productcode != 0)
			{
				if(quantity>=1)
			 	{
					var uprice = parseFloat(document.getElementById("uprice"+idposition).value);
					var discount =parseFloat(document.getElementById("discount"+idposition).value);
					var udiscount = parseFloat(document.getElementById("unitdiscount"+idposition).value);
					var staxpercentage = parseFloat(document.getElementById("staxpercentage"+idposition).value);
					udiscount =(discount/100)*uprice;
					 
					document.getElementById("unitdiscount"+idposition).value = udiscount;
				
					uprice = uprice - udiscount;
					document.getElementById("staxamount"+idposition).value = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
					var taxamount = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
					var total =  Round((quantity*uprice) +taxamount);
					document.getElementById("total"+idposition).value = Round( total );
					
				 
				}
				else
				{
					alert("Quantity Should not be Zero");
					qty.focus();
				}
			}
			else
			{
				alert("Kindly Select the Product Code");
				
			}
		}
		catch(err)
		{
			alert(err);
		}	
			
	}

	 

   function calculateDiscount(ctr)
   {
   		try
		{
   			
			var position = ctr.replace("qty","");	
			var productcode= parseInt(document.getElementById("item"+position).value);
			if(productcode != 0)
			{
				var discount = document.getElementById('discount'+position).value;
				var uprice = document.getElementById('uprice'+position).value;
				var udiscount =(discount/100)*uprice;
				document.getElementById('unitdiscount'+position).value=udiscount;
				
				var quantity = document.getElementById('qty'+position).value;
				if(quantity>=1)
				{ 
					uprice = uprice - udiscount;
					var staxpercentage = parseFloat(document.getElementById("staxpercentage"+position).value);
					document.getElementById("staxamount"+position).value = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
					var taxamount = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
					var total =  Round((quantity*uprice) +taxamount);
					document.getElementById("total"+position).value = Round( total );
					
				}
				else
				{
					alert("Quantity Should not be Zero");
					ctr.focus();
				}
			}
			else
			{
				alert("Kindly Select the Product Code");
				
			}
		}
		catch(err)
		{
			alert(err);
		}
   }
	 

	//Delete Row
	function deleteRow(i,rx)
	{
		document.getElementById('myTable').deleteRow(i);
		row = row-1;
		if(row<=1)
			Load();
		deleteArray[drow] =rx;
		drow = drow+1;
		display();
		calculateTotal();
		assignGrandTotal();
	}

	//******************************
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
		
		//alert("Added :: \n"+hs+"\n\n\n Deleted :: \n"+hs1+"\n\nChecked \n"+hs2);
	}
	//**********************************


	function paramAssign(svalue)
	{
		document.getElementById('param').value=svalue;
	}

	
<%
	String taxid[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
	String lvalue="";
	for(int x=0; x<taxid.length;x++)
	{
		for(int y=0; y<3;y++)
		{
			lvalue = lvalue+taxid[x][y]+",";
		}
		lvalue = lvalue+"~";	
	}
	%>

	var taxvalue = "<%=lvalue%>";
	var taxvalue1 =taxvalue.split("~");

	 
	
	function assignTaxValue(ctr)
	{
		
		var taxid = document.getElementById(ctr).value;
		var idposition = ctr.replace("stax","");
		var productcode= parseInt(document.getElementById("item"+idposition).value);
		if(productcode != 0)
		{
			var qty = parseFloat(document.getElementById("qty"+idposition).value);
			var uprice = parseFloat(document.getElementById("uprice"+idposition).value);
			var discount =parseFloat(document.getElementById("discount"+idposition).value);
			var udiscount = parseFloat(document.getElementById("unitdiscount"+idposition).value);
			var total = parseFloat(document.getElementById("total"+idposition).value);
			uprice = uprice - udiscount;
			for(i=0; i<taxvalue1.length-1; i++)
			{
				var rowvalue = taxvalue1[i].split(",")

				if(rowvalue[0]=== taxid)
				{
					document.getElementById("staxpercentage"+idposition).value = rowvalue[2];
					document.getElementById("staxamount"+idposition).value = Round((qty*uprice) *parseFloat(rowvalue[2]) /100);
					
					var taxamount = Round((qty*uprice) *parseFloat(rowvalue[2]) /100);
					var total =  Round((qty*uprice) +taxamount);
					document.getElementById("total"+idposition).value = Round( total );
				}	
			}
			 
		}
		else
		{
			alert("Kindly Select the Product Code");
			
		}
	}
	
				
	 




--></script>

                      <div id="divscroll"  style="OVERFLOW:auto;width:auto;height:300px">
							<table id="myTable" width="100%" border="1" cellpadding="1"
								cellspacing="1">

								<th class="boldEleven">
								<div align="left"><strong>Type</strong></div>
								</th>
								<th class="boldEleven"><b>Item</b></th>
								<th class="boldEleven"><b>Description</b></th>
								<th class="boldEleven"><b>Quantity/Unit</b></th>
								<th class="boldEleven"><b>Unit Price</b></th>
								<th class="boldEleven"><b>Discount(%)</b></th>
								<th class="boldEleven"><b>Unit Discount</b></th>
								
								<th class="boldEleven"><b>Tax</b></th>
								<th class="boldEleven"><b>Tax (%)</b></th>
								<th class="boldEleven"><b>Tax Amount </b></th>
								<th class="boldEleven"><b>Total</b></th>
								<th class="boldEleven">&nbsp;</th>
							</table>
							</div>
                      </td>
			        </tr>
				    <tr>
				      <td colspan="6">&nbsp;</td>
			        </tr>
				    <tr>
				      <td colspan="6">
                      <div align="left" >
<script language="javascript">
function insRowcheck()
{
	try
	{
		 
			insRow();
	}
	catch(err)
	{
		alert(err);
	}
}
</script>
<input type="button" class="tMLAscreenHead" onClick="insRowcheck()"  value="Add"   accesskey="s"   id="buttonitemadd" tabindex="8">
<input
										name="param" type="hidden" id="param" value='0,'>
                      <span class="boldEleven">
                      <input type="hidden" name="filename" value="ScheduleEntryStaff" />
                      <input type="hidden" name="actionS"  value="MKTScheduleEntryStaffEdit" />
                      <input name="id" type="hidden" id="id" value="<%=id%>" />
                      <input name="customer" type="hidden" id="customer" value="<%=customerid%>" />
                      </span></div>
                      </td>
			        </tr>
				    <tr>
				      <td colspan="6">&nbsp;</td>
			        </tr>
				    <tr>
				      <td colspan="6">&nbsp;</td>
			        </tr>
				    <tr>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
			        </tr>
				    <tr>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
			        </tr>
				    <tr>
				      <td colspan="6"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
				        <tr>
				          <td><input name="Submit"  id="Submit" type="submit" class="buttonbold13" value="Update" /></td>
				          <td><input name="Close" type="button" class="buttonbold13" id="Close"  value="Close"   accesskey="c"  onclick="redirect('Funnel.jsp')" /></td>
			            </tr>
			          </table></td>
			        </tr>
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
		</table>
		</td>
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
		<td>&nbsp;</td>
	</tr>
</table>
  </form>
<%@ include file="../footer.jsp"%>
</body>
</html><%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

