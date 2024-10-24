package com.my.org.erp.JasperReport.HRM;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JRDesignQuery;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

public class OfferLetter {
	
	public HashMap getData(HashMap map,String path){
		String query="SELECT coalesce(pb.chr_aname, col) as chr_aname, h.val,(h.val*12) annual,FUN_CAL_TAKEHOME($P{appid}) takeHome, FUN_TAX_CAL( Fun_CAL_TakeHome($P{appid})) compTax, curdate() "+
	                 "  from ( select 'BASIC' as col, INT_BASIC as val from hrm_t_allowance WHERE INT_APPID=$P{appid} union all select 'A001' as col, A001 as val from hrm_t_allowance WHERE INT_APPID=$P{appid} "+
				     "  union all select 'A002' as col, A002 as val from hrm_t_allowance  WHERE INT_APPID=$P{appid} union all select 'A003' as col, A003 as val from hrm_t_allowance WHERE INT_APPID=$P{appid}  "+
	                 "  union all select 'A004' as col, A004 as val from hrm_t_allowance WHERE INT_APPID=$P{appid} union all select 'A005' as col, A005 as val from hrm_t_allowance WHERE INT_APPID=$P{appid}  "+
				     "  union all select 'A006' as col, A006 as val from hrm_t_allowance WHERE INT_APPID=$P{appid} union all select 'A007' as col, A007 as val from hrm_t_allowance WHERE INT_APPID=$P{appid} "+
	                 "  union all  select 'A0011' as col, A0011 as val from hrm_t_allowance WHERE INT_APPID=$P{appid} union all select 'GROSS' as col, sum(INT_BASIC+A001+A002+A003+A004+A005+A006+A0010+A0011) as val "+
				     "  from hrm_t_allowance WHERE INT_APPID=$P{appid} union all select 'Employer PF' as col, (INT_BASIC*12/100) as val from hrm_t_allowance WHERE INT_APPID=$P{appid} union all select 'Employer ESI' as col,"+
	                 " ((sum(INT_BASIC+A001+A002+A003+A004+A005+A006+A0010+A0011) *1.75)/100) as val from hrm_t_allowance WHERE INT_APPID=$P{appid} union all select 'Total Cost To Company (CTC)' as col,"+
				     "(sum(INT_BASIC+A001+A002+A003+A004+A005+A006+A0010+A0011)+ sum(A007+A008+A009+A0012+A0013+A0014+A0015)+(INT_BASIC*12/100)+ (sum(INT_BASIC+A001+A002+A003+A004+A005+A006+A0010+A0011) *4.75)/100) as val "+
	                 " from hrm_t_allowance WHERE INT_APPID=$P{appid} union all select 'As applicable to your current role' as col, null as val  union all select 'Take Home Salary :' as col,"+
				     "((sum(INT_BASIC+A001+A002+A003+A004+A005+A006+A0010+A0011)+sum(A007+A008+A009+A0012+A0013+A0014+A0015)+(INT_BASIC*12/100)+((sum(INT_BASIC+A001+A002+A003+A004+A005+A006+A0010+A0011) *4.75)/100) ) - "+
	                 "((INT_BASIC*12/100) + ((sum(INT_BASIC+A001+A002+A003+A004+A005+A006+A0010+A0011) *1.75)/100)) ) val from hrm_t_allowance WHERE INT_APPID=$P{appid} ) h left join   pay_m_allowance pb   on pb.chr_acode = h.col";
		JRDesignQuery nQuery=new JRDesignQuery();
    	nQuery.setText(query);

    	InputStream input=null;
		try {
			input = new FileInputStream(new File(path+"\\"+"offerLetter_subreport1.jrxml"));
			JasperDesign jasperDesign = JRXmlLoader.load(input);
			jasperDesign.setQuery(nQuery);
	    	System.out.println("jasperTemp:"+jasperDesign.getQuery().getText());
	    	System.out.println("Compiling Report Designs");
	    	JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
	    	map.put("offerLetter_subreport1", jasperReport);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
		
		return map;
	}

}
