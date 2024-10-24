<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>

<title> :: PAYROLL ::</title>


 

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
  
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<%@ include file="index.jsp"%>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
 
<table width="900" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td height="42">&nbsp;</td>
	</tr>
	<tr>
	  <td><table class="BackGround" cellspacing="0" cellpadding="0" width="600"
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
            <td ><table width="800" align="center">
                <tr>
                  <td><div align="center"><span class="bold1"> <%=(""+request.getParameter("path")).toUpperCase()%></span></div>
                      <table width="100%" border="0" align="center">
                        <tr>
                          <td height="26" align="left" valign="top"><table>
                              <tr>
                                <td></td>
                              </tr>
                            </table>
                              <div align="center">
                                <% 
File folder = new File(request.getRealPath("")+"/uploadfiles/ESI/"+request.getParameter("path")+"/");
File[] listOfFiles = folder.listFiles();
out.println("<table width='600' border='0' align='center' cellpadding='2' cellspacing='2'>");
out.println("<tr>");
//out.println("<td class='boldEleven'><b>S.No");
//out.println("<td class='boldEleven'><B>Document Name");
int u=0;
String extn="";
String fileName="";
for (int i = 0; i < listOfFiles.length; i++) 
	if (listOfFiles[i].isFile()) 
	{
		if(u%2==0)
			out.println("<tr>");
		extn="";
		out.println("<td class='boldEleven'>"+(u+1)+"." );
		out.println("<td class='boldEleven'><a target='_blank' href='../uploadfiles/ESI/"+request.getParameter("path")+"/"+listOfFiles[i].getName()+"'>");
		fileName = listOfFiles[i].getName();
		int mid= fileName.lastIndexOf(".");
  		fileName=fileName.substring(0,mid);
  		out.println(fileName.toUpperCase());
		out.println("</a>");
		u=u+1;
	}	
		 
out.println("</table>");	
 

		%>
                            </div></td>
                        </tr>
                    </table></td>
                </tr>
                <tr>
                  <td colspan="2" align="left" valign="middle" class=""><table align="center" cellpadding="3" cellspacing="3">
                      <tr align="center">
                        <td width="56"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c"  onClick="redirect('PF_ESI_FORMS_Download.jsp')">
                        </td>
                      </tr>
                    </table>
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
      </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	<tr>
		<td>&nbsp;</td>
</table>

<%@ include file="../footer.jsp"%>
</body>
 
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>