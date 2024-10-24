  <%@ page import="java.sql.*,java.util.*,java.io.*"%>
  <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


<html>
<head>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>

<title> :: TRANSPORT ::</title>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Transport/Model.js"></script>
<script language="JavaScript">

 function Add()
	{ 
			document.frm.action="ModelAction.jsp";
 	}


	function BEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id
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
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ModelAction.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
		
 	}	

 	function FDelete()
 	{		
		var count;
		count=0;
		 
		coffee1=document.forms[0].id
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
			if (document.forms[0].id.checked) { count=1;}
		}
		 
		if(count>0)
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadModel('0')">
 <%@ include file="index.jsp"%>
<form name='frm'   method="post">

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>
	
	
	<table width="90%" height="227" align="center" cellpadding="1" cellspacing="1" class="TableDesign"  >
      <!--cellpadding="0" cellspacing="0"  
			 >-->
      <tr  >
        <td height="31"  ><div align="center" class="whiteMedium">VEHICLE MODEL </div></td>
      </tr>
      <tr  >
        <td height="31" align="center"  ><table width="258" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
          <tr>
            <td >Make</td>
            <td><select name="vehiclemake" class="formText135"  id="vehiclemake" onChange="LoadModel('0')">
			<option value="0">All</option>
			<%
			
			String	readData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_MAKEID,CHR_MAKENAME FROM   veh_m_make ORDER BY CHR_MAKENAME");
			for(int u=0;u<readData.length;u++)
				out.println("<option value='"+readData[u][0]+"'>"+readData[u][1]+"</option>");
			%>
            </select>            </td>
          </tr>
        </table></td>
      </tr>
      <tr  >
        <td height="31"  ><div align="center">
            <table width="100%" border="0" cellpadding="1" cellspacing="1" class="whiteMedium">
              <tr  >
                <td width="5%" >S.No.</td>
                <td width="10%"></td>
                <td width="35%" >Model Name</td>
                <td width="50%" >Vehicle Make </td>
              </tr>
            </table>
        </div></td>
      </tr>
      <tr class="MRow1">
        <td height="127" valign="top" class="footermenu"><table width="100%">
         
            <tr>
              <td class="bolddeepblue" align="center" bgcolor="#efefef"></td>
            </tr>
            <tr>
              <td>
			  <div id="divscroll" style="OVERFLOW:auto;width:100%;height:300px"
							class="boldEleven">
                  <div id="GroupTable"></div>
              </div></td>
            </tr>
			   <tr>
              <td class="bolddeepblue" align="center"><div align="center" id="totalrec"></div></td>
            </tr>
        </table></td>
      </tr>
    </table>	</td>
  </tr>
  <tr>
    <td height="15">&nbsp;</td>
  </tr>
  <tr>
    <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('0')">All</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('A')">A</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('B')">B</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('C')">C</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('D')">D</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('E')">E</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('F')">F</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('G')">G</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('H')">H</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('I')">I</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('J')">J</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('K')">K</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('L')">L</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('M')">M</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('N')">N</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('O')">O</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('P')">P</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('Q')">Q</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('R')">R</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('S')">S</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('T')">T</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('U')">U</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('V')">V</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('W')">W</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('X')">X</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('Y')">Y</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadModel('Z')">Z</a></div>				</td>
			</tr>
		</table></td>
  </tr>
  <tr>
    <td height="15"><input type="hidden" name="filename" value="Model">
      <input type="hidden" name="actionS" value="TRSModelDelete"></td>
  </tr>
  <tr>
    <td><table border="0" align="center" cellpadding="1" cellspacing="1">
      <tr>
        <td width="56"><input type="submit" class="ButtonHead"
					onClick="Add()" name="action1" value="Add"></td>
        <td width="56"><input type="submit" class="ButtonHead" id="Edit"
					onClick="return BEdit()" name="action1" value="Edit"></td>
    
	
<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Delete" id="Delete" value="Delete"
					onClick="return FDelete()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>



	
	    
        <td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('Transportmain.jsp')"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
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
