<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>

<%
try
{
%>
 
 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: COMMON ::</title>
<%@ include file="index.jsp"%>
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>
<script language="JavaScript"> 
function validate()
{
	try
	{	
		 
	 
		 if(	
			checkNull('compname','Enter Company Name..') 
			&& checkNull('shortname','Enter Company Short Name..')
			&& checkNull('legalname','Enter Legal Name..') 
			&& checkNull('street','Enter Street Name..') 
			&& checkNullSelect( "country","Select Country" ,'0')
			&& checkNullSelect( "state","Select State" ,'0')
			&& checkNullSelect( "district","Select District" ,'0')
			&& checkNullSelect( "city","Select City" ,'0') 
			&& checkNull('pin','Enter Postal Code..') 
			&& checkNull('areacode','Enter Area Code..') 
			&& checkNull('phone','Enter Phone..') 
			&& chkemail1("email",'Entert the correct E-mail Address...')
			&& checkNull('gstnumber','Enter GST No..') 
			&& checkNull('pannumber','Enter PAN No..') 
			/*&& checkNull('tngsno','Enter TNGS No..') 
			&& checkNull('cstno','Enter CST No..') 
			&& checkNull('tinno','Enter TIN No..') 
			&& checkNull('servicetaxno','Enter Service Tax No ..') 
			 */
			)
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
		alert(err);
		return false;
	}	 
}      
 </script>


<script language="javascript" src="../JavaScript/smartcommon/onChangeCountry.js"></script>
<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>
 
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function lookup(inputString) 
{
	if(inputString.length == 0) 
	{
		$('#suggestions').hide();
	} 
	else 
	{
		$.post("../JavaScript/pincodes.jsp", {queryString: ""+inputString+""}, function(data)
		{
			if(data.length >0) 
			{
				$('#suggestions').show();
				$('#autoSuggestionsList').html(data);
			}
		});
	}
}



 
function fill(thisValue) 
{
	var listArray = thisValue.split("/");
	setOptionValue('country',listArray[0]);
	
	var _targ=document.getElementsByName('state')[0];       
	 _targ.options.length=0;
	 _targ.options[0]=new Option(listArray[3],listArray[2]);  
	
	var _targ1=document.getElementsByName('district')[0];       
	 _targ1.options.length=0;
	 _targ1.options[0]=new Option(listArray[5],listArray[4]);  

	var _targ2=document.getElementsByName('city')[0];       
	 _targ2.options.length=0;
	 _targ2.options[0]=new Option(listArray[7],listArray[6]);  
	 
	document.getElementById('pin').value=listArray[8];
	$('#pin').val(listArray[8]);
	$('#suggestions').hide();
	//setTimeout("$('#suggestions').hide();", 200);
}



</script>
<style type="text/css">
body {
font-family: Helvetica;
font-size: 13px;
color: #000;
}
h3 {
margin: 0px;
padding: 0px;
}


.suggestionsBox 
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
.suggestionList 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList li 
{
	margin: 0px 0px 3px 0px;
	padding: 1px;
	cursor: pointer;
}

.suggestionList li:hover {
background-color: #99cc99;
}
</style>

 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<body  onpaste="return false;" leftmargin="0" rightmargin="0" topmargin="0" >


<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return validate()"	>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td height="27">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="400"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" alt="" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" alt="" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
			        <td width="412"><table width="100%" align="center"
						border="0">
                      <!--DWLayoutTable-->
                      <tbody>
                        <tr>
                          <td height="16" colspan="2"  align="center" valign="top"
									class="boldThirteen">COMPANY INFORMATION
                            <%   
  	String action=request.getParameter("action1"); 
	String companyId="";;	
  	String companyName,legalName,street,city,district,state,country,pin;
  	String areacode,phone,fax,email,website,tngstno,cstno,regno,tinno;
    String servicetax,shortname,pannumber,pfnumber,gstnumber;
  	String red=""; 
	String elink="";
	String values="";
	String sql ="";
	String link="";
	String active="1";
	String actionStu="";
	if(action.equals("Edit"))
	{
		actionStu="GENcompanyEdit";
		companyId=request.getParameter("id");
		sql = " SELECT INT_COMPANYID,CHR_COMPANYNAME,CHR_LEGALNAME, ";
		sql = sql +" CHR_STREET,INT_CITYID,INT_DISTRICTID,INT_STATEID,INT_COUNTRYID,INT_PINCODE, ";
		sql = sql +" CHR_AREACODE,CHR_PHONE,CHR_FAX,CHR_EMAIL,CHR_WEBSITE,CHR_TNGSTNO,CHR_CSTNO,CHR_REGNO,CHR_TINNO,";
		sql = sql +" CHR_SERVICETAX,CHR_SHORTNAME,CHR_PANNO,CHR_PFNUMBER,INT_ACTIVE,CHR_GSTNO,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
		sql = sql +"  FROM com_m_company WHERE INT_COMPANYID="+companyId;
		String data[][] =  CommonFunctions.QueryExecute(sql);
		companyName=""+data[0][1];
		legalName=""+data[0][2];
		street=""+data[0][3];
		city=""+data[0][4];
		district=""+data[0][5];
		state=""+data[0][6];
		country=""+data[0][7];
		pin=""+data[0][8];
		areacode=""+data[0][9];
		phone=""+data[0][10];
		fax=""+data[0][11];
		email=""+data[0][12];
		website=""+data[0][13];
		tngstno=""+data[0][14];
		cstno=""+data[0][15];
		regno=""+data[0][16];
		tinno=""+data[0][17];
		servicetax=""+data[0][18];
		shortname=""+data[0][19];
		pannumber=""+data[0][20];
		pfnumber=""+data[0][21];
		active=""+data[0][22];
		gstnumber=""+data[0][23];
		elink=""; 
		red=" readonly=readonly ";
		values="Update";
		link=" onKeyUp=\"CheckUnique(this,'divunitname','com_m_company','CHR_COMPANYNAME')\"  ";
	}
	else
	{
		actionStu="GENcompanyAdd";
		companyName="";
		legalName="";
		street="";
		city="0";
		district="0";
		state="0";
		country="0";
		pin="";
		areacode="";
		phone="";
		fax="";
		email="";
		website="";
		tngstno="";
		cstno="";
		regno="";
		tinno="";
		servicetax="";
		shortname="";
		pannumber="";
		pfnumber="";
		gstnumber="";
		red =" onKeyUp =\"CheckUnique(this,'soValid2','com_m_company','CHR_SHORTNAME')\"  ";
		active="1";
		values="Add";
		link=" onKeyUp=\"CheckUnique(this,'divunitname','com_m_company','CHR_COMPANYNAME')\"  ";
	}   
    
		
%></td>
                        </tr>
                        <tr>
                          <td height="19" colspan="2"  align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory </span></td>
                        </tr>
                         
                        <tr>
                          <td height="17" class="boldEleven">Company Name <span
									class="bolddeepred">* </span></td>
                          <td width="317"  align="left"><input type="type" name="compname" id="compname" class="formText135" value="<%=companyName%>" 	 <%=link%>  maxlength="50"  size='35'   onBlur="upperMe(this)"   />
                             <div id='divunitname'></div>							  </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Short Name <span
									class="bolddeepred">* </span></td>
                          <td  align="left"><input
									name="shortname" type="text" class="formText135" id="shortname"
									 value="<%=shortname%>"
									size="35" maxlength="3" <%=red%>   onBlur="upperMe(this)"       />
                              <div id="soValid2"></div></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Legal Name<span class="bolddeepred"> *</span></td>
                          <td  align="left"><input type="text"
									name="legalname" id="legalname" class="formText135" value="<%=legalName%>"
									size="35" maxlength="50"
									 onBlur="upperMe(this)"   /></td>
                        </tr>
                        <tr>
                          <td width="195" height="17" valign="top" class="boldEleven">Street<span class="bolddeepred"> *</span></td>
                          <td  align="left" class="bolddeepblue"><textarea name="street" cols="30" rows="5" class="formText135"
									id="street" onKeyPress="textArea('street','400')"    onBlur="upperMe(this)"   ><%=street%></textarea>                          </td>
                        </tr>
                         
                        <tr>
                          <td height="17" class="boldEleven">Country <span class="bolddeepred">*</span></td>
                          <td class="boldEleven"><select name="country" id="country" style="width:170" onChange="onChangeCountry()">
                            <option value="0">Select Country</option>
                            <%
	 		String readData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<readData.length;i++)
				out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
	 %>
                          </select></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">State<span class="bolddeepred"> *</span></td>
                          <td class="errormessage"><select name="state" id="state" style="width:170" onChange="LoadSelectDistrict()">
                            <option value="0" selected="selected">Select State</option>
                            <%
						
						if(!"Add".equals(action))
	  					{
							String stateData[][] =  CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID=" +country);
							if(stateData.length>0)
								for(int u=0;u<stateData.length;u++)
									out.print("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
						}
					%>
                          </select></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">District<span class="bolddeepred"> *</span></td>
                          <td class="boldEleven"><span class="bolddeepblue">
                            <select name="district" id="district" style="width:170" onChange=" LoadSelectCity()">
                              <option value="0" selected="selected">Select District</option>
                              <%
						
						if(!"Add".equals(action))
	  					{
							String districtData[][] =  CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT FROM com_m_district WHERE INT_STATEID=" +state);
							if(districtData.length>0)
								for(int u=0;u<districtData.length;u++)
									out.print("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
						}
					%>
                            </select>
                          </span> </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">City<span class="bolddeepred"> *</span></td>
                          <td class="boldEleven"><span class="bolddeepblue">
							    <select name="city" id="city" style="width:170" onChange="AssignPincode('pin')">
                                  <option value="0" selected="selected">Select City</option>
                                  <%
						
						if(!"Add".equals(action))
	  					{
							String cityData[][] =  CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +district);
							if(cityData.length>0)
								for(int u=0;u<cityData.length;u++)
									out.print("<option value='"+cityData[u][0]+"'>"+cityData[u][1]+"</option>");
						}
					%>
                                </select>
							    <%
	 if(!"Add".equals(action))
	  {
	  %>
                                <script language="JavaScript" type="text/javascript">
	   		setOptionValue('country',"<%=country%>");
			setOptionValue('state',"<%=state%>");
			setOptionValue('district',"<%=district%>");
			setOptionValue('city',"<%=city%>");
			
	 
   		                        </script>
                                <%	
	  }
	  %>
</span> </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Postal <span class="bolddeepred">*</span></td>
                          <td  align="left" class="bolddeepblue"><input name="pin" type="text" class="formText135" id="pin" onKeyPress="return numeric_only(event,'pin','7')"    onKeyUp="lookup(this.value)" value="<%=pin%>" size="10" 									maxlength="6" />
                          <br />
                          <div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
                            <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                          </div>				</td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Area Code<span class="bolddeepred"> *</span></td>
                          <td  align="left" class="bolddeepblue"><input
									type="text" name="areacode"   id="areacode" class="formText135"
									value="<%=areacode%>" maxlength="8"
								  size="35"  onKeyPress="return numeric_only(event,'areacode','12')"   /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Phone <span class="bolddeepred">*</span></td>
                          <td  align="left" class="bolddeepblue"><input type="text" name="phone"  id="phone" class="formText135" value="<%=phone%>" size="35" maxlength="11" onKeyPress="return numeric_only(event,'phone','15');" /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Fax</td>
                          <td  align="left" class="bolddeepblue"><input
									type="text" class="formText135" value="<%=fax%>" name="fax"
									size="35" maxlength="12" onKeyPress="return numeric_only(event,'fax','18')"  /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">E-Mail</td>
                          <td  align="left" class="bolddeepblue"><input
									type="email" name="email"  id="email" class="formText135" value="<%=email%>"
									maxlength="50" size="35"   /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Website</td>
                          <td  align="left" class="bolddeepblue"><input	type="url" name="website" class="formText135"
									value="<%=website%>" maxlength="50"
									size="35" />                          </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">GST Number <span class="bolddeepred">*</span></td>
                          <td  align="left" class="bolddeepblue"><input name="gstnumber"
									type="text" class="formText135" id="gstnumber" title="Enter the GST Number" value="<%=gstnumber%>" size="35"
									maxlength="30"></td>
                        </tr>
						<tr>
                          <td height="17" class="boldEleven">PAN Number <span class="bolddeepred">*</span></td>
                          <td  align="left" class="bolddeepblue"><input name="pannumber"
									type="text" class="formText135" id="pannumber" value="<%=pannumber%>" size="35"
									maxlength="50"    onBlur="upperMe(this)"   /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Register No <span
									class="bolddeepred"></span></td>
                          <td  align="left" class="bolddeepblue"><input
									type="text" name="regno" id="regno" class="formText135"
									value="<%=regno%>"  
									maxlength="50" size="35"    onBlur="upperMe(this)"   /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">TNGS No</td>
                          <td  align="left" class="bolddeepblue"><input
									type="text" name="tngsno" id="tngsno" class="formText135"
									value="<%=tngstno%>"  
									maxlength="50" size="35"    onBlur="upperMe(this)"   /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">CST No</td>
                          <td  align="left" class="bolddeepblue"><input
									type="text" name="cstno" id="cstno" class="formText135"
									value="<%=cstno%>"  
									maxlength="50" size="35"    onBlur="upperMe(this)"   /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">TIN No</td>
                          <td  align="left" class="bolddeepblue"><input
									type="text" name="tinno" id="tinno" class="formText135"   onBlur="upperMe(this)"   
									value="<%=tinno%>"  
									maxlength="50" size="35"
									onkeyup="LoadUniqueCheck('tinno', 'UniqueId1', 'com_m_company', 'CHR_TINNO', 'submit')" />
                              <div id="UniqueId1"></div></td>
                        </tr>
                        <tr>
                          <td height="17" valign="top" class="boldEleven">Service Tax No</td>
                          <td  align="left" class="bolddeepblue"><input
									type="text" name="servicetaxno" id="servicetaxno" class="formText135"
									value="<%=servicetax%>"  
									maxlength="50" size="35"   onBlur="upperMe(this)"   
									onkeyup="LoadUniqueCheck('servicetaxno', 'UniqueId1', 'com_m_company', 'CHR_SERVICETAX', 'submit')" /></td>
                        </tr>
                        
                        <tr>
                          <td height="17" class="boldEleven">PF Number
                            <input name="actionS" type="hidden" value="<%=actionStu %>"   />
                              <input name="rowid" type="hidden" id="rowid" value="<%=companyId%>" />
                              <input type="hidden" name="filename" value="Company" /></td>
                          <td  align="left" class="bolddeepblue"><input name="pfnumber" value="<%=pfnumber%>" class="formText135" type="text" id="pfnumber" size="35" maxlength="25"    onBlur="upperMe(this)"   /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Active
                         
                          <%
	                   String test2="";
                       String test1="";
                       if("1".equals(active))
                    	   test1=" checked=checked "; 
					  else
					   		test2=" checked=checked ";
						
						 
                    		
                    %>                          </td>
                          <td  align="left" class="bolddeepblue"><table width="80" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td><span class="boldEleven">
                                <input type="radio" name="active" id="active" value="1" <%=test1%> />
                              </span></td>
                              <td class="boldEleven">Yes</td>
                              <td><span class="boldEleven">
                                <input type="radio" name="active" id="active2" value="0" <%=test2%> />
                              </span></td>
                              <td class="boldEleven">No</td>
                            </tr>
                          </table></td>
                        </tr>
                        <tr>
                          <td height="30" colspan="2"  valign="top"><table width="161" border="0" align="center" cellpadding="1" cellspacing="1">
                              <tr>
                                <td width="56"><div align="center">
                                    <input name="Submit" type="submit" id="Submit" class="buttonbold" value="<%=values%>" />
                                </div></td>
                                <td width="56"><div align="center">
                                    <input name="close" type="button" class="buttonbold"   value="Close"   accesskey="c"  onClick="redirect('CompanyView.jsp')" />
                                </div></td>
                              </tr>
                          </table></td>
                        </tr>
                      </tbody>
                      <input type="hidden" name="mobileBookingOption" />
                    </table></td>
			        <td nowrap="nowrap" width="4"><spacer height="1" width="1" 
                        type="block" /></td>
            <td class="BorderLine" width="1"><spacer height="1" 
                        width="1" type="block" /></td>
          </tr>
          <tr>
            <td colspan="2" rowspan="2"><img height="7" src="../Image/Smart Inventory/BLCorner.gif" width="7" alt="" /></td>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
            <td colspan="2" rowspan="2"><img height="7" src="../Image/Smart Inventory/BRCorner.gif" width="7" alt="" /></td>
          </tr>
          <tr>
            <td class="BorderLine" height="0"><spacer height="1" width="1" type="block" /></td>
          </tr>
        </tbody>
      </table>
</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr><td>
      </td></tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>
   

								</form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
