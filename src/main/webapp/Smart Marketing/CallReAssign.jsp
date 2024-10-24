<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Untitled Document</title>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");

 
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>

<script type="text/javascript">
 
function lookupbefore(othersid) 
{
	try
	{
		
			if(othersid.length == 0) 
			{
				$('#suggestions').hide();
			} 
			else 
			{
				$.post("../Smart Common/getEmployeeid.jsp", {queryString: ""+othersid+""}, function(data)
				{
					if(data.length >0) 
					{
						$('#suggestions').show();
						$('#autoSuggestionsList').html(data);
					}
				});
			}
		 
	}
	catch(err)
	{
		alert(err);
	}
}
function fill(thisValue) 
{
	 
	{		
		document.getElementById('othersid').value=thisValue;
		$('#othersid').val(thisValue);
		//$('#suggestions').hide();
		setTimeout("$('#suggestions').hide();", 1000);
	}
}
</script>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");

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


<script language="javascript">
function validate()
{
	try
	{
		if( checkNull("othersid","Enter tramsfer employee id") )
			return true;
		else
			return false;	
	}
	catch(err)
	{
		alert(err)
		return false;
	}
}
</script>
<body onselectstart="return false" onpaste="return false;" onCopy="return false" >


<form action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return validate()">
  <p>&nbsp;</p>
  <table class="BackGround" cellspacing="0" cellpadding="0" width="500"
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
        <td  ><table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
          <tr>
            <td colspan="2" align="center" class="bold1">SFA CALLS REASSIGN
            <%
			String rowid = request.getParameter("rowid");
			String id="",Name="",actionS="",value="",dt="";
			String from="";
			String to="";
			String customerid="0";
			String customername="";
			String active="";
			String sql="",sql1="",sql2="";
			String calltype="";
			String desc ="";
			String status="";
			String nextcall ="";
			String Nfrom = "";
			String Nto = "";
			String dbvalue = "";
			String type="";
			String callvalue="";
			String department="";
			String cperson="";
			String quotationnumber="";
			String transactionid="";
			String winorlost="";
			String percentage="";
			String designination="";
			 
			 
			sql = "SELECT a.INT_CALLID,a.INT_CUSTOMERID,d.CHR_NAME,c.INT_CALLTYPEID,a.CHR_DESC,DATE_FORMAT(a.DAT_START,'%d-%m-%Y %H:%i:%s'),DATE_FORMAT(a.DAT_END,'%d-%m-%Y %H:%i:%s'), a.CHR_STATUS,DOU_VALUE,a.CHR_ADDEDTO_FUNNEL,a.CHR_DEPARTMENT,a.CHR_CONTACTPERSON,a.CHR_QUOTATION, a.CHR_TRANSACTIONID,a.CHR_WINLOST,a.INT_PERCENTAGE,a.CHR_DESIGINATION,FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID),a.CHR_EMPID  FROM mkt_t_daillycalls a,mkt_m_customerinfo b,mkt_k_calltype c,mkt_m_customername d WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_CALLTYPE=c.INT_CALLTYPEID AND b.INT_CUSTOMERNAMEID =d.INT_CUSTOMERNAMEID AND a.INT_CALLID= "+rowid;
 			//out.println(sql);	
			String data[][]=CommonFunctions.QueryExecute(sql);
			if(data.length>0)
				for(int i=0;i<8;i++)
					if("-".equals(data[0][i]))
						data[0][i] ="";
			id=data[0][0];
			customerid=data[0][1];
			customername=data[0][2];
			calltype=data[0][3];
			desc=data[0][4];
			Nfrom=data[0][5];
			Nto=data[0][6];
			status= data[0][7];
			callvalue=data[0][8];
			department=data[0][10];
			cperson=data[0][11];
			quotationnumber=data[0][12];
			transactionid=data[0][13];
			winorlost=data[0][14];
			percentage=data[0][15];
			designination=data[0][16];
			actionS="MKTScheduleEntryEdit";
			value="Update";
			%>
            
            <span class="boldEleven">
            <input type="hidden" name="filename" value="DaillyCalls" />
            <input type="hidden" name="actionS"  value="MKTDaillyCallsReAssign" />
            <input name="rowid" type="hidden" id="rowid" value="<%=rowid%>">
            <input type="hidden" name="fromempid" id="fromempid" value="<%=data[0][18]%>">
            </span></td>
          </tr>
           
          <tr >
           <td class="boldEleven">Customer</td>
                      <td class=""><%=customername%> </td>
                    </tr>
                    
					
					 
					<tr>
					  <td class="boldEleven">Department <span class="spc"> </span></td>
					  <td class="boldEleven"><%=department%></td>
				    </tr>
					<tr>
					  <td class="boldEleven">Desigination <span class="spc"> </span></td>
					  <td class="boldEleven"><%=designination%></td>
				    </tr>
					<tr>
					  <td class="boldEleven">Contact Person <span class="spc"> </span></td>
					  <td class="boldEleven"><%=cperson%></td>
				    </tr>
					<tr>
                      <td width="35%" align="left" valign="top" class="boldEleven">Description<span class="spc"> </span></td>
                      <td width="65%" align="left" valign="top" class="boldEleven"><%=desc%></td>
                    </tr>
					
                    <tr>
                      <td class="boldEleven">Starting Date<span class="spc"> </span></td>
                      <td class="boldEleven"><%=Nfrom%></td>
                    </tr>
                     
            <tr >
                      <td colspan="2" class="boldEleven" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr class="boldEleven">
                          <td class="copyright">From</td>
                          <td><%=data[0][17]%></td>
                          <td class="copyright">To <span class="errormessage">*</span></td>
                          <td>
                          <input name="othersid" type="text" class="formText135" id="othersid" size="30" maxlength="50"  onBlur="fill();"   onkeyup="upperMe(this),lookupbefore(this.value);" value="" >
                <div class="suggestionsBox" id="suggestions" style="display: none;">
					<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
				 </div></td>
                        </tr>
                      </table></td>
            </tr>
            <tr >
            <td class="boldEleven" > <span class="spc"></span></td>
            <td class="boldEleven">&nbsp; </td>
          </tr>
          <tr>
            <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
              <tr>
                <td><input name="Submit"  id="Submit" type="submit" class="buttonbold13"  value="Add"   accesskey="s"   ></td>
                <td><input name="Close" type="button" class="buttonbold13" id="Close"  value="Close"   accesskey="c"  onClick="javascript:window.close()"></td>
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
