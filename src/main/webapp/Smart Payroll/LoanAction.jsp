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
	if(checkNull("Name","Enter Name") 
		 && checkNull("descr","Enter Description"))
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
                <td colspan="2" class="bold1"><div align="center"> LOAN 
				
				    <%
							String action=request.getParameter("action1");
							String id="",Name="",Descri="",actionS="",value="";
							String desc1="",nam1="";
							String sql="";
							String link="";
							 
							if("Add".equals(action))
							{
								id="";Name=""; Descri="";
								actionS="PAYLoanAdd";
								value="Add";
								// call Ajax for exits record
								link=" onBlur=\"  CheckUnique(this,'divunitname','pay_m_loan','CHR_LOANNAME')\"  onKeyUp=\" CheckUnique(this,'divunitname','pay_m_loan','CHR_LOANNAME')\" ";
								
							}
							else
							{
								id="";Name=""; 
								id=request.getParameter("id");
								sql = "  SELECT INT_LOANID,CHR_LOANNAME,CHR_DESC FROM pay_m_loan WHERE INT_LOANID="+id;
								String data[][] =  CommonFunctions.QueryExecute(sql);
								nam1=data[0][1];
								desc1=data[0][2];
								actionS="PAYLoanEdit";
								value="Update";
								link=" onBlur=\"  CheckUnique(this,'divunitname','pay_m_loan','CHR_LOANNAME')\"  onKeyUp=\" CheckUnique(this,'divunitname','pay_m_loan','CHR_LOANNAME')\" ";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td width="31%" class="boldEleven">  Name <span class="boldred">*</span> </td>
                <td width="69%" class="boldEleven"><input name="Name" type="text" onBlur="upperMe(this)" class="formText135" id="Name" value="<%=nam1%>"  size="40"  <%=link%> maxlength="60">
				<div id='divunitname'></div></td>
              </tr>
              
              <tr>
                <td valign="top" class="boldEleven">  Description<span class="boldred">*</span> </td>
                <td valign="top" class="boldEleven"> 
                  <textarea name="descr" type="text" class="formText135" onBlur="textArea('descr','200')" id="descr" value="" cols="37"  maxlength="100"><%= desc1%></textarea>
				  	</td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="Loan"/>
				<input type="hidden" name="actionS"  value="<%=actionS%>"/>
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">	</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1" cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('LoanView.jsp')"></td>
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
