<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<title> :: PAYROLL ::</title>


 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<script language="javascript" src="../JavaScript/comfunction.js"></script>

<script language="javascript">
    function Validate()
  	{
  		if(
		
			checkNullSelect("recovery","Select recovery","0")
			&& checkNullSelect("month","Select the month","0")
			&& checkNullSelect("year","Select the year","0")
			&& checkNull('file','Select Excel file ')
			
			)
  		{
			 
			var file = document.getElementById("file").value
			 
			var fileExtn = file.lastIndexOf(".");
			 
			var Extn=file.substring(fileExtn);
			 
			if((Extn == ".xls") ||(Extn == ".XLS")  )
			{
				return true;
			}
			else
			{
				alert("Only possible XLS file only");
				return false;
			}
		}
   		else
		{
   			
			return false;
  		}
		
 	}  
 </script>
 
 
 
</head>

<body  onpaste='return false;'>
<p>&nbsp;</p>
<p>&nbsp;</p>

  
<form name="frm" enctype="multipart/form-data" action="UploadUpdateRecoveryCopy1.jsp" method="post" onSubmit="return Validate()">

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
      <td width="412"><table width="420" border="0" cellspacing="2" cellpadding="2"
						 >
        <!--DWLayoutTable-->
        <tr align="center" valign="middle">
          <td height="18" colspan="2"  class="BackGround">UPLOAD RECOVERY </td>
        </tr>
        <tr>
          <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2" class="boldEleven"><p class="bolddeepred">The excel file contains the data in the following format as well as the file in .xls(sheet1) format </p>
            <p class="bolddeepred">and removed the column names like <strong>Emp Id</strong>,<strong>Amount</strong></p>
            <table width='60%' align="center"     cellpadding=2 cellspacing=1 bgcolor='#00008B'  class='formText135'  id='myTable' >
              <tr class="MRow1">
                <td width="147"><strong>Emp Id</strong></td>
                <td width="118"><strong>Amount</strong></td>
              </tr>
              <tr class="MRow1">
                <td>CISJUN2003000319</td>
                <td>5000</td>
              </tr>
              <tr class="MRow1">
                <td>CISJAN2007001347</td>
                <td>300 </td>
              </tr>
            </table>
            <p></p></td>
          </tr>
        <tr>
          <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
        <tr>
          <td class="boldEleven">Recovery</td>
          <td><select name="recovery" class="formText135" id="recovery">
            <option value="0">Select recovery</option>
            <%
	String RecoverySql=" SELECT CHR_RCODE,CHR_RNAME from pay_m_recovery where CHR_MONTHFLAG='Y'  order by INT_RECOVERYID ";
	String RecoveryData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(RecoverySql);
	if (RecoveryData.length>0)
		for (int i=0; i<RecoveryData.length; i++) 
			out.println("<option value="+RecoveryData[i][0]+">"+RecoveryData[i][1] +"</option>");			
	
						%>
          </select></td>
        </tr>
        <tr class="bolddeepblue">
          <td width="132" height="35" valign="middle" class="bolddeepblue">Month<font
								color='red'>&nbsp;</font></td>
          <td width="268" valign="top" class="bolddeepblue">
		  <select  name="month" id="month" class="formText135">
            <option value="select">Select Month</option>
            <option value="01">January</option>
            <option value="02">February</option>
            <option value="03">March</option>
            <option value="04">April</option>
            <option value="05">May</option>
            <option value="06">June</option>
            <option value="07">July</option>
            <option value="08">August</option>
            <option value="09">September</option>
            <option value="10">October</option>
            <option value="11">November</option>
            <option value="12">December</option>
          </select>
		  UploadUpdate</td>
        </tr>
        <tr>
          <td class="bolddeepblue">Year</td>
          <td><select name="year"  id="year" class="formText135">
            <option value="select">Select year</option>
            <%
			      for(int i=2000;i<=2050;i++)
			      {
			       out.println("<option value="+i+">"+i+"</option>");
			      }
			     %>
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
        <tr>
          <td class="bolddeepblue">File</td>
          <td><input type="file" name="file" id="file"  />
            <input name="filename" type="hidden" id="filename" value="UploadUpdate">
            <input name="actionS" type="hidden" id="actionS" value="PAYUploadUpdate"></td>
        </tr>
        <tr>
          <td height="28" colspan="2" valign="middle" class="bolddeepblue"><table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
            <tr>
              <td width="61"><input name="upload" type="submit"
										class="buttonbold14" id="submit" value="Upload"></td>
              <td width="60"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="javascript:window.close()"></td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td height="2"></td>
          <td></td>
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
</body>
</html>
