<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>

<title>:: ACCOUNTS ::</title>

 
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
	 checkNullSelect( "Name","Select Accoutn type" ,'0')
	 &&checkNullSelect( "ledgeraccount"," Select Account Name",'0')
	 && checkNull( "desc","Enter Description " )
	 && checkNull( "date","Enter Date " )
	 && checkNull( "amount","Enter Amount " )
	 && AccountDateCheck()
	)
		return true;
	else
		return false;				
		
	
 } 	
 
   
 function AccountDateCheck()
 {
 	try
 	{
 		var date = document.getElementById('date').value;
		var fromdate='<%=""+session.getAttribute("ACCFROMDATE")%>';
		var todate='<%=""+session.getAttribute("ACCTODATE")%>';
 		var url = "../Account?actionS=LoadDateCheck&date="+escape(date)+"&todate="+todate+"&fromdate="+fromdate;
    	initRequest(url);
    	req.onreadystatechange=DateCheckRequest;
		req.open("GET", url, true);
    	req.send(null);
		var ch = document.getElementById('credit').value;
		if(ch == "true")
		{
			return true;
		}	
		else
		{
			return false;
		}	
		 
    	
    }
     
	catch(err)
	{
		
		alert(err.description);
		
	} 	
    
}
 
function DateCheckRequest() 
{
		if(req.readyState == 4) 
		{    	
			if (req.status == 200) 
			{		  	
			  DateCheckMessages();
			}
		}
}
	
	
function DateCheckMessages() 
{	 
   
   	 	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    	var str=""; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{	     
			var batch = batchs.childNodes[loop];
			var Field1 = batch.getElementsByTagName("Value")[0].childNodes[0].nodeValue;
			var fromdate = batch.getElementsByTagName("fromdate")[0].childNodes[0].nodeValue;
			var todate = batch.getElementsByTagName("todate")[0].childNodes[0].nodeValue;
			
			if(Field1 == "False")
			{
				alert("Kindly check date is not between "+fromdate+ "  to  "+todate);	
				document.getElementById('credit').value = "false";
			}
			else
				document.getElementById('credit').value = "true";
				
		}
	 	
	
}
 
 
	
	//-----------------------------
	
function LoadRuntimeLedger(ctr)
{
 	try
 	{
 		var tb=document.getElementById('ledgerlist');
  	 	//tb.innerHTML=""   ;
		var tb=document.getElementById('ledgername');
  	 	//tb.innerHTML=" "   ;
		
		
		
		var _targ=document.getElementsByName('ledgeraccount')[0];
    	_targ.options.length=0;	 
		var opt = document.createElement("option");
		document.getElementById("ledgeraccount").options.add(opt); 
       	opt.text = "Select";
        opt.value = "0";	 
		
		
		
		var id = ctr.value;
 		var url = "../Account?actionS=LoadRuntimeLedger&id="+escape(id);
    	initRequest(url);
    	req.onreadystatechange=LoadRuntimeLedgerRequest;
		req.open("GET", url, true);
    	req.send(null);
		 
    	
    }
     
	catch(err)
	{
		
		alert(err.description);
		
	} 	
    
}
 
function LoadRuntimeLedgerRequest() 
{
		if(req.readyState == 4) 
		{    	
			if (req.status == 200) 
			{		  	
			  LoadRuntimeLedgerMessages();
			}
		}
}
	
	
function LoadRuntimeLedgerMessages() 
{	 
   
   	 	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
		var str="<select name='ledgeraccount' id='ledgeraccount'>";
         str="";       
		
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{	     
			var batch = batchs.childNodes[loop];
			var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
			var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
			//str=str+"<option value='"+Id+"'>"+Name+"</option>";
			
			//var sel=document.getElementById("ledgeraccount");   
			//alert(Id+" / "+Name);
			//sel.options[loop].text=Name;          
        	//sel.options[loop].value=Id;
			
			var opt = document.createElement("option");
			document.getElementById("ledgeraccount").options.add(opt); 
       		opt.text = Name;
        	opt.value = Id;
		}
		//str= str+"</select>";
		//ledgername,
		var tb=document.getElementById('ledgerlist');
  	 	//tb.innerHTML=str   ;
		var tb=document.getElementById('ledgername');
  	 	//tb.innerHTML=" Account Name"   ;
	 	
	
}
 
 
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="indexacct.jsp"%>
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
		    <table width="400" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center">Day Book Entry  
                    <%
							String action=request.getParameter("action1");
							String id="",Name="",actionS="",value="",ledgerid="";
							String customer="",purchaseno="",desc="",date="",amount="";
							String sql="";
							if("Add".equals(action))
							{
								id="";Name=""; customer="";desc="";date="";amount="";purchaseno="";ledgerid="";
								actionS="ACCDayBookAdd";
								value="Add";
							}
							else
							{
								id="";Name="";ledgerid="";
								id=request.getParameter("id");
								sql = " SELECT INT_DAYID,INT_TYPESUBSIDIARYID,DOU_AMOUNT,CHR_DESC,DATE_FORMAT(DT_DATE,'%d-%m-%Y'),INT_LEDGERID  FROM accc_t_dayentry WHERE INT_DAYID= "+id;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								id=data[0][0];Name=data[0][1]; 
								desc=data[0][3];date=data[0][4];amount=data[0][2];
								ledgerid=data[0][5];
								actionS="ACCDayBookEdit";
								value="Update";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td class="boldEleven"> Account type </td>
                <td class="boldEleven">
				 <select name="Name" id="Name" onChange="LoadRuntimeLedger(this)">
				 <option value="0">Select</option>
				 <%
				String readData[][] =  com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_TYPESUBSIDIARYID,CHR_TYPESUBSIDIARYNAME FROM  accc_m_typesubsidiarygroup ORDER BY CHR_TYPESUBSIDIARYNAME");
				for(int u=0;u<readData.length;u++)
					out.println("<option value='"+readData[u][0]+"'>"+readData[u][1]+"</option>");
				 %>
				</select>
				<%
				if(!"Add".equals(action))
				{
				%>
				<script language="javascript" >setOptionValue('Name','<%=Name%>')</script> 
				<%
				}
				%>	 				</td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven"><div id="ledgername">Account Name</div></td>
                <td valign="top" class="boldEleven"><div id="ledgerlist">
				<select name='ledgeraccount' id='ledgeraccount'>
					<option value="0">Select</option>
				<%
				if(!"Add".equals(action))
				{
					
					String readData1[][] =  com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_LEDGERID,CHR_NAME FROM  accc_m_ledger WHERE INT_TYPESUBSIDIARYID="+Name+" ORDER BY CHR_NAME");
				for(int u=0;u<readData1.length;u++)
					out.println("<option value='"+readData1[u][0]+"'>"+readData1[u][1]+"</option>");
				}	
				%>	
				</select>
				<%
				if(!"Add".equals(action))
				{
					%>
				<script language="javascript" >setOptionValue('ledgeraccount','<%=ledgerid%>')</script> 
				<%
				}
				%>	 
				</div>
				
                </td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Description</td>
                <td valign="top" class="boldEleven"><textarea name="desc" cols="30" rows="5" class="formText135" id="desc" onBlur=" textArea('desc','450')" ><%=desc%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">Date</td>
                <td class="boldEleven"><input name="date" type="text" class="formText135"
									id="date"
									tabindex="2" value="<%=date%>" size="15" readonly="readonly">
                  <a
									href="javascript:cal2.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>
                  <script language='JavaScript'
									type="text/javascript">
		<!--			
				//document.getElementById('saleDate').disabled=true;
				var cal2 = new calendar1(document.forms['frm'].elements['date']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				<%
				if("Add".equals(action))
				{
				%>
				setCurrentDate('date'); 
				<%
				}
				 
				%>
		//-->
                          </script></td>
              </tr>
              <tr>
                <td class="boldEleven">Amount</td>
                <td class="boldEleven"><input name="amount" type="text" class="formText135" id="amount"  value="<%=amount%>" maxlength="10"  style="text-align:right" onKeyPress="doubleValue('amount','10')"></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="DayBook" />
                <input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				<input name="credit" type="hidden" id="credit" value="false"></td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                    <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('DayBook.jsp')"></td>
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
<%
}
catch(Exception e)
{
}
%>