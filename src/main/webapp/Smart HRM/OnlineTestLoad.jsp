  

<% 
try
{
	String r=request.getParameter("id").trim();
	 
	
	String ssql=" SELECT b.INT_APPID,a.INT_JOBID,a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE, ";
	ssql = ssql + " b.CHR_APPCODE,b.CHR_APPNAME, a.CHR_TESTYPEID,a.CHR_NOOFQUESTION,a.INT_TESTHOURS,a.CHR_PASSINGPERCENTAGE ";
	ssql = ssql + " FROM hrm_m_jobdesign a,hrm_m_application b WHERE a.CHR_JOBGRADE = b.CHR_JOBGRADE  AND a.INT_JOBID = b.INT_JOBID ";
	ssql = ssql + " AND b.INT_APPID= "+r;
	//out.println(ssql);
	String AppDatails[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
	if (AppDatails.length > 0)
	{
		out.println("<center>");
		out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' align='left'><b>JOB GRADE </b></td>");
		out.println("<td class='boldEleven' align='left'>"+AppDatails[0][2]+"</td>");
		out.println("</tr>");
		out.println("<tr class='MRow2'>");
		out.println("<td class='boldEleven' align='left'><b>JOB CODE </b></td>");
		out.println("<td class='boldEleven' align='left'>"+AppDatails[0][3]+"</td>");
		out.println("</tr>");
		out.println("<tr class='MRow1'>");
		 out.println("<td class='boldEleven' align='left'><b>JOB TITLE </b></td>");
		out.println("<td class='boldEleven' align='left'>"+AppDatails[0][4]+"</td>");
		out.println("</tr>");
		out.println("<tr class='MRow2'>");
		out.println("<td class='boldEleven' align='left'><b>APPLICANT CODE </b></td>");
		out.println("<td class='boldEleven' align='left'>"+AppDatails[0][5]+"</td>");
		out.println("</tr>");
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' align='left'><b>APPLICANT NAME </b></td>");
		out.println("<td class='boldEleven' align='left'>"+AppDatails[0][6]+"</td>");
		out.println("</tr>");
		 out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' align='left'><h3><font color='red'>DURATION </font></h3></td>");
		out.println("<td class='boldEleven' align='left'><h3><font color='red'>"+AppDatails[0][9]+" - MINUTES </font></h3></td>");
		out.println("</tr>");
		 
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' align='left' colspan='2'><b>TEST DETAILS </b></td>");
		out.println("</tr>");
		
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' align='left' colspan='2'> ");
		String testids= AppDatails[0][7];
		String attenquestion= AppDatails[0][8];
		String timeduration= AppDatails[0][9];
		String percentage= AppDatails[0][10];
		String pass[] = percentage.split(",");
		String question[] = attenquestion.split(",");
		testids=testids.trim();
		testids = testids.substring(0,testids.length()-1);
		ssql=" SELECT b.CHR_TESTNAME, COUNT(*) FROM  hrm_m_testquestion  a,hrm_m_testtype b WHERE a.INT_TESTTYPEID= b.INT_TESTTYPEID  AND b.INT_TESTTYPEID IN("+testids+") GROUP BY a.INT_TESTTYPEID  ORDER BY b.CHR_TESTNAME ";
		 
		String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
		if (Data.length > 0)
		{
				out.println("<center>");
				out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven' align='center'><b>Test Name </b></td>");
				out.println("<td class='boldEleven' align='center'><b>No of Question</b></td>");
				out.println("<td class='boldEleven' align='center'><b>Available Questions</b></td>");
				out.println("<td class='boldEleven' align='center'><b>Minimum %</b></td>");
				out.println("</tr>");
				for(int i=0;i<Data.length;i++)
				{ 
					if(i%2==0)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr class='MRow2'>");	
						
					 
					out.println("<td class='boldEleven'  >"+Data[i][0]+"</td>");
					out.println("<td class='boldEleven'  ><input name='quetion"+(i+1)+"'  id='quetion"+(i+1)+"' type='text' class='formText135'  onKeyPress=\"numeric_only(event,'quetion"+(i+1)+"','3')\" onBlur=\"checkdbquestion('quetion"+(i+1)+"','dbquetion"+(i+1)+"')\"  value='"+question[i]+"' size=20 maxlength='3'  ><input name='dbquetion"+(i+1)+"'  id='dbquetion"+(i+1)+"' type='hidden' value='"+Data[i][1]+"' >   </td>"); 
					out.println("<td class='boldEleven'  >"+Data[i][1]+"</td>");
					out.println("<td class='boldEleven'  >"+pass[i]+" % <input name='passpercentage"+(i+1)+"' id='passpercentage"+(i+1)+"' type='hidden' value='"+pass[i]+"' > </td>");
					
					out.println("</tr>");	 
						
				}
				out.println("</table>");
				out.println("<center>");
				%>
				<script language="javascript">
				alert("WELCOME");
				</script>
				<%  
				
		}
		 out.println("<input name='nooftesttype' type='hidden' id='nooftesttype' value='"+Data.length+"'>");
		 out.println("<input name='applicantid' type='hidden' id='applicantid' value='"+r+"'>");
		 out.println("<input name='testids' type='hidden' id='testids' value='"+testids+"'>");
		 out.println("<input name='attenquestion' type='hidden' id='attenquestion' value='"+attenquestion+"'>");
		 out.println("<input name='timeduration' type='hidden' id='timeduration' value='"+timeduration+"'>");
		 out.println("<input name='percentage' type='hidden' id='percentage' value='"+percentage+"'>");
		out.println("</td></tr>");
		
		
		out.println("</table>");
		out.println("<center>");
 	}
}
catch(Exception e)
{
	out.println(e.getMessage());
}

%>
