<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="DBConnection.*"%>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <%
 try
 {
 %>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<body >
<%@ include file="indexinv.jsp"%>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<%
		
		try 
		{
			String filename= request.getParameter("pono");
			String mode= request.getParameter("mode");
			String sql="";
			
			if("DirectSales".equals(mode.trim()))
				sql = "SELECT IMG_INVOICE FROM inv_t_directsales  WHERE CHR_SALESNO='"+filename+"'";
			else
				sql = "SELECT IMG_INVOICE FROM inv_t_directpurchase  WHERE CHR_PURCHASEORDERNO='"+filename+"'";	
			DBCon co  = new DBCon();
			Connection cons= co.getConnection();
			Statement sts = cons.createStatement();
			ResultSet rss = sts.executeQuery(sql);
			String ofile="";
			boolean flag = false;
			filename=filename.replaceAll("/", "_");
			//filename=filename.replaceAll("-", "");
			while(rss.next())
			{
				Object o = rss.getObject("IMG_INVOICE");
				if(!(""+o).equals("null"))
				{
					byte dbbytes[] = rss.getBytes("IMG_INVOICE");
					ofile = (String) "../webapps/SmartCampus/uploadfiles/DCIMAGE/"+filename+".pdf";
					File of = new File(ofile);
					OutputStream os = new FileOutputStream(of);
					os.write(dbbytes,0,dbbytes.length);
					os.close();
					flag = true;
				} 
				
			}
			cons.close();
			if(flag)
			{
				File f = new File(ofile);
				if (f.exists())
		    		response.sendRedirect("../uploadfiles/EXTRACTDCIMAGE/"+filename+".doc");
				else
					response.sendRedirect("AccountDirectPurchase.jsp");
			}
			else
			{
				response.sendRedirect("../uploadfiles/EXTRACTDCIMAGE/Datanotfound.doc");
			}
					
			 
	
			
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		} 
	%>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<br>
<%@ include file="../footer.jsp"%>
</body>

<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
