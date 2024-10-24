package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException; 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 

public class PayRollRevisionActionHandler extends AbstractActionHandler 
{

	
	String action = null;
	String Staffid = null;
	String Revision = null;
	String rivisiontype = null;
	String rdescription = null;
	String dor = null;
	String dor1=null;
	String doa = null;
	String doa1 = null;
	String doj = null;
	String PF  = null;
	String optpf  = null;
	String TxtPfNo  = null;
	String TxtPfValue  = null;
	String ESI  = null;
	String optesi  = null;
	String TxtEsiNo  = null;
	String TxtEsiValue  = null;
	String pfcalculationtype = null;
	
	String sql="";
	double oldctc=0;
	double oldgross=0;
	double newctc=0;
	double newgross=0;
	double newbasic=0;
	double newpfamount=0;
	double newesiamount=0;
	double rpercentage  = 0;
	double grossdifference=0;
	double ctcdifference=0;
	double tempctc=0;
	String userid =null;
	HttpSession session =null;
	String institutionData[][] = CommonFunctions.QueryExecute("SELECT  INT_PFAMT,INT_ESIAMT,INT_ESILIMIT,INT_PFLIMIT,INT_PFLIMITMINIMUM ,INT_CPY_ESIAMT FROM m_institution WHERE INT_ID=1");
	double pfpercentage = Double.parseDouble( institutionData[0][0]);
	double esipercentage = Double.parseDouble( institutionData[0][1]);
	double esilimitamount = Double.parseDouble( institutionData[0][2]);
	double pfmaximumlimit = Double.parseDouble( institutionData[0][3]);
	double pfminimumlimit = Double.parseDouble( institutionData[0][4]);
	double esicomapnypercentage = Double.parseDouble( institutionData[0][5]);
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			action = request.getParameter("actionS");
			session = request.getSession();
			userid = (String) session.getAttribute("USRID");
			
			String loginempid = (String) session.getAttribute("EMPID");
 			
			if("PAYPayRollRevisionAdd".equals(action))
			{ 
				Staffid = ""+request.getParameter("Staffid");
				Revision = ""+request.getParameter("Revision");
				rivisiontype = ""+request.getParameter("rivisiontype");
				rdescription = ""+request.getParameter("rdescription");
				dor = ""+request.getParameter("dor");
				doj = ""+request.getParameter("doj");
				doa = ""+request.getParameter("doa");
				doa1 = ""+request.getParameter("doa1");
				PF  = ""+request.getParameter("pf");
				optpf  = ""+request.getParameter("optpf");
				TxtPfNo  = ""+request.getParameter("TxtPfNo");
				TxtPfValue  = ""+request.getParameter("TxtPfValue");
				ESI  = ""+request.getParameter("ESI");
				optesi  = ""+request.getParameter("optesi");
				TxtEsiNo  = ""+request.getParameter("TxtEsiNo");
				TxtEsiValue  = ""+request.getParameter("TxtEsiValue");
				rpercentage  = Double.parseDouble(""+request.getParameter("rpercentage"));
				pfcalculationtype  =  ""+request.getParameter("pfcalculationtype") ;
				asql = " SELECT INT_PFMINIMUM_LIMIT,INT_PFMAXIMUM_LIMIT,INT_ESILIMIT FROM m_pf_setting WHERE INT_ROWID = "+pfcalculationtype;
				String pfData[][] = CommonFunctions.QueryExecutecon(con,asql);
				if(pfData.length>0)
				{
					pfminimumlimit = Double.parseDouble( pfData[0][0]);
					pfmaximumlimit = Double.parseDouble( pfData[0][1]);
					esilimitamount = Double.parseDouble( pfData[0][2]);
				}
				
				dor1 = CommonFunctions.QueryExecute("SELECT  DATE_FORMAT(DAT_RIVISION,'%Y-%m-%d')  FROM com_m_staff WHERE CHR_EMPID='"+Staffid+"'")[0][0];
				
				if("Y".equals(Revision))
				{
					if("A".equals(rivisiontype))
					{	
						oldgross  = Double.parseDouble(""+request.getParameter("gross"));
						newgross =oldgross+(oldgross*rpercentage/100);
						
						newbasic =salaryBandBasic(newgross);
						
						//PF CALCULAION
						if("C".equals(PF))
						{
							if(newbasic <= pfminimumlimit)
								newpfamount = (pfminimumlimit*pfpercentage/100); 
							else if( (newbasic>pfminimumlimit)  && (newbasic <=pfmaximumlimit))	
								newpfamount = (newbasic*pfpercentage/100); 
							else
								newpfamount = (pfmaximumlimit*pfpercentage/100);
						}
						else if("Y".equals(PF))
							newpfamount=Double.parseDouble(TxtPfValue);
						else
							newpfamount =0;
						 
						 
							
						//NEW ESI CALCULATION
						if( "C".equals(ESI)  && ( newgross <= esilimitamount))
							newesiamount=(newgross*esicomapnypercentage/100);
						else if( "Y".equals(ESI)  && ( newgross <= esilimitamount))
							newesiamount=Double.parseDouble(TxtEsiValue);
						else
							 newesiamount=0;
						
						//Arrival of New CTC
						oldctc  = Double.parseDouble(""+request.getParameter("totalctc"));
						newctc = newgross+newpfamount+newesiamount;
						
						grossdifference  = newgross-oldgross;
						ctcdifference =newctc-oldctc;
						//PayrollRevisionMethod.revisionAutoUpdate(request,response,newgross,con,apstm, auserid);
						revisionUpdate(request,response,newgross);
					}
					else
					{
						revisionManualUpdate(request,response);
					}
						
				}
				else
				{
					revisionNotUpdate(request,response );
				}
					
								
			}
			else if("PAYPayRollRevisionNext".equals(action))
			{
				dor = request.getParameter("dor");
				Staffid = request.getParameter("Staffid");
				sql ="UPDATE com_m_staff SET DAT_RIVISION=? WHERE CHR_EMPID=?";
				apstm = con.prepareStatement(sql);
				apstm.setString(1,DateUtil.FormateDateSQL(dor));
				apstm.setString(2,Staffid);
				apstm.execute(); 
				apstm.close();
				con.close();   
				response.sendRedirect("Smart Payroll/PayRollRevision.jsp");
				
			}
			else if("PAYPayRollRevisionAccept".equals(action))
			{
				revisionMovetoMaster(request, response);
				
			}
			else if("PAYPayRollRevisionArrearIssue".equals(action))
			{

				 
				String issuedate= request.getParameter("issuedate");
				String issuemode= request.getParameter("issuemode");
				 
				String memo= request.getParameter("memo");
				String dec= request.getParameter("dec");
				int row = Integer.parseInt(dec) ;
				String issue;
				asql = "UPDATE pay_t_appraisal SET ";
				asql = asql + " CHR_ISSUEDATE =? ,";
				asql = asql + " CHR_ISSUEMODE =? ,";
				asql = asql + " CHR_ISSUE_DESC =? ,";
				asql = asql + " CHR_ISSUEDBY =? ";
				asql = asql + "  WHERE INT_APPRAISALID=? AND CHR_EMPID=? ";
				apstm = con.prepareStatement(asql);
				for(int i=1; i<=row;i++)
				{
					issue = request.getParameter("issue"+i);
					apstm.setString(1,issuedate );
					apstm.setString(2,issuemode );
					//apstm.setString(3,bankgroup );
					apstm.setString(3,memo );
					apstm.setString(4,loginempid );
					apstm.setString(5,request.getParameter("rowid"+i) );
					apstm.setString(6,request.getParameter("empid"+i) );
					if("Y".equals(issue))
							apstm.addBatch();
				}
				System.out.println(""+apstm);
				 
				apstm.executeBatch();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Payroll/ArrearIssue.jsp ");
				
				
			
				
			}
			
			 
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 
		}
	}
	
	
	//Auto Update
	private void revisionUpdate(HttpServletRequest request,HttpServletResponse response,double newgross)throws ServletException, IOException
	{
		try
		{			
			 System.out.println("Revision Automated");
			sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_PF,a.CHR_PFTYPE,a.INT_PFAMT,a.CHR_PFNO, ";
			sql = sql + " a.CHR_ESI,a.CHR_ESITYPE,a.INT_ESIAMT,a.CHR_ESINO , a.INT_GROSS_PERCENT, a.INT_VARIABLE_PERCENT ,";
			sql = sql + " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y')";
			sql = sql + " FROM com_m_staff a  "; 
			sql = sql + " WHERE a.CHR_EMPID='"+Staffid+"' ";
			String perData[][] =CommonFunctions.QueryExecute(sql);
			
			//sql = "SELECT PERIOD_DIFF(DATE_FORMAT('"+DateUtil.FormateDateSQL(doa1)+"','%Y%m'),DATE_FORMAT('"+DateUtil.FormateDateSQL(doa)+"','%Y%m')) ";
			//sql = " SELECT TIMESTAMPDIFF(MONTH, '"+DateUtil.FormateDateSQL(doa)+"',  DATE_FORMAT(DATE_ADD('"+DateUtil.FormateDateSQL(doa1)+"', INTERVAL 1 DAY),'%Y-%m-%d')) ";
			//String monthdifference[][] =CommonFunctions.QueryExecute(sql);
			sql = " SELECT DATEDIFF( '"+DateUtil.FormateDateSQL(doa1)+"',   '"+DateUtil.FormateDateSQL(doa)+"' ),DAY(LAST_DAY('"+DateUtil.FormateDateSQL(dor)+"')) ";
			String daydifference[][] =CommonFunctions.QueryExecute(sql);

			
			sql = " INSERT INTO pay_t_appraisal ( ";
			sql = sql + " CHR_EMPID,CHR_STAFFNAME,CHR_OLD_PF,CHR_OLD_PFTYPE,INT_OLD_PFAMT,CHR_OLD_PFNO, ";
			sql = sql + " CHR_OLD_ESI,CHR_OLD_ESITYPE,INT_OLD_ESIAMT,CHR_OLD_ESINO,  ";
			sql = sql + " INT_OLD_GROSS,INT_OLDCTC,  ";
			sql = sql + " CHR_PF,CHR_PFTYPE,INT_PFAMT,CHR_PFNO,  ";
			sql = sql + " CHR_ESI,CHR_ESITYPE,INT_ESIAMT,CHR_ESINO,  ";
			sql = sql + " CHR_REVISION,CHR_REVISION_TYPE,CHR_DESC,  ";
			sql = sql + " INT_REVISION_PERCENT,INT_GROSS,INT_CTC,   ";
			sql = sql + " DAT_DOJ,DAT_DOR,DAT_DOA, DAT_DOA1,INT_DIFFERENCE,DOU_INCREMENT,DOU_ARREAR_AMOUNT, ";
			sql = sql + " DOU_GROSS_DIFFERENCE,DOU_CTC_DIFFERENCE,CHR_ACCEPT,CHR_ACCEPTEDBY,CHR_PFCALCULATIONTYPE,";
			sql = sql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			sql = sql + " VALUES ( ";
			sql = sql + " ?,?,?,?,?,";
			sql = sql + " ?,?,?,?,?,  ";
			sql = sql + " ?,?,?,?,?, ?, ?,?,  ";
			sql = sql + " ?,?,?,?,?,  ";
			sql = sql + " ?,?,?,?,?, ?, ";
			sql = sql + " ?,?,?,?,?, ?,?,?,?, ?,";
			sql = sql + " DATE(NOW()),'Y' ";
			sql = sql + " )";
			apstm  = con.prepareStatement(sql);
			apstm.setString(1, Staffid);
			apstm.setString(2, perData[0][1]);
			apstm.setString(3, perData[0][2]);
			apstm.setString(4, perData[0][3]);
			apstm.setString(5, perData[0][4]);
			apstm.setString(6, perData[0][5]);
			apstm.setString(7, perData[0][6]);
			apstm.setString(8, perData[0][7]);
			apstm.setString(9, perData[0][8]);
			apstm.setString(10, perData[0][9]);
			apstm.setString(11, ""+(int)oldgross);
			apstm.setString(12, ""+(int)oldctc);
			apstm.setString(13, PF);
			apstm.setString(14, optpf);
			apstm.setString(15, TxtPfValue);
			apstm.setString(16, TxtPfNo);
			apstm.setString(17, ESI);
			apstm.setString(18, optesi);
			apstm.setString(19, TxtEsiValue);
			apstm.setString(20, TxtEsiNo);
			apstm.setString(21, Revision);
			apstm.setString(22, rivisiontype);
			apstm.setString(23, rdescription);
			apstm.setString(24, ""+(int)rpercentage);
			apstm.setString(25, ""+(int)newgross);
			apstm.setString(26, ""+(int)newctc);
			apstm.setString(27,DateUtil.FormateDateSQL(perData[0][12]));
			apstm.setString(28,DateUtil.FormateDateSQL(dor));
			apstm.setString(29,DateUtil.FormateDateSQL(doa));
			apstm.setString(30,DateUtil.FormateDateSQL(doa1));
			apstm.setString(31, daydifference[0][0]);
			apstm.setString(32,""+(int)ctcdifference );//(newctc-oldctc)
			 apstm.setString(33,""+(int) (ctcdifference/Integer.parseInt(daydifference[0][1]))*Integer.parseInt(daydifference[0][0]));//(newctc-oldctc)
			 apstm.setString(34, ""+(int)(newgross-oldgross));
			apstm.setString(35, ""+(int)(newctc-oldctc));
			apstm.setString(36,"Y");
			apstm.setString(37,auserid);
			apstm.setString(38,pfcalculationtype);
			apstm.setString(39,userid.toUpperCase());
			System.out.println("sql :"+apstm);	
			apstm.execute();
			
			sql = " UPDATE com_m_staff  SET "; 
			sql = sql + " CHR_PF=?, ";
			sql = sql + " CHR_PFTYPE=?, ";
			sql = sql + " INT_PFAMT=?, ";
			sql = sql + " CHR_PFNO=?, ";
			sql = sql + " CHR_ESI=?, ";
			sql = sql + " CHR_ESITYPE=?, ";
			sql = sql + " INT_ESIAMT=?, ";
			sql = sql + " CHR_ESINO=?, ";
			sql = sql + " INT_GROSSSALARY=? ,DAT_RIVISION=?, CHR_PFCALCULATIONTYPE=? ";
			sql = sql + " WHERE CHR_EMPID=? ";
			apstm  = con.prepareStatement(sql);
			apstm.setString(1, PF);
			apstm.setString(2, optpf);
			apstm.setString(3, TxtPfValue);
			apstm.setString(4, TxtPfNo);
			apstm.setString(5, ESI);
			apstm.setString(6, optesi);
			apstm.setString(7, TxtEsiValue);
			apstm.setString(8, TxtEsiNo);
			apstm.setString(9, ""+(int)newgross);
			if(Integer.parseInt(daydifference[0][0]) >0)
				apstm.setString(10,CommonFunctions.QueryExecute(" SELECT DATE_FORMAT(DATE_ADD('"+(dor1)+"', INTERVAL 1 YEAR),'%Y-%m-%d') ")[0][0]);
			else
				apstm.setString(10,CommonFunctions.QueryExecute(" SELECT DATE_FORMAT(DATE_ADD('"+DateUtil.FormateDateSQL(dor)+"', INTERVAL 1 YEAR),'%Y-%m-%d') ")[0][0]);
			
			apstm.setString(11, pfcalculationtype);
			apstm.setString(12, Staffid);
			System.out.println("sql :"+apstm);
			apstm.execute();
			apstm.close();
			
			salaryBandInGrossAllowance(Staffid , newgross,DateUtil.FormateDateSQL(dor));
			
			
			con.close();   
			response.sendRedirect("Smart Payroll/PayRollRevisionAutomatedNext.jsp?staffid="+Staffid+"&dor="+DateUtil.FormateDateSQL(dor));
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
		}
	}
	
	
	

	
	
	private void revisionNotUpdate(HttpServletRequest request,HttpServletResponse response )throws ServletException, IOException
	{
		try
		{
			
			Staffid = request.getParameter("Staffid");
			Revision = request.getParameter("Revision");
			rdescription = request.getParameter("rdescription");
			dor = request.getParameter("dor");
			sql = "INSERT INTO pay_t_rivision_cancel ";
			sql = sql + " ( CHR_EMPID,CHR_REVISION,CHR_DESC,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			sql = sql + " VALUES (?,?,?,?,DATE(NOW()),'Y' )";
			apstm = con.prepareStatement(sql);
			apstm.setString(1,Staffid);
			apstm.setString(2,Revision);
			apstm.setString(3,rdescription);
			apstm.setString(4,auserid);
			apstm.execute(); 
			apstm.close();
			con.close();   
			response.sendRedirect("Smart Payroll/PayRollRevisionNext.jsp?staffid="+Staffid+"&dor="+DateUtil.FormateDateSQL(dor));
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
		}
	}
 
	
	
	
	
	//Manual
	private void revisionManualUpdate(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			 
			System.out.println();
			System.out.println();
			System.out.println();
			System.out.println();
			Staffid = request.getParameter("Staffid");
			Revision = request.getParameter("Revision");
			rivisiontype = request.getParameter("rivisiontype");
			rdescription = request.getParameter("rdescription");
			dor = request.getParameter("dor");
			doj = request.getParameter("doj");
			doa = request.getParameter("doa");
			doa1 = request.getParameter("doa1");
			PF  = request.getParameter("pf");
			optpf  = request.getParameter("optpf");
			TxtPfNo  = request.getParameter("TxtPfNo");
			TxtPfValue  = request.getParameter("TxtPfValue");
			ESI  = request.getParameter("ESI");
			optesi  = request.getParameter("optesi");
			TxtEsiNo  = request.getParameter("TxtEsiNo");
			TxtEsiValue  = request.getParameter("TxtEsiValue");
			newbasic  = Double.parseDouble(""+request.getParameter("basic"));
			oldgross  = Double.parseDouble(""+request.getParameter("gross"));
			oldctc  = Double.parseDouble(""+request.getParameter("totalctc"));
			pfcalculationtype  = ""+request.getParameter("pfcalculationtype") ;
			
			
			double newgrossallowance=0;
			String allowancefield[][] =  CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
			String grossallowancefield="";
			String othersallowancefield="";
			String grossallowancename="";
			String otherallowancename="";
			if(allowancefield.length>0)
				for(int u=0;u<allowancefield.length;u++)
					if("Y".equals(allowancefield[u][2]))
					{
						grossallowancename = grossallowancename +allowancefield[u][1]+",";
						grossallowancefield = grossallowancefield +allowancefield[u][0]+",";
					}	
					else
					{
						otherallowancename = otherallowancename +allowancefield[u][1]+",";
						othersallowancefield = othersallowancefield +allowancefield[u][0]+",";
					}	
			
			
			String grossdata[] = grossallowancename.split(",");
			String grossallowancedata[] = grossallowancefield.split(",");
			
			
			
			
			
			if(grossdata.length>0)
				for(int u=0;+u<grossdata.length;u++)
					newgrossallowance = newgrossallowance +Double.parseDouble(request.getParameter("allowance"+(u+1)));
			newgross = newbasic+newgrossallowance;
			
			
			
			
			pfcalculationtype  =  ""+request.getParameter("pfcalculationtype") ;
			asql = " SELECT INT_PFMINIMUM_LIMIT,INT_PFMAXIMUM_LIMIT,INT_ESILIMIT FROM m_pf_setting WHERE INT_ROWID = "+pfcalculationtype;
			String pfData[][] = CommonFunctions.QueryExecutecon(con,asql);
			if(pfData.length>0)
			{
				pfminimumlimit = Double.parseDouble( pfData[0][0]);
				pfmaximumlimit = Double.parseDouble( pfData[0][1]);
				esilimitamount = Double.parseDouble( pfData[0][2]);
			}
			System.out.println();
			System.out.println(pfminimumlimit);
			System.out.println(pfmaximumlimit);
			System.out.println(esilimitamount);
			
			
			//NEW PF CALCULAION
			if("C".equals(PF))
			{
				if(newbasic <= pfminimumlimit)
					newpfamount = (pfminimumlimit*pfpercentage/100); 
				else if( (newbasic>pfminimumlimit)  && (newbasic <=pfmaximumlimit))	
					newpfamount = (newbasic*pfpercentage/100); 
				else
					newpfamount = (pfmaximumlimit*pfpercentage/100);
			}
			else if("Y".equals(PF))
				newpfamount=Double.parseDouble(TxtPfValue);
			else
				newpfamount =0;
				
				
			//NEW ESI CALCULATION
			if( "C".equals(ESI)  && ( newgross <= esilimitamount))
				newesiamount=(newgross*esicomapnypercentage/100);
			else if( "Y".equals(ESI)  && ( newgross <= esilimitamount))
				newesiamount=Double.parseDouble(TxtEsiValue);
			else
				 newesiamount=0;
			
			//Arrival of New CTC
			newctc = newgross+newpfamount+newesiamount;
			
			grossdifference  = newgross-oldgross;
			ctcdifference =newctc-oldctc;
			
			
			
			
			
			sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_PF,a.CHR_PFTYPE,a.INT_PFAMT,a.CHR_PFNO, ";
			sql = sql + " a.CHR_ESI,a.CHR_ESITYPE,a.INT_ESIAMT,a.CHR_ESINO , a.INT_GROSS_PERCENT, a.INT_VARIABLE_PERCENT ,";
			sql = sql + " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y')";
			sql = sql + " FROM com_m_staff a  "; 
			sql = sql + " WHERE a.CHR_EMPID='"+Staffid+"' ";
			String perData[][] =CommonFunctions.QueryExecute(sql);
			
			//sql = "SELECT PERIOD_DIFF(DATE_FORMAT('"+DateUtil.FormateDateSQL(doa1)+"','%Y%m'),DATE_FORMAT('"+DateUtil.FormateDateSQL(doa)+"','%Y%m')) ";
			
			//sql = " SELECT TIMESTAMPDIFF(MONTH, '"+DateUtil.FormateDateSQL(doa)+"',  DATE_FORMAT(DATE_ADD('"+DateUtil.FormateDateSQL(doa1)+"', INTERVAL 1 DAY),'%Y-%m-%d')) ";
			//String monthdifference[][] =CommonFunctions.QueryExecute(sql);
			
			sql = " SELECT DATEDIFF( '"+DateUtil.FormateDateSQL(doa1)+"',   '"+DateUtil.FormateDateSQL(doa)+"' ),DAY(LAST_DAY('"+DateUtil.FormateDateSQL(dor)+"')) ";
			String daydifference[][] =CommonFunctions.QueryExecute(sql);
			
			
			sql = " INSERT INTO pay_t_appraisal ( ";
			sql = sql + " CHR_EMPID,CHR_STAFFNAME,CHR_OLD_PF,CHR_OLD_PFTYPE,INT_OLD_PFAMT,CHR_OLD_PFNO, ";
			sql = sql + " CHR_OLD_ESI,CHR_OLD_ESITYPE,INT_OLD_ESIAMT,CHR_OLD_ESINO,  ";
			sql = sql + " INT_OLD_GROSS,INT_OLDCTC,  ";
			sql = sql + " CHR_PF,CHR_PFTYPE,INT_PFAMT,CHR_PFNO,  ";
			sql = sql + " CHR_ESI,CHR_ESITYPE,INT_ESIAMT,CHR_ESINO,  ";
			sql = sql + " CHR_REVISION,CHR_REVISION_TYPE,CHR_DESC,  ";
			sql = sql + " INT_REVISION_PERCENT,INT_GROSS,INT_CTC,   ";
			sql = sql + " DAT_DOJ,DAT_DOR,DAT_DOA, DAT_DOA1,INT_DIFFERENCE,DOU_INCREMENT,DOU_ARREAR_AMOUNT, ";
			sql = sql + " DOU_GROSS_DIFFERENCE,DOU_CTC_DIFFERENCE,CHR_PFCALCULATIONTYPE ,";
			sql = sql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			sql = sql + " VALUES ( ";
			sql = sql + " ?,?,?,?,?,";
			sql = sql + " ?,?,?,?,?,  ";
			sql = sql + " ?,?,?,?,?, ?,?,?,  ";
			sql = sql + " ?,?,?,?,?,  ";
			sql = sql + " ?,?,?,?,?, ?, ";
			sql = sql + " ?,?,?,?,?, ?,?,?, ";
			sql = sql + " DATE(NOW()),'Y' ";
			sql = sql + " )";
			apstm  = con.prepareStatement(sql);
			apstm.setString(1, Staffid);
			apstm.setString(2, perData[0][1]);
			apstm.setString(3, perData[0][2]);
			apstm.setString(4, perData[0][3]);
			apstm.setString(5, perData[0][4]);
			apstm.setString(6, perData[0][5]);
			apstm.setString(7, perData[0][6]);
			apstm.setString(8, perData[0][7]);
			apstm.setString(9, perData[0][8]);
			apstm.setString(10, perData[0][9]);
			apstm.setString(11, ""+(int)oldgross); 
			apstm.setString(12, ""+(int)oldctc); 
			apstm.setString(13, PF);
			apstm.setString(14, optpf);
			apstm.setString(15, TxtPfValue);
			apstm.setString(16, TxtPfNo);
			apstm.setString(17, ESI);
			apstm.setString(18, optesi);
			apstm.setString(19, TxtEsiValue);
			apstm.setString(20, TxtEsiNo);
			apstm.setString(21, Revision);
			apstm.setString(22, rivisiontype);
			apstm.setString(23, rdescription);
			apstm.setString(24, "0");
			apstm.setString(25, ""+(int)newgross);
			apstm.setString(26, ""+(int)newctc);
			apstm.setString(27,DateUtil.FormateDateSQL(perData[0][12]));
			apstm.setString(28,DateUtil.FormateDateSQL(dor));
			apstm.setString(29,DateUtil.FormateDateSQL(doa));
			apstm.setString(30,DateUtil.FormateDateSQL(doa1));
			apstm.setString(31, daydifference[0][0]);
			apstm.setString(32,""+(int)ctcdifference );//(newctc-oldctc)
			apstm.setString(33,""+(int) (ctcdifference/Integer.parseInt(daydifference[0][1]))*Integer.parseInt(daydifference[0][0]));//(newctc-oldctc)
			apstm.setString(34,""+(int)(newgross-oldgross));
			apstm.setString(35,""+(int)(newctc-oldctc));
			apstm.setString(36,pfcalculationtype );
			apstm.setString(37,userid.toUpperCase());
			System.out.println("sql :"+apstm);	
			apstm.execute();
			
			asql ="SELECT MAX(INT_APPRAISALID) FROM pay_t_appraisal  WHERE CHR_EMPID='"+Staffid+"'";
			String appraisalid = CommonFunctions.QueryExecute(asql)[0][0];
			
			asql = " INSERT INTO pay_t_appraisal_basic (CHR_EMPID,INT_APPRAISALID,CHR_PFCALCULATIONTYPE,CHR_MONTH,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES  (?,?,?,MONTHNAME('"+DateUtil.FormateDateSQL(dor)+"'),YEAR('"+DateUtil.FormateDateSQL(dor)+"'),?,DATE(NOW()),'Y' ) ";
			apstm  = con.prepareStatement(asql);
			apstm.setString(1, Staffid);
			apstm.setString(2, appraisalid);
			apstm.setString(3, pfcalculationtype);
			apstm.setString(4, auserid);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
			
			asql = " INSERT INTO pay_t_appraisal_allowance (CHR_EMPID,INT_APPRAISALID,CHR_MONTH,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES  (?,?,MONTHNAME('"+DateUtil.FormateDateSQL(dor)+"'),YEAR('"+DateUtil.FormateDateSQL(dor)+"'),?,DATE(NOW()),'Y' ) ";
			apstm  = con.prepareStatement(asql);
			apstm.setString(1, Staffid);
			apstm.setString(2, appraisalid);
			apstm.setString(3, auserid);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
			
			asql = " INSERT INTO pay_t_appraisal_recovery (CHR_EMPID,INT_APPRAISALID,CHR_MONTH,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES  (?,?,MONTHNAME('"+DateUtil.FormateDateSQL(dor)+"'),YEAR('"+DateUtil.FormateDateSQL(dor)+"'),?,DATE(NOW()),'Y' ) ";
			apstm  = con.prepareStatement(asql);
			apstm.setString(1, Staffid);
			apstm.setString(2, appraisalid);
			apstm.setString(3, auserid);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
			 
			sql = " UPDATE pay_t_appraisal_basic  SET "; 
			sql = sql + " CHR_PF=?, ";
			sql = sql + " CHR_PFTYPE=?, ";
			sql = sql + " INT_PFAMT=?, ";
			sql = sql + " CHR_PFNO=?, ";
			sql = sql + " CHR_ESI=?, ";
			sql = sql + " CHR_ESITYPE=?, ";
			sql = sql + " INT_ESIAMT=?, ";
			sql = sql + " CHR_ESINO=?, INT_SALARY=?,";
			sql = sql + " INT_GROSSSALARY=? , ";
			sql = sql + " DAT_RIVISION =? ";
			sql = sql + " WHERE CHR_EMPID=? AND INT_APPRAISALID=?";
			apstm  = con.prepareStatement(sql);
			apstm.setString(1, PF);
			apstm.setString(2, optpf);
			apstm.setString(3, TxtPfValue);
			apstm.setString(4, TxtPfNo);
			apstm.setString(5, ESI);
			apstm.setString(6, optesi);
			apstm.setString(7, TxtEsiValue);
			apstm.setString(8, TxtEsiNo);
			apstm.setString(9,  ""+(int)newbasic);
			apstm.setString(10, ""+(int)newgross);
			if(Integer.parseInt(daydifference[0][0]) >0)
				apstm.setString(11,CommonFunctions.QueryExecute(" SELECT DATE_FORMAT(DATE_ADD('"+(dor1)+"', INTERVAL 1 YEAR),'%Y-%m-%d') ")[0][0]);
			else
				apstm.setString(11,CommonFunctions.QueryExecute(" SELECT DATE_FORMAT(DATE_ADD('"+DateUtil.FormateDateSQL(dor)+"', INTERVAL 1 YEAR),'%Y-%m-%d') ")[0][0]);
			apstm.setString(12, Staffid);
			apstm.setString(13, appraisalid);
			System.out.println("========="+apstm);
			apstm.execute();
			apstm.close();
			
					
			//need allowance & recovery updated...
			//Allowance
			newgrossallowance=0;
			String allsql ="UPDATE pay_t_appraisal_allowance SET ";
			if(grossdata.length>0)
				for(int u=0;+u<grossdata.length;u++)
				{
					newgrossallowance = newgrossallowance +Double.parseDouble(request.getParameter("allowance"+(u+1)));
					allsql = allsql + grossallowancedata[u] +" = "+request.getParameter("allowance"+(u+1)) +" ,";
				}	
				
			
			String othersdata[] = otherallowancename.split(",");
			String othersallowancedata[] = othersallowancefield.split(",");
			if(othersdata.length>0)
				for(int u=0;+u<othersdata.length;u++)
					allsql = allsql + othersallowancedata[u] +" = "+request.getParameter("otherallowance"+(u+1)) +" ,";
			
			
			allsql  = allsql + " DT_UPDATEDATE ='"+DateUtil.FormateDateSQL(dor)+"'  ";
			allsql  = allsql + " WHERE CHR_EMPID ='"+Staffid+"'";
			allsql  = allsql + " AND INT_APPRAISALID= "+appraisalid ;
			System.out.println("Allowance Update");
			apstm  = con.prepareStatement(allsql);
			System.out.println("========="+apstm);
			apstm.execute();
			apstm.close();
			
			//CommonFunctions.Execute(allsql);
			
			
			//Recovery
			String recoveryfield[][] =  CommonFunctions.QueryExecute("SELECT CHR_RCODE,CHR_RNAME  FROM  pay_m_recovery ORDER BY INT_RECOVERYID");
			String recoveryfields="";
			String recoveryname="";
			if(recoveryfield.length>0)
			{
				for(int u=0;u<recoveryfield.length;u++)
				{
					recoveryname =recoveryname+ recoveryfield[u][1]+",";
					recoveryfields =recoveryfields+ recoveryfield[u][0]+",";
				}
			}
			String recsql ="UPDATE pay_t_appraisal_recovery SET ";
			String recdata[] = recoveryname.split(",");
			String recoveryfieldsdata[] = recoveryfields.split(",");
			if(recdata.length>0)
				for(int u=0;+u<recdata.length;u++)
				{
					recsql = recsql + recoveryfieldsdata[u] +" = "+request.getParameter("recovery"+(u+1)) +" ,";
				}
			recsql  = recsql + " DT_UPDATEDATE ='"+DateUtil.FormateDateSQL(dor)+"'  ";
			recsql  = recsql + " WHERE CHR_EMPID ='"+Staffid+"'";
			recsql  = recsql + " AND INT_APPRAISALID = "+appraisalid ;
			System.out.println("Recovery Update");
			apstm  = con.prepareStatement(recsql);
			System.out.println("========="+apstm);
			apstm.execute();
			apstm.close();
			//CommonFunctions.Execute(recsql);
			
			con.close();   
			response.sendRedirect("Smart Payroll/PayRollRevisionNext.jsp?staffid="+Staffid+"&dor="+DateUtil.FormateDateSQL(dor)+"&appraisalid="+appraisalid);
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
		}
	}
 
	

	private void revisionMovetoMaster(HttpServletRequest request,HttpServletResponse response )throws ServletException, IOException
	{
		try
		{
			
			dor = request.getParameter("dor");
			Staffid = request.getParameter("Staffid");
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			String Apparaisalid = request.getParameter("Apparaisalid");
			
			// update basic
			asql = " UPDATE com_m_staff a,  pay_t_appraisal_basic b SET ";
			asql = asql + " a.CHR_PF = b.CHR_PF, ";
			asql = asql + " a.CHR_PFTYPE = b.CHR_PFTYPE,  ";
			asql = asql + " a.INT_PFAMT = b.INT_PFAMT,  ";
			asql = asql + " a.CHR_PFNO = b.CHR_PFNO , ";
			asql = asql + " a.CHR_ESI = b.CHR_ESI ,  ";
			asql = asql + " a.CHR_ESITYPE = b.CHR_ESITYPE , ";
			asql = asql + " a.INT_ESIAMT = b.INT_ESIAMT , ";
			asql = asql + " a.CHR_ESINO = b.CHR_ESINO , ";
			asql = asql + " a.INT_SALARY = b.INT_SALARY, ";
			asql = asql + " a.INT_GROSSSALARY = b.INT_GROSSSALARY, ";
			asql = asql + " a.CHR_PFCALCULATIONTYPE = b.CHR_PFCALCULATIONTYPE, ";
			asql = asql + " a.DAT_RIVISION = b.DAT_RIVISION ,a.CHR_USERNAME =?,a.DT_UPDATEDATE=DATE(NOW()),a.CHR_USERSTATUS='Y' ";
			asql = asql + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
			asql = asql + " AND b.CHR_MONTH =? ";
			asql = asql + " AND b.INT_YEAR =? ";
			asql = asql + " AND a.CHR_EMPID =? ";
			asql = asql + " AND b.INT_APPRAISALID =? ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,auserid);
			apstm.setString(2,DateUtil.getMonth(Integer.parseInt(month)));
			apstm.setString(3,year);
			apstm.setString(4,Staffid);
			apstm.setString(5,Apparaisalid);
			System.out.println("1"+apstm);
			apstm.execute(); 
			apstm.close();
			
			
			//update allowance
			String allowancefield[][] =  CommonFunctions.QueryExecute("SELECT CHR_ACODE  FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
			asql  =" UPDATE pay_t_allowance a,  pay_t_appraisal_allowance b SET ";
			if(allowancefield.length>0)
				for(int u=0;+u<allowancefield.length;u++)
				  asql = asql +"  a."+allowancefield[u][0] + " = b."+allowancefield[u][0] +", "; 	
				
			asql = asql +" DAT_EFFECT = DATE(NOW())  ";
			asql = asql + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
			asql = asql + " AND b.CHR_MONTH =? ";
			asql = asql + " AND b.INT_YEAR =? ";
			asql = asql + " AND a.CHR_EMPID =? ";
			asql = asql + " AND b.INT_APPRAISALID =? ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,DateUtil.getMonth(Integer.parseInt(month)));
			apstm.setString(2,year);
			apstm.setString(3,Staffid);
			apstm.setString(4,Apparaisalid);
			System.out.println("2"+apstm);
			apstm.execute(); 
			apstm.close();
			
			//update recovery
			String recoveryfield[][] =  CommonFunctions.QueryExecute("SELECT CHR_RCODE  FROM  pay_m_recovery ORDER BY INT_RECOVERYID");
			asql  =" UPDATE pay_t_recovery a,  pay_t_appraisal_recovery b SET ";
			if(recoveryfield.length>0)
				for(int u=0;+u<recoveryfield.length;u++)
				  asql = asql +"  a."+recoveryfield[u][0] + " = b."+recoveryfield[u][0] +", "; 	
				
			asql = asql +" DAT_EFFECT = DATE(NOW())  ";
			asql = asql + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
			asql = asql + " AND b.CHR_MONTH =? ";
			asql = asql + " AND b.INT_YEAR =? ";
			asql = asql + " AND a.CHR_EMPID =? ";
			asql = asql + " AND b.INT_APPRAISALID =? ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,DateUtil.getMonth(Integer.parseInt(month)));
			apstm.setString(2,year);
			apstm.setString(3,Staffid);
			apstm.setString(4,Apparaisalid);
			System.out.println(""+apstm);
			apstm.execute(); 
			apstm.close();
			
		    
			asql = "UPDATE pay_t_appraisal SET CHR_ACCEPT='Y',CHR_ACCEPTEDBY='"+session.getAttribute("EMPID")+"' ";
			asql = asql + " WHERE CHR_EMPID=? AND  MONTHNAME(DAT_DOR) =? AND  YEAR(DAT_DOR)= ?";
			asql = asql + " AND  INT_APPRAISALID =? ";
		    apstm = con.prepareStatement(asql);
		    apstm.setString(1,Staffid);
		    apstm.setString(2,DateUtil.getMonth(Integer.parseInt(month)));
			apstm.setString(3,year);
			apstm.setString(4,Apparaisalid);
			System.out.println(""+apstm);
			apstm.execute(); 
			apstm.close();
			con.close();
			response.sendRedirect("Smart Payroll/PayRollRevisionAccept.jsp");
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
		}
	}

	 
	
	 
	public static double salaryBandBasic(double gross)
	{
		double basic=0.0;
		try
		{
			 String salaryData[][] =CommonFunctions.QueryExecute(" SELECT INT_SALARYBANDID,INT_STARTINGSALARY,INT_ENDINGSALARY,CHR_SPLITUPIN FROM  pay_m_salaryband  ORDER BY INT_SALARYBANDID ");
			int rowid=0;
			boolean flag = false;
		 
			for(int u=0; u<salaryData.length;u++)
			{
				if( ((int)gross >=Integer.parseInt(salaryData[u][1])) && ((int)gross <=Integer.parseInt(salaryData[u][2]) ) )
				{	 
					rowid = Integer.parseInt(salaryData[u][0]);
					flag = true;
				}
			}
			if(flag)
			{
				String salaryband="";
			 	 
			 	salaryband=" SELECT ("+gross+" *(INT_BASIC/100))  ,";
				salaryband=salaryband.trim();
				salaryband = salaryband.substring(0,salaryband.length()-1);
				salaryband = salaryband+"  FROM  pay_m_salaryband  WHERE INT_SALARYBANDID= "+rowid;
				String Data[][] =CommonFunctions.QueryExecute(salaryband);
				basic = Double.parseDouble(Data[0][0]);
				return basic; 
			}
		}
		catch(Exception e)
		{
		}
		return basic;
	}
	
	
	
	
	
	public static void salaryBandInGrossAllowance(String staffid,double gross, String dor)
	{
		 
		try
		{
			 
			String AllowanceData[][] = CommonFunctions.QueryExecute("SELECT INT_ALLOWANCEID,CHR_ACODE,CHR_ANAME FROM  pay_m_allowance WHERE CHR_FLAG='Y'  ORDER BY INT_ALLOWANCEID");
			String recoveryData[][] = CommonFunctions.QueryExecute("  SELECT CHR_RCODE FROM pay_m_recovery  ORDER BY  INT_RECOVERYID ");
			String sql ="";
			 
			String salaryData[][] = CommonFunctions.QueryExecute(" SELECT INT_SALARYBANDID,INT_STARTINGSALARY,INT_ENDINGSALARY,CHR_SPLITUPIN FROM  pay_m_salaryband  ORDER BY INT_SALARYBANDID ");
			int rowid=0;
			boolean flag = false;
			 
			for(int u=0; u<salaryData.length;u++)
				if( ((int)gross >=Integer.parseInt(salaryData[u][1])) && ((int)gross <=Integer.parseInt(salaryData[u][2]) ) )
				{	 
					rowid = Integer.parseInt(salaryData[u][0]);
					flag = true;
				}
			 
				 
			if(flag)
			{
				String salaryband="";
 			 	salaryband=" SELECT ("+gross+" *(INT_BASIC/100)) , ";
			 	for(int u=0; u<AllowanceData.length;u++)
					salaryband = salaryband+"("+gross+" * ( "+AllowanceData[u][1]+"/100) ) , ";
				
				salaryband=salaryband.trim();
				salaryband = salaryband.substring(0,salaryband.length()-1);
				salaryband = salaryband+"  FROM  pay_m_salaryband  WHERE INT_SALARYBANDID= "+rowid;
			  
				System.out.println("SALARY Slab ---"+salaryband);
				String Data[][] = CommonFunctions.QueryExecute(salaryband);
				
				
				 
				
				//Updation for Basic 
				sql =" UPDATE com_m_staff  SET INT_SALARY="+Data[0][0]+" ,DAT_RIVISION = DATE_FORMAT(DATE_ADD('"+dor+"' , INTERVAL 1 YEAR),'%Y-%m-%d')  WHERE CHR_EMPID='"+staffid+"'";
				System.out.println(sql);
				CommonFunctions.Execute(sql);
				
				 
				// delete the old record
				CommonFunctions.Execute("DELETE FROM pay_t_allowance WHERE CHR_EMPID='"+staffid+"'");
				
				//insert into Allowance data
				sql=" INSERT  INTO pay_t_allowance  ( CHR_EMPID , ";
				for(int u=0; u<AllowanceData.length;u++)
					sql = sql+AllowanceData[u][1]+", ";
				sql= sql +" DAT_EFFECT ) VALUES ( ";
				sql = sql+" '"+staffid+"' , ";
				for(int u=0; u<AllowanceData.length;u++)
					sql = sql+Data[0][(u+1)]+", ";
				sql = sql+" '"+dor+"' ";
				sql = sql + " )";
				System.out.println(sql);
				CommonFunctions.Execute(sql);
				 
				
				//Delete the old record
				CommonFunctions.Execute("DELETE FROM pay_t_recovery WHERE CHR_EMPID='"+staffid+"'");
				
				 //Insert into recovery Values
				sql=" INSERT  INTO pay_t_recovery  ( CHR_EMPID , ";
				for(int u=0; u<recoveryData.length;u++)
					sql = sql+recoveryData[u][0]+", ";
				sql= sql +" DAT_EFFECT ) VALUES ( ";
				sql = sql+" '"+staffid+"' , ";
				for(int u=0; u<recoveryData.length;u++)
					sql = sql+"0, ";
				sql = sql+" '"+dor+"' ";
				sql = sql + " )";
				System.out.println(sql);
				CommonFunctions.Execute(sql);
			}
			 
			else
			{
				//Updation for Basic 
				CommonFunctions.Execute(" UPDATE com_m_staff  SET INT_SALARY="+gross+"  ,  DAT_RIVISION = DATE_FORMAT(DATE_ADD('"+dor+"' , INTERVAL 1 YEAR),'%Y-%m-%d') WHERE CHR_EMPID='"+staffid+"'");
			
				// delete the old record
				CommonFunctions.Execute("DELETE FROM pay_t_allowance WHERE CHR_EMPID='"+staffid+"'");
				
				//insert into Allowance data
				sql=" INSERT  INTO pay_t_allowance  ( CHR_EMPID , ";
				for(int u=0; u<AllowanceData.length;u++)
					sql = sql+AllowanceData[u][1]+", ";
				sql= sql +" DAT_EFFECT ) VALUES ( ";
				sql = sql+" '"+staffid+"' , ";
				for(int u=0; u<AllowanceData.length;u++)
					sql = sql+" 0 , ";
				sql = sql+" '"+dor+"' ";
				sql = sql + " )";
				CommonFunctions.Execute(sql);
				
				//Delete the old record
				CommonFunctions.Execute("DELETE FROM pay_t_recovery WHERE CHR_EMPID='"+staffid+"'");
				
				
				//Insert into recovery Values
				sql=" INSERT  INTO pay_t_recovery  ( CHR_EMPID , ";
				for(int u=0; u<recoveryData.length;u++)
					sql = sql+recoveryData[u][0]+", ";
				sql= sql +" DAT_EFFECT ) VALUES ( ";
				sql = sql+" '"+staffid+"' , ";
				for(int u=0; u<recoveryData.length;u++)
					sql = sql+"0, ";
				sql = sql+" '"+dor+"' ";
				sql = sql + " )";
				CommonFunctions.Execute(sql);
			}
			
			 
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		 
	}
	
	
	
	
	
}