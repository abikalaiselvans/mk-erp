<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<html>
<head>

<title> :: AMC ::</title>

 
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

<%
	String ddata[][]= CommonFunctions.QueryExecute("SELECT INT_SERVICEITEMID,CHR_SERVICEITEMNAME FROM  inv_m_serviceitems ORDER BY CHR_SERVICEITEMNAME");
	String datas="";
	
	for(int u=0; u<ddata.length;u++)
		datas= datas+"<option value="+ddata[u][0]+">"+ddata[u][1]+"</option>";
	
%>

<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>
 
 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" src="../JavaScript/AMC/serviceamcpersonalinfo.js"></script>
<script language="javascript" >
 

	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	


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
		var s0= "type"+r;
		var s1= "serailno"+r;
		var s2 = "description"+r;
		var s3 = "amcamount"+r;
		var s4 = "divname"+r;
		
		x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' ><option value=''>Select</option><%=datas%></select>";
		x.insertCell(1).innerHTML="<input type='text' size=10 class='formText135'   name='"+s1+"' id ='"+s1+"' style='text-align:right' onKeyUp=\"upperMe(this),CheckUnique(this,'"+s4+"','inv_m_serviceamc','CHR_SERIALNO')\" onBlur=\"upperMe(this), CheckUnique(this,'"+s4+"','inv_m_serviceamc','CHR_SERIALNO')\" /> <div id='"+s4+"'></div>";
		
		x.insertCell(2).innerHTML="<textarea  onkeyup=\"textArea('"+s2+"','2000')\" name='"+s2+"' id ='"+s2+"'  cols='30' rows='5' class='formText135'  ></textarea>";
		  					
		x.insertCell(3).innerHTML="<input type='text' size=10 class='formText135' name='"+s3+"' id ='"+s3+"' value='0' style='text-align:right'  onKeyPress=\"return numeric_only(event,'"+s3+"','7')\"  maxlength='6'/>";
		
		x.insertCell(4).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")' >";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
		display();
		document.getElementById('type'+(r-1)).focus();
		
	}
 
  
 
 
 
 	function deleteRow(i,rx)
	{
		document.getElementById('myTable').deleteRow(i);
		row = row-1;
		if(row<=1)
			Load();
		deleteArray[drow] =rx;
		drow = drow+1;
		display();
		
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
	
	
	
	 

	


</script>
<body   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('customerid').focus()" >
<%
try
{
%>
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>

	<tr>
	  <td height="19"><form AUTOCOMPLETE="off" method="post" name="frm" id="frm" action="../SmartLoginAuth" onSubmit="return validate()">
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table class="BackGround" cellspacing="0" cellpadding="0" width="800"
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
                  <td width="412"><table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
                      <!--DWLayoutTable-->
                      <tbody>
                        <tr>
                          <td height="16" colspan="3" align="center" valign="top" 	class="boldThirteen">SERVICE CONTRACT   
						    <%
						String action=request.getParameter("action1");
						
						String id="",Name="",actionS="",value="",cid="",pid="",serial="",desc="",stdate="",noofyear="",amcamount="";
						String sql="";
						
							if("Add".equals(action))
							{
								id="";Name="";
								cid="";pid="";serial="";desc="";stdate="";noofyear="";amcamount="";
								actionS="AMCServiceAMCAdd";
								value="Add";
							}
							else
							{
								id="";Name="";
								id=request.getParameter("id");
								sql = "SELECT CHR_AMCID,INT_CUSTOMERID,INT_SERVICEITEMID,CHR_SERIALNO, CHR_DESC,DT_STARTDATE,INT_NOOFYEAR,DOU_AMCAMOUNT,CHR_STATUS FROM  inv_m_serviceamc WHERE CHR_AMCID='"+id+"'";
								String data[][]= CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								cid=data[0][1];
								pid=data[0][2];
								serial=data[0][3];
								desc=data[0][4];
								stdate=data[0][5];
								String startdate =data[0][5];
								String stdates[] = startdate.split(" ");
								String sdate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(stdates[0])+" "+stdates[1];
						//com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(indate)
								stdate=sdate;
						
								noofyear=data[0][6];
								amcamount=data[0][7];
								actionS="AMCServiceAMCEdit";
								value="Update";
							}
							
						%>			
									
						<input 	name="id" type="HIDDEN" id="id" value="<%=id%>">
                        <input type="hidden" name="filename" value="ServiceAMC" />
                        <input type="hidden" name="actionS" value="<%=actionS%>" />
                        <input name="param" type="hidden" id="param" value="0,"></td>
                        </tr>
                         
                        <tr>
                          <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                          <td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
                        </tr>
                        <tr>
                          <td height="17" valign="top" class="boldEleven">Customer Name </td>
                          <td align="left" valign="top">
						  
						  <select name="customerid" id="customerid" size="5" class="formText135" onclick="LoadAMCPersonalinfo(this)" >
								 
								<%
				String readData[][] =  CommonFunctions.QueryExecute("SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM  inv_m_servicecustomerinfo WHERE INT_BRANCHID="+""+session.getAttribute("AMCBRANCH") +" ORDER BY CHR_CUSTOMERNAME");
				for(int u=0;u<readData.length;u++)
					out.println("<option value="+readData[u][0]+">"+readData[u][1]+"</option>");
				%>
						</select>
						<script language="javascript">setOptionValue('customerid','<%=cid%>')</script>												  </td>
                          <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                        </tr>
                        <tr>
                          <td height="17" colspan="3" valign="top" class="boldEleven"><div id='infos'></div></td>
                          </tr>
                        
                         
						<tr>
						  <td height="17" colspan="3" valign="top" class="boldEleven">
						  
						<div id="divscroll" style="OVERFLOW:auto;width:100%;height:auto">
							<table width="100%" border="0" cellpadding="1" cellspacing="1"	id="myTable">
								<tr>
									<th class="boldEleven" valign="top"><b>Machine Type</b></th>
									<th class="boldEleven" valign="top"><b>Serial Number</b></th>
									<th class="boldEleven" valign="top"><b>Description</b></th>
									<th class="boldEleven" valign="top"><b>AMC Amount</th>
								</tr>
							</table>
							</div>						  </td>
					    </tr>
						<tr>
						  <td height="17" valign="top" class="boldEleven"><table width="56" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td><div align="left">
                                <input name="button2" type="button"
								class="buttonbold13" id="buttonitemadd"
								tabindex="8" onClick="insRow()"  value="Add"   accesskey="s"   />
                              </div></td>
                            </tr>
                          </table></td>
						  <td colspan="2" align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
						<tr>
						  <td height="17" valign="top" class="boldEleven">Booked Status</td>
						  <td colspan="2" align="left" valign="top"><table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="10%" class="boldEleven"><input
											name="complainttype" type="radio" value="A"></td>
                              <td width="16%" class="boldEleven">AMC</td>
                              <td width="11%" class="boldEleven"><input
											name="complainttype" type="radio" value="W" checked></td>
                              <td width="25%" class="boldEleven">Warranty</td>
                              <td width="10%" class="boldEleven"><input
											name="complainttype" type="radio" value="O"></td>
                              <td width="28%" class="boldEleven">Oncall</td>
                            </tr>
                          </table></td>
					    </tr>
						<td height="17" valign="top" class="boldEleven">Starting
								Date</td>
								<td colspan="2" align="left" valign="top"><input
									name="startdate" type="text" class="formText135" id="startdate" onKeyPress="dateOnly(this)"
									size="25" maxlength="20" readonly="readonly" /> 
								 <script language='JavaScript'
									type="text/javascript">
						<!--			
							 
							setCurrentDateandTime('startdate'); 
							
						//-->
                       </script>
					   
					   
					   <script language="javascript">

$('#startdate').datetimepicker({
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	stepHour: 1,
	stepMinute: 1,
	stepSecond: 1,
	changeMonth: true,
			changeYear: true,
	showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true
});
 
</script>					   </td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">No of Years								</td>
								<td colspan="2" align="left" valign="top">
								<select 	name="amcperiod" class="formText135" id="amcperiod">
									<option value="0">Select</option>
									<option value="1">1 - Year</option>
									<option value="2">2 - Years</option>
									<option value="3">3 - Years</option>
									<option value="4">4 - Years</option>
									<option value="5">5 - Years</option>
								</select> 
								<script language="javascript">setOptionValue('amcperiod','<%=noofyear%>')</script>								</td>
							</tr>
							 
						
						
						
                         
                         
                        <tr>
                          <td height="17" colspan="3" valign="top" class="boldEleven"><table width="131" border="0" align="center">
                              <tr>
                                <td width="54">
<input name="Submit" type="submit"	id="Submit" class="buttonbold13" value="<%=value%>" ></td>
                                <td width="67"><div align="center">
                                  <input name="button" type="button" class="buttonbold13"  value="Close"   accesskey="c"  onClick="redirect('amc.jsp')">
                                </div></td>
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
            <td>&nbsp; </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
	  </form>	  </td>
	   
	  
	  	  </td>
  </tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	
	
	<tr>
	  <td><!--DWLayoutEmptyCell-->&nbsp;</td>
  </tr>
	<tr>
	  <td><!--DWLayoutEmptyCell-->&nbsp;</td>
  </tr>
	<tr>
	  <td><!--DWLayoutEmptyCell-->&nbsp;</td>
  </tr>
	<tr>
	  <td><!--DWLayoutEmptyCell-->&nbsp;</td>
  </tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
<script language="javascript" >
function validate()
{
	
	display();
	if(parseInt(checkArray.length-1)<1)
	{
		alert("Please Add atleast one Machine Type...");
		document.getElementById('buttonitemadd').focus();
		return false;
	}
	
			
	svalue="";
   	for(u=0; u<checkArray.length-1;u++)
   		svalue =svalue+"type"+checkArray[u]+","+"serailno"+checkArray[u]+","+"description"+checkArray[u]+","+"amcamount"+checkArray[u]+",";
			
	var s = "customerid,startdate,amcperiod,";
	s = s+svalue;
	var v = s.split(",");
	var flag =false;

	if( 
			checkNullSelect("customerid","Select Customer Id",'')
			&&checkNull("startdate","Enter Start Date")	
			&&checkNullSelect("amcperiod","Select amcperiod",'0')	
			
	   )
	   {
	 		for( i=0; i<v.length-1; i++)
			{
				var chk =document.getElementById(v[i]).value;
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
		
	else
	{
		return false
	}	
}
</script>
<%
}
catch(Exception e)
{
out.println(""+e.getMessage());
}
%>
</body>
</html>
