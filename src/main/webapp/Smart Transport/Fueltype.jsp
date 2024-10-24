<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>

<html>
<head>
<title>::  MANAGEMENT ::</title>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Transport/Fueltype.js"></script>
<script language="JavaScript">

 function Add()
	{ 
			document.frm.action="FuelAction.jsp";
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
			document.frm.action="FuelAction.jsp";
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadFuelType('0')">
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
	
	
	<table height="227" align="center" cellpadding="1" cellspacing="1" class="TableDesign"  >
      <!--cellpadding="0" cellspacing="0"  
			 >-->
      <tr >
        <td height="31" ><div align="center" class="whiteMedium">Fuel Type  </div></td>
      </tr>
      <tr >
        <td height="31" ><div align="center">
            <table width="100%" border="0" cellpadding="1" cellspacing="1" class="whiteMedium">
              <tr >
                <td width="2%" >S.No.</td>
                <td width="1%"></td>
                <td >Name</td>
              </tr>
            </table>
        </div></td>
      </tr>
      <tr class="MRow1">
        <td height="127" valign="top" class="footermenu">
		 
			  <div id="GroupTable" style="OVERFLOW:auto;width:100%;height:300px" class="boldEleven">              </div> <br>
			  <div id="totalrec"></div><br>
			  
			  </td>
      </tr>
    </table>	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('0')">All</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('A')">A</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('B')">B</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('C')">C</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('D')">D</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('E')">E</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('F')">F</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('G')">G</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('H')">H</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('I')">I</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('J')">J</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('K')">K</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('L')">L</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('M')">M</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('N')">N</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('O')">O</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('P')">P</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('Q')">Q</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('R')">R</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('S')">S</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('T')">T</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('U')">U</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('V')">V</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('W')">W</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('X')">X</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('Y')">Y</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:LoadFuelType('Z')">Z</a></div>				</td>
			</tr>
		</table></td>
  </tr>
  <tr>
    <td><input type="hidden" name="filename" value="FuelType">
      <input type="hidden" name="actionS" value="TRSFuelDelete"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
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
