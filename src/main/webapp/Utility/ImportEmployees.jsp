<%@ page import="java.io.*,java.util.*,com.my.org.erp.bean.*"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<% 
	String str=null;
	String AV100,BIO,A6;
%>
<html>
<head>

<title> :: UTILITY :: </title>
<%@include file="Redirect.jsp" %>

<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
	function Import()
 	{		
			var mod=document.getElementById("model").value;
			if(mod=="AV100") {
				 document.frmImport.action="ImportEmpData.jsp";  // AV 100				 
			}
			else if(mod=="BIO"){
				 document.frmImport.action="ImportEmpDataBio.jsp"; // Bio 
			}
			else if(mod=="A6"){
				 document.frmImport.action="ImportEmpDataBio.jsp"; // A6
			}
			document.frmImport.submit();		
 	}
 	function Save()
 	{	
			if(checkNull('company','Select Company')&& checkNull('branch','Select Branch')
			 && checkNull('depart','Select Department') && checkNull('desig','Select Designation'))
			{
				document.frmImport.action="SaveEmpData.jsp";
				document.frmImport.submit();
			}
 	}
</script>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 <form name="frmImport">
 <p><br>
   <br><br>
 </p>
 <table border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
   <tbody>
     <tr>
       <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
       <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
       <td width="10" colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
     </tr>
     <tr>
       <td height="6"><spacer height="1" width="1" type="block" /></td>
     </tr>
     <tr>
       <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
       <td width="6"><spacer height="1" width="1" type="block" /></td>
       <td width="405" valign="top"><table width="417" height="157" border="0" align="center" cellpadding="3" cellspacing="3"
						 >
         <!--DWLayoutTable-->
         <tr>
           <td height="30" colspan="3" align="center" valign="middle"
								  class="BackGround"><%
	ArrayList empdata =(ArrayList)session.getValue("empdata");
	String message=""+session.getValue("message");
	if(message.equals("null") || message.equals("")) 
	{
			message="";
			if(empdata!=null){
			   empdata.clear();
	  		   session.putValue("empdata",empdata);
	  		}
	}
	String model=""+request.getParameter("model");
	AV100="";BIO="";A6="";
	if(model.equals("AV100")){
		AV100="selected='selected'";
	}else if(model.equals("BIO")){
		BIO="selected='selected'";
	}else if(model.equals("A6")){
		A6="selected='selected'";
	}
%></td>
         </tr>
         <tr>
           <td height="30" colspan="3" align="center" valign="middle"
								  class="BackGround"><strong class="bold1">Importing
				Employee Data From
               <select class="bold1" name="model" id="model">
                 <option value="AV100" <%=AV100 %>>AV 100</option>
                 <option value="BIO" <%=BIO %>>BIO</option>
                 <option value="A6" <%=A6 %>>A6</option>
               </select>
           </strong></td>
         </tr>
        
         <tr>
           <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
           <td><!--DWLayoutEmptyCell-->&nbsp;</td>
         </tr>
         <tr>
           <td colspan="2" class="boldEleven"><table width='600' border="1" align="center" cellpadding="0"
					cellspacing="0"  >
             <tr>
               <td><table width="300" border="0"
							  >
                 <tr>
                   <td width="100"><strong class="bold1"> Emp Id </strong></td>
                   <td width="200"><strong class="bold1">Emp Name</strong></td>
                 </tr>
               </table>
               <td width="300"   ><strong class="bold1">* For Save Employee Details</strong></td>
             <tr>
               <td height="202" valign="top"><div id="divscroll"
							style="OVERFLOW: auto;width:300px;">
                 <table width="100%" border="0" cellpadding="0" cellspacing="0"
							class='bolddeepblue'>
                   <%
       if(empdata!=null)
       {
       if(empdata.size()>0){
    	   boolean bgflag=false;
    	   String bgcolor1="#ccccc";
	       for(int i=0;i< empdata.size();i++){
	   		NewEmployee emp=(NewEmployee)empdata.get(i);
	   		String empId=emp.getEmpId();
	   		String empName=emp.getEmpName();
	   		if("".equals(empName)) empName="---";
	   		if(bgflag)
			{
				bgflag = false;
				bgcolor1="#FFFFFF";
			}
			else
			{
				bgflag = true;
				bgcolor1="#EEFFEE";
			}
			out.println("<tr bgcolor='"+bgcolor1+"'><td width='100'>"+emp.getEmpId()+ "</td>");
			
			out.println("<td width='200'>" + empName +"</td></tr>");			
		   }	
       }
       else     {
    	   out.println("<tr align=center bgcolor='EEFFEE'><td width='300'> Import Employess</td>");    	 
       }       

       }
       else     {
    	   out.println("<tr bgcolor='EEFFEE'><td width='300'> Import Employess</td>");    	 
       }       
       %>
                 </table>
               </div>
               <td><table>
                 <tr>
                   <td class="bold1">Company</td>
                   <td><select name="company" id="company"
									onChange="loadBranch()" class="bold1" style="width:200px">
                     <%                  
     					String queryBranch1 = "SELECT * FROM  com_m_company ";
     					String	branch1[][] = CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
                   </select></td>
                 </tr>
                 <tr>
                   <td class="bold1">Branch</td>
                   <td><select name="branch" id="branch" class="bold1"
									style="width:200px">
                   </select></td>
                 </tr>
                 <tr>
                   <td class="bold1">Department</td>
                   <td><select name="depart" class="bold1" id="depart">
                     <%
				    try
					{
				    	String sql="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME ";
				    	String depValue[][] = CommonFunctions.QueryExecute(sql);
				    	for(int i=0;i<depValue.length;i++)
						{
							out.println("<option value="+depValue[i][0]+">"+depValue[i][1]+"</option>");		
						}						
				
					}catch(Exception ex)
					{
						//System.out.println(ex);
					}
									
				%>
                   </select></td>
                 </tr>
                 <tr>
                   <td class="bold1">Designation</td>
                   <td><select name="desig" class="bold1" id="desig">
                     <%
				    try
					{
				    	String sql="SELECT INT_DESIGID,chr_DESIGNAME FROM  com_m_desig  ORDER BY CHR_DESIGNAME ";
				    	String depValue[][]= CommonFunctions.QueryExecute(sql);
				    	for(int i=0;i<depValue.length;i++)
						{
							out.println("<option value="+depValue[i][0]+">"+depValue[i][1]+"</option>");		
						}
					}catch(Exception ex)
					{
						//System.out.println(ex);
					}									
				%>
                   </select></td>
                 </tr>
               </table></td>
             </tr>
             <%
       out.println("<tr bgcolor='#EFEAF1' class='bolddeepblue'><td colspan='2'>"+message+"</td></tr>");

       if(message.equalsIgnoreCase("Saved Sucessfully")) {
  		 empdata.clear();
  		 session.putValue("empdata",empdata);
  		 message="";
  		 session.putValue("message",message);
  	}
       %>
           </table></td>
         </tr>
         <tr>
           <td colspan="2" class="boldEleven">
           
           <script language='JavaScript'>
		<!--
		 <%       
	       if(empdata!=null){
		 	if(empdata.size()>0)	  
				out.println("document.getElementById('cmdsave').disabled=false;");
		 	else
		 		out.println("document.getElementById('cmdsave').disabled=true;");
	       }
	       else
	    	   out.println("document.getElementById('cmdsave').disabled=true;");
		%>			
			//-->
		</script>
		<%
	message="";
	session.putValue("message",message);
%>
           </td>
         </tr>
         <tr>
           <td colspan="2" class="boldEleven"><table border="0" align="center" cellpadding="1" cellspacing="1">
             <tr>
               <td width="56"><input class="buttonbold" type="button"
					value="Import" onClick="Import()" accesskey="I"></td>
               <td width="56"><input class="buttonbold" type="button"
					value="Save" id="cmdsave" onClick="Save()" accesskey="S"></td>
               <td width="56"><input class="buttonbold" type="button"
					 value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')" accesskey="C"></td>
             </tr>
           </table></td>
         </tr>
       </table></td>
       <td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
       <td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
     </tr>
     <tr>
       <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
       <td height="6"><spacer height="1" width="1" type="block" /></td>
       <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div></td>
     </tr>
     <tr>
       <td class="BorderLine" height="1"></td>
     </tr>
   </tbody>
 </table>
<p>&nbsp;</p>
<p>&nbsp;</p>
 
 </body>
</html>
