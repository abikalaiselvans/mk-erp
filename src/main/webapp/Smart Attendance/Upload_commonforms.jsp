
<html>
<head>

<title> :: ATTENDANCE ::</title>


</head>
</html>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript"> loadServer() </script>

 <script language="javascript">
 function  validate()
 {
 	if( checkNull( "filename_1","Select File 1" ) )
		return true;
	else
		return false;				
		
 }
 </script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index.jsp"%> </td>
  </tr>
  <tr>
    <td height="480" align="center"><table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block" /></td>
          <td width="412" valign="top">
		  <form action="../uploadservlets" method="post" enctype="multipart/form-data" onSubmit="return validate()">
		  
		  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"> FILE UPLOAD
                   
                    <input type="HIDDEN" name="filename" value="Upload">
                    <input
										type="HIDDEN" name="actionS" value="ATTUpload">
                    <input name="redirect" type="hidden" id="redirect" value="Smart Attendance/HRFORMS.jsp">
                    <input name="uploadpath" type="hidden" id="uploadpath" value="uploadfiles/FORMS/">
                </div></td>
              </tr>
              
              <tr>
                <td width="31%" class="boldEleven"><strong>1. </strong></td>
                <td width="69%" class="boldEleven"><input id="filename_1" type="file" name="filename_1" size="50"/>                    </td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven"><strong>2.</strong></td>
                <td valign="top" class="boldEleven"><input id="filename_2" type="file" name="filename_2" size="50"/></td>
              </tr>
              <tr>
                <td class="boldEleven"><strong>3.</strong></td>
                <td class="boldEleven"><input id="filename_3" type="file" name="filename_3" size="50"/></td>
              </tr>
              <tr>
                <td class="boldEleven"><strong>4.</strong></td>
                <td class="boldEleven"><input id="filename_4" type="file" name="filename_4" size="50"/></td>
              </tr>
			  <tr>
                <td class="boldEleven"><strong>5.</strong></td>
                <td class="boldEleven"><input id="filename_5" type="file" name="filename_5" size="50"/></td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven">
				<table   border="0" align="center" cellpadding="1"
									cellspacing="1">
                    <tr>
                      <td width="100"><input name="submit" type="submit" value="Upload File"  class="buttonbold13" /></td>
                      
                      <td width="56"><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"   onClick="redirect('HRFORMS.jsp')"></td>
                    </tr>
                </table></td>
              </tr>
          </table>
		  
		  </form>
		  
		  
		  </td>
          <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
      </tbody>
    </table>	</td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%> </td>
  </tr>
</table>

 


