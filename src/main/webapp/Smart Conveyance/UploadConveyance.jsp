  <%@ page language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
 
<title>:: CONVEYANCE ::</title>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>

<script language="javascript" src="../JavaScript/comfunction.js"></script>

<script language="javascript">
    function Load()
  	{
  		if(
		
			checkNull('file','Select Excel file ')
			
			)
  		{
			 
			var file = document.getElementById("file").value
			 
			var fileExtn = file.lastIndexOf(".");
			 
			var Extn=file.substring(fileExtn);
			 
			if((Extn == ".xls") ||(Extn == ".XLS")  )
			{
				 
				var query="UploadConveyanceCopy.jsp?filename=Conveyance"; 
				query = query+"?fileExtn="+Extn;
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
    <p class="bolddeepred">The excel file contains the data in the following format as well as the file in .xls(sheet1) format  <a href="../uploads/Coonveyance.xls" target="_blank">Download sample format</a></p>
           
             <table width="686" align="center"  cellpadding=2 cellspacing=1 bgcolor='#9900CC'  class="boldEleven">
 <TR>
   <Th bgColor=#ffffff class="boldEleven">Date</Th>
							<Th bgColor=#ffffff class="boldEleven">From</Th>
							<Th bgColor=#ffffff class="boldEleven">To</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Vehicle No of Kms</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Call Number </Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Train / Bus Fare</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Auto Fare</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Lunch / Dinner</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Telephone Charges</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Others Desc</Th>
							<Th align=middle bgColor=#ffffff class="boldEleven">Others Amt</Th>
			   </TR>
						<TR>
						  <TD bgColor=#ffffff class="boldEleven">yyyy-mm-dd</TD>
							<TD bgColor=#ffffff class="boldEleven">Office</TD>
							<TD bgColor=#ffffff class="boldEleven">Clientplace</TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"><div align="center">20</div></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven">Call-1</TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"><div align="center">45</div></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"><div align="center">150</div></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"><div align="center">100</div></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"><div align="center">20</div></TD>
							<TD align=middle bgColor=#ffffff class="boldEleven">Printout &amp; scanning </TD>
							<TD align=middle bgColor=#ffffff class="boldEleven"><div align="center">150</div></TD>
						</TR>
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
          <td height="18" colspan="2"  class="copyright">UPLOAD CONVRYANCE </td>
        </tr>
         
        
        <tr>
          <td width="137" class="boldEleven">File</td>
          <td width="269"><input type="file" name="file" id="file"  /></td>
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
