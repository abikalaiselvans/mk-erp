<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@include file="Redirect.jsp" %>	
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%
try
 {
	

	Connection con ;
	Statement st=null; 
	ResultSet rs;  
	String str=null;
	String mnuList=null;
	ResultSet rsMenu;
	String tablename=null;
	String fieldname=null;
%>
<html>
<head>

<title> :: UTILITY :: </title>


 <link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
  <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
 
function SelectAll()
{	
	var nocheck=document.forms[0].mnuSel
	var val=document.getElementById("SAll").checked
	if(val==false){
		for(i=0;i<nocheck.length;++ i)
		{
			nocheck[i].checked=false;
		}
	}
	else
	{
		for(i=0;i<nocheck.length;++ i)
		{		
			nocheck[i].checked=true;
		}
	}
	
}
</script>
<body  onpaste='return false;'>
<form name="frm" method="post" action="SetRights.jsp">
  <br>
		
  <table width="100%" border="0" align="center" cellpadding="5" cellspacing="2">
          <tr>
            <td class="bold1"><div align="center">
              <input type='hidden' name='UserName'value='<%= request.getParameter("ename") %>'>
            <%
			
				String pdata[][]= CommonFunctions.QueryExecute(" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_TYPE  FROM com_m_staff a , m_user b  WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_EMPID ='"+request.getParameter("ename")+"' ");
				 
				String hj = "EMPID : " + pdata[0][0]+"/  NAME : "+pdata[0][1] +" /  <font color='red'><b>";
				if("S".equals(pdata[0][2]))	 
					hj = hj+" Super Admin ";
				else if("B".equals(pdata[0][2]))	 
					hj = hj+" Branch Admin ";
				else if("A".equals(pdata[0][2]))	 
					hj = hj+" Admin ";
				else 
					hj = hj+" Staff ";
								
				out.println(hj +"</b></font>");
				out.println();
			%>
			
			</div></td>
          </tr>
          <tr>
            <td class="bold1"><div align="center">
              <% 	
			  
			tablename=request.getParameter("Rights");
			
			boolean f = false;
			String sql="SELECT CHR_SHORTNAME,CHR_MODULE,CHT_TABLE,CHR_FIELD FROM   m_projectmodule  ";
			sql = sql+" WHERE CHR_SHORTNAME='"+tablename+"' ORDER BY CHR_MODULE";
			//out.println(sql);
			String data[][]= CommonFunctions.QueryExecute(sql);
			for(int u=0;u<data.length;u++)
				if(tablename.equals(data[u][0]))
				{
					out.print(data[u][1]);
					tablename=data[u][2];
					fieldname=data[u][3];
					f=true;
				}
			 
			out.println("<input type='hidden' name='fname' value='"+fieldname+"'>");
		%>
            </div></td>
          </tr>
          <tr>
            <td class="bold1"><div align="center">
              <input type="checkbox" value="0" name="SAll" id="SAll" onClick="SelectAll()">
			  <input name="mnuSel" type="hidden" value="0">
              <span class="bold1">Select
            All</span></div></td>
          </tr>
          <tr>
            <td class="bold1"><table width="95%" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
              <tbody>
                <tr>
                  <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
                  <td class="BorderLine" height="1"> </td>
                  <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="9" /></td>
                </tr>
                <tr>
                  <td height="6"> </td>
                </tr>
                <tr>
                  <td class="BorderLine" width="1"> </td>
                  <td width="10"> </td>
                  <td  valign="top"><table width="100%"  height="25" border="0" align="center"
						 >
                       

                      <tr>
                        <td valign="middle" bgcolor="#DEE7FF" class="tabledata">
                          
                            <%	
 try
 {
	
	 con =conbean.getConnection();
	 st=con.createStatement();
	
	 out.println("<center><table width='100%'   height='200px' cellpadding='1' cellspacing='1' align='center' border='1' ");
	 out.println("  bgcolor='#9900CC' > <tr align='center'  bgcolor='#DEE7FF'>");	     
	 out.println(f);
	 if(f)
	 {
	 	str="SELECT * FROM "+tablename+" WHERE INT_MENUID> 0 ORDER BY INT_MENUID";
		String b="";
	 	String b1="";
	 	rs=st.executeQuery(str); 
	 	int i=0;	
	 	while(rs.next())
	 	{
			String mnuType=rs.getString("CHR_MENUDES").trim();
			b="";
			b=""+(rs.getString("CHR_MENUNAME"));
			b1=""+rs.getInt("INT_MENUID");
			i=i+1;
			if(mnuType.equals("Root"))
			{
				out.println("<td align='left' valign='top' class='boldEleven'><strong>");
				out.println("<input class='formText135' name=\"mnuSel\" id=\""+b1+"\" type='checkbox'  value='"+b1+"' >");
				out.println(b);
				out.println("</strong><br><br><br>");
			}
			else 
			{	
				out.println("<input class='formText135' name=\"mnuSel\" id=\""+b1+"\" type='checkbox'  value='"+b1+"' >");
				out.println(b);
				out.println("<br>");  
			}
		}
		rs.close();
	}
	else
	{
		out.println("<tr><td> Module not found...</td></tr>");
	}
	out.println("</table></center>");
	
 }
 catch(Exception e)
 {
	System.out.println(e.getMessage());
	out.println(e.getMessage());
 }
%>
                           </td>
                      </tr>

                  </table></td>
                  <td nowrap="nowrap" width="8"> </td>
                  <td width="1" class="BorderLine"> </td>
                </tr>
                <tr>
                  <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
                  <td height="6"> </td>
                  <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div></td>
                </tr>
                <tr>
                  <td class="BorderLine" height="1"></td>
                </tr>
              </tbody>
            </table></td>
          </tr>
          <tr>
            <td class="bold1"><div align="center"></div></td>
          </tr>
          <tr>
            <td><table align="center">
              <tr>
                <td width="100">
				<%
				if(f)
					out.println("<input name='submit' type='submit'	class='buttonbold' Value='Grant Permission'>");
				%>	
				</td>
					
                <td width="100"><input name="submit" type="button"
					 value="Close"   accesskey="c"  class="buttonbold" onClick="redirect('UserRights.jsp')"
					></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF"> </td>
          </tr>
  </table>
	 
</form>
<% 	
	  	
		 str="SELECT "+fieldname+" FROM  m_user  WHERE CHR_EMPID='"+request.getParameter("ename")+"' " ;
		 rs=st.executeQuery(str); 
		 if(rs.next())
	     {		
	    	 //mnuList=rs.getString("\""+fieldname+"\"");	    	 
			 mnuList=rs.getString(1);	    	 
			 if(!mnuList.equals(""))	    		 
	    	 {
		       str="SELECT * FROM "+tablename+" WHERE INT_MENUID IN ("+mnuList+") ORDER BY INT_MENUID";
			   rsMenu=st.executeQuery(str);
			   while(rsMenu.next())
			   {
			     	String mnuType=rsMenu.getString("CHR_MENUDES");
	      		  	str=rsMenu.getString("INT_MENUID");
				  
	%>
<script language="javascript">
	try
	{
		document.getElementById("<%=str%>").checked=true;
	}
	 
	catch(err)	
	{
		alert("<%=str%>"+err.description)
	}
</script>
<%	       		 
		      }
	         }
	     }
	     rs.close();
 
     
     
     
   }
 catch(Exception e)
 {
	System.out.println(e.getMessage());
	out.println(e.getMessage());
 }
%>   
</body>
</html>
