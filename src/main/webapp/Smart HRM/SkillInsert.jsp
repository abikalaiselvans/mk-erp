 <%@ page import="com.my.org.erp.common.CommonFunctions" %>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 <%
 try
 {
  	

	String skillsids =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_GENERALSKILL FROM hrm_m_jobdesign WHERE INT_JOBID=(SELECT INT_JOBID FROM hrm_m_application WHERE INT_APPID= "+request.getParameter("id")+") ")[0][0] ;
	

	String skilldata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_SKILLID,CHR_SKILLNAME FROM  hrm_m_skilllevel WHERE INT_SKILLID IN ("+skillsids+" 0) ORDER BY CHR_SKILLNAME ");
	
	 
	
	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
 	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven'><b>S.No</b></td>");
	out.println("<td class='boldEleven'><b>Skill Name</b></td>");
	out.println("<td class='boldEleven'><b>Level 1</b></td>");
	out.println("<td class='boldEleven'><b>Level 2</b></td>");
	out.println("<td class='boldEleven'><b>Level 3</b></td>");
	out.println("<td class='boldEleven'><b>Level 4</b></td>");
	out.println("<td class='boldEleven'><b>Level 5</b></td>");
	out.println("</tr>");
	 
if(skilldata.length>0)
 	for(int u=0;u<skilldata.length;u++)
	 {
			if(u%2==0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");		
			out.println("<td class='boldEleven'><b>"+(u+1)+"</b></td>");
			out.println("<td class='boldEleven'><b>"+skilldata[u][1]+"</b></td>");
			out.println("<td class='boldEleven'><input name='skill_"+skilldata[u][0]+"'  id='skill_"+skilldata[u][0]+"'    type='radio' value='1'></td>");
			out.println("<td class='boldEleven'><input name='skill_"+skilldata[u][0]+"'  id='skill_"+skilldata[u][0]+"'    type='radio' value='2'></td>");
			out.println("<td class='boldEleven'><input name='skill_"+skilldata[u][0]+"'  id='skill_"+skilldata[u][0]+"'    type='radio' value='3'></td>");
			out.println("<td class='boldEleven'><input name='skill_"+skilldata[u][0]+"'  id='skill_"+skilldata[u][0]+"'    type='radio' value='4'></td>");
			out.println("<td class='boldEleven'><input name='skill_"+skilldata[u][0]+"'  id='skill_"+skilldata[u][0]+"'    type='radio' value='5'></td>");
			out.println("</tr>");	
				
 	 }
 
		 
		 
 
 out.println("</table>");
 	String  cdata[][] =CommonFunctions.QueryExecute("SELECT CHR_QUALIFICATION ,ROUND(DATEDIFF(now(),DT_DOB)/365) FROM hrm_m_application WHERE INT_APPID=" +request.getParameter("id"));
if(cdata.length>0)
{
 	out.println("<input id='deducation' name='deducation' type='hidden' value='"+cdata[0][0]+"' />");
	out.println("<input id='dage' name='dage' type='hidden' value='"+cdata[0][1]+"' />");	
 }
	
 
 
  
 }
 catch(Exception e)
 {
 	System.out.println(""+e.getMessage());
 }
%>
