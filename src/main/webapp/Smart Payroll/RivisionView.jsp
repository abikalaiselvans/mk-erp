<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
  
  function Edit()
 	{		
 	    var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].staffid.checked)
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
		document.frmRevisionEditView.action="RivisionEdit.jsp";
		return true;
		}
 	}
 	


 function Delete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].staffid
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
			if (document.forms[0].staffid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frmRevisionEditView.action="../SmartLoginAuth";
				//document.frmRevisionEditView.submit();
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
	var f=document.frmRevisionEditView.staffid.checked;
	alert (f);
return true;
}
 	 	
 </script>

<title> :: PAYROLL ::</title>


 
 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off"   name="frmRevisionEditView" method="get">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="100">
		<%
try
{
%> <%@ include file="index.jsp"%></td>
	</tr>
	<tr>
	<tr>
		<td height="68">&nbsp;</td>
	</tr>
	<td height="299">
	<table width="780" border="0" align="center" cellpadding="1"
		cellspacing="1">
		<tr>
			<td width="594" height="15"></td>
		</tr>
		<tr>
			<td>
			<table width="100%" border="0" align="center" cellpadding="0"
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
						<td width="577" valign="top">
						<table width="753" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
								<div align="center" class="boldEleven"><strong>Revision
								Information</strong></div>								</td>
							</tr>
							<tr>
								<td>
								<%

                		
            			String mth = com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(""+request.getParameter("Month")));
                        String yr = request.getParameter("Year");
                       	String id = request.getParameter("staffid");
                       	
                        
                    	String sql = "SELECT A.CHR_EMPID, A.CHR_STAFFNAME, B.INT_RIVISIONID, B.INT_BASIC, B.INT_INCREMENT, B.DT_RIVISION from  com_m_staff  A, pay_t_rivision B ";
                    	sql=sql+ " where A.CHR_EMPID=B.CHR_EMPID AND B.CHR_EMPID='"+id+"'";
                    	sql=sql+ " AND monthname(B.DAT_EFFECT)='"+mth+"' AND year(B.DAT_EFFECT)="+yr;
 
               			String Datas[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						//out.println(sql);
                        %>								</td>
							</tr>

							<tr>
								<td>
								<table width='101%' cellpadding="5" cellspacing="0">
									<tr class='boldEleven'>
										<td colspan="6">
										<table width="536" border="0" align="center" cellpadding="1"
											cellspacing="1">
											<tr>
												<td width="69" class="boldEleven"><strong>Staff
												Id <span class="style3">::</span></strong></td>
												<td width="165" class="boldEleven"><strong><%=Datas[0][0] %></strong></td>
												<td width="11" class="boldEleven">&nbsp;</td>
												<td width="77" class="boldEleven"><strong>Staf
												Name <span class="style3">::</span></strong></td>
												<td width="198" class="boldEleven"><strong><%=Datas[0][1]%></strong></td>
											</tr>
										</table>
									<tr class='boldEleven'>
										<td width=14 height="29"
											 >
										<td width=154  ><b>Revision
										ID</b>
										<td width=165  ><b>Basic</b>
										<td width=165  ><b>Increment</b>
										<td width=155  ><b>Date</b>
								</table>								</td>
							</tr>
							<tr>
								<td>
								<div align="center">
								
								<%
								
								sql = "SELECT A.CHR_EMPID, A.CHR_STAFFNAME, B.INT_RIVISIONID, B.INT_BASIC, B.INT_INCREMENT, B.DT_RIVISION from  com_m_staff  A, pay_t_rivision B ";
                    			sql=sql+ " where A.CHR_EMPID=B.CHR_EMPID AND B.CHR_EMPID='"+id+"' ORDER BY  B.INT_RIVISIONID";
                    			String WDatas[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								out.println("<table width='100%' >");
								for(int u=0; u<WDatas.length;u++)
								{
									if(u%2==0)
										out.println("<tr height='25' class='MRow2'>");
									else
										out.println("<tr height='25' class='MRow1'>");
									out.println("<td width='150' class='boldEleven' align='center'>"+WDatas[u][2]);
									out.println("<td width='150' class='boldEleven' align='center'>"+WDatas[u][3]);
				    				out.println("<td width='150' class='boldEleven' align='center'>"+WDatas[u][4]);
				    				out.println("<td width='150' class='boldEleven' align='center'>"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(WDatas[u][5]));	
								}
								out.println("</table>");	
								%>
								<br><br>
								
								
								<%
					
					boolean bgflag=false;
					out.println("<div  id='divscroll' style='OVERFLOW: auto;width:760px;height:150px'>");
					out.println("<table width='100%' >");
					for(int u=0; u<Datas.length;u++)
					{
						if(bgflag)
						{
							bgflag = false;
							out.println("<tr height='25' class='MRow2'>");
						}	
						else
						{
							bgflag = true;
							out.println("<tr height='25' class='MRow1'>");
						}	
						
				    	if (Datas.length==(u+1))
						{
				    		out.println("<td width='100' class='boldEleven' align='center'>&nbsp;<input type='checkbox' name='staffid' value="+Datas[u][0]+">&nbsp;<a href='RivisionEdit.jsp?staffid="+Datas[u][0]+"&maxid="+Datas[u][2]+"'><font color='blue'>"+Datas[u][2]+"</font></a>");
							out.println("<input type='hidden' name=maxid value="+Datas[u][2]+">");
				    	}
				    	else
				    		out.println("<td width='100' class='boldEleven' align='center'>&nbsp;<input type='checkbox' disabled>&nbsp;"+Datas[u][2]);	

				    	out.println("<td width='150' class='boldEleven' align='center'>"+Datas[u][3]);
				    	out.println("<td width='150' class='boldEleven' align='center'>"+Datas[u][4]);
				    	out.println("<td width='150' class='boldEleven' align='center'>"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(Datas[u][5]));
				    	out.println("</td></tr>");
					}
					out.println("</table>");
					out.println("</div>");
				
					
				%>
								</div>
								</div>								</td>
							</tr>
							<tr>
								<td></td>
							</tr>
							<tr>
							  <td height="28">&nbsp;</td>
						  </tr>
							<tr>
								<td height="28">
								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width=56><input name="submit" type="submit"
											class="buttonbold" id="submit" onClick="return Edit()"
											value="Update">
										<td width=56><input name="submit" type="Submit"
											class="buttonbold" id="submit" onClick=" return Delete()"
											value="Delete">
										<td width=56><input name="Submit" type="Button"
											class="buttonbold" onClick="redirect('Rivision.jsp')"
											 value="Close"   accesskey="c" ></td>
										<td><input name="filename" type="hidden" id="filename"
											value="StaffAllowanceRecovery"> <input name="actionS"
											type="hidden" id="actionS" value="PAYRivisionDelete"></td>
									</tr>
								</table>								</td>
							</tr>
						</table>
						</td>
						<td nowrap="nowrap" width="6"><spacer height="1" width="1"
							type="block" /></td>
						<td width="1" class="BorderLine"><spacer height="1" width="1"
							type="block" /></td>
					</tr>
					<tr>
						<td colspan="2" rowspan="2"><img height="7"
							src="../Image/General/BLCorner.gif" width="7" /></td>
						<td height="6"><spacer height="1" width="1" type="block" /></td>
						<td colspan="2" rowspan="2" valign="bottom">
						<div align="right"><img height="7"
							src="../Image/General/BRCorner.gif" width="7" /></div>
						</td>
					</tr>
					<tr>
						<td class="BorderLine" height="1"></td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
	</table>
	</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
<%
 }
 catch(Exception es)
 {
 	//System.out.println(es.getMessage());
 }
 %>
</form>
</body>
</html>
