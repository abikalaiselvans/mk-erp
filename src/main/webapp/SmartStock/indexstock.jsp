<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style><table width="100%" border="0" cellspacing="0" cellpadding="0"  id="header"> 
  <tr  class="headerImgBackground" >
    <td><div align="right"><img src="../images/top_banner.png"  height="62" /></div></td>
  </tr>
  <tr>
    <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
          <tr   class="headerBackground" >
            <td width="183" height="25" align="center" valign="middle"><span class="boldgre">STOCK </span></td>
            <td width="287" class="text_0">&nbsp;
			<%
	String cpy = (String) session.getAttribute("STKCOMPANY");
	String bch = (String) session.getAttribute("STKBRANCH");
	
	String sesUserName=""+session.getAttribute("USRID"); 
	String EMPID=""+session.getAttribute("EMPID"); 
	if(sesUserName.equals("null") ||  sesUserName.equals("")) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
	String stkcompanyid=""+session.getAttribute("STKCOMPANY"); 
	String stkbranchid=""+session.getAttribute("STKBRANCH"); 
	String controlsql = "";
	controlsql ="SELECT CHR_COMPANYNAME FROM com_m_company WHERE INT_COMPANYID ="+stkcompanyid;
	String cpyData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(controlsql);
	
	controlsql ="SELECT CHR_BRANCHNAME FROM com_m_branch WHERE INT_COMPANYID ="+stkcompanyid +" AND INT_BRANCHID="+stkbranchid; 
	String bData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(controlsql);
	
	
	if( "S".equals(""+session.getAttribute("USRTYPE"))) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
			
			
	
%>
            <span class="bold1">Welcome :: <%=com.my.org.erp.common.CommonFunctions.employeeName(""+session.getAttribute("EMPID") )%>
            </span></td>
            <td width="360" align="right"   class="headerBackground" ><div align="center"><span class="bold1">
               
           </span> </div></td>
            <td width="170" align="right">
			 <a href="mailto:<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MAILID FROM  m_institution WHERE INT_ID=1")[0][0]%>" ><font class="boldEleven"><b>Mail</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="../Mainscreen.jsp" target="_parent"><font class="boldEleven"><b>Home</b></font></a>&nbsp;&nbsp;|&nbsp;&nbsp;
			 <a href="../Logout.jsp" target="_parent"><font class="boldEleven"><b>Logout</b></font></a> </td>
        </tr>
        </table></td>
  </tr>
  <tr   class="headerBackground" >
    <td  id="menutd"><%@ include file="menu_stock.jsp"%></td>
  </tr>
</table>

 