<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

<html>
<head>
<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
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
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
 -->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/ServiceSpare.js"></script>
 <script language="javascript">
 function Add()
	{ 
		document.frm.action="SpareAction.jsp";
 	}

	function Edit(){	
		var chkbox=document.forms[0].id;
		var len=0;
		var ch=0;
		for(i=0;i<chkbox.length;i++)
		{
			if(chkbox[i].checked)
			{
				len++;
			}
		}
			if(len>1)
			{
				alert("Select Only One Value");
				return false;
			}
			else if(len==0)
			{
				if(chkbox.checked)
				{
					document.frm.action="SpareActionEdit.jsp";
					return true;
				}
				else
				{
					alert("Select Any One Value");
					return false;
				}
			}
			else
			{
				document.frm.action="SpareActionEdit.jsp";
				return true;
			}
	}

function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id
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
			if (document.forms[0].id.checked) { count=1;}
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
	
	
function UploadWindow(query)
{  
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	newWindow = window.open(query,"subWind",styleStr);
	newWindow.focus( );
}




var isIE;
var req;
var names;

 
function initRequest(url) 
{
    if (window.XMLHttpRequest) 
    {
        req = new XMLHttpRequest();
    } 
    else if (window.ActiveXObject) 
    {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}
 
 
 
function LoadSpareModel()
{
	try
	{
		var unittype = document.getElementById('unittype').value;
	 	var url = "../inventory?actionS=LoadSpareModel&startLetter=0&unittype="+unittype;
	 	initRequest(url);
		req.onreadystatechange=LoadSpareModelRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function LoadSpareModelRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	 var _targ=document.getElementsByName('model')[0];       
	    	 _targ.options.length=0;
	    	 _targ.options[0]=new Option('All','0');  
	    	if (req.status == 200) 
	        {		  	
	    		LoadSpareModelMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function LoadSpareModelMessages() 
{	 
 try
 {
	  
	 var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	 var _targ=document.getElementsByName('model')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('All','0');  
     var str=""; 
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
	 {	     
        var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var Model = batch.getElementsByTagName("Model")[0].childNodes[0].nodeValue;
	   _targ.options[loop+1]=new Option(Model,Rowid);
	 }
      
	
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}
		
	
</script>

<body  onLoad="loadsspare('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="" method="get" name="frm"  >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table width="150" border="0" align="right" cellpadding="0" cellspacing="0">
	    <tr>
	      <td><img src="../Image/report/msexcel-mysql1.jpg" width="30" height="30"></td>
	      <td><span class="bolddeepblue"><a   title="Upload Datas" href="javascript:UploadWindow('UploadMIF.jsp')">Upload MIF</a></span></td>
	      </tr>
      </table></td>
    </tr>
	<tr>
	  <td><table align="center" cellpadding="0" cellspacing="0"   class="TableDesign">
        <tr>
          <td><div align="center" class="whiteMedium"><strong>SPARE MASTER </strong> ( MIF )</div>
           
    </td>
        </tr>
        <tr>
          <td align="center"><table width="100%" border="0" align="center" cellpadding="5" cellspacing="0" class="whiteMedium">
            <tr>
              <td>State</td>
              <td>
              <select name="location" id="location" class="formText135" style="width: 80"  onChange="loadsspare('0')">
                <option value="0" selected="selected">All</option>
                <%
String	stateData[][]= CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME,CHR_SHORTNAME FROM com_m_state   ORDER BY CHR_STATENAME");
for(int u=0;u<stateData.length;u++)
	out.println("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
																	%>
</select></td>
              <td>Unit Type</td>
              <td><select name="unittype" id="unittype" class="formText135" style="width: 80"  onChange="LoadSpareModel()"  onBlur="loadsspare('0')">
                <option value="0">All</option>
                <%
String	typeData[][]= CommonFunctions.QueryExecute("SELECT INT_SPAREUNITID,CHR_SPAREUNITNAME  FROM inv_m_spareunit   ORDER BY CHR_SPAREUNITNAME");
for(int u=0;u<typeData.length;u++)
	out.println("<option value='"+typeData[u][0]+"'>"+typeData[u][1]+"</option>");
																	%>
                
				 
				
</select></td>
              <td>Model</td>
              <td><select name="model" class="formText135" id="model"  style="width: 80"  onChange="loadsspare('0')">
                <option value="0">All</option>
              </select></td>
              
              <td>Type</td>
              <td><select name="Type" class="formText135" id="Type" tabindex="1"  style="width: 80" onChange="loadsspare('0')">
                <option value="0">All</option>
                <option value="A">Amc</option>
                <option value="W">Warranty</option>
              </select></td>
              <td>Status</td>
              <td><select name="status" class="formText135" id="status" tabindex="1" onChange="loadsspare('0')"  style="width: 80">
                <option value="">All</option>
                <option value="0">Live</option>
                <option value="1">Expired</option>
              </select></td>
              <td>Search by Serial</td>
              <td><input name="search" type="text" class="formText135" id="search" onKeyUp="loadsspares(this)" size="15" ></td>
             </tr>
          </table></td>
        </tr>
		 
        <tr class="boldEleven">
          <td bgcolor="#FFFFFF"><div align="center">
            <div id="ServiceTable" style="OVERFLOW:auto;width:100%;height:260px"class="boldEleven"> </div>
          </div><br>
		   <div id ="totRec" align="center"> </div>
                  <br>		
		  </td>
        </tr>
      </table></td>
    </tr>
	
	<tr>
	  <td valign="top">&nbsp;</td>
    </tr>
	<tr>
	  <td valign="top"><table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsspare('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	<tr>
	  <td valign="top">&nbsp;</td>
    </tr>
	<tr>
	  <td valign="top"><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" value="Edit"
					onclick=" return Edit()" /></td>
					<input type="hidden" name="filename" value="ServiceSpare" />
		 			 <input type="hidden" name="actionS" value="INVServiceSpareDelete" />
          <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
          <td  >
			  <input name="submit" type="submit" class="ButtonHead" onClick="return Delete()" value="Delete"  style="width:60"
					 > 				</td>
          <% }%>
          <td width="56"><input name="Close" type="button"
					class="ButtonHead" id="Close"  value="Close"   accesskey="c" 
					onclick="redirect( 'InventoryMains.jsp')" /></td>
        </tr>
      </table></td>
    </tr>
	<tr >
		<td valign="top"><font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1">
		  
          <strong><font color="#000000"><font size="1">
          
          </font></font></strong></font></font></strong></font></font></strong></font></td>
	</tr>
</table>
 <jsp:include page="../footer.jsp" /></form>
</body>
</html>
