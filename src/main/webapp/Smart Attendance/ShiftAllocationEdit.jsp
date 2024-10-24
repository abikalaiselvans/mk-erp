<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
 function Validate()
  {
  	if(checkNull("ename","Select Staff...") 
	&& checkNull("TxtPlace","Enter Place Name..."))
		return true;
	else
		return false;
  }
  
  function Edit()
 	{		
 	    var count=0;
 	    sel=document.forms[0].allocation;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].allocation.checked)
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
		document.ShiftEditfrm.action="ShiftAllocationUpdate.jsp";
		return true;
		}
 	}
 	


 function Delete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].allocation
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
			if (document.forms[0].allocation.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.ShiftEditfrm.action="../SmartLoginAuth";
				//document.onDutyEditfrm.submit();
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

function checkAll()
{
	var f=document.onDutyEditfrm.allocation.checked;
	alert (f);
return true;
}
 	 	
 </script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off"   name="ShiftEditfrm" method="get" action="../SmartLoginAuth">
<table width="98%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="954">
		<%
try
{
	String staff  = request.getParameter("stafftid");
	String staffname= ""+com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select CHR_STAFFNAME from com_m_staff where CHR_EMPID='"+staff+"'","CHR_STAFFNAME");
	String sql ="";
	int year  = Integer.parseInt(request.getParameter("year"));
	String month =request.getParameter("month");
	
%> <%@ include file="index.jsp"%></td>
	</tr>

	<tr>
	<td height="19"><br/><br/>
      <a href="file://///Mmi-server/D/Tomcat 5.0/webapps/SmartCampus/Smart Attendance/ShiftAllocationUpdate.jsp"></a>
      <table width="681" border="0" align="center" cellpadding="0"
				cellspacing="0" bgcolor="#dce4f9" class="BackGround">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
							src="../Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="1"><spacer height="1"
							width="1" type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
							src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
							type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block"></td>
          <td width="665" valign="top"><table width="529" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="21" colspan="3"><div align="center" class="tablehead1"><strong>Shift
                  Allocation</strong></div></td>
              </tr>
              <tr>
                <td height="29" colspan="3" class="tablesubhead"><table width="658" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <th width="92" height="22" class="tablesubhead" scope="col"><div align="left">Staff Name :: </div></th>
                    <th width="259" class="tablesubhead" scope="col"><div align="left" class="subtitle"><%= staffname %></div></th>
                    <th width="58" class="tablesubhead" scope="col"><div align="left">Month :: </div></th>
                    <th width="97" class="tablesubhead" scope="col"><div align="left" class="subtitle"><%= month %></div></th>
                    <th width="60" class="tablesubhead" scope="col"><div align="left">Year ::</div></th>
                    <th width="92" class="tablesubhead" scope="col"><div align="left" class="subtitle"><%= year %></div></th>
                  </tr>
                </table></td>
                </tr>
              <tr>
                <td width="10%" height="23" class="tablesubhead">S.L.No</td>
                <td width="39%" class="tablesubhead"><div align="center">Date</div></td>
                <td width="51%" class="tablesubhead"><div align="center">Shift Name </div></td>
                </tr>
                <%
				sql="select * from att_t_shiftallocation where chr_empid='"+staff+"' and chr_month='"+month+"' and int_year="+year;
                
                boolean flag=com.my.org.erp.common.CommonInfo.RecordExist(sql);

                
                %>
              <tr>
                <td height="191" colspan="3"><div id="staffload" style="overflow:auto; width:660; height:190;">
                <%
                out.println("<table width='100%'>");
                if(flag)
                {
                  String mon[]={"31","28","31","30","31","30","31","31","30","31","30","31"};
                  String dat="";
              	  String m="";   
              	  int mon1=DateUtil.getMonthNumber(month);
              	  int totalday=Integer.parseInt(mon[mon1-1]);
              	 if(mon1==2 && year%4==0)
              		totalday=29;
              	  for(int u=0;u<totalday;u++)
                    {
              		  sql="select DAT_SHIFT"+(u+1)+" from att_t_shiftallocation where chr_empid='"+staff+"' and chr_month='"+month+"' and int_year="+year;
              		  String data[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
						dat=""+year+"-"+mon1+"-"+(u+1);
						dat=dat.trim();
              		  if(u%2==0)
              		  out.println("<tr class='MRow1'>");
              		  else
                  		  out.println("<tr class='MRow2'>");              			  
              		out.println("<td width='10%' height='23' class='boldEleven'><input type='checkbox' name='allocation' value='"+staff+"~"+month+"~"+year+"~"+data[0][0]+"~"+dat+"'>");
              		if((u+1)<10)
              		out.println("0"+(u+1)+"</td>");
              		else
                  		out.println((u+1)+"</td>");              			
              		out.println("<td width='39%' ><div align='center'><a href='ShiftAllocationUpdate.jsp?allocation="+staff+"~"+month+"~"+year+"~"+data[0][0]+"~"+dat+"'><font class='boldEleven'><font color='blue'>"+(u+1)+"/"+mon1+"/"+year+"</div></td>");
					if(data[0][0].equals("-") || data[0][0].equals("0"))
              		out.println("<td width='51%' class='boldEleven'><div align='center'>Not Allocated</div></td></tr>");
					else
						out.println("<td width='51%' class='boldEleven'><div align='center'>"+com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select chr_shiftname from att_m_shift where int_shiftid="+data[0][0],"chr_shiftname")+"</div></td></tr>");
                    
                    }
                	sql="";
                }
                else
                {
                	out.println("Data Not Found....");
                }
                out.println("</table>");
                %>
                </div></td>
              </tr>
              <tr>
                <td colspan="3"></td>
              </tr>
              <tr>
                <td height="28" colspan="3"><table border="0" align="center" cellpadding="1" cellspacing="1">
                    <tr>
                      <td width=56><input name="update" type="Submit"
											class="buttonbold" id="update" onClick="return Edit()"
											value="Update">
                      <td width=56><input name="submit" type="Submit"
											class="buttonbold" id="submit" onClick=" return Delete()"
											value="Delete">
                      <td width=56><input name="Submit" type="Button"
											class="buttonbold" onClick="redirect('ShiftAllocation.jsp')"
											 value="Close"   accesskey="c" ></td>
                      <td><input name="filename" type="hidden" id="filename"
											value="ShiftAllocation">
                          <input name="actionS"
											type="hidden" id="actionS" value="ATTshiftDelete"></td>
                    </tr>
                </table></td>
              </tr>
          </table></td>
          <td nowrap="nowrap" width="8"><spacer height="1" width="1"
							type="block" /></td>
          <td width="1" class="BorderLine"><spacer height="1" width="1"
							type="block" /></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
							src="../Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
							src="../Image/General/BRCorner.gif" width="7" /></div></td>
        </tr>
        <tr>
          <td class="BorderLine" height="1"></td>
        </tr>
      </tbody>
    </table><br/></td>
	
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
<%
 }
 catch(Exception es)
 {
 	 
 }
 %>
</form>
</body>
</html>
