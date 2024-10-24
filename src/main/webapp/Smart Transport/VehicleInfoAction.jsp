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
<script language="JavaScript" src="../JavaScript/SmartCommon/CommonAjax.js"> </script>
 <script language="javascript" src="../JavaScript/Transport/SelectChanges.js"></script>
 <script language="JavaScript" src="../calendar1.js"> </script>
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
		 checkNullSelect('vehicletype','Select Vehicle Type' ,'0')	
		&& checkNullSelect('vehiclemake','Select Vehicle Make' ,'0')	
		&& checkNullSelect('vehiclemodel','Select Vehicle Model' ,'0')	
		&& checkNullSelect('varriant','Select Vehicle Variant' ,'0')	
		&& checkNullSelect('color','Select Color' ,'0')	
		&& checkNullSelect('fueltype','Select Fuel Type' ,'0')	
		 
		&& checkNull('regnumber','Enter regnumber')	
		 
		 
		&& checkNull('cc','Enter cc')	
		 
		&& checkNull('insurancenumber','Enter Insurance Number')	
		&& checkNull('insurancedate','Enter Insurance Date')	
		&& checkNull('comments','Enter Comments')
		&& checkNull('chasenumber','Enter chasenumber ')
		&& checkNull('batterynumber','Enter batterynumber')
		&& checkNull('keynumber','Enter keynumber')
		
	  )
		return true;
	else
		return false;
		
  }
  
 function upperMe(field)
  {
  		field.value=field.value.toUpperCase();
  }    
  
  </script>
<style type="text/css">
<!--
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
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
</head>
<%@ include file="index.jsp"%>
<body  onpaste="return false;"    onLoad="document.frm.vehicletype.focus()">
<form  AUTOCOMPLETE = "off"   method="get" name='frm' action="../SmartLoginAuth" onSubmit="return validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="48">
		<% 
		 String makename,sql;
		 String msg,action,actionS;
		 String vid="";
		 String typeid="";
		 		 		  
				msg=""+request.getParameter("msg");	
				action=""+request.getParameter("action1");
				
				String vehicletype="",vehiclemake="",vehiclemodel="",varriant="";
				String color="",fueltype="",regnumber="",monthname="",year="",cc="";
				String insurancenumber="",insurancedate="",comments="",chasenumber="";
				String batterynumber="",keynumber="";
				
				if(action.equals("Add"))
				{
					
					actionS="TRSVehicleInfoAdd";
					makename="";
					typeid="";
					vehicletype="";vehiclemake="";vehiclemodel="";varriant="";
					color="";fueltype="";regnumber="";monthname="";year="";cc="";
					insurancenumber="";insurancedate="";comments="";chasenumber="";
					batterynumber="";keynumber="";
				
					
				}
				else
				{
					vid=request.getParameter("id");	
					actionS="TRSVehicleInfoEdit";
					 
sql = " SELECT  INT_ID,INT_VEHICLETYPEID,INT_MAKEID,INT_MODELID,INT_VARRIANTID,INT_COLORID,INT_FUELTYPEID,  CHR_VEHICLEREGNO,CHR_MONTH,INT_YEAR, INT_ENGINECAPACITY, CHR_INSURANCE,DATE_FORMAT(CHR_INSURANCEEXPIRYDATE,'%d-%m-%Y'),CHR_COMMENTS, CHR_CHASISNO,CHR_BATTERYNO, CHR_KEYNO, CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS FROM veh_m_vehicleinfo WHERE INT_ID="+vid;
 				
					String	readData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					vehicletype=readData[0][1];
					vehiclemake=readData[0][2];
					vehiclemodel=readData[0][3];
					varriant=readData[0][4];
					color=readData[0][5];
					fueltype=readData[0][6];
					regnumber=readData[0][7];
					monthname=readData[0][8];
					year=readData[0][9];
					cc=readData[0][10];
					insurancenumber=readData[0][11];
					insurancedate=readData[0][12];
					comments=readData[0][13];
					chasenumber=readData[0][14];
					batterynumber=readData[0][15];
					keynumber=readData[0][16];
					
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
					<td class="BorderLine" height="0">  </td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6">  </td>
				</tr>
				<tr>
					<td class="BorderLine" width="1">  </td>
					<td width="6">  </td>
					<td width="412">
					<table cellspacing="2" cellpadding="2" width="437" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
						<tr>
                    <td width="403" height="16" colspan="2" align="center" valign="top" class="boldThirteen">VEHICLE INFORMATIONS </td>
                  </tr>
					<tr>
                    <td height="19" colspan="2" align="right" valign="top"><span class="bolddeepred">* </span><span class="fairyHead"><span class="changePos">- Mandatory</span> </span> </td>
					</tr>
							<tr>
                              <td><span class="bold1">Type<span class="boldEleven"> <strong> <span class="style11 style19 style3">*</span> </strong> </span></span></td>
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

%>                            
		
								
								
								
								
								                             </td>
						  </tr>
							<tr>
                              <td><span class="bold1">Make<span class="boldEleven"> <strong> <span class="style11 style19 style3">*</span> </strong> </span></span></td>
							  <td>
<select name="vehiclemake" class="formText135"  id="vehiclemake" onChange="LoadSelectHomeModel()">
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

%>                            



							  </td>
						  </tr>
							<tr>
                              <td><span class="bold1">Model<span class="boldEleven"> <strong> <span class="style11 style19 style3">*</span> </strong> </span></span></td>
							  <td>
							  <select name="vehiclemodel" class="formText135"  id="vehiclemodel" onChange="LoadSelectHomeVarriant()"  >
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
%>    		  
							  
							  </td>
						  </tr>
							<tr>
                              <td height="29" valign="middle" class="boldEleven"><span class="bold1">Variant <strong> <span class="style11 style19 style3">*</span> </strong> </span></td>
							  <td valign="top" class="boldEleven">
  <select name="varriant" class="formText135"  id="varriant"  >
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

								                            </td>
						  </tr>
							<tr>
                              <td height="29" valign="middle" class="boldEleven"><strong>Colour <strong> <span class="style11 style19 style3">*</span> </strong> </strong></td>
							  <td valign="top" class="boldEleven">
							  
							  <select name="color" class="formText135"  id="color"  >
                                  <option value="0">Select</option>
                                  <%
			
			 
				String	readData4[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_COLORID,UPPER(CHR_COLORNAME) FROM com_m_color ORDER BY CHR_COLORNAME ");
				for(int u=0;u<readData4.length;u++)
					out.println("<option value='"+readData4[u][0]+"'>"+readData4[u][1]+"</option>");
			 		
			%>
                                </select> 
									
<%
if(!action.equals("Add"))
{
%>
<script language="JavaScript" type="text/javascript">setOptionValue('color','<%=color%>')</script>
<%

}
else
{
}
%>   								
								
								                             </td>
						  </tr>
							<tr>
                              <td height="29" valign="middle" class="boldEleven"><strong>Fuel Type  <span class="style11 style19 style3">*</span>  </strong></td>
							  <td valign="top" class="boldEleven">
							  <select name="fueltype" class="formText135"  id="fueltype"  >
                                  <option value="0">Select</option>
                                  <%
			
			String	readData5[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_FUELTYPEID,UPPER(CHR_FUELTYPENAME) FROM veh_m_fueltype ORDER BY CHR_FUELTYPENAME ");
			for(int u=0;u<readData5.length;u++)
				out.println("<option value='"+readData5[u][0]+"'>"+readData5[u][1]+"</option>");
			%>
                              </select>
							  <%
if(!action.equals("Add"))
{
%>
<script language="JavaScript" type="text/javascript">setOptionValue('fueltype','<%=fueltype%>')</script>
<%

}
else
{
}
%> 
							  </td>
						  </tr>
							<tr>
                              <td class="boldEleven"><strong> Vehicle Registration Number </strong> <strong> <span class="style11 style19 style3">*</span> </strong> </td>
							  <td><span class="bold1"><span class="boldEleven">
                                <input name="regnumber" type="text" class="formText135" id="regnumber" value="<%=regnumber%>" size="30" maxlength="50" />
                              </span> </span></td>
						  </tr>
							<tr>
                              <td class="boldEleven"><strong> Purchase Month </strong> </td>
							  <td><span class="bold1">
                                <jsp:include page="../JavaScript/common/monthnamewithselect.jsp" flush="true" />
								
<%
if(!action.equals("Add"))
{
%>
<script language="JavaScript" type="text/javascript">setOptionValue('monthname','<%=monthname%>')</script>
<%

}
else
{
}
%>                         
							    </span></td>
						  </tr>
							<tr>
                              <td class="boldEleven"><strong> Purchase Year </strong> </td>
							  <td><jsp:include page="../JavaScript/common/yearwithselect.jsp" flush="true" />
							  <%
if(!action.equals("Add"))
{
%>
<script language="JavaScript" type="text/javascript">setOptionValue('year','<%=year%>')</script>
<%

}
else
{
}
%>
							  </td>
						  </tr>
							<tr>
                              <td height="29" valign="middle" class="boldEleven"><strong>Engine Capacity <strong> </strong> <strong> <span class="style11 style19 style3">*</span> </strong> </strong></td>
							  <td valign="top" class="boldEleven"><input name="cc" type="text" class="formText135" id="cc"  onKeyPress="return numeric_only(event,'cc','5')"    value="<%=cc%>" size="30" maxlength="4"></td>
						  </tr>
							<tr>
                              <td height="29" valign="middle" class="boldEleven"><strong>Insurance Number <strong> </strong> <strong> <span class="style11 style19 style3">*</span> </strong> </strong></td>
							  <td valign="top" class="boldEleven"><input name="insurancenumber" type="text" class="formText135" id="insurancenumber" value="<%=insurancenumber%>" size="30" maxlength="50" /></td>
						  </tr>
							<tr>
                              <td height="29" valign="middle" class="boldEleven"><strong>Insurance Expire Date <strong> </strong> <strong> <span class="style11 style19 style3">*</span> </strong> </strong></td>
							  <td valign="top" class="boldEleven"><input name="insurancedate" type="text" class="formText135" id="insurancedate" title="dd/mm/yyyy" 													onkeypress="numericHypenOnly('insurancedate','9')" value="<%=insurancedate%>" size="22" maxlength="10" />
                                  <a href="javascript:cal1.popup();"> <img
																src="../JavaScript/img/cal.gif" width="16" border="0"
																alt="Click here to Pick Up the Date" />
                                 
<%
if(!action.equals("Add"))
{

}
else
{
%>
 <script language="JavaScript" type="text/javascript">
																<!--
 
  var cal1=new calendar1(document.forms['frm'].elements['insurancedate']);
  cal1.year_scroll=true;
  cal1.time_comp=false;
//-->
																</script>
<%
}
%>
								 
								 
								 
                                </a></td>
						  </tr>
							<tr>
                              <td height="29" valign="top" class="boldEleven"><strong>Comments <strong> </strong> <strong> <span class="style11 style19 style3">*</span> </strong> </strong></td>
							  <td valign="top" class="boldEleven"><textarea name="comments" cols="30" rows="5" id="comments"><%=comments%></textarea></td>
						  </tr>
							<tr>
                              <td height="29" valign="middle" class="boldEleven"><strong>Chase Number<strong> </strong> <strong> <span class="style11 style19 style3">*</span> </strong> </strong></td>
							  <td valign="top" class="boldEleven"><input name="chasenumber" type="text" class="formText135" id="chasenumber" value="<%=chasenumber%>" size="30" maxlength="50" /></td>
						  </tr>
							<tr>
                              <td height="29" valign="middle" class="boldEleven"><strong>Battery Number <strong> </strong> <strong> <span class="style11 style19 style3">*</span> </strong> </strong></td>
							  <td valign="top" class="boldEleven"><input name="batterynumber" type="text" class="formText135" id="batterynumber" value="<%=batterynumber%>" size="30" maxlength="50" /></td>
						  </tr>
							<tr>
                              <td height="29" valign="middle" class="boldEleven"><strong>Key Number <strong> </strong> <strong> <span class="style11 style19 style3">*</span> </strong> </strong>
                                <input
									type="hidden" name="filename" value="VehicleInfo" />
                                <input
									type="hidden" name="actionS" value="<%=actionS %>" />
                                <input
									type="hidden" name="id" value="<%=vid %>" /></td>
							  <td valign="top" class="boldEleven"><input name="keynumber" type="text" class="formText135" id="keynumber" value="<%=keynumber%>" size="30" maxlength="50" /></td>
						  </tr>
							
							<tr>
								<td height="30" colspan="2" valign="top"><table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="56"><input name="submit" type="submit"
											id="submit" class="buttonbold" value="Submit"   accesskey="s"   ></td>
										<td width="56">
										<div align="center"><input name="button" type="button"
											class="buttonbold"  value="Close"   accesskey="c" 
											onClick="redirect('VehicleInfo.jsp')">
										</div>										</td>
									</tr>
								</table>							 			</tr>
						</tbody>
					</table>
					</td>
					<td nowrap="nowrap" width="4">  </td>
					<td class="BorderLine" width="1">  </td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6">  </td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0">  </td>
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
