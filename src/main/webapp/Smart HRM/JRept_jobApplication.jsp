<%@ page import="java.sql.*" isErrorPage="false" errorPage="./InValidSession.jsp"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page language="java"  %>
<%@ page import="java.util.*" %>
<%
try
{
%><html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> :: HRM :</title>

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<script language="javascript">
function submit(){
	if(grade.value='Group-1'){
		alert(grade.value);
	}
}
</script>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
<body>
<form action="../hrmCon" method="post">
<p>
  <input type="hidden" name="pageAction" value="JApplication" />
</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table class="BackGround1" cellspacing="0" cellpadding="0" width="300"
			align="center" border="0">
  <tbody>
    <tr>
      <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
      <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
      <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
    </tr>
    <tr>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
    </tr>
    <tr>
      <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
      <td width="6"><spacer height="1" width="1" type="block" /></td>
      <td width="412" valign="top"><table width="298" align="center">
        <tr>
          <td class="boldEleven">Grade:</td>
          <td><select name="grade" onChange="Submit()" style="width:150">
            <option value="0">All</option>
            <option value="Top">Group-1</option>
            <option value="Middle">Group-2</option>
            <option value="Bottom">Group-3</option>
          </select></td>
        </tr>
        <tr>
          <td class="boldEleven">Job Title</td>
          <td><select name="title" style="width:150">
            <option value="0">All</option>
            
			<%
 
		String titleData[][] =  CommonFunctions.QueryExecute("SELECT INT_JOBID,CHR_JOBTITLE FROM hrm_m_jobdesign ");
		for(int u=0;u<titleData.length;u++)
			out.print("<option value='"+titleData[u][0]+"'>"+titleData[u][1]+"</option>"); 
	%>
    
			 
          </select></td>
        </tr>
        <tr>
          <td class="boldEleven">Office</td>
          <td><select name="location" style="width:150">
            <option value="0">All</option>
            			<%
 
		String locationData[][] =  CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM com_m_office");
		for(int u=0;u<locationData.length;u++)
			out.print("<option value='"+locationData[u][0]+"'>"+locationData[u][1]+"</option>"); 
	%>
   
          </select></td>
        </tr>
        <tr>
          <td class="boldEleven">Month:</td>
          <td><select name="month" id="month"  >
           <option value="0">All</option>
				 <%@ include file="../JavaScript/months.jsp"%>
			 </select></td>
        </tr>
        <tr>
          <td class="boldEleven">Year:</td>
          <td><select name="year"  id="year" style="width:150">
            <%@ include file="../JavaScript/years.jsp"%>
          </select>
          
          
          <script language='JavaScript' type="text/javascript">
				<!--			
					 
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						
						setOptionValue('month',month1);
						setOptionValue('year',year1);
						 
												
				//-->
</script>	</td>
        </tr>
        <tr>
          <td colspan="2" align="center"><input type="submit" value="Submit"/></td>
        </tr>
      </table></td>
      <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
      <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
    </tr>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
    </tr>
    <tr>
      <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
    </tr>
  </tbody>
</table>
<p>&nbsp;</p>
</form>
</body>
</html><%
}
catch(Exception e)
{
		System.out.println(e.getMessage());
}
%>