<%@ page import="java.io.*,java.util.*"%>
<%
	try
 	{
%>
		
<html>
<head>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>

<title> :: TRANSPORT ::</title>


 


<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
 <script language="javascript" src="../JavaScript/Transport/SelectChanges.js"></script>
 <script language="javascript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<style type="text/css">
<!--
	a:visited {
			color: #663366;
			}
	a:hover {
			color: #FF0000;
			}
	a:active {
			color: #0000FF;
			}
-->
</style>
<script language="javascript">
 function validate()
  {
  	if(	
		checkNull('ename','Select Employee Name')
		&& checkNullSelect('vehicletype','Select Vehicle Type','0')
		&& checkNullSelect('vehiclemake','Select Vehicle Make','0')
		&& checkNullSelect('vehiclemodel','Select Vehicle Model','0')
		&& checkNullSelect('varriant','Select Vehicle Varrient','0')
		&& checkNullSelect('vehicle','Select Vehicle vehicle','0')
		
		&& checkNull('entrydate','Enter Date')
	
	)
		return true;
	else
		return false;
		
  }
  
  
  
  </script>
<style type="text/css">
<!--
.style11 {color: #FF0000}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<%@ include file="index.jsp"%>
<body  onpaste="return false;"  onLoad="init()">
<form  AUTOCOMPLETE = "off"   method="post" name='frm' action="../SmartLoginAuth" onSubmit="return validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="80">
		<% 
		 String empid,sql;
		 String msg,action,actionS;
		 String id="";
		 String vehicletype="",vehiclemake="",vehiclemodel="",varriant="",entrydate="",vehiclenumber="";
				 
				
		 		 		  
				msg=""+request.getParameter("msg");	
				action=""+request.getParameter("action1");
				if(action.equals("Add"))
				{
					actionS="TRSDriverAssignAdd";
					empid="";
					vehicletype="";
					vehiclemake="";
					vehiclemodel="";
					varriant="";
					entrydate="";
					vehiclenumber="";
				}
				else
				{
					id=request.getParameter("id");	
					actionS="TRSDriverAssignEdit";
					sql="SELECT INT_DRIVERASSIGNID, CHR_EMPID,INT_VEHICLEID,CHR_FLAG,DATE_FORMAT(DT_DATE,'%d-%m-%Y') FROM veh_m_driverassign  WHERE INT_DRIVERASSIGNID= "+id;
					String	readData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					id=readData[0][0];
					empid=readData[0][1];
					entrydate=readData[0][4];
					vehiclenumber=readData[0][2];
					sql="SELECT INT_VEHICLETYPEID,INT_MAKEID,INT_MODELID,INT_VARRIANTID FROM veh_m_vehicleinfo WHERE INT_ID= "+readData[0][2];;
					
					String	readData1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					vehicletype=readData1[0][0];
					vehiclemake=readData1[0][1];
					vehiclemodel=readData1[0][2];
					varriant=readData1[0][3];
					
			  }
%>
		</td>
	</tr>
	<tr>
		<td align="center">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"> </td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"> </td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"> </td>
					<td width="6"> </td>
					<td width="412">
					  <table width="100%" border="0" cellspacing="2" cellpadding="2">
                        <tr>
                          <td colspan="2"><div align="center"><span class="boldThirteen">DRIVER ASSIGN </span></div></td>
                        </tr>
                        <tr>
                          <td colspan="2"><div align="right"><span class="bolddeepred">* </span><span class="fairyHead"><span class="changePos">- Mandatory</span></span></div></td>
                        </tr>
                        <tr>
                          <td colspan="2"><span class="bolddeepblue">

<%@ include file="../JavaScript/ajax.jsp"%>
<%
if(!action.equals("Add"))
{
%>
<script language="JavaScript" type="text/javascript"></script>
<%
}
%>
							
							
                          </span></td>
                        </tr>
                       
                        <tr>
                          <td><span class="bold1">Type<span class="boldEleven"> <strong> <span class="style11 style19 style3">*</span></strong></span></span></td>
                          <td><select name="vehicletype" class="formText135"  id="vehicletype" onChange="LoadSelectHomeMake()"  >
                            <option value="0">Select</option>
                            <%
			
			String	readData0[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_VEHICLETYPEID,CHR_VEHICLETYPENAME FROM   veh_m_vehicletype ORDER BY CHR_VEHICLETYPENAME");
			for(int u=0;u<readData0.length;u++)
				out.println("<option value='"+readData0[u][0]+"'>"+readData0[u][1]+"</option>");
			%>
                          </select>
                            <%
if(!action.equals("Add"))
{
%>
                            <script language="JavaScript" type="text/javascript">setOptionValue('vehicletype','<%=vehicletype%>')</script>
                            <%

}

%></td>
                        </tr>
                        <tr>
                          <td><span class="bold1">Make<span class="boldEleven"> <strong> <span class="style11 style19 style3">*</span> </strong> </span></span></td>
                          <td><select name="vehiclemake" class="formText135"  id="vehiclemake" onChange="LoadSelectHomeModel()">
                            <option value="0">Select</option>
                            <%
			if(!action.equals("Add"))
			{
				String	readData1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_MAKEID,CHR_MAKENAME FROM   veh_m_make WHERE INT_VEHICLETYPEID ="+vehicletype+" ORDER BY CHR_MAKENAME ");
				for(int u=0;u<readData1.length;u++)
					out.println("<option value='"+readData1[u][0]+"'>"+readData1[u][1]+"</option>");
			}		
			%>
                          </select>
                            <%
if(!action.equals("Add"))
{
%>
                            <script language="JavaScript" type="text/javascript">setOptionValue('vehiclemake','<%=vehiclemake%>')</script>
                            <%

}

%></td>
                        </tr>
                        <tr>
                          <td width="47%"><span class="bold1">Model<span class="boldEleven"> <strong> <span class="style11 style19 style3">*</span> </strong> </span></span></td>
                          <td width="53%"><select name="vehiclemodel" class="formText135"  id="vehiclemodel" onChange="LoadSelectHomeVarriant()"  >
                            <option value="0">Select</option>
                            <%
			
		if(!action.equals("Add"))
			{	
				String	readData2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_MODELID,CHR_MODELNAME FROM   veh_m_model WHERE INT_MAKEID = "+vehiclemake+" ORDER BY CHR_MODELNAME");
				for(int u=0;u<readData2.length;u++)
					out.println("<option value='"+readData2[u][0]+"'>"+readData2[u][1]+"</option>");
			}		
			%>
                          </select>
                            <%
if(!action.equals("Add"))
{
%>
                            <script language="JavaScript" type="text/javascript">setOptionValue('vehiclemodel','<%=vehiclemodel%>')</script>
                            <%

}
else
{
}
%></td>
                        </tr>
                        <tr>
                          <td><span class="boldEleven"><span class="bold1">Variant <strong> <span class="style11 style19 style3">*</span> </strong> </span></span></td>
                          <td><span class="boldEleven">
                            <select name="varriant" class="formText135"  id="varriant" onBlur="LoadSelectVehicleinfo()"  >
                              <option value="0">Select</option>
                              <%
			if(!action.equals("Add"))
			{
				String	readData3[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_VARRIANTID,CHR_VARRIANTNAME FROM   veh_m_varriant  WHERE INT_MODELID="+vehiclemodel+" ORDER BY CHR_VARRIANTNAME");
				for(int u=0;u<readData3.length;u++)
					out.println("<option value='"+readData3[u][0]+"'>"+readData3[u][1]+"</option>");
			}		
			%>
                            </select>
                            <%
if(!action.equals("Add"))
{
%>
                            <script language="JavaScript" type="text/javascript">setOptionValue('varriant','<%=varriant%>')</script>
                            <%

}
else
{
}
%>
                          </span></td>
                        </tr>
                        <tr>
                          <td class="bold1">Vehicle Number </td>
                          <td><span class="boldEleven">
                            <select name="vehicle" class="formText135"  id="vehicle"  >
                              <option value="0">Select</option>
                               
                           <%
			if(!action.equals("Add"))
			{
				 
				
				String	readData4[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_ID,CHR_VEHICLEREGNO FROM veh_m_vehicleinfo WHERE INT_ID>=1 AND INT_VEHICLETYPEID ="+vehicletype+"  AND INT_MAKEID = "+vehiclemake+" AND INT_MODELID="+vehiclemodel+" AND INT_VARRIANTID="+varriant+" ORDER BY CHR_VEHICLEREGNO");
				
	 
				for(int u=0;u<readData4.length;u++)
					out.println("<option value='"+readData4[u][0]+"'>"+readData4[u][1]+"</option>");
			}		
			%>
                            </select>
                            <%
if(!action.equals("Add"))
{
%>
                            <script language="JavaScript" type="text/javascript">setOptionValue('vehicle','<%=vehiclenumber%>')</script>
                            <%

}
else
{
}
%>
                          </span></td>
                        </tr>
                        <tr>
                          <td class="bold1">Date</td>
                          <td>
<input name="entrydate" type="text" class="formText135" id="entrydate" 	onKeyPress="numericHypenOnly('entrydate','9')" value="<%=entrydate%>" size="15"  >
                            <a
												href="javascript:cal1.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a>
                            <script
												language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frm'].elements['entrydate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			
				<%
				if(action.equals("Add"))
				{
				%>
				setCurrentDate('entrydate');
			 	<%
				}
				%>
			
		//-->
	                          </script>
                            <span class="boldEleven"> ( dd-mm-yyyy ) </span></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td><input
									type="hidden" name="filename" value="DriverAssign" />
                            <input
									type="hidden" name="actionS" value="<%=actionS %>" />
                            <input
									type="hidden" name="id" value="<%=id %>" /></td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="2"><table border="0" align="center" cellpadding="1" cellspacing="1">
                            <tr>
                              <td width="56"><input name="submit" type="submit"
											id="submit" class="buttonbold" value="Submit"   accesskey="s"   ></td>
                              <td width="56"><div align="center">
                                <input name="button" type="button"
											class="buttonbold"  value="Close"   accesskey="c" 
											onClick="redirect('DriverAssign.jsp')">
                              </div></td>
                            </tr>
                          </table></td>
                        </tr>
                      </table>
					  <p>&nbsp;</p>
				  </td>
					<td nowrap="nowrap" width="4"> </td>
					<td class="BorderLine" width="1"> </td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"> </td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"> </td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
	<td>
	<br><br>
	<%
	try
	{
		 	if(!msg.equals("0") && !msg.equals("null"))
		 	{
				 out.println("<table id='table' width='200' border='1' align='center' cellpadding='1' ");
				 out.println("cellspacing='0' bordercolor='#570CD3'> <td>");
				 out.println("<td align='center' class='boldEleven'><b><font color='green'>"+msg+"</td>");
				 out.println("</tr>");
				 out.println("</table>");
	 		}	
	 }
	 catch(NullPointerException e) 
	 {
	 
	 }
	 
     %>
     <br>
	</td>
	</tr>
	 
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>
</html>

<%
	}
	catch(Exception ex)
	{
		out.println(ex.getMessage());
	}  
		 
 %>
