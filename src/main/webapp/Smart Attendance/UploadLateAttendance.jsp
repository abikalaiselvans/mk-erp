  <%@ page language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
 
<title>:: ATTENDANCE ::</title>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>

<script language="javascript" src="../JavaScript/comfunction.js"></script>

<script language="javascript">
    function Load()
  	{
  		if(
		
			checkNullSelect("month","Select the month","0")
			&& checkNullSelect("year","Select the year","0")
			&& checkNull('file','Select Excel file ')
			
			)
  		{
			 
			var file = document.getElementById("file").value
			 
			var fileExtn = file.lastIndexOf(".");
			 
			var Extn=file.substring(fileExtn);
			 
			if((Extn == ".xls") ||(Extn == ".XLS")  )
			{
				var query="UploadLateAttendanceCopy.jsp?filename=AttendanceRegister"; 
				query = query+"&month="+document.getElementById("month").value;
				query = query+"&year="+document.getElementById("year").value;
				query = query+"&fileExtn="+Extn;
				document.uploadForm.action=query;
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
 <form  AUTOCOMPLETE = "off"   id="form1" name="uploadForm" action="" 	enctype="multipart/form-data" method="post" onSubmit="return Load()">
<br>
<table width="100%" border="0">
  <tr>
    <td align="center">
    <p class="bolddeepred">The excel file contains the data in the following format as well as the file in .xls(sheet1) format </p>
           
             <table width="686" align="center"  cellpadding=2 cellspacing=1 bgcolor='#9900CC'  class="boldEleven">
  <tr class="MRow3">
    <td width="133">Userid</td>
    <td width="105">Employee id</td>
    <td width="67">Day</td>
    <td width="91">Date </td>
    <td width="86">Time</td>
    <td width="171">EMP Name</td>
  </tr>
  <tr class="MRow1">
    <td align="left" width="50">004220</td>
    <td width="126" align="left">CISFEB2014004220</td>
    <td align="left" width="51">23</td>
    <td align="left" width="101">2015-02-23</td>
    <td align="left" width="64">9.15</td>
    <td>&nbsp;</td>
  </tr>
  <tr class="MRow1">
    <td align="left">002804</td>
    <td align="left">CISMAY2010002804</td>
    <td align="left">21</td>
    <td align="left">2015-02-23</td>
    <td align="left">9.16</td>
    <td>&nbsp;</td>
  </tr>
  <tr class="MRow1">
    <td align="left">001846</td>
    <td align="left">CISDEC2007001846</td>
    <td align="left">21</td>
    <td align="left">2015-02-23</td>
    <td align="left">9.17</td>
    <td>&nbsp;</td>
  </tr>
  <tr class="MRow1">
    <td align="left">003358</td>
    <td align="left">CISJAN2011003358</td>
    <td align="left">23</td>
    <td align="left">2015-02-23</td>
    <td align="left">9.18</td>
    <td>&nbsp;</td>
    </tr>
</table>
            <p>&nbsp;</p>
    </td>
  </tr>
  <tr>
    <td><table class="BackGround" cellspacing="0" cellpadding="0" width="390"
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
          <td height="18" colspan="2"  class="copyright">UPLOAD ATTENDANCE </td>
        </tr>
         
        <tr class="bolddeepblue">
          <td width="132" height="22" valign="middle" class="boldEleven">Month<font
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
		  </td>
        </tr>
        <tr>
          <td class="boldEleven">Year</td>
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
          <td class="boldEleven">File</td>
          <td><input type="file" name="file" id="file"  /></td>
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
</table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>

<br>


</form>
</body>
</html>
