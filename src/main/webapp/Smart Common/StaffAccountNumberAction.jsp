<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>

<title> :: COMMON ::</title>
<%@ include file="index.jsp"%>
 
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
<script language="JavaScript" src="../JavaScript/AJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/commonAJAX.js" type="text/javascript"></script>

 
<script language="JavaScript">
 
function resetIFSC()
{
	try
	{
		document.getElementById('ifsccode').value="";
		document.getElementById('ifsccode').focus();
	}
	catch(err)
	{
		alert(err);
	}
}

function Validate()
{	
	try
	{
	   
		if(  checkNullSelect( "bank","Select Bank" ,"0" ) 
			 && checkNull( "no","Enter Account Number" )
			 && checkNull( "confirmno","Enter Confirm Account Number" ) 
			 && checkBothNumber()
			 && checkNull( "ifsccode","Enter ifsc code  " )  
		)
		{
			var myString = document.getElementById('no').value;
			var myArray = new Array();
			var no="";
			for (var i=0; i < myString.length; i++)
				 no = no + myString[i] + "  " ;
		
			var rs=confirm("Are you sure?, Account number  "+no+"   is correct");
			if (rs==true)
				return true;
			else
				return false;
		}
		else
			return false;				
			
	}
	catch(err)
	{
		alert(err);
		return false;
	}		
 } 	
 
 
 function checkBothNumber()
 {
	 try
	 {
		 var f1 = document.getElementById('no').value;
		 var f2 = document.getElementById('confirmno').value;
		 if( f1 == f2)
		 	return true;
		else
		{
			alert("Confirm account number is correct");
			var f2 = document.getElementById('no').focus();
			return false;
		}
	 }
	 catch(err)
	 {
		 alert(err);
		 return false;
	 }
 }
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

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
                <td colspan="2" class="bold1"><div align="center"> ACCOUNT NUMBER UPDATION
				
				    <%
							 
							String id="",Name="",accno="",actionS="",value="",ifsc="";
							String sql="";
							String link="";
							String empname="";
							id="";Name=""; ifsc="";
							id=request.getParameter("staffid");
							sql = " SELECT CHR_EMPID,CHR_BANK,CHR_ACCNO, CHR_IFSC,FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID)  FROM com_m_staff  WHERE CHR_EMPID= '"+id+"'";
							String data[][]= CommonFunctions.QueryExecute(sql);
							id=data[0][0];Name=data[0][1];  accno=data[0][2]; ifsc=data[0][3]; empname=data[0][4]; 
							actionS="GENStaffRegistrationAccountUpdation";
							value="Update";
							link=" onKeyUp=\" CheckUnique(this,'divunitname','com_m_staff','CHR_ACCNO')\" ";
						 
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td class="boldEleven">Empid / Name </td>
                <td class="bold1"><%=empname%></td>
              </tr>
              <tr>
                <td width="31%" class="boldEleven">Bank Name <font
																class="bolddeepred" align="absmiddle">*</font></td>
                <td width="69%" class="boldEleven"> 
				  <select name="bank" class="formText135" id="bank"  style="width:170" tabindex="27" onChange="resetIFSC()">
                    <option value="0">Select Bank Name</option>
                    <%
                   
                  		String datas[][]= CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME  FROM com_m_bankgroup  ORDER BY CHR_BANKGROUPNAME");
                  		if (datas.length>0){
                  			for (int i=0; i<datas.length; i++) {
								out.println("<option value="+datas[i][0]+">"+datas[i][1]+"</option>");			
                  			}
                  		}
				%>
                  </select>
				  <script language="javascript">setOptionValue('bank','<%=Name%>')</script>				  </td>
              </tr>
              
              <tr>
                <td valign="top" class="boldEleven">Account No  <font
																class="bolddeepred" align="absmiddle">*</font></td>
                <td  ><input name="number" type="text" class="formText135" id="no" size="30"  maxlength="20"    onkeyup="upperMe(this),checkAccounts(this) " tabindex="28" value="<%=accno%>"/>
                                    <script language="javascript">
function checkAccounts(ctr)
{
	try
	{
		
		document.getElementById('Submit').disabled=false;	
		var v = ctr.value;
		v = v.toUpperCase();
		v = v.replace('','');
		var f = ( ( v !="") && (v != "DD") );
		
		if( f)
			LoadUniqueCheck('no', 'acc', 'com_m_staff', 'CHR_ACCNO', 'Submit')
		else
		{
			document.getElementById('Submit').disabled=false;	
			document.getElementById('acc').innerHTML=""; 
		}
	}
	catch(err)
	{
		alert(err);
	}			
	
}
            </script>
                                    <!--CheckUnique(ctr,'acc','com_m_staff','CHR_ACCNO') ;-->
                                    <div id="acc"></div>
                                  <span class="boldred">A/c no does'nt have, Put DD </span></td>
              </tr>
              <tr>
                <td class="boldEleven">Confirm A/c no <font
																class="bolddeepred" align="absmiddle">*</font></td>
                <td  ><input name="confirmno" type="text" class="formText135" id="confirmno" size="30"  maxlength="20"  value=""/></td>
              </tr>
              <tr>
                <td class="boldEleven">IFSC CODE </td>
                <td  ><script language="javascript">
 function ifsccodefill(thisValue) 
{
	document.getElementById('ifsccode').value=thisValue;
	//setTimeout("$('#ifsccode1').hide();", 30);
	$('#ifsccode1').hide();
}

function ifsccodelookup(inputString) 
{
	try
	{
		if(checkNullSelect('bank','Select Bank','0'))
		{
			var bank = document.getElementById('bank').value;
			
			if(inputString.length == 0 )
			{
				$('#ifsccode1').hide();
			} 
			else 
			{
				$.post("ifsccode.jsp?bank="+bank, {queryString: ""+inputString+" "  }, function(data)
				{
					if(data.length >0) 
					{
						$('#ifsccode1').show();
						$('#ifsccodeListdata').html(data);
					}
				});
			}	
		}
	}
	catch(err)
	{
		alert(err);
	}		
	
}
          </script>
                                    <style type="text/css">
 

.ifsccodeBox1 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.ifsccodeList1 
{
	margin: 0px;
	padding: 0px;
}
.ifsccodeList1 li 
{
	margin: 0px 0px 3px 0px;
	padding: 3px;
	cursor: pointer;
}

.ifsccodeList1 li:hover {
background-color: #ffffff;
}
            </style>
                                    <input name="ifsccode" type="text"	class="formText135" id="ifsccode"  size="30"     											maxlength="20"  tabindex="29" value="<%=ifsc%>"   onKeyUp="ifsccodelookup(this.value);" title="Please type branch name  or IFSC code wise" />
                                    <div class="ifsccodeBox1" id="ifsccode1" style="display: none;width:250%;">
                                      <div class="ifsccodeList1" id="ifsccodeListdata" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                                    </div>
                                  <br>
                                    <span class="boldred">Search branch name  / IFSC code </span></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input name="filename" type="hidden" value="StaffRegistration" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('Staff_Accountnumber.jsp')"></td>
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
	String msg=""+request.getParameter("msg");
	if(!"null".equals(msg))
	{
	%>
	<script language="javascript">
		var rs=confirm("<%=msg%>, Add one more record...");
		if (rs==true)
  		 	location = 'EmailCompanyAction.jsp?action1=Add'; 
		else	
		location = 'EmailCompany.jsp'; 
	</script>
	<%	
	}
}
catch(Exception e)
{
}
%>
</body>
</html>
