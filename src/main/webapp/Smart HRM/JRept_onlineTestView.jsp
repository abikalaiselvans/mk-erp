 
<%@ page import="java.util.*" %>
 <html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>HRM</title>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
<body>
<form action="../hrmCon" method="post">
<p>
  <input type="hidden" name="pageAction" value="onlineTestView" />
</p>
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
      <td width="412" valign="top"><table width="100%" align="center">
        <tr>
          <td class="boldEleven">Grade</td>
          <td><select name="grade" class="formText135" style="width:150" >
            <option>All</option>
            <option>Group-1</option>
            <option>Group-2</option>
            <option>Group-3</option>
          </select></td>
        </tr>
        <tr>
          <td class="boldEleven">Job Title</td>
          <td><select name="title" class="formText135" style="width:150" >
            <option>All</option>
            <%

List gdata=new com.my.org.erp.JasperReport.HRM.HrmBean().getData("SELECT CHR_JOBTITLE FROM hrm_m_jobdesign ");
Iterator i=gdata.iterator();
while(i.hasNext()){
%>
            <option><%=(String)i.next() %></option>
            <%} %>
          </select></td>
        </tr>
        <tr>
          <td class="boldEleven">Office</td>
          <td><select name="location" class="formText135" style="width:150" >
            <option>All</option>
            <%
List data=new com.my.org.erp.JasperReport.HRM.HrmBean().getData("SELECT CHR_OFFICENAME FROM com_m_office");
Iterator itr=data.iterator();
while(itr.hasNext()){
%>
            <option><%=(String)itr.next() %></option>
            <%} %>
          </select></td>
        </tr>
        <tr>
          <td class="boldEleven">Month</td>
          <td><select name="month" id="month"  >
           <option value="0">All</option>
				 <%@ include file="../JavaScript/months.jsp"%>
			 </select></td>
        </tr>
        <tr>
          <td class="boldEleven">Year</td>
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
          <td class="boldEleven">Result</td>
          <td><select name="result" class="formText135" style="width:150"  >
            <option>All</option>
            <option>Not Attending</option>
            <option>Fail</option>
            <option>Pass</option>
          </select></td>
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
</form>
</body>
</html>