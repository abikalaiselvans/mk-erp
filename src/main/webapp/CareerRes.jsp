<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.SmartHRM.*"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	String name="",fname="",dob="",gender="",marital="";
	String language1="",read1="",write1="",speak1="";
	String language2="",read2="",write2="",speak2="";
	String language3="",read3="",write3="",speak3="";
	String exemployee="",bike="",passportno="",passdate="",qualification="",interestarea="";
	String certificates="",description="",emailid="",Mobile="",yearofexperience="";
	String applypost="",referencename="",previousdetails="",currentlocation="",interestedlocation="";
	String referencephone="";
	String row="0";
	boolean flag = false;
			
 %>
<%
 session.removeAttribute("CAREERID");
 
 boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 if (!isMultipart) 
 {
 } 
 else 
 {
   FileItemFactory factory = new DiskFileItemFactory();
   ServletFileUpload upload = new ServletFileUpload(factory);
   List items = null;
   try 
   {
   		items = upload.parseRequest(request);
   } 
   catch (FileUploadException e) 
   {
   		e.printStackTrace();
   }	
   Iterator itr = items.iterator();
   while (itr.hasNext()) 
	   {
   			FileItem item = (FileItem) itr.next();
   			if (item.isFormField())
	   		{
	      		String iname = item.getFieldName();
				String value = item.getString();
		   
				if(iname.equals("name"))
				{
					name=value;
					flag=true;
				}
				if(iname.equals("fname"))
				{
					fname=value;
					flag=true;
				} 
				if(iname.equals("dob"))
				{
					dob=DateUtil.FormateDateSQL(value);;
					flag=true;
				} 
				if(iname.equals("dob"))
				{
					dob=DateUtil.FormateDateSQL(value);;
					flag=true;
				} 
				if(iname.equals("gender"))
				{
					gender= value ;
					flag=true;
				} 
				if(iname.equals("marital"))
				{
					marital= value ;
					flag=true;
				} 
				if(iname.equals("language1"))
				{
					language1= value ;
					flag=true;
				} 
				if(iname.equals("read1"))
				{
					read1= value ;
					if(!"X".equals(read1))
						read1="N";
					flag=true;
				} 
				if(iname.equals("write1"))
				{
					write1= value ;
					if(!"X".equals(write1))
						write1="N";
					flag=true;
				}  
				if(iname.equals("speak1"))
				{
					speak1= value ;
					if(!"X".equals(speak1))
						speak1="N";
					flag=true;
				}  
				if(iname.equals("language2"))
				{
					language2= value ;
					flag=true;
				} 
				if(iname.equals("read2"))
				{
					read2= value ;
					if(!"X".equals(read2))
						read2="N";
					flag=true;
				} 
				if(iname.equals("write2"))
				{
					write2= value ;
					if(!"X".equals(write2))
						write2="N";
					flag=true;
				}  
				if(iname.equals("speak2"))
				{
					speak2= value ;
					if(!"X".equals(speak2))
						speak2="N";
					flag=true;
				}  
				
				if(iname.equals("language31"))
				{
					language3= value ;
					flag=true;
				} 
				if(iname.equals("read3"))
				{
					read3= value ;
					if(!"X".equals(read3))
						read3="N";
					flag=true;
				} 
				if(iname.equals("write3"))
				{
					write3= value ;
					if(!"X".equals(write3))
						write3="N";
					flag=true;
				}  
				if(iname.equals("speak3"))
				{
					speak3= value ;
					if(!"X".equals(speak3))
						speak3="N";
					flag=true;
				}  
				
				if(iname.equals("exemployee"))
				{
					exemployee=value;
					flag=true;
				}
				if(iname.equals("bike"))
				{
					bike=value;
					flag=true;
				}
				if(iname.equals("passportno"))
				{
					passportno=value;
					flag=true;
				}
				if(iname.equals("passdate"))
				{
					passdate=DateUtil.FormateDateSQL(value);
					flag=true;
				}  
				if(iname.equals("qualification"))
				{
					qualification=value;
					flag=true;
				}
				if(iname.equals("interestarea"))
				{
					interestarea=value;
					flag=true;
				}
				if(iname.equals("certificates"))
				{
					certificates=value;
					flag=true;
				}
				if(iname.equals("description"))
				{
					description=value;
					flag=true;
				}
				if(iname.equals("emailid"))
				{
					emailid=value;
					flag=true;
				}
				if(iname.equals("mobile"))
				{
					Mobile=value;
					flag=true;
				}
				if(iname.equals("yearofexperience"))
				{
					yearofexperience=value;
					flag=true;
				}
				if(iname.equals("applypost"))
				{
					applypost=value;
					flag=true;
				}
				if(iname.equals("referencename"))
				{
					referencename=value;
					flag=true;
				}
				if(iname.equals("previousdetails"))
				{
					previousdetails=value;
					flag=true;
				}
				if(iname.equals("currentlocation"))
				{
					currentlocation=value;
					flag=true;
				}
				if(iname.equals("interestedlocation"))
				{
					interestedlocation=value;
					flag=true;
				}
				if(iname.equals("referencephone"))
				{
					referencephone=value;
					flag=true;
				}
   			} 
			else
	   		{
    			try 
				{
	
  					String itemName = item.getName(); 
					row = CommonFunctions.QueryExecute("select if( (COUNT(*)>0 ) ,(MAX(INT_CAREERID)+1),'1')   FROM com_m_careers ")[0][0];  
					//System.out.println(row);
   					File savedFile = new File(config.getServletContext().getRealPath("/")+"uploadfiles/CareersResume\\"+ row+".doc");
   					item.write(savedFile);
     %>

<%				 
					  
   				} 
				catch (Exception e) 
				{
   					e.printStackTrace();
   				}
   			}
   		}
   }
   
   
    Connection con=conbean.getConnection();
    CallableStatement acs = con.prepareCall("{call COM_PRO_CAREERS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
	acs.setString(1, "INSERT");
	acs.setString(2, "1");
	acs.setString(3, name);
	acs.setString(4, fname);
	acs.setString(5, dob);
	acs.setString(6, gender);
	acs.setString(7, marital);
	acs.setString(8, language1);
	acs.setString(9, read1);
	acs.setString(10, write1);
	acs.setString(11, speak1);
	acs.setString(12, language2);
	acs.setString(13, read2);
	acs.setString(14, write2);
	acs.setString(15, speak2);
	acs.setString(16, language3);
	acs.setString(17, read3);
	acs.setString(18, write3);
	acs.setString(19, speak3);
	acs.setString(20, exemployee);//DateUtil.FormateDateSQL(dor)
	acs.setString(21, bike);
	acs.setString(22, passportno);
	acs.setString(23, passdate);
	acs.setString(24, qualification);
	acs.setString(25, interestarea);
	acs.setString(26, certificates);
	acs.setString(27, emailid);
	acs.setString(28,Mobile);
	acs.setString(29,yearofexperience);
	acs.setString(30,applypost);
	acs.setString(31,referencename);
	acs.setString(32,previousdetails);
	acs.setString(33,description);
	acs.setString(34,currentlocation);
	acs.setString(35,interestedlocation);
	acs.setString(36,referencephone);
	acs.setString(37,"N");
	//System.out.println(""+acs);
	acs.execute();
	//System.out.println(row);
	//CommonFunctions.insertCareerProfile(request.getRealPath("/")+"/uploadfiles/CareersResume/"+row+".doc", row);
	CommonFunctions.Execute("UPDATE com_m_careers SET CHR_RESUMESTATUS='Y' WHERE INT_CAREERID ="+row);
	System.out.println(row);			
    
   %>

<SCRIPT language="javascript">
 						alert("You have successfully uploaded  ");
						 
						
					</SCRIPT>

<%

	//send a mail to person and HR
	String hr=CommonFunctions.QueryExecute("SELECT CHR_HRMAILID FROM m_institution WHERE INT_ID=1")[0][0];
	//CareerResume.sendMailtoPerson(emailid, "Resume",id );
	//CareerResume.sendMailtoHr(hr, "Resume",id);
	 
	String content ="\n\n\n Your personal informations has been sent to our HR Team . \n\nOur team will contact you for further details.\n\nThis is your reference number : "+row+" Thank you.";
	content = content+"\n\nYou have any queries please mail to hr@careind.net or call us at 044-24340906 Extn 26. ";
	String a[] =(hr+","+emailid).split(",") ;
	CareerResume.SimpleMail(a, "Resume", content);
	
	//System.out.println(row);
	String sql ="SELECT CHR_NAME,CHR_FATHERNAME,CHR_APPLIEDPOST FROM com_m_careers WHERE INT_CAREERID="+row;
	String data[][]=CommonFunctions.QueryExecute(sql);
	
	content=data[0][0]+" "+data[0][1]+" Uploaded the Resume. His/Her Reference Number :"+row+"  Thank you. ";
	//System.out.println(row);
	CareerResume.SimpleMail(hr,hr, "Resume", content);
	session.setAttribute("CAREERID",row);
	response.sendRedirect("Careerresponses.jsp");
	
	
%>
