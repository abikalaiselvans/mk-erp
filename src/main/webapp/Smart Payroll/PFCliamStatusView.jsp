
<html>
<head>

<title> :: PAYROLL ::</title>


 


 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript" src="../JavaScript/Payroll/PFCliamStatus.js"></script>
<script language="javascript">
 
 function sEdit()
 	{		
 		var count=0;
 	    sel=document.forms[0].rowid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].rowid.checked)
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
			document.frm.action="PFCliamStatusEdit.jsp";
			document.frm.submit();
			return true;
		}
 	}
 	
	function Add()
 	{		
		document.frm.action="PFCliamStatus.jsp";
		document.frm.submit();
 	}		

	function sDelete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].rowid
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
			if (document.forms[0].rowid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				document.frm.submit();
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

 
 
  
		 
	
	
	
function Validate()
{
	
	 
	if(
		 
		 checkNullSelect('empid','Select Staff Name','0') 
		&& checkNull('comments','Enter the comments')  )
		return true;
	else
		return false;
}

 
</script>
<%@ include file="index.jsp"%>

<body  onpaste="return false;" onLoad="loadPFCliamStatus('0')">

<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="42">&nbsp;</td>
	</tr>
	<tr>
		<td>
		
		
		  <table width="90%" height="82" border="1" align="center" cellpadding="0" cellspacing="0"    >
            <!--DWLayoutTable-->
            <tr align="center" valign="middle"  >
              <td height="28" class="tablehead">PF CLIAM  </td>
            </tr>
            <tr class="BackGround">
              <td height="31" class="BackGround" ><table width="66%" border="0" align="center" cellpadding="1" cellspacing="1" class="boldEleven">
                  <tr>
                    <td><span class="boldThirteen"><strong>Month</strong></td>
                    <td><span class="boldThirteen">
                      <select name="month" id="month"   onChange="loadPFCliamStatus('0')">
                        <option value="0">All</option>
                        <%@ include file="../JavaScript/months.jsp" %>
                      </select>
                    </span> </td>
                    <td><strong>Year</strong></td>
                    <td><span class="boldThirteen">
                      <select name="year" id="year"   onChange="loadPFCliamStatus('0')">
                        <%@ include file="../JavaScript/years.jsp" %>
                      </select>
                      <script language='JavaScript' type="text/javascript">
							<!--			
								var d=new Date()
								var month1=d.getMonth() + 1
								var day=d.getDate()
						if(day<10) day="0"+day;
								if(month1<10) month1="0"+month1;
								var year1=d.getFullYear();
								setOptionValue('month',month1);
								setOptionValue('year',year1);	
								 							
							//-->
         			  </script>
                    </span> </td>
                  </tr>
              </table></td>
            </tr>

            <tr>
              <td height="21" valign="top"><div id="PFTable" style="OVERFLOW:auto;width:100%;height:300px" ></div>
          </table>
			</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><table  width="90%" border="0" align="center" cellpadding="1" cellspacing="1"  >
          <tr class="para">
            <td height="22" ><div align="center"><a href="javascript:loadPFCliamStatus('0')">ALL</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('A')">A</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('B')">B</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('C')">C</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('D')">D</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('E')">E</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('F')">F</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('G')">G</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('H')">H</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('I')">I</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('J')">J</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('K')">K</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('L')">L</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('M')">M</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('N')">N</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('O')">O</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('P')">P</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('Q')">Q</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('R')">R</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('S')">S</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('T')">T</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('U')">U</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('V')">V</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('W')">W</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('X')">X</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('Y')">Y</a></div></td>
            <td ><div align="center"><a href="javascript:loadPFCliamStatus('Z')">Z</a></div></td>
          </tr>
        </table></td>
	<tr>
	  <td>&nbsp;</td>
  <tr>
    <td><table width="209"  border="0" align="center" cellpadding="2" cellspacing="2">
      <tr>
        <td width="56"><input class="tMLAscreenHead" name="submit2" type="submit" onClick=Add() value="Add"></td>
        <td  width="56"><input name="btnEdit" type="submit" class="tMLAscreenHead" id="Edit" onClick="return sEdit()" value="Edit"></td>
        <td  width="56"><input name="btnDelete" type="submit" class="tMLAscreenHead" id="Delete" onClick="return sDelete()" value="Delete"></td>
        <td  width="47"><input class="tMLAscreenHead" type="button" name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
      </tr>
    </table></td>
  <tr>
    <td><input name="filename" type="hidden" id="filename" value="PFCliamStatus">
    <input name="actionS" type="hidden" id="actionS" value="PAYPFCliamStatusDelete"></td>
  <tr>
	  <td>&nbsp;</td>
</table>
 
<%@ include file="../footer.jsp"%>
</form>	
</body>

</html>
