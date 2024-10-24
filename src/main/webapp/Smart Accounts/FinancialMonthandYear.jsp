
<%try
{
		
		String fyear = ""+session.getAttribute("ACCYEAR");
		String fyear1 = ""+session.getAttribute("ACCYEAR1");
		int fy1= Integer.parseInt(fyear);
		int fy2= Integer.parseInt(fyear1);
		 
			
	%>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<table width="276" border="0" cellspacing="2" cellpadding="2">
      <tr>
        <td class="boldEleven">Month and Year </td>
        <td><select name="Financialyear" class="formText135" id="Financialyear">
          <option value="04">April - <%=fy1%></option>
          <option value="05">May - <%=fy1%></option>
          <option value="06">June - <%=fy1%></option>
          <option value="07">July - <%=fy1%></option>
          <option value="08">August - <%=fy1%></option>
          <option value="09">September - <%=fy1%></option>
          <option value="10">October - <%=fy1%></option>
          <option value="11">November - <%=fy1%></option>
          <option value="12">December - <%=fy1%></option>
          <option value="01">January - <%=fy2%></option>
          <option value="02">February - <%=fy2%></option>
          <option value="03">March - <%=fy2%></option>
        </select>
          <%
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}
	%>
          <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('Financialyear',month1);
						
				//-->
            </script></td>
      </tr>
    </table>
