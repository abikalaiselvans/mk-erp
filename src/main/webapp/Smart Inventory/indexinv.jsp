 <%@ page import="com.my.org.erp.common.CommonFunctions"%> 
<script language="javascript" src="../JavaScript/Servercheck.js"></script>
<script language="javascript">
loadServer()
</script>





<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
</style>

<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="header"  class="headerImgBackground" > 
  <tr  class="headerImgBackground" >
    <td  class="headerImgBackground"  align="right"> <img src="../images/top_banner.png"  height="62" /> </td>
  </tr>
  <tr>
    <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
          <tr   class="headerBackground" >
            <td   height="25" align="center" valign="middle"><span class="boldgre">INVENTORY </span></td>
            <td   class="text_0">&nbsp;
			<%
	String sesUserName=""+session.getAttribute("USRID"); 
	String EMPID=""+session.getAttribute("EMPID"); 
	if(sesUserName.equals("null") ||  sesUserName.equals("")) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
	String invcompanyid=""+session.getAttribute("INVCOMPANY"); 
	String invbranchid=""+session.getAttribute("INVBRANCH"); 
	String controlsql = "";
	CommonFunctions.lockCheckDOB(request);
	controlsql ="SELECT CHR_COMPANYNAME FROM com_m_company WHERE INT_COMPANYID ="+invcompanyid;
	String cpyData[][] = CommonFunctions.QueryExecute(controlsql);
	
	controlsql ="SELECT CHR_BRANCHNAME FROM com_m_branch WHERE INT_COMPANYID ="+invcompanyid +" AND INT_BRANCHID="+invbranchid; 
	String bData[][] = CommonFunctions.QueryExecute(controlsql);
	
	
	if( "S".equals(""+session.getAttribute("USRTYPE"))) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
	
%>
			 
            <span class="bold1">Welcome :: <%= CommonFunctions.employeeName(""+session.getAttribute("EMPID") )%>
            </span></td>
            <td   align="right"   class="headerBackground" ><span class="bold1"><%=cpyData[0][0]%> @ <%=bData[0][0]%></span> </td>
            <td   align="right">
			 <font class="boldEleven"><a href="javascript:openCalc()" style="text-decoration:none"><img src="../Image/report/calculator.png" width="16" height="16" border="0" /></a></font>
			 
			 &nbsp;&nbsp;|&nbsp;&nbsp;
             <a href="smart.xls"><font class="boldEleven"><b><img src="../Image/report/Excel.png" border="0" /></b></font></a>
             &nbsp;&nbsp;|&nbsp;&nbsp;
			  <a href="../chat/login.jsp"><font class="boldEleven"><b>Chat</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="../Smart Help/helpmain.jsp" target="_blank" ><font class="boldEleven"><b>Help</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="mailto:<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MAILID FROM  m_institution WHERE INT_ID=1")[0][0]%>" ><font class="boldEleven"><b>Mail</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="../Home.jsp" target="_parent"><font class="boldEleven"><b>Home</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="../Logout.jsp" target="_parent"><font class="boldEleven"><b>Logout</b></font></a> </td>
        </tr>
        </table></td>
  </tr>
  <tr   class="headerBackground" >
    <td height="25" valign="top"  id="menutd"><%@ include file="Inventory_menu.jsp"%></td>
  </tr>
</table>
 <script language="javascript">
 
function openCalc(query)
{  
	 
	 
	var width="300", height="270";
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left=50,top=50,screenX=50,screenY=50';
	newWindow = window.open('../Calculator/Calculator.html',"subWind",styleStr);
	newWindow.focus( );
}
 </script>
