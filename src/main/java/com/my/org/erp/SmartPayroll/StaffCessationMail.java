package com.my.org.erp.SmartPayroll;

import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.SmartMailtemplates.Mail;
import com.my.org.erp.SmartMailtemplates.StyleSheet;
import com.my.org.erp.SmartMailtemplates.Template2;

public class StaffCessationMail 
{
	public static String sql =""; 
	public static void sendStaffCessationMail(String staffid,String branchid, String Path)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM pay_m_basicsettings WHERE INT_ID=1")[0][0]))
			{
				
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_CESSATIONMAIL FROM   m_mailsetting WHERE INT_MAILID=1")[0][0];
				String content = staffCessationMailContent(staffid,branchid);
				String subject = " Relieving Formality  "+staffid;
				String recipients[] =(approvalmail).split(",") ;
				String[] attachments = Template2.paymentUpdatedImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	public static void deletedStaffCessationMail(String staffid,String branchid, String Path,String reason)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM pay_m_basicsettings WHERE INT_ID=1")[0][0]))
			{
				
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_CESSATIONMAIL FROM   m_mailsetting WHERE INT_MAILID=1")[0][0];
				String content = staffCessationMailDeleteContent(staffid,branchid,reason);
				String subject = " Deleting from cessation  "+staffid;
				String recipients[] =(approvalmail).split(",") ;
				String[] attachments = Template2.paymentUpdatedImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	public static String  staffCessationMailContent(  String staffid, String branchid )
    {
    	String content="";
		try
    	{ 
    		
			//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template2.topContent("CESSATION");
			
			
			//content start		 						
			String asql = " ";
			asql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_OFFICENAME,c.CHR_DEPARTNAME  ,DATE_FORMAT(e.DT_TERM_DATE,'%d-%b-%Y') ,e.CHR_REASON,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),";
			asql = asql + " CONCAT( ";
			asql = asql + " 		FLOOR(PERIOD_DIFF(DATE_FORMAT(NOW(),'%y%m') , DATE_FORMAT(a.DT_DOJCOLLEGE,'%y%m'))/12 ), ' - Years  / ' , ";
			asql = asql + " 		MOD(PERIOD_DIFF(DATE_FORMAT(NOW(),'%y%m') , DATE_FORMAT(a.DT_DOJCOLLEGE,'%y%m') ), 12) , ' - Months' ";
			asql = asql + " 		), ";
			asql = asql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REPTO) ";
			//  DATEDIFF(e.DT_TERM_DATE,a.DT_DOJCOLLEGE)  
			asql = asql + " FROM com_m_staff a, com_m_office b, com_m_depart c, pay_t_emp_ndc d ,pay_m_emp_termination e ";
			asql = asql + " WHERE a.INT_OFFICEID =b.INT_OFFICEID ";
			asql = asql + " AND a.INT_DEPARTID = c.INT_DEPARTID ";
			asql = asql + " AND a.CHR_EMPID = d.CHR_EMPID   AND a.CHR_EMPID = e.CHR_EMPID  ";
			asql = asql + " AND a.CHR_EMPID='"+staffid+"' ";
			String data[][] = CommonFunctions.QueryExecute(asql);
					
			if(data.length>0)
			{
				 
				 
				content = content + "<table width='100%' border='0' align='center' cellpadding='2' cellspacing='2'> ";
				content = content + " <tr> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>EMP ID </td> ";
				content = content + " <td class='boldEleven'>"+data[0][0]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				content = content + " <tr bgcolor='#FF9900'> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>NAME</td> ";
				content = content + " <td class='boldEleven'>"+data[0][1]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				content = content + " <tr > ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>DOJ</td> ";
				content = content + " <td class='boldEleven'>"+data[0][6]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				content = content + " <tr bgcolor='#FF9900'> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>OFFICE</td> ";
				content = content + " <td class='boldEleven'>"+data[0][2]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				content = content + " <tr  > ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>DEPARTMENT</td> ";
				content = content + " <td class='boldEleven'>"+data[0][3]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				content = content + " <tr bgcolor='#FF9900'> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>LAST WORKING DAY</td> ";
				content = content + " <td class='boldEleven'>"+data[0][4]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				content = content + " <tr > ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>REASON</td> ";
				content = content + " <td class='boldEleven'>"+data[0][5]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				content = content + " <tr bgcolor='#FF9900'> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>Experience</td> ";
				content = content + " <td class='boldEleven'>"+data[0][7]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				content = content + " <tr> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>Reporting To</td> ";
				content = content + " <td class='boldEleven'>"+data[0][8]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				
				//Advance
				asql="SELECT sum(INT_ADVAMT) FROM pay_m_advance WHERE CHR_EMPID='"+staffid+"' ";
				String advdata[][] = CommonFunction.doubleRecordSetArray(asql);
				double advance=0.0;
				double dtection=0.0;
				if(advdata.length>0)
					advance=Double.parseDouble(advdata[0][0]);


				asql="SELECT sum(INT_DUEAMT) FROM pay_t_advance WHERE CHR_EMPID='"+staffid+"' ";
				String detectdata[][] = CommonFunction.doubleRecordSetArray(asql);
				if(detectdata.length>0)
					dtection=Double.parseDouble(detectdata[0][0]);

				if((advance-dtection)>0)
				{
					content = content + " <tr bgcolor='#FF9900'> ";
					content = content + " <td>&nbsp;</td> ";
					content = content + " <td class='boldEleven'><b>ADVANCE</td> ";
					content = content + " <td class='boldEleven' bgcolor='#d9534f'>Advance Amount Rs."+(advance-dtection)+"</td> ";
					content = content + " <td>&nbsp;</td> ";
					content = content + " </tr> ";
				}
				//Asset
				if(CommonFunction.RecordExist("SELECT COUNT(*) FROM inv_t_asset WHERE CHR_EMPID ='"+staffid+"'  AND CHR_STATUS='N'"))
				{
					content = content + " <tr> ";
					content = content + " <td>&nbsp;</td> ";
					content = content + " <td class='boldEleven'><b>ASSET</td> ";
					content = content + " <td class='boldEleven'>";
					asql = " SELECT  b.CHR_ITEMNAME ,a.CHR_SERIALNO ,a.CHR_DESCRIPTION,DATE_FORMAT(a.DAT_CREATIONDATE,'%d-%b-%Y')  ";
					asql = asql + " FROM inv_t_asset a, inv_m_item b   ";
					asql = asql + " WHERE  b.CHR_ITEMID = a.CHR_ITEMID AND a.CHR_STATUS ='N'  ";
					asql = asql + " AND a.CHR_EMPID ='"+staffid+"'  ";
					String adata[][] = CommonFunctions.QueryExecute(asql);
					if(adata.length>0)
					{
						content = content + "<center>";
						content = content + "<table width='60%' cellpadding=2 cellspacing=1 bgcolor='#d9534f' >";
						content = content + "<tr >";
						content = content + "<td class='boldEleven' align='center'><b>S.No<b></td>";
						content = content + "<td class='boldEleven' align='center'><b>Item<b></td>";
						content = content + "<td class='boldEleven' align='center'><b>Serial<b></td>";
						content = content + "<td class='boldEleven' align='center'><b>Description<b></td>";
						content = content + "<td class='boldEleven' align='center'><b>Date<b></td>";
						content = content + "</tr>";
						
						for(int x=0;x<adata.length;x++)
						{
							content = content + "<tr >";
							content = content + "<td class='boldEleven' >"+(x+1)+"</td>";
							content = content + "<td class='boldEleven' >"+adata[0][0]+"</td>";
							content = content + "<td class='boldEleven' >"+adata[0][1]+"</td>";
							content = content + "<td class='boldEleven' >"+adata[0][2]+"</td>";
							content = content + "<td class='boldEleven' >"+adata[0][3]+"</td>";
							content = content + "</tr>" ;
						}
						content = content + "</table>" ;
						content = content + "</center>" ;
						
					content = content + " <td>&nbsp;</td> ";
					content = content + " </tr> ";
					}
					content = content + " </td>";
				}
				content = content + " </table> ";
				 

			}
			//content end.
			
			//bottom content
			content = content + Template2.bottomContent(branchid);
	
			
			return content;
    		
    	}
    	catch(Exception e)
    	{
    		 
    		System.out.println(e.getMessage());
    	}
    	return content;
    }
	
	
	public static String  staffCessationMailDeleteContent(  String staffid, String branchid, String reason )
    {
    	String content="";
		try
    	{ 
    		
			//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template2.topContent("CESSATION DELETE");
			
			
			//content start		 						
			String asql = " ";
			asql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_OFFICENAME,c.CHR_DEPARTNAME ";
			asql = asql + " FROM com_m_staff a, com_m_office b, com_m_depart c ";
			asql = asql + " WHERE a.INT_OFFICEID =b.INT_OFFICEID ";
			asql = asql + " AND a.INT_DEPARTID = c.INT_DEPARTID ";
			asql = asql + " AND a.CHR_EMPID='"+staffid+"' ";
			String data[][] = CommonFunctions.QueryExecute(asql);
					
			if(data.length>0)
			{
				 
				 
				content = content + "<table width='100%' border='0' align='center' cellpadding='2' cellspacing='2'> ";
				content = content + " <tr> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>EMP ID </td> ";
				content = content + " <td class='boldEleven'>"+data[0][0]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				content = content + " <tr bgcolor='#FF9900'> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>NAME</td> ";
				content = content + " <td class='boldEleven'>"+data[0][1]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				content = content + " <tr> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>OFFICE</td> ";
				content = content + " <td class='boldEleven'>"+data[0][2]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				content = content + " <tr bgcolor='#FF9900'> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>DEPARTMENT</td> ";
				content = content + " <td class='boldEleven'>"+data[0][3]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				
				content = content + " <tr > ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>REASON</td> ";
				content = content + " <td class='boldEleven'><h1>"+reason+"</h1></td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				
				
				 
			 
				//Advance
				asql="SELECT sum(INT_ADVAMT) FROM pay_m_advance WHERE CHR_EMPID='"+staffid+"' ";
				String advdata[][] = CommonFunction.doubleRecordSetArray(asql);
				double advance=0.0;
				double dtection=0.0;
				if(advdata.length>0)
					advance=Double.parseDouble(advdata[0][0]);


				asql="SELECT sum(INT_DUEAMT) FROM pay_t_advance WHERE CHR_EMPID='"+staffid+"' ";
				String detectdata[][] = CommonFunction.doubleRecordSetArray(asql);
				if(detectdata.length>0)
					dtection=Double.parseDouble(detectdata[0][0]);

				if((advance-dtection)>0)
				{
					content = content + " <tr> ";
					content = content + " <td>&nbsp;</td> ";
					content = content + " <td class='boldEleven'><b>ADVANCE</td> ";
					content = content + " <td class='boldEleven' bgcolor='#d9534f'>Advance Amount Rs."+(advance-dtection)+"</td> ";
					content = content + " <td>&nbsp;</td> ";
					content = content + " </tr> ";
				}
				//Asset
				if(CommonFunction.RecordExist("SELECT COUNT(*) FROM inv_t_asset WHERE CHR_EMPID ='"+staffid+"'  AND CHR_STATUS='N'"))
				{
					content = content + " <tr> ";
					content = content + " <td>&nbsp;</td> ";
					content = content + " <td class='boldEleven'><b>ASSET</td> ";
					content = content + " <td class='boldEleven'>";
					asql = " SELECT  b.CHR_ITEMNAME ,a.CHR_SERIALNO ,a.CHR_DESCRIPTION,DATE_FORMAT(a.DAT_CREATIONDATE,'%d-%b-%Y')  ";
					asql = asql + " FROM inv_t_asset a, inv_m_item b   ";
					asql = asql + " WHERE  b.CHR_ITEMID = a.CHR_ITEMID AND a.CHR_STATUS ='N'  ";
					asql = asql + " AND a.CHR_EMPID ='"+staffid+"'  ";
					String adata[][] = CommonFunctions.QueryExecute(asql);
					if(adata.length>0)
					{
						content = content + "<center>";
						content = content + "<table width='60%' cellpadding=2 cellspacing=1 bgcolor='#d9534f' >";
						content = content + "<tr >";
						content = content + "<td class='boldEleven' align='center'><b>S.No<b></td>";
						content = content + "<td class='boldEleven' align='center'><b>Item<b></td>";
						content = content + "<td class='boldEleven' align='center'><b>Serial<b></td>";
						content = content + "<td class='boldEleven' align='center'><b>Description<b></td>";
						content = content + "<td class='boldEleven' align='center'><b>Date<b></td>";
						content = content + "</tr>";
						
						for(int x=0;x<adata.length;x++)
						{
							content = content + "<tr >";
							content = content + "<td class='boldEleven' >"+(x+1)+"</td>";
							content = content + "<td class='boldEleven' >"+adata[0][0]+"</td>";
							content = content + "<td class='boldEleven' >"+adata[0][1]+"</td>";
							content = content + "<td class='boldEleven' >"+adata[0][2]+"</td>";
							content = content + "<td class='boldEleven' >"+adata[0][3]+"</td>";
							content = content + "</tr>" ;
						}
						content = content + "</table>" ;
						content = content + "</center>" ;
						
					content = content + " <td>&nbsp;</td> ";
					content = content + " </tr> ";
					}
					content = content + " </td>";
				}
				content = content + " </table> ";
				 

			}
			//content end.
			
			//bottom content
			content = content + Template2.bottomContent(branchid);
	
			
			return content;
    		
    	}
    	catch(Exception e)
    	{
    		 
    		System.out.println(e.getMessage());
    	}
    	return content;
    }
}
