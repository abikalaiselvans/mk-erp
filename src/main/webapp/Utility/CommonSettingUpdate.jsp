<%@include file="Redirect.jsp" %> 
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%
try
{
 	String sql=null;
	String userName=null;
	String mnuVal=null;
	String fname;
%>
<html>
<head>

<title> :: UTILITY :: </title>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
<body  onpaste="return false;" >
<form name="frm" method="post">
<p>
<%
	 try
	 {
			 String name=request.getParameter("companyname");
			 String add1=request.getParameter("companyaddress");
			 String city=request.getParameter("city");
			 String state=request.getParameter("state");
			 int pin=Integer.parseInt(request.getParameter("pincode"));
			 int phone=Integer.parseInt(request.getParameter("phone"));		
			 String mail=request.getParameter("mailid");
			 String pf=request.getParameter("pf");
			 String esi=request.getParameter("esi");	
			 String TxtcpyPF1=request.getParameter("companypf1");	
			 String TxtcpyPF2=request.getParameter("companypf2");	
			 String TxtcpyESI=request.getParameter("companyesi");	
			 String Salary=request.getParameter("salary");	
			 String TxtPetrol=request.getParameter("txtpetrol");	
			 String dtlock=""+request.getParameter("dtlock");
			 String mailalert=""+request.getParameter("maialert");	
			 String sessiontime=""+request.getParameter("sessiontime");	
			 String serverupdate=""+request.getParameter("serverupdate");	
			 String conveyance=""+request.getParameter("conveyance");	
			 String sms=""+request.getParameter("sms");	
			 String fpass=""+request.getParameter("fpass");	
			 String order=""+request.getParameter("order");	
			 String leaveupdation=""+request.getParameter("leaveupdation");	
			 String adminhide=""+request.getParameter("adminhide");	
			 String leavecarry=""+request.getParameter("leavecarry");	
			 String paytaxdeduction=""+request.getParameter("paytaxdeduction");	
			 String paytaxvalue=""+request.getParameter("paytaxvalue");	
			 String Bonus=""+request.getParameter("bonus");	
			 String Bonusdays=""+request.getParameter("bonusdays");	
			 String leavelimit=""+request.getParameter("leavelimit");	
			 String reseller=""+request.getParameter("reseller");	
			String Resignlimit=""+request.getParameter("resignlimit");
			
			String Pfnumber=""+request.getParameter("pfnumber");
			String Esinumber=""+request.getParameter("esinumber");
			String Pflimit=""+request.getParameter("pflimit");
			String pflimitminimum=""+request.getParameter("pflimitminimum");
			String Esilimit=""+request.getParameter("esilimit");
			String HRmailid=""+request.getParameter("hrmailid");
			String Billingmailid=""+request.getParameter("billingmailid");
			String billingmailidpassword=""+request.getParameter("billingmailidpassword");
			String taxdeductionemp=""+request.getParameter("taxdeductionemp");
			String creditlimit=""+request.getParameter("creditlimit");	
			String mailhost=""+request.getParameter("mailhost");
			String groupmail=""+request.getParameter("groupmail");
			String Company=""+request.getParameter("company");	
			String loginmailcheck=""+request.getParameter("loginmailcheck");	
			String newjoinnermailalert=""+request.getParameter("newjoinnermailalert");	
			String technicalmailid=""+request.getParameter("technicalmailid");		
			String productmailid=""+request.getParameter("productmailid");		
			String cpyshortname=""+request.getParameter("cpyshortname");
			String automaticattendancemark=""+request.getParameter("automaticattendancemark");	
			
			String grosslimit=""+request.getParameter("grosslimit");	
			String dojlock=""+request.getParameter("dojlock");	
			String resignerlock=""+request.getParameter("resignerlock");	
			String firsttimeautomate=""+request.getParameter("firsttimeautomate");	
			String joinnerlock=""+request.getParameter("joinnerlock");	
			 
			 //leaveupdation, adminhide,Pfnumber,Esinumber,Pflimit,Esilimit ,HRmailid,Billingmailid,billingmailidpassword
			 String s="";
			 if("null".equals(""+request.getParameterValues("leavecarry")))
			 {
			 	s="0,";
			 }	
			 else
			 {
			 	String cycle[] = request.getParameterValues("leavecarry");
				s="";
				for(int y=0; y<cycle.length;y++)
					s = s+cycle[y]+",";
			 }
			 String cycles= s;
			 
			 if("on".equals(dtlock)|| "Y".equals(dtlock))
				dtlock ="Y";
			 else
				dtlock ="N";
				
			 if("on".equals(mailalert)|| "Y".equals(mailalert))
				mailalert ="Y";
			 else
				mailalert ="N";
				
			if("on".equals(serverupdate)|| "Y".equals(serverupdate))
				serverupdate ="Y";
			 else
				serverupdate ="N";
				
			if("on".equals(sms)|| "Y".equals(sms))
				sms ="Y";
			 else
				sms ="N";
				
			if("on".equals(fpass)|| "Y".equals(fpass))
				fpass ="Y";
			 else
				fpass ="N";		
			
			 if("on".equals(adminhide) || "Y".equals(adminhide))
				adminhide ="Y";
			 else
				adminhide ="N";
				
				
			if("on".equals(paytaxdeduction) || "Y".equals(paytaxdeduction))
				paytaxdeduction ="Y";
			 else
				paytaxdeduction ="N";	
				
			if("on".equals(creditlimit) || "Y".equals(creditlimit))
				creditlimit ="Y";
			 else
				creditlimit ="N";	
				
			 String defaultpass=""+request.getParameter("txtpassword");		
			 if(("".equals(defaultpass)) || ("null".equals(defaultpass)))
				defaultpass="mkm1234";
				
			if("on".equals(loginmailcheck) || "Y".equals(loginmailcheck))
				loginmailcheck ="Y";
			 else
				loginmailcheck ="N";	
				
			if("on".equals(newjoinnermailalert) || "Y".equals(newjoinnermailalert))
				newjoinnermailalert ="Y";
			 else
				newjoinnermailalert ="N";			
				
				
			if("on".equals(automaticattendancemark) || "Y".equals(automaticattendancemark))
				automaticattendancemark ="Y";
			 else
				automaticattendancemark ="N";			
				
			if("on".equals(firsttimeautomate) || "Y".equals(firsttimeautomate))
				firsttimeautomate ="Y";
			 else
				firsttimeautomate ="N";			
			
				
				
				
			sql ="UPDATE m_institution SET";
			sql = sql +" CHR_NAME='"+name+"' , ";
			sql = sql +" CHR_ADD1='"+add1+"' , ";
			sql = sql +" CHR_CITY='"+city+"' , ";
			sql = sql +" CHR_STATE='"+state+"' , ";
			sql = sql +" INT_PINCODE="+pin+" , ";
			sql = sql +" INT_PHONE="+phone+" , ";
			sql = sql +" CHR_MAILID='"+mail+"' , ";
			sql = sql +" INT_PFAMT="+pf+" , ";
			sql = sql +" INT_ESIAMT="+esi+" , ";
			sql = sql +" INT_CPY_PFAMT="+TxtcpyPF1.trim()+" , ";
			sql = sql +" INT_CPY_PENSIONAMT="+TxtcpyPF2.trim()+" , ";
			sql = sql +" INT_CPY_ESIAMT="+TxtcpyESI.trim()+" , ";
			sql = sql +" CHR_SALARY ='"+Salary.trim()+"' , ";
			sql = sql +" DAT_LOCK='"+dtlock+"' , ";
			sql = sql +" CHR_PASSWORD='"+defaultpass+"' , ";
			sql = sql +" DOU_PETROL="+TxtPetrol+" , ";
			sql = sql +" INT_SESSION="+sessiontime+" , ";
			sql = sql +" CHR_UPDATE='"+serverupdate+"' , ";
			sql = sql +" INT_CONVEYANCECLEAR="+conveyance+" , ";
			sql = sql +" CHR_MAILALERT='"+mailalert+"' , ";
			sql = sql +" CHR_SMSALERT ='"+sms+"' , ";
			sql = sql +" CHR_FORGETPASSWORD='"+fpass+"' , ";
			sql = sql +" CHR_ORDERBY='"+order+"' , ";
			sql = sql +" CHR_LEAVEUPDATE='"+leaveupdation+"' , ";
			sql = sql +" CHR_LEAVENOTCARRY='"+cycles+"' , ";
			sql = sql +" CHR_PAYTAXDEDUCTION='"+paytaxdeduction+"' , ";
			sql = sql +" CHR_PAYTAXVALUE='"+paytaxvalue+"' , ";
			sql = sql +" DOU_BONUS="+Bonus+" , ";
			sql = sql +" INT_BONUSWORKINGDAYS="+ Bonusdays+" , ";
			sql = sql +" INT_LEAVELIMIT="+ leavelimit+" , ";
			sql = sql +" DOU_RESELLERPERCENTAGE="+ reseller+" , ";
			sql = sql +" INT_RESIGNATIONLIMIT="+ Resignlimit+" , ";
			sql = sql +" CHR_PFNUMBER='"+Pfnumber+"' , ";
			sql = sql +" CHR_ESINUMBER='"+Esinumber+"' , ";
			sql = sql +" INT_PFLIMITMINIMUM="+ pflimitminimum+" , ";
			 
			
			 
			sql = sql +" INT_ESILIMIT="+ Esilimit+" , ";
			sql = sql +" CHR_HRMAILID='"+HRmailid+"' , ";
			sql = sql +" CHR_BILLINGMAILID='"+Billingmailid+"' , ";
			sql = sql +" CHR_BILLINGMAILPASSWORD='"+billingmailidpassword+"' , ";
			sql = sql +" CHR_TAXDEDUCTIONEMP='"+taxdeductionemp+"' , ";
			sql = sql +" CHR_TECHNICALEMAILID='"+technicalmailid+"' , ";
			sql = sql +" CHR_PRODUCTMAILID='"+productmailid+"' , ";
			sql = sql +" CHR_CUSTOMERCREDITLIMIT='"+creditlimit+"' , ";
			sql = sql +" CHR_MAILHOST='"+mailhost+"' , ";
			sql = sql +" CHR_GROUPMAIL ='"+groupmail+"' , ";
			
			sql = sql +" CHR_LOGINMAILDCHECK='"+loginmailcheck+"' , ";
			sql = sql +" CHR_NEWJOINNERMAILALERT='"+newjoinnermailalert+"' , ";
			sql = sql +" CHR_SHORTNAME='"+cpyshortname+"' , ";
			
			sql = sql +" CHR_ATTENDANCEMARK='"+automaticattendancemark+"' , ";
			sql = sql +" INT_GROSSLIMIT = "+grosslimit+"  , ";
			
			  
			sql = sql +" INT_COMPANYSELECTION = "+Company+"  , ";
			sql = sql +" CHR_ADMININFORMATION ='"+adminhide+"' ,  ";
			sql = sql +" CHR_FIRSTTIMEAUTOMATE ='"+firsttimeautomate+"' ,  ";
			
			sql = sql +" CHR_DOJLOCK = "+dojlock+" ,  ";
			sql = sql +" INT_DATLOCK = "+joinnerlock+" ,  ";
			
			sql = sql +" INT_RESIGNERLOCK = "+resignerlock;
			
			
			sql = sql +" WHERE INT_ID=1";
			//System.out.println(sql);
			com.my.org.erp.common.CommonFunction.SQLUpdate(sql);
			response.sendRedirect("CommonSetting.jsp");
		}
		catch(Exception e)
		{
		}	
		 %>
</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center" class="DataGridFixedHeader">Common Settings
updated Sucessfully</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<h3>
<p align="center" class="boldThirteen">Do you want to change Commmon
Settings again : <a href="CommonSetting.jsp">YES</a>/<a
	href="Userframe.jsp">NO</a></p>
<p align="center" class="boldThirteen">&nbsp;</p>
</h3>

</form>

<%
}
catch(Exception e)
{
}
%>
 </body>
</html>

