<%@ page import="java.io.*,java.util.*"%>
<%-- <%@ page import="sun.net.smtp.SmtpClient"%> --%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
 
<title>:: ASSET ::</title>



<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Asset/AssetEntry.js"></script>
<script language="JavaScript">
	function getDBPath()
	{
		var pathname = window.location.pathname;
		var iPos = window.location.pathname.toString().toLowerCase().lastIndexOf('.nsf');
		if(iPos>0) return pathname.substring(0, iPos+4);
		alert(pathname);
		return pathname; 
	} 

    function Add()
	{ 
		document.frm.action="AssetEntryAdd.jsp";		
 	}

	function REdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].assetid
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
				count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].assetid.checked) { count=1;}
		}
		if(count==1)
		{			
			document.frm.action="AssetEntryEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].assetid;
		txt=""
		var id="";
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			id=i;
			}
		}
		if(count==0)
		{
			if (document.forms[0].assetid.checked) { count=1;}
		}
		
		if(count>1)
		{
			alert("Kindly select one value");
			return false;
		}
		if(count==1)
		{			
			 var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
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
</script>

<body  onpaste="return false;" onLoad="LoadAssetEntry('0')">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	 
	<tr>
	  <td>	  </td>
	</tr>
	<tr>
		<td height="291"><table height="307" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
          <tr  >
            <td height="31"  ><div align="center" class="whiteMedium">ASSET ENTRY
			
			 
			</div></td>
          </tr>
          <tr  >
            <td height="31" align="center"  >
              <div align="center">
                <table width="100%"   border="0" align="center" cellpadding="2" cellspacing="2" class="whiteMedium">
                  <tr>
                    <td><strong>Branch
                      <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				 
			%>
                    </strong></td>
                    <td><span  >
                      <select name="Branch" class="formText135" id="Branch" tabindex="6"  onChange="LoadAssetEntry('0')" style="width:200">
                        <%
								
				String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
				if(usertype.equals("F"))
				{
				  for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
				else
				{
					 
					 for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
					 					
				}
						
							%>
                      </select>
                      <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						  </script>
                    </span></td>
                    <td><strong>Division</strong></td>
                    <td><span  >
                      <select name="divis"
							class="formText135" id="divis" tabindex="1"  onChange="LoadAssetEntry('0')"
							 style="width:200">
                        <option value='0'>All</option>
                        <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division");
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                      </select>
                    </span></td>
                  </tr>
                  <tr>
                    <td>Month</td>
                    <td><select name="month" id="month" onChange="LoadAssetEntry('0')" style="width:200">
                        <option value="0">All</option>
                        <%@ include file="../JavaScript/Inventory/month.jsp"%>
                    </select></td>
                    <td>Year</td>
                    <td><select name="year" id="year"
							 onChange="LoadAssetEntry('0')" style="width:200">
                        <%@ include file="../JavaScript/Inventory/year.jsp"%>
                        </select>
                    <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                      </script></td>
                  </tr>
                </table>
            </div></td>
          </tr>
           

          <tr>
            <td height="18" valign="top" class="footermenu">
<table width='100%' border='0'    cellpadding='0' cellspacing='0' class="whiteMedium">
<tr><td  ><b>S.No</b></td>
<td  ><b>Group</b></td>
<td  ><b>Item</b></td>
<td  ><b>Company</b></td>
<td  ><b>Branch</b></td>
<td  ><b>Division</b></td>
<td  ><b>PDate</b></td>
<td  ><b>PO</b></td>
<td  ><b>Serial</b></td>
<td  ><b>Status</b></td>
<td  ><b>Stock</b></td>
</tr></table>			</td>
          </tr>
          <tr class="MRow1">
            <td height="127" valign="top" class="footermenu">
			<div id="AssetEntry" style="OVERFLOW:auto;width:100%;height:240px" 	class="boldEleven"> </div>
			<br>						</td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
        <tr class="para">
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadAssetEntry('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	 
	<tr>
	  <td height="15"><input name="filename" type="hidden" value="AssetEntry" />
        <input
			name="actionS" type="hidden" value="ASSAssetEntryDelete" /></td>
    </tr>
	<tr>
	  <td><table width="224" border="0" align="center" cellpadding="01"
			cellspacing="0">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action12" id="btnEdit" value="Edit"
					onclick="return REdit()" /></td>
         
<%
	   
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Delete" id="Delete" value="Delete"
					onClick="return Delete()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>


          <td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('Assetmain.jsp')" /></td>
        </tr>
      </table></td>
    </tr>
</table>
 <%@ include file="../footer.jsp"%></form>
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