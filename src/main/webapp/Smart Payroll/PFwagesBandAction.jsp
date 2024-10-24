<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

 <%
try
{
%>
<html>
<head>

<title> :: PAYROLL ::</title>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	if(
		 checkNull("pfmini","Enter PF Minimum ") 
		 && checkNull("pfmaxi","Enter PF Maximum")
		 && checkNull("esilimit","Enter ESI Limit")
		 && checkNullSelect("status","Select the Status",'0')
		 
		 )
		return true;
	else
		return false;	
 		
 } 	
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="index.jsp"%>
<jsp:include page="../JavaScript/dynamicStylesheet.jsp" flush="true" />

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
          <td class="BorderLine" height="0"> </td>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr> 
        </tr>
        <tr>
          <td class="BorderLine" width="1"> </td>
          <td width="6"> </td>
          <td width="412" valign="top">
		 
		    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"> PF WAGES
				
				    <%
							String action=request.getParameter("action1");
							String id="",Name="",Descri="",actionS="",value="";
							String desc1="",nam1="";
							String sql="";
							String link="";
							String pfmini,pfmaxi,esilimit,status;
							pfmini="";
							pfmaxi="";
							esilimit="";
							status="";
							if("Add".equals(action))
							{
								id="";Name=""; Descri="";
								actionS="PAYPFwagesBandAdd";
								value="Add";
								pfmini="0";
								pfmaxi="0";
								esilimit="0";
								status="0";
								
							}
							else
							{
								id="";Name=""; 
								id=request.getParameter("Rowid");
								sql = "   SELECT INT_ROWID,INT_PFMINIMUM_LIMIT,INT_PFMAXIMUM_LIMIT,INT_ESILIMIT, CHR_STATUS  FROM m_pf_setting   WHERE INT_ROWID="+id;
								String data[][] =  CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								pfmini=data[0][1];
								pfmaxi=data[0][2];
								esilimit=data[0][3];
								status=data[0][4];
								actionS="PAYPFwagesBandEdit";
								value="Update";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td width="31%" class="boldEleven">  PF Minimum<span class="boldred">*</span> </td>
                <td width="69%" class="boldEleven"> <input name="pfmini" type="text" class="formText135" id="pfmini" tabindex="26" onKeyPress="return numeric_only(event,'pfmini','10')" value="<%=pfmini%>" 	size="30" maxlength="7"  onpaste="return false;">
<div id='divunitname'></div></td>
              </tr>
              
              <tr>
                <td valign="top" class="boldEleven">PF Maximum </td>
                <td valign="top" class="boldEleven"><input name="pfmaxi" type="text" class="formText135" id="pfmaxi" tabindex="26" onKeyPress="return numeric_only(event,'pfmaxi','10')" value="<%=pfmaxi%>" 	size="30" maxlength="7"  onpaste="return false;"> 
                   
				  	</td>
              </tr>
              <tr>
                <td class="boldEleven">ESI Limit</td>
                <td class="boldEleven"><input name="esilimit" type="text" class="formText135" id="esilimit" tabindex="26" onKeyPress="return numeric_only(event,'esilimit','10')" value="<%=esilimit%>" 	size="30" maxlength="7"  onpaste="return false;"></td>
              </tr>
              <tr>
                <td class="boldEleven">Status</td>
                <td class="boldEleven">
                <select name="status" class="formText135" id="status">
                <option value="0" selected>Select Status</option>
                <option value="Y">Active</option>
                <option value="N">Inactive</option>
                </select>
                <script language="javascript">setOptionValue('status','<%=status%>')</script>
                </td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="PFwagesBand"/>
				<input type="hidden" name="actionS"  value="<%=actionS%>"/>
				<input name="Rowid" type="HIDDEN" id="Rowid" value="<%=id%>">	</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1" cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('PFwagesBand.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
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

}
catch(Exception e)
{
}
%>
</body>
</html>
