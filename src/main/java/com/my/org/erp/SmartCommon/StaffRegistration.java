package com.my.org.erp.SmartCommon;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;

import DBConnection.DBCon;

import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.SalaryFunctions;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import java.io.IOException;
import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.List;
import java.util.Iterator;

import com.my.org.erp.common.ImageFunctions;

@WebServlet("/StaffRegistration")
public class StaffRegistration extends HttpServlet 
{
    private static final long serialVersionUID = -3208409086358916855L;
    private long maxFileSize;
    @SuppressWarnings({ "deprecation", "rawtypes" })
    
	protected  synchronized void doPost(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException 
    { 
    	try 
    	{
 			System.out.println("============================"); 
    		HttpSession session = request.getSession();
    		java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
    		java.util.Date date = new java.util.Date();
    		String updatedate = "" + datetime.format(date);
    		String userId = (String) session.getAttribute("USRID");
    		String status="Y";
    		Connection con= new DBCon().getConnection();
    		 
    		String regid="";
    		
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
			   		System.out.println(e.getMessage());
			   } 
			   
			   		
			   		HashMap hm = new HashMap();
			   		Iterator itr = items.iterator();
			   		int i = 0;
			   		while (itr.hasNext()) 
			   		{
			   		    FileItem item = (FileItem) itr.next();
			   		    if (item.isFormField()) 
			   		     	hm.put(item.getFieldName(), item.getString());
			   		    i++;
			   		}


			   		 
			   		
			   		Staff d = new Staff();
			   		BeanUtils.populate(d, hm);
			   		boolean stffregistrationflag = true;
			   		
			   		
			   		if("N".equals(d.getRejoin()))
			   		{
			   			String sql ="";
				   		sql = sql +" SELECT COUNT(*) FROM com_m_staff ";
				   		sql = sql +" WHERE CHR_STAFFNAME='"+d.getName().toUpperCase()+"' ";
				   		sql = sql +" AND  CHR_STAFFFNAME='"+d.getFname().toUpperCase()+"' ";
				   		sql = sql +" AND CHR_MOTHERNAME='"+d.getMothername()+"' ";
				   		sql = sql +" AND DT_DOB ='"+d.getDob()+"' ";
				   		if(CommonFunction.RecordExist(sql))
				   			stffregistrationflag = false;
			   		}
			   		
			   		
			   		if(stffregistrationflag)
			   		{	
			   			regid = ""+ staffRegistrationNumber(d.getDoj(),""+d.getCompany()) ;
						CallableStatement acs = con.prepareCall("{call COM_PRO_STAFF_MULTIPART(" 
										+ " ?,?,?,?,?,?,?,?,?,?,"
										+ " ?,?,?,?,?,?,?,?,?,?,"
										+ " ?,?,?,?,?,?,?,?,?,?,"
										+ " ?,?,?,?,?,?,?,?,?,?,"
										+ " ?,?,?,?,?,?,?,?,?,?,"
										+ " ?,?,?,?,?,?,?,?,?,?,"
										+ " ?,?,?,?,?,?,?,?,?,?,"
										+ " ?,?,?,?,?,?,?,?,?,?,"
										+ " ?,?,?,? ,?,?,?,?)}");
						acs.setString(1, "INSERT");
						acs.setString(2, "");
						acs.setString(3, "" +  d.getCompany());
						acs.setString(4, "" + d.getBranch());
						acs.setString(5, regid);
						acs.setString(6, d.getName().toUpperCase());
						acs.setString(7, d.getFname().toUpperCase());
						acs.setString(8, "" + d.getDepart());
						acs.setString(9, "" + d.getDesig());
						acs.setString(10, "" + d.getOff());
						//System.out.println("1");
						
						acs.setString(11, d.getGender());
						acs.setString(12, d.getDob());
						acs.setString(13, d.getBg());
						acs.setString(14, d.getDoj());
						acs.setString(15, d.getGrade());
						acs.setString(16, d.getCard());
						acs.setString(17, "" + d.getBalance());
						acs.setString(18, d.getStype());
						acs.setString(19, "" + d.getBasic());
						acs.setString(20, d.getPf());
						acs.setString(21, d.getEsi());
						acs.setString(22, "" + d.getGross());
						acs.setString(23, d.getMarry());
						acs.setString(24, d.getWedding());
						acs.setString(25, d.getBank());
						acs.setString(26, d.getNumber());
						acs.setString(27, "" + d.getPin()); 
						acs.setString(28, d.getPadd1().toUpperCase());
						acs.setString(29, d.getPadd2().toUpperCase());
						acs.setString(30, "" + d.getPcity());
						acs.setString(31, "" + d.getPstate());
						acs.setString(32, "" + d.getPpincode());
						acs.setString(33, d.getCadd1());
						acs.setString(34, d.getCadd2());
						acs.setString(35, "" + d.getCcity());
						acs.setString(36, "" + d.getCstate());
						acs.setString(37, "" + d.getCpincode());
						acs.setString(38, "" + d.getPphone());
						acs.setString(39, "" + d.getCphone());
						acs.setString(40, "" + d.getEmailid());
						acs.setString(41, "" + d.getPeremailid());
						acs.setString(42, d.optpf);
						acs.setString(43, "" + d.getTxtpfvalue());
						acs.setString(44, "" + d.getTxtpfno());
						acs.setString(45, d.getOptesi());
						acs.setString(46, "" + d.getTxtesivalue());
						acs.setString(47, "" + d.getTxtesno());
						acs.setString(48, userId);
						acs.setString(49, updatedate);
						acs.setString(50, status);
						acs.setString(51, d.getMobile());
						acs.setString(52, d.getCarry());
						acs.setString(53, "" + d.getQualification());
						acs.setString(54, d.getManagement());
						acs.setString(55, d.getRepto());
						acs.setString(56, d.getReporinghead());
						acs.setString(57, d.getHold());
						acs.setString(58, d.getDispensary());
						acs.setString(59, d.getConveyance());
						acs.setString(60, "" + d.getSalarycalculation());
						acs.setString(61, "" + d.getPayslip());
						acs.setString(62, d.getPannumber().toUpperCase());
						acs.setString(63, d.getPassportnumber().toUpperCase());
						acs.setString(64, d.getDrivingnumber().toUpperCase());
						acs.setString(65, d.getMothername());
						acs.setString(66, "N");//future10
						acs.setString(67, "");
						acs.setString(68, "" + d.getCategory());
						acs.setString(69, d.getPfesidate());
						acs.setString(70, d.getResigndate());
						acs.setString(71, d.getPreviousdetails());
						acs.setString(72, "" + d.pdistrict);
						acs.setString(73, "" + d.getPcountry());
						acs.setString(74, "" + d.getCdistrict());
						acs.setString(75, "" + d.getCcountry());
						acs.setString(76, d.getInterview());
						acs.setString(77, d.getRejoin());
						acs.setString(78, d.getNominee());
						acs.setString(79, d.getSalarysplitupby());
						acs.setString(80, ""+d.getCtc());
						acs.setString(81, d.getIfsccode().toUpperCase());
						acs.setString(82, "" + d.getAttendancecycle());
						acs.setString(83, d.getSalarytype());
						acs.setString(84, d.getRevisiondate());
						acs.setString(85, ""+d.getLocation());
						acs.setString(86, d.getPreviousempid());
						acs.setString(87, d.getPfnomineerelationship());
						acs.setString(88, d.getSpousename());
						System.out.println("" + acs);
						acs.execute();
						System.out.println("Inserted.....");
						acs.close();
						 
	
						//System.out.println("com_m_staff,com_m_staffid,m_user,m_user_privilege,com_m_staffaddressproof,att_t_register Inserted");
					 	
						//Insert Salary Structure...
						if ("A".equals(d.getSalarysplitupby()))
							SalaryFunctions.salaryBand(userId,regid,d.getGross(), d.getStype());
						else
							SalaryFunctions.salaryBandManual(regid, ""+ d.getBasic());
						//System.out.println("allowance & recovery inserted");
						
						//Insert leave...
						PreparedStatement apstm = con.prepareStatement("");
						
						 
						StaffRegistrationMethod.insertStaffLeave(regid,apstm, con,userId);
						
						//System.out.println("leave inserted");
						
						
				   		itr = items.iterator();
				   		while (itr.hasNext()) 
				   		{
				   			FileItem item = (FileItem) itr.next();
				   			if (item.isFormField())
					   		{
					        } 
							else
					   		{
				    			try 
								{
									String itemName = item.getName(); 
									File file = new File(itemName);  
									String fileName= file.getName();
									File savedFile = new File(request.getRealPath("/") +"uploadfiles/StaffPhoto/"+regid+".jpg" );
				   					item.write(savedFile);
				      	 		} 
								catch (Exception e) 
								{
				   					 System.out.println(e.getMessage());
				   				}
				   			}
	 			   		}
	 			   		ImageFunctions.updateStaffImage(request.getRealPath("")+"/uploadfiles/StaffPhoto/"+regid+".jpg", regid);
	 			   		//System.out.println("Photo uploaded...");
				   		Thread.sleep(3000);
				   		
				   		//send a Mail...
						if ("Y".equals(CommonFunctions.QueryExecute("SELECT  CHR_NEWJOINNERMAILALERT  FROM m_institution  WHERE INT_ID= 1")[0][0]))
							StaffRegistrationMethod.sendNewJoinnerInfoMailtoAllEmpwithPhoto(regid,request.getRealPath("/"),CommonFunctions.QueryExecute("SELECT CHR_GROUPMAIL FROM m_institution WHERE INT_ID=1")[0][0]);
						System.out.println(regid +" Mail sent...");
						response.sendRedirect("Smart Common/StaffaddResponse.jsp?addMore=Y&regid="+ regid+ "&Name="+ d.getName()+ "&salarysplitupby="+ d.getSalarysplitupby());
			   		}
			   		else
			   		{
			   			response.sendRedirect("Smart Common/StaffRegistrationView.jsp");
			   		}
			   }
			 
		} 
    	catch (Exception e) 
    	{
		 	System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 
		}
    	 
    }
    
    
    
     //Getting Registration Number
	public static String staffRegistrationNumber(String doj,String company) 
	 {
		try 
	 	{
			String regnumber="";
			String sql = "SELECT CHR_SHORTNAME,MONTH('"	+ doj+ "'),YEAR('"+ doj+ "') FROM com_m_company WHERE INT_COMPANYID="	+company;
			String regdata[][] = CommonFunctions.QueryExecute(sql);
			String runningnumber="";
			sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_ID)+1),'1')   FROM com_m_staffid)),6) ";
			runningnumber =  CommonFunctions.QueryExecute(sql)[0][0];
			regnumber = ""+ regdata[0][0]+ CommonFunctions.getMonthShortName(Integer.parseInt(regdata[0][1]))+ regdata[0][2] +runningnumber;
 			return regnumber;
 	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
}
