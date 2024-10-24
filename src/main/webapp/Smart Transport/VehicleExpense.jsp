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
 
<script language="javascript" src="../JavaScript/Transport/VehicleExpenseAjax.js" ></script>

<script language="JavaScript">

 function Add()
	{ 
			document.frm.action="VehicleExpenseAdd.jsp";
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
			document.frm.action="VehicleExpenseEdit.jsp";
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadVechicleExpense('0')"  >
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
        <td height="31" ><div align="center" class="whiteMedium">VEHICLE INFORMATION </div></td>
      </tr>
      <tr >
        <td height="31" align="center" ><table width="441" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
          <tr>
            <td height="29"  >Month</td>
            <td><span  ><span  >
              <select name="Month"   id="Month" style="width:100" onChange="LoadVechicleExpense('0')">
                <option value="Select">Select</option>
                <%@ include file="../JavaScript/months.jsp" %>
              </select>
            </span></span></td>
            <td  >Year</td>
            <td><span  ><span  >
              <select name="Year"   id="Year" style="width:100" onChange="LoadVechicleExpense('0')">
                <!--<option value="Select">Select</option>-->
                <%@ include file="../JavaScript/years.jsp" %>
              </select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('Month',month1);
						setOptionValue('Year',year1);							
				//-->
          </script>
            </span></span></td>
            </tr>
        </table></td>
      </tr>
      <tr >
        <td height="31" ><table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteMedium">
          <tr>
            <td><div align="center"><strong>S.No</strong></div></td>
            <td><div align="center"><strong>Date</strong></div></td>
            <td><div align="center"><strong>Amount</strong></div></td>
          </tr>
        </table></td>
      </tr>
      <tr class="MRow1">
        <td height="127" valign="top" class="footermenu">
		
		
		 
			  <div id="GroupTable" style="OVERFLOW:auto;width:100%;height:250px"  >
              <br>
              </div><div align="center" id="totalrec"></div> 
			  <br>		</td>
      </tr>
    </table>	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="800" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr  >
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('0')">All</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('A')">A</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('B')">B</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('C')">C</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('D')">D</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('E')">E</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('F')">F</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('G')">G</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('H')">H</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('I')">I</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('J')">J</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('K')">K</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('L')">L</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('M')">M</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('N')">N</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('O')">O</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('P')">P</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('Q')">Q</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('R')">R</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('S')">S</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('T')">T</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('U')">U</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('V')">V</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('W')">W</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('X')">X</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('Y')">Y</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadVechicleExpense('Z')">Z</a></div>				</td>
			</tr>
		</table></td>
  </tr>
  <tr>
    <td> 
      <input name="filename" type="hidden" value="VehicleExpense" />
      <input name="actionS"
									type="hidden" value="TRSVehicleExpenseDelete" /></td>
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
