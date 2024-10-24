<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*" errorPage=""%>
<%@ page import="com.my.org.erp.bean.payroll.PayrollInfo"%>
<%@ page import="java.util.ArrayList"%>

<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<div align="center">

  <p><br />
    <br />
    <br />
    <br />
  </p>
  
  <form name="frm" method="post" action="paybeanerrorresponse.jsp">
  <table class="BackGround" cellspacing="0" cellpadding="0" width="390"
			align="center" border="0">
    <tbody>
      <tr>
        <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
        <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
        <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
      </tr>
      <tr>
        <td height="6"><spacer height="1" width="1" type="block" /></td>
      </tr>
      <tr>
        <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
        <td width="6"><spacer height="1" width="1" type="block" /></td>
        <td width="412"><table width="600" border="0" align="center" cellpadding="3" cellspacing="3">
            <tr>
              <td class="bold1"></td>
            </tr>
            <tr>
              <td class="bold1"><div align="center">ERROR</div></td>
            </tr>
            <tr>
              <td class="boldEleven"><div align="center">
                <%
						   try
						 {
							
								ArrayList p=(ArrayList)  session.getAttribute("payrollinfos");	
								
								
								
								
								if(p.size()>0)
								{
									out.println("<center>");
									out.println("<table width='70%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
									out.println("<tr class='MRow1'>");
									out.println("<td class='boldEleven' colspan='10' align='center'><b>UPLOAD ERROR - INFORMATION </b></td>");
									out.println("</tr>");
									out.println("<tr class='MRow1'>");
									out.println("<td class='boldEleven'><b>S.No</b></td>");
									out.println("<td class='boldEleven'><b>Emp Id</b></td>");
									out.println("<td class='boldEleven'><b>Amount</b></td>");
									out.println("<td class='boldEleven'><b>Description</b></td>");
									out.println("</tr>");
									 for(int i=0;i<p.size();i++)
									 {
										PayrollInfo a= (PayrollInfo)p.get(i);
										 if(i%2==0)
											out.println("<tr class='MRow2'>");
										else
											out.println("<tr class='MRow1'>");	
										out.println("<td class='boldEleven'>"+(i+1)+"</td>");
										out.println("<td class='bolddeepred'>"+ a.getEmpid()   +"</td>");
										out.println("<td class='boldEleven'>"+a.getAmount()+"</td>");
										out.println("<td class='boldEleven'>"+a.getDescription()+"</td>");
										out.println("</tr>"); 
									} 
									out.println("</table>");	
									out.println("</center>");
								}
							
						 
						}
						catch(Exception e)
						{
							out.println(e.getMessage());
						}
						
						
						  
					  %>
                   
              </div></td>
            </tr>
            <tr>
              <td class="boldEleven"><table width="56" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Close" type="submit"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											  /></td>
                  </tr>
              </table></td>
            </tr>
        </table></td>
        <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
        <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
      </tr>
      <tr>
        <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
        <td height="6"><spacer height="1" width="1" type="block" /></td>
        <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
      </tr>
      <tr>
        <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
      </tr>
    </tbody>
  </table>
  </form>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
</div>