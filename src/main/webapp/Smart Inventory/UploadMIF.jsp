   <%@ page language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
 
<title>:: INVENTORY ::</title>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>

<script language="javascript" src="../JavaScript/comfunction.js"></script>

<script language="javascript">
function Load()
{
	try
	{
  		if(
		
			checkNullSelect("customer","Select the customer","")
			&& checkNullSelect("location","Select the location","")
			&& checkNullSelect("equipmenttype","Select the equipmenttype","")
			&& checkNullSelect("model","Select the model","")
			&& checkNull('file','Select Excel file ')
			
			) 
  		{
			 
			var file = document.getElementById("file").value
			 
			var fileExtn = file.lastIndexOf(".");
			 
			var Extn=file.substring(fileExtn);
			 
			if((Extn == ".xls") ||(Extn == ".XLS")  )
			{
				 
				var query="UploadMIFResponse.jsp?filename=AttendanceRegister"; 
				query = query+"&location="+document.getElementById("location").value;
				query = query+"&equipmenttype="+document.getElementById("equipmenttype").value;
				query = query+"&customer="+document.getElementById("customer").value;
				query = query+"&model="+document.getElementById("model").value;
				query = query+"&category="+document.getElementById("category").value;
				query = query+"&fileExtn="+Extn;
				//alert(query);
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
	catch(err)
	{
		alert(err.description);
	} 
}  
	
	
 	
	
var isIE;
var req;
var names;

 
function initRequest(url) 
{
    if (window.XMLHttpRequest) 
    {
        req = new XMLHttpRequest();
    } 
    else if (window.ActiveXObject) 
    {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}
 
 
 
function LoadEquipementModel()
{
	try
	{
		var equipmenttype = document.getElementById('equipmenttype').value;
	 	var url = "../inventory?actionS=LoadEquipementModel&startLetter=0&equipmenttype="+equipmenttype;
	 	initRequest(url);
		req.onreadystatechange=LoadEquipementModelRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function LoadEquipementModelRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	 var _targ=document.getElementsByName('model')[0];       
	    	 _targ.options.length=0;
	    	 _targ.options[0]=new Option('Select Equipment model','0');  
	    	if (req.status == 200) 
	        {		  	
	    		LoadEquipementModelMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function LoadEquipementModelMessages() 
{	 
 try
 {
	  
	 var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	 var _targ=document.getElementsByName('model')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select Equipment model','0');  
     var str=""; 
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
	 {	     
        var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var Model = batch.getElementsByTagName("Model")[0].childNodes[0].nodeValue;
	   _targ.options[loop+1]=new Option(Model,Rowid);
	 }
      
	
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}
		
 </script>
 
 
 
</head>

<body  onpaste='return false;'>
 <form  AUTOCOMPLETE = "off"   id="form1" name="uploadForm" action="" 	enctype="multipart/form-data" method="post" onSubmit="return Load()">
<br>
<table width="100%" border="0">
  <tr>
    <td align="center"> <table width="708" border="0" cellpadding="2" cellspacing="1">
      <tr class="MRow3">
        <td  class="boldEleven"><span class="boldEleven">Customer</span></td>
        <td  class="boldEleven"><span class="boldEleven">Location(State)</span></td>
        <td  class="boldEleven"><span class="boldEleven">Equipment type</span></td>
        <td  class="boldEleven"><span class="boldEleven">Equipment Model</span></td>
        <td   class="boldEleven"><span class="boldEleven">Category</span></td>
        <td  class="boldEleven"><span class="boldEleven">Serial Number</span></td>
        <td  class="boldEleven"><span class="boldEleven">Description</span></td>
        <td  class="boldEleven"><span class="boldEleven">Start dt</span></td>
        <td  class="boldEleven"><span class="boldEleven">End dt</span></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td><span class="boldEleven">SMART</span></td>
        <td align="right"><span class="boldEleven">2</span></td>
        <td><span class="boldEleven">DMP</span></td>
        <td><span class="boldEleven">WEP LX540DX</span></td>
        <td><span class="boldEleven">A</span></td>
        <td><span class="boldEleven">09LLX071072</span></td>
        <td>&nbsp;</td>
        <td align="right"><span class="boldEleven">2013-08-01</span></td>
        <td align="right"><span class="boldEleven">2013-08-01</span></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td><span class="boldEleven">SMART</span></td>
        <td align="right"><span class="boldEleven">2</span></td>
        <td><span class="boldEleven">DMP</span></td>
        <td><span class="boldEleven">WEP LX540DX</span></td>
        <td><span class="boldEleven">A</span></td>
        <td><span class="boldEleven">09LLX071078</span></td>
        <td>&nbsp;</td>
        <td align="right"><span class="boldEleven">2013-08-01</span></td>
        <td align="right"><span class="boldEleven">2013-08-01</span></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="center">
   
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
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
          <td height="18" colspan="2"  class="copyright">UPLOAD MIF </td>
        </tr>
         
        <tr class="bolddeepblue">
          <td height="22" valign="middle" class="boldEleven">Customer <span class="errormessage">*</span></td>
          <td valign="top" class="bolddeepblue">
          <select name="customer" class="formText135" id="customer" style="width: 200" >
          <option value="">Select Customer </option>
          <jsp:include page="LoadCustomer.jsp" />
          </select></td>
        </tr>
        <tr class="bolddeepblue">
          <td width="132" height="22" valign="middle" class="boldEleven">State<font
								color='red'> <span class="errormessage">*</span></font></td>
          <td width="268" valign="top" class="bolddeepblue"><select name="location" id="location" class="formText135" style="width: 200"   >
            <option value="" selected="selected">Select location</option>
            <%
String	stateData[][]= CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME,CHR_SHORTNAME FROM com_m_state   ORDER BY CHR_STATENAME");
for(int u=0;u<stateData.length;u++)
	out.println("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+" [ "+stateData[u][0]+" ] </option>");
																	%>
          </select></td>
        </tr>
        <tr>
          <td class="boldEleven">Equipment Type <span class="errormessage">*</span></td>
          <td> <select name="equipmenttype" id="equipmenttype" class="formText135" style="width: 200"  onChange="LoadEquipementModel()">
            <option value="">Select equipmenttype </option>
            <%
String	typeData[][]= CommonFunctions.QueryExecute("SELECT INT_EQUIPEMENTTYPEID,CHR_EQUIPEMENTTYPENAME  FROM spare_m_equipement_type   ORDER BY CHR_EQUIPEMENTTYPENAME");
for(int u=0;u<typeData.length;u++)
	out.println("<option value='"+typeData[u][0]+"'>"+typeData[u][1]+" [ "+typeData[u][0]+" ]</option>");
																	%>
          </select>
 </td>
        </tr>
        <tr>
          <td class="boldEleven">Equipment Model <span class="errormessage">*</span></td>
          <td>
          <select name="model" class="formText135" id="model"  style="width: 200" >
           <option value="">Select Model</option>
          </select></td>
        </tr>
        <tr>
          <td class="boldEleven">Category <span class="errormessage">*</span></td>
          <td><select name="category" class="formText135" id="category"  style="width: 200">
          <option value="A" selected>AMC</option>
          <option value="W">Warranty</option>
          <option value="O">Oncall</option>
          </select></td>
        </tr>
         
        <tr>
          <td class="boldEleven">File <span class="errormessage">*</span></td>
          <td><input name="file" type="file" class="formText135" id="file"  /></td>
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
