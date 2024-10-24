<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%
try
{
%>

<title> :: AMC ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/AMC/ServiceAMC.js"></script>
<script language="JavaScript">

    function SAdd()
	{ 
		document.frm.action="AMCAction.jsp";
 	}

	function AEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id;
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
		if(count==1){			
			document.frm.action="AMCActionEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function ADelete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id;
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
 	

 	function PageBack()
	{
	     //future enhancement
    }
 	




  	
function LoadRuntimeCustomer(ctr)
{
 	try
 	{
 		
		var _targ=document.getElementsByName('customerid')[0];
    	_targ.options.length=0;	 
		var opt = document.createElement("option");
		document.getElementById("customerid").options.add(opt); 
       	opt.text = "All";
        opt.value = "0";	 
		var branch=document.getElementById('branch').value;	 
		var id = document.getElementById('servicecenter').value;
 		var url = "../AMC?actionS=LoadRuntimeCustomer&id="+escape(id)+"&branch="+branch;
		initRequest(url);
    	req.onreadystatechange=RuntimeCustomerRequest;
		req.open("GET", url, true);
    	req.send(null);
		//LoadServiceAMC('0')
    	
    }
     
	catch(err)
	{
		
		alert(err.description);
		
	} 	
    
}
 
function RuntimeCustomerRequest() 
{
		if(req.readyState == 4) 
		{    	
			if (req.status == 200) 
			{		  	
			  RuntimeCustomerMessages();
			}
		}
}
	
	
function RuntimeCustomerMessages() 
{	 
   
   	 	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{	     
			var batch = batchs.childNodes[loop];
			var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
			var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
			var opt = document.createElement("option");
			document.getElementById("customerid").options.add(opt); 
       		opt.text = Name;
        	opt.value = Id;
		}
		 
	 	
	
}  
 	
function loadAll()
{
	var name=confirm("Load all records..")
	if (name==true)
	 LoadServiceAMC('0')
	 
}	
	
</script>

<body   onLoad="loadAll()" ><!--onLoad="LoadServiceAMC('0')"-->

<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table height="215" align="center"
			cellpadding="1" cellspacing="1" class="TableDesign"  >
			<tr >
				<td height="31" >
				<div align="center" class="whiteMedium">CONTRACT INFORMATION </div>				</td>
			</tr>
			<tr >
				<td height="25" valign="top" >
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="2" class="whiteMedium">
					<tr>
					  <td   ><span  >Branch </span></td>
					  <td   ><span  >
					    <select name="branch" id="branch" onBlur="LoadServiceAMC('0')"    onChange="LoadRuntimeCustomer('servicecenter')" class="formText135"  style="width:300">
                           <%
			   	String branchid=""+session.getAttribute("AMCBRANCH"); 
				String suertype=""+session.getAttribute("USRTYPE"); 
				if("F".equals(suertype) )  
				{
					out.println("<option value='0'>All</option>");								
					String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  ";
					String shipids[][] =  CommonFunctions.QueryExecute(sq);
					for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
				}
				else
				{
					
					String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID and  a.INT_BRANCHID = "+branchid;
					String shipids[][] =  CommonFunctions.QueryExecute(sq);
					for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
				}	
				 
			   %>
                        </select>
						<script language="javascript">setOptionValue('branch','<%=branchid%>')</script>
					  </span></td>
					  <td  >Service Center </td>
					  <td   ><select name="servicecenter" class="formText135"  id="servicecenter" onBlur="LoadServiceAMC('0')"  onChange="LoadRuntimeCustomer('servicecenter')"      style="width:300" >
                        <option value="0">All</option>
                        <%
				String readDatas[][] =  CommonFunctions.QueryExecute("SELECT INT_SERVICECENTERID,CHR_CENTERNAME,CHR_SHORTNAME FROM  inv_m_servicecenter ORDER BY CHR_CENTERNAME");
				for(int u=0;u<readDatas.length;u++)
					out.println("<option value="+readDatas[u][0]+">"+readDatas[u][1]+"</option>");
				%>
                      </select></td>
				  </tr>
					<tr>
					  <td   >Customer </td>
					  <td   >
					  
					   <select name="customerid" id="customerid"   class="formText135" onChange="LoadServiceAMC('0') "   style="width:300">
								<option value="0" >All</option>
								<%
				String readData[][] =  CommonFunctions.QueryExecute("SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM  inv_m_servicecustomerinfo WHERE INT_BRANCHID="+""+session.getAttribute("AMCBRANCH") +" ORDER BY CHR_CUSTOMERNAME");
				for(int u=0;u<readData.length;u++)
					out.println("<option value="+readData[u][0]+">"+readData[u][1]+"</option>");
				%>
						</select>					  </td>
						<td  >Service peripherals</td>
						<td   >
						
						<select name="peripheralid" id="peripheralid"    class="formText135" onChange="LoadServiceAMC('0') "   style="width:300">
							<option value="0">All</option>	 
								<%
				String readData1[][] =  CommonFunctions.QueryExecute("SELECT INT_SERVICEITEMID,CHR_SERVICEITEMNAME FROM  inv_m_serviceitems ORDER BY CHR_SERVICEITEMNAME");
				for(int u=0;u<readData1.length;u++)
					out.println("<option value="+readData1[u][0]+">"+readData1[u][1]+"</option>");
				%>
						</select>						</td>
					</tr>
					<tr>
					  <td colspan="4" align="center"   ><table  class="whiteMedium" width="30%" height="24" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td>Search</td> 
                          <td><input name="search" type="text" class="formText135" id="search"   onKeyUp="upperMe(this),LoadServiceAMCsearch()"></td>
                        </tr>
                      </table></td>
				  </tr>
				</table>				</td>
			</tr>
			<tr >
			  <td height="25" valign="top" >
			  
			  <table width="100%" class="whiteMedium">
			  <tr>
	<td><div align="center">S.No</div></td>
	<td><div align="center">Branch</div></td>
	<td><div align="center">Service Center </div></td>
	<td><div align="center">Customer Name</div></td>
	<td><div align="center">Peripherals</div></td>
	<td><div align="center">Quantity</div></td>
	<td><div align="center">Mobile</div></td>
			  </table>
			  </td>
		  </tr>
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				
				<br>
				<div id="divscroll" style="OVERFLOW:auto;width:100%;height:250px" 	 > </div>
						<br><div align="center" id="totRec"></div>		
				<br>
			  </td>
		  </tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('0')">All</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('A')">A</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('B')">B</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('C')">C</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('D')">D</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('E')">E</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('F')">F</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('G')">G</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('H')">H</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('I')">I</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('J')">J</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('K')">K</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('L')">L</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('M')">M</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('N')">N</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('O')">O</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('P')">P</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('Q')">Q</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('R')">R</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('S')">S</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('T')">T</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('U')">U</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('V')">V</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('W')">W</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('X')">X</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('Y')">Y</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadServiceAMC('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="ServiceAMC" /> 
		<input
			name="actionS" type="hidden" value="AMCServiceAMCDELETE" /></td>
	</tr>
	<tr>
		<td>
		<table   border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="SAdd()" /></td>
				<!--<td width="56" valign="top"><input name="Edit" type="button"
					class="ButtonHead" id="Edit" 
					value="Edit" />
				 </td>
				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Submit" id="Submit" value="Delete"
					onClick="return ADelete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='btnDelete'>");
		}
		%>-->
				<td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('AMCmain.jsp')" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
