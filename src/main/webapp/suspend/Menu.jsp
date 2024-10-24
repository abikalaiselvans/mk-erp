 <link rel="StyleSheet" href="../JavaScript/explore/dtree.css"  type="text/css" />
<script type="text/javascript" src="../JavaScript/explore/dtree.js"></script>

<style type="text/css">
<!--
a:link {
	text-decoration: none;
}
a:visited {
	text-decoration: none;
}
a:hover {
	text-decoration: none;
}
a:active {
	text-decoration: none;
}
-->
</style><div class="dtree" style="OVERFLOW:auto;width:200;height:600px">
<%
try
{
	
	String menurights = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MENUSUSPEND FROM m_user  WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0];
	 
	String menudata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MENUNAME,CHR_MENUDES,INT_MENUID,CHR_URL FROM  m_menu_suspend   WHERE  INT_MENUID >0 AND INT_MENUID IN("+menurights+") ORDER BY INT_MENUID");
	 
	int i=0,j=0,k=0;
%>

 	<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>
	<script type="text/javascript">
		<!--

		d = new dTree('d');
		d.add(<%=i%>,<%=i-1%>,'Master');
		<%	
			i=i+1;
			for(int h=0;h<menudata.length;h++)
			{
				if("Root".equals(menudata[h][1]))
				{
					%>
						d.add(<%=i%>,<%=j%>,'<%=menudata[h][0]%>','');
					<%
					k=i;
					i = i+1;
					
				}
				else
				{
					%>
						d.add(<%=i%>,<%=k%>,'<%=menudata[h][0]%>','<%=menudata[h][3]%>','','UserFrame','img/page.gif');
					<%
					i= i+1;
				}
			}
		%>
		
	 document.write(d);

	 //-->
	</script>

<%
}
catch(Exception e)
{
	 out.println(e.getMessage());
}
%>
</div>