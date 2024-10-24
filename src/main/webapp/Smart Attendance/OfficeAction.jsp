<%@ page import="java.io.*,java.util.*"%>
<%!
	String OfficeName,OfficeDes,OfficeId,shortname;
	String actionStu;
%>
<%@ page import="com.my.org.erp.bean.Attendance.Office"%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="javascript" src="../JavaScript/Inventory/InventAJAX.js"></script>
<script language="javascript">
 <%
      try
       {
    	  ArrayList OfficeList=(ArrayList) session.getAttribute("OfficeList");
        int i=0;
%>  var Officeitems=[<%        
        while(i<OfficeList.size())
        {
        	Office office= (Office)OfficeList.get(i); 
        	if(i==0){
        		OfficeId=""+office.getOfficeId();
        		OfficeName=(String)office.getOfficeName();
	             %>["<%=OfficeId%>","<%=OfficeName%>"] <% }
             else{
            	 OfficeId=""+office.getOfficeId();
            	 OfficeName=(String)office.getOfficeName();
            	 %> ,["<%=OfficeId%>","<%=OfficeName%>"] <% }
              i++;       	
        }
%>];<%
       }
       catch(Exception e)
       {
    	   //System.out.println(e);
    	   
       }
%>
act="<%=request.getParameter("action1")%>";
bid="<%=request.getParameter("OptOfficeName")%>";

    function checkName()
  {	  	
        var aname=document.getElementById("TxtOfficeName").value;	  
	  	var message;
	  	var messageText;	  	
	  	if(true)
	  	{
          i=0;
          var userMessageElement = document.getElementById("off");
           aname=aname.toLowerCase();
           aname=Trim(aname);
          // aname=aname.toUpperCase();
          while(i<Officeitems.length)
          {
            id=Officeitems[i][0];
            allowitem=Officeitems[i][1].toLowerCase();
            if(act=="Edit" && id==bid)
            {
            	window.status="Valid Name";
                message="true";
                break;
            }
            if(aname==allowitem)
            {
               window.status="Already Exists";
               message="false";
               break;
            }
            else{
	            window.status="Valid Name";
                message="true";
            }
            i++;
          }           
	     if (message == "false" || aname=="") {
	         userMessageElement.style.color = "red";
	         messageText = " Already Exists";
	         document.getElementById("submit").disabled=true;
	     } else {
	         userMessageElement.style.color = "green";
	         messageText = "Valid Name";
   	         document.getElementById("submit").disabled=false;
	     }
	     var messageBody = document.createTextNode(messageText);
	     if (userMessageElement.childNodes[0]) 
	     {
	         userMessageElement.replaceChild(messageBody, userMessageElement.childNodes[0]);
	     }
	     else 
	     {
	         userMessageElement.appendChild(messageBody);
	     }
	    
	    }
       
  }
  function validate()
  {
  	if(checkNull('TxtOfficeName','Enter Office Name'))
  		document.frmOffice.action="../SmartLoginAuth";  
  	
  }
  function set()
  {
     document.frmOffice.TxtOfficeName.focus();
  }
  function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  } 
  function mainPage()
  {
    // document.frmOffice.action="../RemoveSession";     
	history.back(1);
  } 
  </script>
</head>

<%   
  	String action=request.getParameter("action1");
	//courseName=""+request.getParameter("courseName");
	//courseId=request.getParameter("TxtCourseId");
	ArrayList OfficeList=(ArrayList) session.getAttribute("OfficeList");
	if(action.equals("Edit")){
		 actionStu="ATTOfficeEdit";
		 OfficeId=request.getParameter("OptOfficeName");		 
		 for(int i=0;i<OfficeList.size();i++)
		 {
			Office office= (Office)OfficeList.get(i);
			if(office.getOfficeId()==Integer.parseInt(OfficeId)){
				OfficeName=office.getOfficeName();
				OfficeDes=office.getOfficeDes();
				shortname=office.getOfficeshortname();
				break;
			}
		 }
	}else{
		actionStu="ATTOfficeAdd";
		OfficeName="";
		OfficeDes="";
		shortname="";
	}
	
%>

<body  onpaste="return false;" >
<%@ include file="index.jsp"%>

<form action="../SmartLoginAuth"   method="get" name='frmOffice'  AUTOCOMPLETE="off">
  <p><br>
  </p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><table class="BackGround" cellspacing="0" cellpadding="0" width="424"
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
            <td width="412"><table width="425" border="0" cellspacing="2" cellpadding="2"
						 >
                <!--DWLayoutTable-->
                <tr align="center" valign="middle">
                  <td height="28" colspan="2" class="BackGround" >OFFICE </td>
                </tr>
                <tr>
                  <td width="150" height="29" valign="middle" class="boldEleven">Office <font color="#ff0000">*</font></td>
                  <td width="246" valign="middle"><input name="TxtOfficeName"
								type="text" class="formText135" id="TxtOfficeName" onBlur="TxtTrim(this)"
								onKeyPress="charOnly('TxtOfficeName','24')"
								onKeyUp="upperMe(this), checkName()" value="<%= OfficeName %>"
								size="35">
                      <div id="off"></div></td>
                </tr>
                <tr>
                  <td height="29" valign="top" class="boldEleven">Description</td>
                  <td valign="middle"><textarea name="TxtOfficeDes"   id="TxtOfficeDes" cols="35" rows="5" class="formText135" onKeyPress="textArea('TxtOfficeDes','200')"><%= OfficeDes %></textarea></td>
                </tr>
                <tr>
                  <td height="29" valign="middle" class="boldEleven">Office Shortname <font color="#ff0000">*</font></td>
                  <td valign="middle"><input name="shortname"
								type="text" class="formText135" id="TxtOfficeName" onBlur="TxtTrim(this)"
								 onkeyup="upperMe(this), CheckUniqueNO(this,'soValid1',' com_m_office ',' CHR_OFFICESHORTNAME ')"
								 value="<%=shortname %>"
								size="35" maxlength="3">
                      <div id=soValid1></div></td>
                </tr>
                <tr>
                  <td height="29" colspan="2" valign="middle" class="bolddeepblue"><input
								type="HIDDEN" name="filename" value="Office">
                      <input
								type="HIDDEN" name="actionS" value="<%=actionStu %>">
                      <input
								type="HIDDEN" name="OfficeId" value="<%= OfficeId %>">
                      <table border="0" align="center" cellpadding="3" cellspacing="3">
                        <tr>
                          <td width="56"><input type="submit" disabled="disabled"
										id="submit" name="Submit" class="buttonbold" value="Submit"   accesskey="s"   
										onClick="return validate()"></td>
                          <td width="56"><input name="Button" type="button"
										class="buttonbold"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
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
    <tr>
      <td>&nbsp;</td>
    </tr>
  </table>

</form>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</html>
