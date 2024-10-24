<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>



<%@ include file="index.jsp"%>
 
<html>
<head>

<title> :: ATTENDANCE ::</title>



 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Attendance/OndutyAjax.js"></script>
<script language="javascript" src="../JavaScript/common/Staffloadsdependsoffice.js"></script>
<script language="javascript">
 	function  Edit()
 	{		
 	    obj = findObj("rowid");
		if(obj == null)
		{
			alert("No records  to edit...");
			return false;
		}
		
		var count=0;
 	    sel=document.forms[0].rowid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].rowid.checked)
		    { 
		    	count=1;
		    }   
		    else{	    
		   	   alert("Select Record to Edit");
		   	   return false;
		   	 }
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false
 	    }
 	    if(count==1)
 	    {
		document.frm.action="OnDutyEdit.jsp";
		document.frm.submit();
		return true;
		}
 	}
 	
	 	
		
	function Add()
 	{		
		document.frm.action="OnDutyAdd.jsp";
		document.frm.submit();
 	}	
	
	 function  Delete()
 	{		
		obj = findObj("rowid");
		if(obj == null)
		{
			alert("No records  to edit...");
			return false;
		}
		var count;
		count=0;
		c1=document.forms[0].rowid
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].rowid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				document.frm.submit();
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
	 
function buttondisable()
{
     	document.getElementById('Edit').disabled=true;
		
}
 	</script>
 
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<form  AUTOCOMPLETE = "off"   method="get" name="frm">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="bgcolor" onLoad="loadOnDuty('0')"  >
<table width="100%" align="center">
	<!--DWLayoutTable-->
	<tr>
		<td height="21" colspan="6" align="center" class="bolddeepred">
		<div align="center">		</div>		</td>
	</tr>
	<tr>
		<td height="80" colspan="6" align="center">
		<table width="90%" height="177" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" >
				<td height="28" ><span class="whiteMedium">ONDUTY</span></td>
			</tr>

			<tr>
			  <td height="31"><table width="90%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="whiteMedium">
                <tr>
                  <td    >Office</td>
                  <td    ><%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 String usertype=""+session.getAttribute("USRTYPE");  
			  %>
                      <select name="Office" class="formText135" id="Office"
							tabindex="6" onBlur="loadOnDuty('0')"  onChange="loadStaffName() ">
                         
                       
					   <option value="0">All</option>	
							<%
	String OfficeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
 %>
	  </select><script language="javascript">setOptionValue('Office','<%=""+session.getAttribute("OFFICEID")%>')</script>
					   </td>
					<td  >Staff </td>
						<td  >
						
<select name="staffid" class="formText135" id="staffid"  onBlur="loadOnDuty('0') ">
<option value="0">All</option>
<%
 String empdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT  CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE   CHR_TYPE!='T' AND INT_OFFICEID= "+oficeid+" AND CHR_HOLD!='Y'  ORDER BY CHR_STAFFNAME ");
		for(int u=0; u<empdata.length; u++)
			out.print("<option value='"+empdata[u][0]+"'>"+empdata[u][1] +"</option>");
%>				
</select></td>
                  <td  >Day</td>
                  <td  ><select name="day" id="day"  onBlur="loadOnDuty('0') ">
                      <option value="0">All</option>
                      <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                    </select>                  </td>
                  <td    >Month </td>
                  <td  ><select name="month"
							id="month" onBlur="loadOnDuty('0')"
							onChange="loadOnDuty('0')">
                      <%@ include file="../JavaScript/months.jsp"%>
                    </select>                  </td>
                  <td  > Year </td>
                  <td  ><select name="year"
							id="year" onBlur="loadOnDuty('0')"
							onChange="loadOnDuty('0')">
                      <%@ include file="../JavaScript/years.jsp"%>
                    </select>
                      <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1;
						var day=d.getDate()
						if(day<10) day="0"+day;
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
						setOptionValue('day',day);							
				//-->
                </script>                  </td>
                </tr>
              </table></td>
		  </tr>

			<tr  >
				<td height="31" align="left" valign="middle" class="boldEleven"><table width="100%" border="0" class="whiteMedium"
					  >
                  <tr>
                    <td><strong  >S.No</strong></td>
                    <td><strong  >Staff Id</strong></td>
                    <td><strong  >Staff Name</strong></td>
                    <td><strong  >Office</strong></td>
                    <td><strong  >Date</strong></td>
                    <td><strong  >Day Type</strong></td>
                  </tr>
                </table></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td valign="top">
				<div id="OnDutyTable"
					style="OVERFLOW: auto;width:100%;height:300px"></div><br>
					<div id="totRec"></div><br>
		</table>		</td>
	</tr>
	<tr>
	  <td height="17" colspan="6"><!--DWLayoutEmptyCell-->&nbsp;</td>
  </tr>
	<tr>
		<td height="17" colspan="6"><input name="filename" type="hidden"
			id="filename" value="StaffOnDuty"> <input name="actionS"
			type="hidden" id="actionS" value="ATTOnDutyDeletes">
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadOnDuty('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>

	<tr>
	  <td height="17" colspan="6">    
  <tr>
	  <td height="17" colspan="6">
		<center>
		  <div align="center">
            <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_ATT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_ATT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_ATT FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('AttendanceMain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
          </div>
		</center>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>