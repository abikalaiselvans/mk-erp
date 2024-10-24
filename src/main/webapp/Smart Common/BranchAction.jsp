<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>
<%
try
{
%>
 
<% 
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: COMMON ::</title>
<%@ include file="index.jsp"%>
 
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
	 
	 

 
function Validate()
{
 		 
		if(
			checkNullSelect('companyid','Select Company Name..', '0')
			&& checkNull('branchname', 'Enter Branch Name..')
			&& checkNull('legalname', 'Enter Legal Name..')
			&& checkNull('street', 'Enter Street..')
			&& checkNullSelect( "country","Select Country" ,'0')
			&& checkNullSelect( "state","Select State" ,'0')
			&& checkNullSelect( "district","Select District" ,'0')
			&& checkNullSelect( "city","Select City" ,'0') 
			&& checkNull('pin','Enter Postal Code..') 
			&& checkNull('areacode','Enter Area Code..') 
			&& checkNull('areacode', 'Enter Area Code..')
			&& checkNull('phone', 'Enter Phone..')
			&& chkemail1("email",'Entert the correct E-mail Address...')
			&& checkNull('gstnumber','Enter GST No..') 
			&& checkNull('pannumber','Enter PAN No..') 
		)
		{

  			return true;			
		}
		else
		{

			return false;
		}	    
 }
 
</script>
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
	setTimeout("$('#suggestions').hide();", 200);
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
<body  onpaste="return false;" leftmargin="0" rightmargin="0" topmargin="0">
<form  AUTOCOMPLETE = "off"   name="casesheet" method="post" onSubmit="return Validate()" 	action="../SmartLoginAuth">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 
	<tr>
	  <td height="19">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="499"
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
					<td width="7"><spacer height="1" width="1" type="block" /></td>
				    <td width="483"><table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
                      <!--DWLayoutTable-->
                      <tbody>
                        <tr>
                          <td height="17" colspan="2" class="boldEleven"><div align="center">BRANCH INFORMATIONS
                            <%     
    
  	String action=request.getParameter("action1");   
	String rowid="",company="",companyid="",test1="",test2="" ;
	String branchname="",legalName="",street="",country="0" ,state="0",district="0",city="",pin="";
	String areacode="",phone="",fax="",email="",website="";
	String tngstno="",cstno="",regno="",tinno="",localtax="",pannumber="",gstnumber="",cinnumber="";
	String actionStu="";
	int active=1;
	String buttonvalue="";
	String edlink="";
	String sql="";
	if(action.equals("Edit"))
	{
		actionStu="GENbranchEdit";
		buttonvalue="Update";
		rowid=request.getParameter("rowid");
		sql = " SELECT	";
		sql =sql+ " INT_BRANCHID,INT_COMPANYID,CHR_BRANCHNAME,CHR_LEGALNAME,CHR_STREET,INT_CITYID,INT_DISTRICTID,INT_STATEID, ";
		sql =sql+ " INT_COUNTRYID,INT_PINCODE,CHR_AREACODE,CHR_PHONE,CHR_FAX,CHR_EMAIL,CHR_WEBSITE,CHR_TNGSTNO,CHR_CSTNO, ";
		sql =sql+ " CHR_REGNO,CHR_TINNO,CHR_LOCALTAXNO,CHR_PANNO,INT_ACTIVE,CHR_CIN_NUMBER,CHR_GSTNO, ";	
		sql =sql+ " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
		sql =sql+ " FROM  com_m_branch  WHERE INT_BRANCHID="+rowid; 
		
		String data[][]=  CommonFunctions.QueryExecute(sql);
		 
		companyid=data[0][1];
		branchname=data[0][2];
		legalName=data[0][3];
		street=data[0][4];
		city=data[0][5];
		district=data[0][6];
		state=data[0][7];
		country=data[0][8];
		pin=data[0][9];
		if(pin.equals("0"))
			pin="";
		areacode=data[0][10];
		phone=data[0][11];
		fax=data[0][12];
		email=data[0][13];
		website=data[0][14];
		tngstno=data[0][15];
		cstno=data[0][16];
		regno=data[0][17];
		tinno=data[0][18];
		localtax=data[0][19];
		pannumber =data[0][20];
		active=Integer.parseInt(data[0][21]);
		cinnumber=data[0][22];
		gstnumber=data[0][23];
		edlink=" readonly = 'readonly' ";
		
		  
	}		 
	 else
	{
		actionStu="GENbranchAdd";
		buttonvalue="Add";
		companyid="0";
		branchname="";
		legalName="";
		street="";
		city="";
		state="0";
		pin="";
		country="0";
		areacode="";
		phone="";
		fax="";
		email="";
		website="";
		tngstno="";
		cstno="";
		regno="";
		tinno="";
		localtax="";
		pannumber="";
		cinnumber="";
		gstnumber="";
		active=1;
		 
	} 
%>
                          </div></td>
                        </tr>
                        <tr>
                          <td height="17" colspan="2" class="boldEleven"><div align="right"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory</span></div></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Company Name <span
									class="bolddeepred">* </span></td>
                          <td width="340"><select name='companyid' id='companyid'>
                              <option value="0">Select Company</option>
                              <%
				String	companydata[][]= CommonFunctions.QueryExecute("SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company ");
				for(int i=0;i<companydata.length;i++)
					out.println("<option  value='"+companydata[i][0]+"'>"+companydata[i][1]+"</option>");		
									
					%>
                            </select>
                          <script language="javascript">setOptionValue('companyid','<%=companyid%>')</script>                          </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Branch Name <span
									class="bolddeepred">*</span></td>
                          <td colspan="2" align="left"><input type="type"
									name="branchname" id="branchname" class="formText135"
									value="<%=branchname%>"  <%=edlink%> maxlength="50"
									size="35"    onBlur="upperMe(this)"   />
                              <span class="boldEleven"><span
									class="bolddeepred"><em class="boldElevenlink">(
                                Branch name should same for </em></span></span><span class="boldred"><em class="boldElevenlink">Office Name</em></span><span class="boldEleven"><span
									class="bolddeepred"><em class="boldElevenlink"> )</em></span></span>
                                <div id="UniqueId"></div></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Legal Name<span class="bolddeepred">*</span></td>
                          <td colspan="2" align="left"><input type="text" name="legalname"  id="legalname" class="formText135" value="<%=legalName%>" 	maxlength="50" size="35"     onBlur="upperMe(this)"   />
                              <span class="boldEleven"><strong><em
									class="boldElevenlink">(</em><span class="boldElevenlink">                              Computer Solutions</span> <em class="boldElevenlink">)</em> </strong></span></td>
                        </tr>
                        <tr>
                          <td width="129" height="17" valign="top" class="boldEleven">Street<span class="bolddeepred">*</span></td>
                          <td colspan="2" align="left" class="bolddeepblue"><textarea
									name="street"  id="street" cols="30"  onKeyPress="textArea('street','400')"   rows="5" class="formText135"    onBlur="upperMe(this)"   ><%=street%></textarea>                          </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Country <span class="bolddeepred">*</span></td>
                          <td class="boldEleven"><select name="country" id="country" style="width:170" onChange="LoadSelectState()">
                              <option value="0">Select Country</option>
                              <%
	 		String readData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<readData.length;i++)
				out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
	 %>
                          </select></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">State<span class="bolddeepred"> *</span></td>
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
                          <td class="boldEleven">District<span class="bolddeepred"> *</span></td>
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
                          <td class="boldEleven">City<span class="bolddeepred"> *</span></td>
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
                          <td class="boldEleven">Postal <span class="bolddeepred">*</span></td>
                          <td  align="left" class="bolddeepblue"><input name="pin" type="text" class="formText135" id="pin" onKeyPress="return numeric_only(event,'pin','7')"    onKeyUp="lookup(this.value),fill();" value="<%=pin%>" size="10" 									maxlength="6" />
                              <br />
                              <div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
                                <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                              </div></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Area Code<span class="bolddeepred">*</span></td>
                          <td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="areacode" id="areacode" class="formText135"
									value="<%=areacode%>"  onKeyPress="return numeric_only(event,'areacode','10')"  
									  maxlength="8"
									size="35" /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Phone<span class="bolddeepred">*</span></td>
                          <td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="phone"   id="phone" class="formText135" value="<%=phone%>"
									maxlength="15" size="35"  onKeyPress="return numeric_only(event,'phone','20')"   /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Fax</td>
                          <td colspan="2" align="left" class="bolddeepblue"><input
									type="text" class="formText135" value="<%=fax%>" name="fax" id="fax"
									maxlength="30" size="35" onKeyPress="return numeric_only(event,'fax','10')" /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">E-Mail</td>
                          <td colspan="2" align="left" class="bolddeepblue"><input
									type="email" name="email"  id="email"  class="formText135" value="<%=email%>"
									maxlength="50" size="35" /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Website</td>
                          <td colspan="2" align="left" class="bolddeepblue"><input
									type="url" name="website" class="formText135"  id="website"
									value="<%=website%>" maxlength="50" size="35" /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">GST Number <span class="bolddeepred">*</span></td>
                          <td  align="left" class="bolddeepblue"><input name="gstnumber"
									type="text" class="formText135" id="gstnumber" title="Enter the GST Number" value="<%=gstnumber%>" size="35"
									maxlength="30"></td>
                        </tr>
						<tr>
                          <td height="17" class="boldEleven">PAN Number  <span class="bolddeepred">*</span></td>
                          <td colspan="2" align="left" class="bolddeepblue"><input name="pannumber"
									type="text" class="formText135" id="pannumber" value="<%=pannumber%>" size="35"
									maxlength="30"     onBlur="upperMe(this)"   /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Register No</td>
                          <td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="regno" id="regno" class="formText135"
									value="<%=regno%>" maxlength="30" size="35"     onBlur="upperMe(this)"   /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">TNGST No</td>
                          <td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="tngsno"  id="tngsno" class="formText135"
									value="<%=tngstno%>" maxlength="30" size="35"     onBlur="upperMe(this)"   /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">CST No</td>
                          <td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="cstno"  id="cstno" class="formText135" value="<%=cstno%>"
									maxlength="30" size="35"     onBlur="upperMe(this)"   /></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Tin No</td>
                          <td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="tinno"  id="tinno" class="formText135" value="<%=tinno%>"
									maxlength="30" size="35"     onBlur="upperMe(this)"   /></td>
                        </tr>
                        <tr>
                          <td height="17" valign="top" class="boldEleven">Local Tax No </td>
                          <td colspan="2" align="left" class="bolddeepblue"><input name="localtax" 
									type="text" class="formText135" id="localtax" value="<%=localtax%>" size="35"
									maxlength="30"     onBlur="upperMe(this)"   /></td>
                        </tr>
                        
                        <tr>
                          <td height="17" class="boldEleven">CIN Number </td>
                          <td colspan="2" align="left" class="boldEleven"><span class="bolddeepblue">
                            <input name="cinnumber"
									type="text" class="formText135" id="cinnumber" value="<%=cinnumber%>" size="35"
									maxlength="30"     onBlur="upperMe(this)"   />
                          </span></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Live Status</td>
                          <td colspan="2" align="left" class="boldEleven"><%
	                   test2="";
                       test1="";
                       if(active==0)
                    	   test2="checked=checked";
                       else if(active==1)
                    	   test1="checked=checked"; 
                    
                    %>
                              <input type="radio" name="active" id="active" value="1" <%=test1%> />
                            Yes
                            <input type="radio" name="active" id="active" value="0"	<%=test2%> />
                            No
                            <input type="hidden" name="filename" value="Branch" />
                            <input type="hidden" name="actionS" value="<%=actionStu %>" />
                            <input type="hidden" name="rowid" value="<%=rowid %>" />                          </td>
                        </tr>
                        <tr>
                          <td height="30" colspan="2"  valign="top"><table border="0" align="center" cellpadding="1" cellspacing="1">
                              <tr>
                                <td width="56"><input name="Submit" type="submit" id="Submit" class="buttonbold" value="<%=buttonvalue%>" /></td>
                                <td width="56" colspan="2"><div align="center">
                                    <input name="button" type="button" id="button" class="buttonbold"  value="Close"   accesskey="c"  	onclick="redirect('BranchView.jsp')" />
                                </div></td>
                              </tr>
                          </table></td>
                        </tr>
                      </tbody>
                    </table></td>
				    <td nowrap="nowrap" width="7"><spacer height="1" width="1"
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
		<td></td>
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
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
