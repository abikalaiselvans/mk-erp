<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.AttBranch"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
<jsp:useBean id="conBean" class="DBConnection.DBCon" />
<%
try
{
%>
<%!
  String branchId,company,companyId,test1="",test2="",action;
	int active;
  String branchName,legalName,street,city,state,postal,country;
  String areacode,phone,fax,email,website,tngstno,cstno,regno,tinno,localtax,pannumber;
  float itemPrice;
  Connection con;
  ResultSet rs;
  Statement st;
  String actionStu;
  
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>

<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
	 
	 

 
function Validate()
{
 		 
		if(
			checkNullSelect('companyId','Select Company Name..', '0')
			&& checkNull('branchName', 'Enter Branch Name..')
			&& checkNull('legalname', 'Enter Legal Name..')
			&& checkNull('street', 'Enter Street..')
			&& checkNull('city', 'Enter City..')
			&& checkNullSelect('country','Select Country..', '0')
			&& checkNullSelect('state','Select State..', '0')
			&& checkNull('postal', 'Enter PIN Number..')
			&& checkNull('areacode', 'Enter Area Code..')
			&& checkNull('phone', 'Enter Phone..')
			&& chkemail("email")
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

</head>
<body onpaste="return false;" leftmargin="0" rightmargin="0"
	topmargin="0">
<form AUTOCOMPLETE="off" name="casesheet" method="post"
	onSubmit="return Validate()" action="../SmartLoginAuth">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><%@ include file="insert.jsp"%></td>
	</tr>
	<tr>
		<td height="82">
		<%     
    
  	String action=request.getParameter("action1");   
	 
	if(action.equals("Edit"))
	{
		 actionStu="COMbranchEdit";
		 branchId=request.getParameter("branchId");
		 con=conBean.getConnection();
		 st=con.createStatement();
		 String qry="SELECT INT_BRANCHID,INT_COMPANYID,CHR_BRANCHNAME,CHR_LEGALNAME,CHR_STREET,CHR_CITY,  CHR_STATE, CHR_POSTAL, CHR_COUNTRY, CHR_AREACODE,CHR_PHONE,CHR_FAX,CHR_EMAIL,   CHR_WEBSITE,CHR_TNGSTNO,CHR_CSTNO,CHR_REGNO,CHR_TINNO,INT_ACTIVE,CHR_LOCALTAXNO,CHR_PANNO,CHR_USRNAME,  DT_UPDATEDATE,CHR_UPDATESTATUS  FROM  com_m_branch  WHERE INT_BRANCHID="+branchId;
		  rs=st.executeQuery(qry);
		   
		 if(rs.next())
		 {	 
				companyId=""+rs.getString("INT_COMPANYID");
				branchName=""+rs.getString("CHR_BRANCHNAME");
        		legalName=""+rs.getString("CHR_LEGALNAME");
        		street=""+rs.getString("CHR_STREET");
        		city=""+rs.getString("CHR_CITY");
        		state=""+rs.getString("CHR_STATE");
        		postal=""+rs.getString("CHR_POSTAL");
        		if(postal.equals("0"))
        			postal="";
        		country=""+rs.getString("CHR_COUNTRY");
        		areacode=""+rs.getString("CHR_AREACODE");
        		phone=""+rs.getString("CHR_PHONE");
        		fax=""+rs.getString("CHR_FAX");
        		email=""+rs.getString("CHR_EMAIL");
        		website=""+rs.getString("CHR_WEBSITE");
        		tngstno=""+rs.getString("CHR_TNGSTNO");
        		cstno=""+rs.getString("CHR_CSTNO");
        		regno=""+rs.getString("CHR_REGNO");
        		tinno=""+rs.getString("CHR_TINNO");
        		active=rs.getInt("INT_ACTIVE");		 
				localtax=""+rs.getString("CHR_LOCALTAXNO");
				pannumber =""+rs.getString("CHR_PANNO");
        		
	         }
	}		 
	else
	{
		actionStu="COMbranchAdd";
		companyId="";
		branchName="";
		legalName="";
		street="";
		city="";
		state="";
		postal="";
		country="";
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
		active=1;
	}
%>
		</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="424"
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
					<td width="412">
					<table cellspacing="2" cellpadding="2" width="500" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>

							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Company Name <span
									class="bolddeepred">* </span></td>
								<td width="327"><select name='companyId' id='companyId'>
									<option value="0">Select</option>

									<%
					String sql="SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company ";
					String	company[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					for(int i=0;i<company.length;i++)
						if(companyId.equals(company[i][0]))
	 						out.println("<option selected= 'selected' value='"+company[i][0]+"'>"+company[i][1]+"</option>");	
						else
							out.println("<option  value='"+company[i][0]+"'>"+company[i][1]+"</option>");		
							
			%>
								</select></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Branch Name <span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left"><input type="type"
									name="branchName" id="branchName" class="formText135"
									value="<%=branchName%>" maxlength=50 size=35> <span
									class="boldEleven"><span class="bolddeepred"><em
									class="boldElevenlink">( Trichy)</em></span></span>
								<div id="UniqueId"></div>
								</td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Legal Name<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left"><input type="text"
									name="legalname" id="legalname" class="formText135"
									value="<%=legalName%>" maxlength=50 size=35> <span
									class="boldEleven"><strong><em
									class="boldElevenlink">( </em><span class="boldElevenlink">IT
								Computer Solutions</span> <em class="boldElevenlink">)</em> </strong></span></td>
							</tr>

							<tr>
								<td width="159" height="17" valign="top" class="boldEleven">Street<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><textarea
									name="street" id="street" cols="30" rows="5"
									class="formText135"><%=street%></textarea></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">City<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="city" id="city" class="formText135"
									value="<%=city%>" maxlength=50 size=35> &nbsp;</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Country<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left"><select name="country"
									id="country">
									<option value="0">Select</option>
									<%
	  String sql1="SELECT INT_COUNTRYID,CHR_COUNTRYNAME FROM com_m_country ORDER BY  CHR_COUNTRYNAME ";
	  String countrydata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);
	  for(int i=0;i<countrydata.length;i++)
	  	if(country.equals(countrydata[i][0]))
	    	out.println("<option  selected='selected' value="+countrydata[i][0]+">"+countrydata[i][1]+"</option>");		
		else
			out.println("<option value="+countrydata[i][0]+">"+countrydata[i][1]+"</option>");			
	                                        %>

								</select></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">State<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left"><select name="state"
									id="state">
									<option value="0">Select</option>
									<%
String state1data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM  com_m_state  ORDER BY CHR_STATENAME");
for(int h=0;h<state1data.length;h++)
	if(state.equals(state1data[h][0]))
		out.print("<option  selected='selected' value='"+state1data[h][0]+"'>"+state1data[h][1]+"</option>");
	else
		out.print("<option value='"+state1data[h][0]+"'>"+state1data[h][1]+"</option>");	

%>
								</select></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Postal<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="postal" id="postal" class="formText135"
									value="<%=postal%>" maxlength=6 size=35
									onKeyPress="numericValue('postal','6')"></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Area Code<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="areacode" id="areacode" class="formText135"
									value="<%=areacode%>"
									onKeyPress="numericValue('areacode', '10')" maxlength=10
									size=35></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Phone<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="phone" id="phone" class="formText135"
									value="<%=phone%>" maxlength=30 size=35></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Fax</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" class="formText135" value="<%=fax%>" name="fax"
									id="fax" maxlength=30 size=35></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">E-Mail</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="email" id="email" class="formText135"
									value="<%=email%>" maxlength=50 size=35></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Website</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="website" class="formText135" id="website"
									value="<%=website%>" maxlength=50 size=35></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Register No</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="regno" id="regno" class="formText135"
									value="<%=regno%>" maxlength=30 size=35></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">TNGST No</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="tngsno" id="tngsno" class="formText135"
									value="<%=tngstno%>" maxlength=30 size=35></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">CST No</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="cstno" id="cstno" class="formText135"
									value="<%=cstno%>" maxlength=30 size=35></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Tin No</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="tinno" id="tinno" class="formText135"
									value="<%=tinno%>" maxlength=30 size=35></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Local Tax
								No</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									name="localtax" type="text" class="formText135" id="localtax"
									value="<%=localtax%>" size=35 maxlength=30></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">PAN Number</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									name="pannumber" type="text" class="formText135" id="pannumber"
									value="<%=pannumber%>" size=35 maxlength=30></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Live Status</td>
								<td colspan="2" align="left" class="boldEleven">
								<%
	                   test2="";
                       test1="";
                       if(active==0)
                    	   test2="checked=checked";
                       else if(active==1)
                    	   test1="checked=checked";
                    
                    %> <input type="radio" name="active" id="active"
									value="1" <%=test1%>>Yes <input type="radio"
									name="active" id="active" value="0" <%=test2%>>No <input
									type="hidden" name="filename" value="Branch" /> <input
									type="hidden" name="actionS" value="<%=actionStu %>" /> <input
									type="hidden" name="branchId" value="<%=branchId %>" /> <input
									name="path" type="hidden" id="path" value="<%=path%>"></td>
							</tr>

							<tr>
								<td height="30" colspan="2" valign="top">
								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="56"><input name="Submit" type="submit"
											id="Submit" class="buttonbold" value="Submit" accesskey="s"></td>
										<td width="56" colspan="2">
										<div align="center"><input name="button" type="button"
											id="button" class="buttonbold" value="Close" accesskey="c"
											onClick="redirect('BranchView.jsp?&path=<%=path %>')">
										</div>
										</td>
									</tr>
								</table>
							</tr>

						</tbody>
					</table>
					</td>
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
