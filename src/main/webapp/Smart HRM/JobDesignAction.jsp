<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%
try
{
%>

<html>
<head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/commonAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/common/CheckUniqueAjax.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript">

//var dispmsg="";

function show_pop(dispmsg)
{
	var p=window.createPopup()
	var pbody=p.document.body
	pbody.style.backgroundColor="#ff0000"
	pbody.style.border="solid black 1px"
	pbody.innerHTML=dispmsg;
	p.show(350,550,200,25,document.body)
}


function isNumberFloat(inputString)
{
  	return (!isNaN(parseFloat(inputString))) ? true : false;
}
	

function salaryValue(ctr, len)
{
	var dot=".";
	var txtval = document.getElementById(ctr).value;
  	var keylen = txtval.length;
  	var dotlen;

	if(keylen<len)	
	{
			dotlen = txtval.indexOf(dot);

	  		if((txtval.indexOf(dot))==-1) 
			{

				if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13 || event.keyCode==46)
					 event.keyCode;				 
				else
					event.keyCode=0;

			
				if (keylen>(len-4))
				{
					dispmsg = "Value should be in Decimals";
					window.status="Values should be in Decimal";
					show_pop(dispmsg);
				}
			
			}
			else if ((keylen - dotlen)>2 )
			{
					dispmsg = "Only two Decimals Allowed";
					show_pop(dispmsg);
			}
			
			else if((txtval.indexOf(dot))!=-1) 
			{  
				if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13 )
					 event.keyCode;                  
				else
					event.keyCode=0;
			}


	}
	else
	{	
		event.keyCode=0;		
		window.status="Maximum char reached";
		dispmsg = "Max char reached";
		show_pop(dispmsg);
	}

}

function weightValue(ctr, len)
{
	var dot=".";
	var txtval = document.getElementById(ctr).value;
  	var keylen = txtval.length;
  	var dotlen;

	if(keylen<len)	
	{
			dotlen = txtval.indexOf(dot);

	  		if((txtval.indexOf(dot))==-1) 
			{

				if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13 || event.keyCode==46)
					 event.keyCode;				 
				else
					event.keyCode=0;

			
				if (keylen>(len-3))
				{
					dispmsg = "Value should be in Decimal";
					window.status="Values should be in Decimal";
					show_pop(dispmsg);
				}
			
			}
			else if ((keylen - dotlen)>2 )
			{
					dispmsg = "Only one Decimal Allowed";
					show_pop(dispmsg);
			}
			
			else if((txtval.indexOf(dot))!=-1) 
			{  
				if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13 )
					 event.keyCode;                  
				else
					event.keyCode=0;
			}


	}
	else
	{	
		event.keyCode=0;		
		window.status="Maximum char reached";
		dispmsg = "Max char reached";
		show_pop(dispmsg);
	}

}


	function checkTitle(ctr)
	{

		<% String sqltit = "SELECT CHR_JOBTITLE from  hrm_m_jobdesign "; %>		
		<% String base1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sqltit); %>

		var store1 = [<%
		
			int k=0;

			String departTit;

			while(k<base1.length)
			{
				departTit = base1[k][0];
		
					if (k==0)
					{
				%>		["<%=departTit%>","<%=k%>"]
	
				<%	
					}
					else
					{	
				%>
						,["<%=departTit%>","<%=k%>"]
				
				<%	}
	
					k++;
				}	
				
				%>];
			
			var tname = document.getElementById(ctr).value;

			tname= tname.toLowerCase();
			tname = Trim(tname);
			var msg1 = "Already Exists", msg2 = "Valid Name", msg;
			var flag=0;

			for (k=0; k<store1.length; k++)
			{
				baseval = store1[k][0].toLowerCase();	
				
				if (tname==baseval)
				{
						window.status=msg1;
						flag=1;
					break;
				}
				else
				{
					window.status=msg2;
				}

				if (tname == "")
					window.status="";
			}

			var msgElement = document.getElementById("titchk");
			
			
			if (flag==1)
			{
				msg = msg1;
				msgElement.style.color="Red";
			}
			else
			{
				msg = msg2;
				msgElement.style.color="Green";
			}
			var msgbody = document.createTextNode(msg);

			if (msgElement.childNodes[0])
			{
				if (tname=="")
				{
					msgElement.removeChild(msgElement.childNodes[0]);
				}
				else
				{
					msgElement.replaceChild(msgbody, msgElement.childNodes[0]);
				}				
			}
			else
			{
				msgElement.appendChild(msgbody);
			}
								


			if (msgElement.childNodes[0])
			{
				if (flag==0)
					document.getElementById('Submit').disabled=false;
				else
					document.getElementById('Submit').disabled=true;

			}				
	}	
	

	function checkCode(ctr)
	{
	
		<% 	String sqlcode = "SELECT CHR_JOBCODE from  hrm_m_jobdesign "; %>		

		<% String base2[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sqlcode); %>

		var store2 = [<%
		
			int m=0;

			String jcode;

			while(m<base2.length)
			{
				jcode = base2[m][0];
		
					if (m==0)
					{
				%>		["<%=jcode%>","<%=m%>"]
	
				<%	
					}
					else
					{	
				%>
						,["<%=jcode%>","<%=m%>"]
				
				<%	}
	
					m++;
				}	
				
				%>];
			
			
			var tname = document.getElementById(ctr).value;

			tname= tname.toLowerCase();
			tname = Trim(tname);
			var msg1 = "Already Exists", msg2 = "Valid Name", msg;
			var flag=0;

			for (m=0; m<store2.length; m++)
			{
				baseval = store2[m][0].toLowerCase();	
				
				if (tname==baseval)
				{
						window.status=msg1;
						flag=1;
					break;
				}
				else
				{
					window.status=msg2;
				}

				if (tname == "")
					window.status="";
			}

			var msgElement = document.getElementById("codechk");			
			
			
			if (flag==1)
			{
				msg = msg1;
				msgElement.style.color="Red";
			}
			else
			{
				msg = msg2;
				msgElement.style.color="Green";
			}
			var msgbody = document.createTextNode(msg);

			if (msgElement.childNodes[0])
			{
				if (tname=="")
				{
					msgElement.removeChild(msgElement.childNodes[0]);
				}
				else
				{
					msgElement.replaceChild(msgbody, msgElement.childNodes[0]);
				}				
			}
			else
			{
				msgElement.appendChild(msgbody);
			}
								


			if (msgElement.childNodes[0])
			{
				if (flag==0)
					document.getElementById('Submit').disabled=false;
				else
					document.getElementById('Submit').disabled=true;

			}				
	}	
	
	
function checkDecimal(ctr, len)
{
       
	var val=document.getElementById(ctr).value;	
	var dtCh= ".";		
	var pos1=val.indexOf(dtCh);
	var pos2=val.indexOf(dtCh, pos1+1)
	
	if (pos2!= -1)
	{
		alert("Only one Decimal Point Allowed");
	    document.getElementById(ctr).focus();
		return false;
	}	
	else if (pos1==-1){
		alert("The format should be : 10000.00");
	    document.getElementById(ctr).focus();
		return false;
	}
	else if((val.length-1)>len)
	{
		alert("Reached Max Length : "+len);
	    document.getElementById(ctr).focus();
		return false;
	}
	else if (((val.length-1) - pos1) == 1 || ((val.length-1) - pos1) == 0)
	{
		alert("Enter Two Digits after Decimal Point");
	    document.getElementById(ctr).focus();
		return false;
	}		
	else if (((val.length-1) - pos1) > 2)
	{
		alert("Only Two Digits after Decimal Point");
	    document.getElementById(ctr).focus();
		return false;
	}		
	else
	{
 	  return true;
 	}
}

	
	
	
	
function validateFields()
{
	try
	{    
   	 	 
		 
		if(
			
			checkNullSelect('jobGrade','Select Job Grade','0')
			&& checkNull('title','Enter Job Title')
		  	&& checkNull('purpose','Enter Job Purpose')
			&& checkNull('duties','Enter Duties')
			&& checkNull('skillset','Enter Skill set')
			&& checkNullSelect('report','Select Report To','0')
			&& checkNullSelect('department','Select Department','0')
   	 		&& checkNull('testtype','Enter test type')
			&& checkNull('noofquestion','Enter The no of question')
			&& checkNull('passingpercentage','Enter passing percentage')
			&& checkNullSelect('testhours','Select test hours','0')
			&& checkNull('education','Select Education')
			&& checkNullSelect('age','Select Age From','0')
			&& checkNullSelect('ageto','Select Age To','0')
			&& checkNullSelect('experience','Select Experience','0')
			&& checkNull('scale','Enter Scale')
			&& checkNull('generalskills','Enter general skills')
			&& checkNull('technicalskills','Enter technical skills')
			&& checkTestTypeidandNoofQuestion()
			&& checktestpassingpercentage()
	 		 
		)
			return true;
   		else
	   		return false;	  
	}
	catch(err)
	{
		alert(err);
		return false;
	}	
}	
  
  
  function checkTestTypeidandNoofQuestion()
  {
  	try
	{
  	 	var a = testNoogQuestion() ;
  		var b = checkTestType();
		if( a == b)
		{
			return true;
		}
		else
		{
			alert("The Selected Test Type & No of Questions are not equal, kindly check the data...");
			return false;
		}
	}
	catch(err)
	{
		alert(err);
		return false;
	}	
  }
   
   
  function checktestpassingpercentage()
  {
  	try
	{
  	 	var a = testpassingpercentage() ;
  		var b = checkTestType();
		if( a == b)
		{
			return true;
		}
		else
		{
			alert("The Selected Test Type & No of Passing percentage are not equal, kindly check the data...");
			return false;
		}
	}
	catch(err)
	{
		alert(err);
		return false;
	}	
  } 
   
  
  function testNoogQuestion()
  {
  	try
	{
		if(checkNull('noofquestion','Enter The noofquestion') )
		{
			var value= document.getElementById('noofquestion').value;
			var question = value.split(",");
			var count =0;
			for(i=0;i<question.length;i++)
				count = count+1;
			return count;	
		}
		else
		{
			alert("Enter The noofquestion");
			document.getElementById('noofquestion').focus();
		}
	}
	catch(err)
	{
		alert(err);
		return false;
	}	
  }


 function testpassingpercentage()
  {
  	if(checkNull('passingpercentage','Enter The passing percentage') )
	{
		var value= document.getElementById('passingpercentage').value;
		var question = value.split(",");
		var count =0;
		for(i=0;i<question.length;i++)
			count = count+1;
		return count;	
	}
	else
	{
		alert("Enter The passing percentage");
		document.getElementById('passingpercentage').focus();
	}
		
  }


  function checkTestType()
   {
   		 
		try
		{ 
			 var frm = document.forms.frm;
			 var SeltesttypeVal = "";
			 var x = 0;
			 var count=0;
			 for (x=0;x<frm.testtype.length;x++)
				if(frm.testtype[x].selected == true)
					count = count+1;
			  	
			return count;
			
		}
		catch(err)
		{
			alert(err.description)
		}	  
  }

  
  function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  }
</script>	


<title>:: HRM ::</title>


 

<style type="text/css">
<!--
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
-->
</style>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<form  AUTOCOMPLETE = "off" name="frm" method="post" action="../SmartLoginAuth" onsubmit="return validateFields()  ">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<%@ include file="indexhrm.jsp" %>
<table width="100%" border="0">

 
  <tr>
    <td valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td valign="top"><table width="90%" height="668" border="0" align="center" cellpadding="2" cellspacing="2">
      <tr>
         
        <td  >
        
        
        <TABLE width='100%' border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
          <TBODY>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
              <TD class=BorderLine height=1><SPACER height="1" 
                        width="1" type="block" /></TD>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TRCorner.gif" width=7></TD>
            </TR>
            <TR>
              <TD height=6><SPACER height="1" width="1" type="block"/></TD>
            </TR>
            <TR>
              <TD class=BorderLine width=1><SPACER height="1" 
                        width="1" type="block" /></TD>
              <TD width=6><SPACER height="1" width="1" type="block" 
                      /></TD>
              <TD width=100% valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td colspan="2"><div align="center"><span class="boldThirteen">JOB DESIGN
					
					      <%!
	String Code, actionDes;
	int jid=0;
%>

<%
		String rowid = request.getParameter("rowid");
		String act = request.getParameter("action1");
		String TxtId, TxtCode, TxtTitle, TxtPurpose, TxtDuties, TxtAuthority;
		String TxtResponse, ComGrade, TxtPromotion, TxtHazards, TxtReport, ComDepart;
		String RadGender, RadMemory, RadCreativity, RadTeach, RadEmotion;
		String TxtEducation, TxtScale, TxtAge, TxtExperience, TxtHeight, TxtWeight;
		String TxtTime, TxtDA, TxtHRA,testtype,noofquestion,testhours,skillset,passingpercentage,ageto;
		String generalskillsids="",technicalskillsids="";
		String sql; 
		boolean f = false;
		if (act.equals("Edit"))
		{
		
			actionDes = "HRMjobDesignEdit";
			 
			sql = " SELECT INT_JOBID,INT_DEPARTID,CHR_JOBGRADE,CHR_JOBCODE,CHR_JOBTITLE,CHR_JOBPURPOSE,CHR_JOBDUTY,CHR_JOBAUTH,CHR_RESPONSE,CHR_JOBPROMOTIONS,CHR_JOBHAZ,CHR_JOBREPORT	,CHR_GENDER,INT_AGE,CHR_QUALIFICATIONID,INT_EXPERIENCE,INT_HEIGHT,INT_WEIGHT,INT_SALARY,INT_DA,INT_HRA,CHR_MEMORY,CHR_CREATIVITY,CHR_TEACHING,CHR_EMOTIONAL,INT_WORKING,CHR_TESTYPEID,CHR_NOOFQUESTION,INT_TESTHOURS,CHR_SKILLSET	,CHR_PASSINGPERCENTAGE,INT_AGE_TO, CHR_GENERALSKILL, CHR_TECHNICALSKILL, DT_UPDATEDATE,CHR_UPDATESTATUS FROM  hrm_m_jobdesign  WHERE INT_JOBID = '"+rowid+"'";
 			String jobData [][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			
			jid = Integer.parseInt(jobData[0][0]);
			ComDepart = jobData[0][1];		
			ComGrade = jobData[0][2];
			TxtCode = jobData[0][3];
			TxtTitle = jobData[0][4];
			TxtPurpose = jobData[0][5];
			TxtDuties = jobData[0][6];
			TxtAuthority = jobData[0][7];
			TxtResponse = jobData[0][8];
			TxtPromotion = jobData[0][9];
			TxtHazards = jobData[0][10];
			TxtReport = jobData[0][11];
			RadGender = jobData[0][12];
			TxtAge = jobData[0][13];
			TxtEducation = jobData[0][14];
			TxtExperience = jobData[0][15];
			TxtHeight = jobData[0][16];
			TxtWeight = jobData[0][17];
			TxtScale = jobData[0][18];
			TxtDA = jobData[0][19];
			TxtHRA = jobData[0][20];
			RadMemory = jobData[0][21];
			RadCreativity = jobData[0][22];
			RadTeach = jobData[0][23];
			RadEmotion = jobData[0][24];
			TxtTime = jobData[0][25];
			testtype = jobData[0][26];
			noofquestion = jobData[0][27];
			testhours = jobData[0][28];
			skillset = jobData[0][29];
			passingpercentage = jobData[0][30];
			ageto= jobData[0][31];
			generalskillsids= jobData[0][32];
			technicalskillsids= jobData[0][33];

 
		}
		else
		{

			actionDes = "HRMjobDesignAdd";
			ComDepart = "0";
			ComGrade = "Top";			
			TxtCode = "";
			TxtTitle = "";
			TxtPurpose = "";
			TxtDuties = "";
			TxtAuthority = "";
			TxtResponse = "";
			TxtPromotion = "YES";
			TxtHazards = "NO";
			TxtReport = "";
			TxtEducation = "";
			TxtScale = "";
			TxtAge = "";
			TxtExperience = "";
			TxtHeight = "";
			TxtWeight = "";
			TxtTime = "";
			TxtDA = "";
			TxtHRA = "";
			RadGender = "";
			RadMemory = "";
			RadCreativity = "";
			RadTeach = "";
			RadEmotion = "";
			testtype = "";
			noofquestion = "";
 			testhours = "";
			passingpercentage="";
		skillset="";
		ageto="";
		
		}
		                      
		                      

 %>
					 </span><span class="boldEleven">
					 <%
								String val="";
								String bname="";
								if (act.equals("Edit"))
								{
									 
									val="";
									bname="Update";
								}
								else
								{
									bname="Submit";val="";
								}
									
								
							%>
                     <input name="rowid"  id="rowid"type="hidden" value="<%=rowid%>">
                     <input name="jobcode" id="jobcode" type="hidden" value="<%=TxtCode%>">
                     </span></div></td>
                  </tr>
                  <tr>
                    <td colspan="2"><div align="right"><font color='red'>*</font><span class="changePos">Mandatory</span></div></td>
                  </tr>
                  <tr>
                    <td colspan="2"><table width="288" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="288" class="boldEleven"><table width="238" border="0" align="center" cellpadding="2" cellspacing="0">
                             
                            <tr>
                              <td class="boldEleven">Job Grade<font color='red'>*</font></td>
                              <td colspan="2" class="boldEleven"><select   name="jobGrade"  id="jobGrade" class="formText135" tabindex="2">
                                <option value="0">Select jobGrade</option>
								
							<%
								String topset="", midset="", botset="";
								if (ComGrade.equals("Top"))
									topset="selected";
								if (ComGrade.equals("Middle"))
									midset="selected";
								if (ComGrade.equals("Bottom"))
									botset="selected";
							%>
									
								<option value="Top" <%= topset %>>Group-1</option>
								<option value="Middle" <%= midset %>>Group-2</option>
								<option value="Bottom" <%= botset %>>Group-3</option>
                                
                              </select></td>
                            </tr>
                             
                          </table></td>
                          </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFF00">
                        <tr>
                          <td height="180"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
                            <tr>
                              <td width="98%" height="160"><table width="100%" border="0" align="center" cellpadding="1" cellspacing="2" bordercolor="#D4D0C8" class="boldEleven">
                                  
                                  <tr>
                                    <td width="110" class="boldEleven">&nbsp;</td>
                                    <td width="287">&nbsp;</td>
                                    <td width="160">&nbsp;</td>
                                    <td width="265">                                        </td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven" >Job Title <font color='red'>*</font>          </td>
                                    
                                    <td>
	 
	<input name="title" type="text" class="formText135" id="title" tabindex="3" onBlur="TxtTrim(this),CheckUnique(this,'soValid','hrm_m_jobdesign','CHR_JOBTITLE')"   onKeyUp="upperMe(this),CheckUnique(this,'soValid','hrm_m_jobdesign','CHR_JOBTITLE')" value="<%=TxtTitle.trim()%>" size="50" maxlength="100" />
	<div id='soValid'></div>
	
	 	
	 
	
								
							         <div id="titchk"></div></td>
                                    <td class="boldEleven">Promotion</td>
                                    <td><input name="promotion"  id="promotion" type="text" class="formText135" tabindex="8" onBlur="TxtTrim(this)"   value="<%=TxtPromotion%>" size="50" maxlength="50" /></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven" >Job Purpose <font color='red'>*</font> </td>
                                    <td><input name="purpose" type="text" class="formText135" id="purpose" tabindex="4"  onBlur="TxtTrim(this)"  value="<%=TxtPurpose%>" size="50" maxlength="100" onKeyUp="upperMe(this)" /></td>
                                    <td class="boldEleven">Hazards</td>
                                    <td><input name="hazards"  id="hazards" type="text" class="formText135" tabindex="9" onBlur="TxtTrim(this)"   value="<%=TxtHazards%>" size="50" maxlength="50" /></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven">Duties <font color='red'>*</font> </td>
                                    <td><input name="duties" type="text" class="formText135" id="duties" tabindex="5" onBlur="TxtTrim(this)"  value="<%=TxtDuties%>" size="50" maxlength="100"  onKeyUp="upperMe(this)" /></td>
                                    <td class="boldEleven">Authority</td>
                                    <td><select   name="authority"  id="authority"  size="1" class="formText135" tabindex="11">
                                      <option value="0" selected="selected">Select Report</option>
									<%
		 
		String auData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE CHR_REP='Y' AND CHR_TYPE !='Y' AND CHR_HOLD!='Y'  ORDER BY CHR_STAFFNAME ");
	for(int i=0;i<auData.length;i++) 
			out.println("<option value='"+auData[i][0]+"'>"+auData[i][1]+"</option>");		
			 
	%></select><script language="javascript">setOptionValue('authority','<%=TxtAuthority%>')</script>		 								 </td>
                                  </tr>
                                  <tr>
                                    <td align="left" valign="top" class="boldEleven">Responsibilities</td>
                                    <td><textarea name="response" cols="50" rows="5" class="formText135" id="response" tabindex="7" onBlur="TxtTrim(this)" onKeyPress="textArea('response', '1000')"><%= TxtResponse %></textarea></td>
                                    <td valign="top" class="boldEleven">Test Type  <font color='red'>*</font></td>
                                    <td valign="top"><select   name="testtype"  id="testtype"  size="5" multiple="multiple" class="formText135" tabindex="11"  style="width:200px">
                                      <option value="" >Select Testtype</option>
                                      <%
		 String tdata[] = testtype.split(",");
		String testData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT a.INT_TESTTYPEID,a.CHR_TESTNAME,COUNT(*)  FROM hrm_m_testtype  a,hrm_m_testquestion b WHERE  a.INT_TESTTYPEID= b.INT_TESTTYPEID GROUP By b.INT_TESTTYPEID ORDER BY a.CHR_TESTNAME ");
		 for(int i=0;i<testData.length;i++) 
		 {
		 	f = false;
		  	for(int u=0; u<tdata.length;u++)
				if(tdata[u].equals(testData[i][0]) )
					f= true;
			if(f)
				out.println("<option value='"+testData[i][0]+"' selected='selected'   title='Available Question "+ testData[i][2]+"'>"+testData[i][1]+" - "+testData[i][2]+"</option>");
			else
				out.println("<option value='"+testData[i][0]+"' title='Available Question "+ testData[i][2]+"' >"+testData[i][1]+" - "+testData[i][2]+"</option>");	
				 
		}	 
	%>
                                      </select></td>
                                  </tr>
                                  <tr>
                                    <td rowspan="3" align="left" valign="top" class="boldEleven">Skill Set <font color='red'>*</font></td>
                                    <td rowspan="3" valign="top"><textarea name="skillset" cols="50" rows="5" class="formText135" id="skillset" tabindex="7" onBlur="TxtTrim(this)" onKeyPress="textArea('skillset', '1000')"><%= skillset %></textarea></td>
                                    <td valign="top" class="boldEleven">No of Questions for each Test type   <font color='red'>*</font></td>
                                    <td valign="top"><p>
                                      <input name="noofquestion" type="text" class="formText135" id="noofquestion" tabindex="5" onBlur="TxtTrim(this)" size="25" maxlength="50"   value="<%=noofquestion%>" />
                                      <span class="errormessage">for e.g(15,25,30)</span> </p>                                      </td>
                                  </tr>
                                  <tr>
                                    <td valign="top" class="boldEleven">Passing percentage    <font color='red'>*</font></td>
                                    <td valign="top"><input name="passingpercentage" type="text" class="formText135" id="passingpercentage" tabindex="5" onBlur="TxtTrim(this)"   value="<%=passingpercentage%>"     size="25" maxlength="50" />
                                      <span class="errormessage">for e.g(15,25,30)</span></td>
                                  </tr>
                                  <tr>
                                    <td valign="top" class="boldEleven">Time Duration forTest <font color='red'>*</font></td>
                                    <td valign="top">
									<select name="testhours" id="testhours" >
									<option value="0">Select Test hours </option>
									<%
									for(int u=30;u<240;u++)
										out.println("<option value='"+u+"'>"+u+"-Minutes</option>");
										%>
									</select>
									<script language="javascript">setOptionValue('testhours','<%=testhours%>')</script>									 																		 </td>
                                  </tr>
                              </table></td>
                            </tr>
                          </table></td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td width="49%" height="19">&nbsp;</td>
                    <td width="51%">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFF00">
                        <tr>
                          <td height="210"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
                            <tr>
                              <td height="210"><table width="100%" border="0" align="center" cellpadding="1" cellspacing="2">
                                  <tr>
                                    <td height="15" colspan="4" ><div align="center"><strong>Other Details</strong></div></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven">&nbsp;</td>
                                    <td width="288" class="boldEleven">&nbsp;</td>
                                    <td width="159" class="boldEleven">&nbsp;</td>
                                    <td width="266" class="boldEleven">&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td width="109" rowspan="4" align="left" valign="top" class="boldEleven" >Education Qualification <font color='red'>*</font></td>
                                    <td rowspan="4" align="left" valign="top" class="boldEleven">
									<select name="education"  class="formText135"   id="education" style="width:200px" multiple="multiple">
									<option value=""  >Select Education</option>
									<%
										String ssql=" SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM com_m_qualification ORDER BY CHR_QUALIFICATIONNAME";
										String qualdata[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(ssql);
										
										String edudata[] = TxtEducation.split(",");
										for(int c=0;c<qualdata.length;c++)
										{
											f = false;
											for(int u=0; u<edudata.length;u++)
												if(edudata[u].equals(qualdata[c][0]) )
													f= true;
													
											if(f)
												out.println("<option value='"+qualdata[c][0]+"' selected='selected' >"+qualdata[c][1]+"</option>");
											else
												out.println("<option value='"+qualdata[c][0]+"'  >"+qualdata[c][1]+"</option>");	
														
											 
										}
										
									
									%>
									</select> 								</td>
                                    <td valign="top" class="boldEleven">Scale <font color='red'>*</font></td>
                                    <td valign="top" class="boldEleven"><input name="scale"   id="scale"type="text" class="formText135" tabindex="13"  onKeyPress="return numeric_only(event,'scale','12')" value="<%= TxtScale %>" size="25" maxlength="10" maxsize="11"  style="width:200px"/></td>
                                  </tr>
                                  <tr>
                                    <td valign="top" class="boldEleven">D.A</td>
                                    <td valign="top" class="boldEleven"><input name="da"  id="da" type="text" class="formText135" tabindex="19"   value="<%= TxtDA %>" size="25" maxlength="6" style="width:200px" onKeyPress="return numeric_only(event,'da','12')"/></td>
                                  </tr>
                                  <tr>
                                    <td valign="top" class="boldEleven">H.R.A</td>
                                    <td valign="top" class="boldEleven"><input name="hra"  id="hra" type="text" class="formText135" tabindex="20"   value="<%= TxtHRA %>" size="25" maxlength="6" style="width:200px" onKeyPress="return numeric_only(event,'hra','12')" /></td>
                                  </tr>
                                  <tr>
                                    <td valign="top" class="boldEleven">Memory</td>
                                    <td valign="top" class="boldEleven"><table width="250" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                                      <tr>
                                        <%
                                          		String mem1="", mem2="";
                                          		if (RadMemory.equals("R"))
                                          			mem1="checked";
                                          		else
                                          			mem2="checked";
                                           %>
                                        <td width="20" id="ps1"><span class="bolddeepblue">
                                          <input name='opt_memory' type='radio' value='R'  <%= mem1 %> tabindex="23"/>
                                        </span></td>
                                        <td width="70" class="boldEleven"   id="ps2">Required</td>
                                        <td width="20" class="boldEleven"><span class="bolddeepblue">
                                          <input name='opt_memory' type='radio'  value='N' <%= mem2 %> tabindex="24"/>
                                        </span></td>
                                        <td width="103" class="boldEleven"  >Not Required</td>
                                      </tr>
                                    </table></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven" >Age<font color='red'> <font color='red'>*</font></font></td>
                                    <td class="boldEleven">									<table width="88%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td width="17%" class="boldEleven">FROM</td>
                                        <td width="25%" class="boldEleven"><select name="age" size="1" class="formText135" id="age" style="width:50px" >
                                          <option value="0" selected="selected">Select Age</option>
                                          <%
										for(int c=15;c<100;c++)
											out.println("<option value='"+c+"'>"+c+"</option>");
										
									%>
                                        </select><script language="javascript">setOptionValue('age','<%=TxtAge%>')</script></td>
                                        <td width="10%" class="boldEleven">TO</td>
                                        <td width="48%" class="boldEleven"><select name="ageto" size="1" class="formText135" id="ageto" style="width:50px" >
                                          <option value="0" selected="selected">Select Age</option>
                                          <%
										for(int c=15;c<100;c++)
											out.println("<option value='"+c+"'>"+c+"</option>");
										
									%>
                                        </select>
										<script language="javascript">setOptionValue('ageto','<%=ageto%>')</script>										</td>
                                      </tr>
                                    </table></td>
                                    <td class="boldEleven">Creativity</td>
                                    <td><table width="250" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                                      <tr>
                                        <%
                                          		String create1="", create2="";
                                          		if (RadCreativity.equals("R"))
                                          			create1="checked";
                                          		else
                                          			create2="checked";
                                           %>
                                        <td width="20" id="ps1"><span class="bolddeepblue">
                                          <input name='opt_creativity' type='radio' value='R'  <%=create1 %> tabindex="25"/>
                                        </span></td>
                                        <td width="70" class="boldEleven"   id="ps2">Required</td>
                                        <td width="20" class="boldEleven"><span class="bolddeepblue">
                                          <input name='opt_creativity' type='radio'  value='N' <%=create2 %> tabindex="26"/>
                                        </span></td>
                                        <td width="103" class="boldEleven"  >Not Required</td>
                                      </tr>
                                    </table></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven" >Experience<font color='red'> <font color='red'>*</font></font></td>
                                    <td class="boldEleven">
									
									<select name="experience" id="experience" style="width:200px">
            <option value="0"  >Select Experience</option>
            <option value="-1">Below one year</option>
            <option value="-2">Below 6-months</option>
            <option value="-3">Fresher</option>
            <%
			for(int u=1;u<25;u++)
				out.println("<option value="+u+">"+u+"+</option>");
		%>
        </select><script language="javascript">setOptionValue('experience','<%=TxtExperience%>')</script>									</td>
                                    <td class="boldEleven">Teaching Ability </td>
                                    <td><table width="250" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                                      <tr>
                                        <%
                                          		String teach1="", teach2="";
                                          		if (RadTeach.equals("R"))
                                          			teach1="checked";
                                          		else
                                          			teach2="checked";
                                           %>
                                        <td width="20" id="ps1"><span class="bolddeepblue">
                                          <input name='opt_teach' type='radio' value='R'  <%= teach1 %>   tabindex="27"/>
                                        </span></td>
                                        <td width="70" class="boldEleven"  id="ps2">Required</td>
                                        <td width="20" class="boldEleven"><span class="bolddeepblue">
                                          <input name='opt_teach' type='radio'  value='N' <%= teach2 %> tabindex="28"/>
                                        </span></td>
                                        <td width="96" class="boldEleven" >Not Required</td>
                                      </tr>
                                    </table></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven">Height</td>
                                    <td class="boldEleven">
									 <select name="height" id="height" style="width:200px">
            <option value="0" >Select height</option>
             
            <%
			for(int u=80;u<250;u++)
				out.println("<option value="+u+">"+u+"</option>");
		%>
        </select><script language="javascript">setOptionValue('height','<%=TxtHeight%>')</script>									 </td>
                                    <td class="boldEleven">Emotional Stability </td>
                                    <td class="boldEleven"><table width="250" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                                      <tr>
                                        <%
                                          		String emot1="", emot2="";
                                          		if (RadEmotion.equals("R"))
                                          			emot1="checked";
                                          		else
                                          			emot2="checked";
                                           %>
                                        <td width="20" id="ps1"><span class="bolddeepblue">
                                          <input name='opt_emotion' type='radio' value='R' <%= emot1 %> tabindex="29"/>
                                        </span></td>
                                        <td width="70" class="boldEleven" id="ps2">Required</td>
                                        <td width="20" class="boldEleven"><span class="bolddeepblue">
                                          <input name='opt_emotion' type='radio'  value='N' <%= emot2 %> tabindex="30"/>
                                        </span></td>
                                        <td width="96" class="boldEleven" >Not Required</td>
                                      </tr>
                                    </table></td>
									</tr>
                                  <tr>
                                    <td class="boldEleven">Weight</td>
                                    <td class="boldEleven"> 
									<select name="weight" id="weight" style="width:200px">
            <option value="0"  >Select Weight</option>
             
            <%
			for(int u=30;u<250;u++)
				out.println("<option value="+u+">"+u+"</option>");
		%>
        </select><script language="javascript">setOptionValue('weight','<%=TxtWeight%>')</script>									 </td>
                                    <td class="boldEleven">&nbsp;</td>
                                    <td class="boldEleven">&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven"  >Working Time</td>
                                    <td class="boldEleven">
									<select name="time" id="time" style="width:200px">
            <option value="0"  >Select Working Time</option>
             
            <%
			for(int u=1;u<24;u++)
				out.println("<option value="+u+">"+u+" - Hours</option>");
		%>
        </select><script language="javascript">setOptionValue('time','<%=TxtTime%>')</script>									 </td>
                                    <td class="boldEleven">&nbsp;</td>
                                    <td class="boldEleven">&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven"  >Gender</td>
                                    <td class="boldEleven"><table width="192" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                                        <tr>
                                          <td id="ps1"><span class="bolddeepblue">
                                            <%
                                          		String mselect="", fselect="", both="";
                                          		if (RadGender.equals("MALE"))
                                          			mselect="checked";
                                          		else if (RadGender.equals("FEMALE"))
                                          			fselect="checked";
												else
													both="checked";
                                           %>
                                            <input name="opt_gender" type="radio" value="MALE"  <%= mselect %> tabindex="21"/>
                                          </span></td>
                                          <td class="boldEleven"   id="ps2">Male</td>
                                          <td class="boldEleven"><span class="bolddeepblue">
                                            <input name='opt_gender' type='radio' value="FEMALE" <%= fselect %> tabindex="22"/>
                                          </span></td>
                                          <td class="boldEleven" >Female</td>
                                          <td class="boldEleven"  ><span class="bolddeepblue">
                                            <input name='opt_gender' type='radio' value="BOTH" <%= both %> tabindex="22"/>
                                          </span></td>
                                          <td class="boldEleven"  >Both</td>
                                        </tr>
                                    </table></td>
                                    <td class="boldEleven">&nbsp;</td>
                                    <td class="boldEleven">&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td align="left" valign="top" class="boldEleven"  >General Skills <font color='red'><font color='red'> <font color='red'>*</font></font></font></td>
                                    <td align="left" valign="top" class="boldEleven">
									<select name="generalskills" size="10" multiple id="generalskills">
                                    <%
									String generalData1[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_SKILLID,CHR_SKILLNAME,CHR_DESC FROM hrm_m_skilllevel  ORDER BY CHR_SKILLNAME");
										
										String generaldata[] = generalskillsids.split(",");
										for(int c=0;c<generalData1.length;c++)
										{
											f = false;
											for(int u=0; u<generaldata.length;u++)
												if(generaldata[u].equals(generalData1[c][0]) )
													f= true;
 											if(f)
												out.println("<option value='"+generalData1[c][0]+"' selected='selected' >"+generalData1[c][1]+"</option>");
											else
												out.println("<option value='"+generalData1[c][0]+"'  >"+generalData1[c][1]+"</option>");	
 										}
										
										
									%>
									</select> 
                                    </td>
                                    <td align="left" valign="top" class="boldEleven">Technical Skills <font color='red'> <font color='red'>*</font></font></td>
                                    <td align="left" valign="top" class="boldEleven">
									<select name="technicalskills" size="10" multiple id="technicalskills">
                                     <%
									String techData1[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_TECHNICALCOMPETENCYID,CHR_TECHNICALCOMPETENCYNAME,CHR_DESC FROM hrm_m_technicalcompetencylevel      ORDER BY CHR_TECHNICALCOMPETENCYNAME");
										
									String technicaldata[] = technicalskillsids.split(",");
									for(int c=0;c<techData1.length;c++)
									{
										f = false;
										for(int u=0; u<technicaldata.length;u++)
											if(technicaldata[u].equals(techData1[c][0]) )
												f= true;
												
										if(f)
											out.println("<option value='"+techData1[c][0]+"' selected='selected' >"+techData1[c][1]+"</option>");
										else
											out.println("<option value='"+techData1[c][0]+"'  >"+techData1[c][1]+"</option>");	
									}
									%>
									</select></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven"  >&nbsp;</td>
                                    <td class="boldEleven">&nbsp;</td>
                                    <td class="boldEleven">&nbsp;</td>
                                    <td class="boldEleven">&nbsp;</td>
                                  </tr>
                              </table></td>
                            </tr>
                          </table></td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="19">&nbsp;</td>
                    <td><input name="filename" type="hidden" id="filename" value="JobDesign">
                    <input name="actionS" type="hidden" id="actionS" value="<%= actionDes %>">
                    <input  name="report" id="report" type="hidden" value="ADMIN">
                    <input name="department" type="hidden" id="department" value="1"></td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><table  border="0" align="center" cellpadding="2" cellspacing="2">
                        <tr>
                          <td width="56"><input type="submit" name="Submit"  id="Submit" class="tMLAscreenHead" value="<%=bname%>"  tabindex="31"/></td>
                          <td width="56">
						  <input type="button" name="submit" class="tMLAscreenHead"  value="Close"   accesskey="c"  onClick="redirect('JobDesignView.jsp')" tabindex="32"/></td>
                        </tr>
                    </table> </td>
                  </tr>
              </table></TD>
              <TD noWrap width=5><SPACER height="1" width="1" 
                        type="block" /></TD>
              <TD class=BorderLine width=2><SPACER height="1" width="1" type="block" /></TD>
            </TR>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/BLCorner.gif" width=7></TD>
              <TD height=6><SPACER height="1" width="1" type="block"/></TD>
              <TD colSpan=2 rowSpan=2 valign="bottom"><div align="right"><IMG height=7 src="../Image/General/BRCorner.gif" width=7></div></TD>
            </TR>
            <TR>
              <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
            </TR>
          </TBODY>
        </TABLE></td>
      </tr>
    </table>    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>
</body>
<%

}
catch(Exception e)
{
	out.print(e.getMessage());
}
%>
</form>
</html>