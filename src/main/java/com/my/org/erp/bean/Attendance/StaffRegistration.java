package com.my.org.erp.bean.Attendance;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

import DBConnection.DBCon;

public class StaffRegistration {
	public static boolean RecordExist(String staffid) {
		boolean flag = false;
		try {
			String staffId = staffid;
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT * FROM  com_m_staff ";
			sql = sql + " WHERE  CHR_EMPID = '" + staffId + "'";
			String dbId = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				dbId = "" + rs.getString("CHR_EMPID").trim();
			if ((dbId.equalsIgnoreCase("null")) || (dbId.equalsIgnoreCase("")))
				flag = false;
			else
				flag = true;
			//System.out.println("RECORD POSITION :: " + flag);
			return flag;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return flag;
	}

	public static String staffName(String staffid) {
		String empName = "";
		try {
			String staffId = staffid;
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT CHR_STAFFNAME FROM  com_m_staff ";
			sql = sql + " WHERE  CHR_EMPID = '" + staffId.trim() + "'";
			String dbId = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				dbId = rs.getString("CHR_STAFFNAME");
			return dbId;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return empName;
	}

	public static String RecordValue(String staffid) {
		String staffdetails = "";
		try {
			String staffId = staffid.trim();
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT * FROM  com_m_staff ";
			sql = sql + " WHERE  CHR_EMPID = '" + staffId + "'";
			String s = "";
			rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			if (rs.next())
				for (int i = 0; i < rsmd.getColumnCount(); i++)
					s = s + rs.getString((i + 1)) + " ~ ";
			staffdetails = s;
			return staffdetails;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return staffdetails;
	}

	// this is used for leave master in smart attendance....
	public static boolean LRecordExist(String staffid) {
		boolean flag = false;
		try {
			String staffId = staffid;
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT * FROM  ATT_M_LEAVE";
			sql = sql + " WHERE  CHR_EMPID = '" + staffId + "'";
			String dbId = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				dbId = "" + rs.getString("CHR_EMPID").trim();
			if ((dbId.equalsIgnoreCase("null")) || (dbId.equalsIgnoreCase("")))
				flag = false;
			else
				flag = true;
			//System.out.println("RECORD POSITION :: " + flag);
			return flag;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return flag;
	}

	public static String leaveRecordExist(String staffid, String field1,
			String field2) {
		String val = "";
		try {
			String staffId = staffid;
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			boolean flag = false;
			String sql = "SELECT * FROM ATT_M_LEAVE";
			sql = sql + " WHERE  CHR_EMPID = '" + staffId + "' AND INT_YEAR=YEAR(now())";
			String dbId = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				dbId = "" + rs.getString("CHR_EMPID").trim();
			if ((dbId.equalsIgnoreCase("null")) || (dbId.equalsIgnoreCase("")))
				flag = false;
			else
				flag = true;

			if (flag) {
				rs = st.executeQuery(sql);
				val = "";
				if (rs.next())
					val = rs.getString(field1) + "~" + rs.getString(field2)
							+ "~";
			} else {
				val = "0" + "~" + "0" + "~";
			}
			return val;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return val;
	}

	public static String leaveTypeValue() {
		String columnValue = "";
		try {
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT * FROM ATT_M_LEAVETYPE ORDER BY INT_LEAVEID";
			String dbId = "";
			rs = st.executeQuery(sql);

			while (rs.next())
				dbId = dbId + "" + rs.getString("CHR_LEAVENAME").trim() + "~";
		 
			return dbId;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return columnValue;
	}

	public static String leaveTypeChar() {
		String columnValue = "";
		try {
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT * FROM ATT_M_LEAVETYPE ORDER BY INT_LEAVEID";
			String dbId = "";
			rs = st.executeQuery(sql);

			while (rs.next())
				dbId = dbId + "" + rs.getString("CHR_SYMBOL").trim() + "~";
			 
			return dbId;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return columnValue;
	}

	public static String getDepartment(String deptid) {
		String deptidName = "";
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;			
			deptid=""+deptid;			
			if (deptid.equals("") ||deptid.equalsIgnoreCase("null"))
				deptid="0";			
			
			String sql = " SELECT * FROM   com_m_depart  ";
			sql = sql + " WHERE  INT_DEPARTID = "
					+ Integer.parseInt(deptid.trim());			 
			deptidName = "";			
			rs = st.executeQuery(sql);
			if (rs.next())
				deptidName = rs.getString("CHR_DEPARTNAME").trim();
			
			return deptidName;
		} catch (Exception e) {
			//System.out.println(e.getMessage());
			// System.out.println(e.getMessage());
			 
		}
		return deptidName;
	}

	public static String getDesigination(String desigid) {
		String desigName = "";
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			desigid=""+desigid;
			if (("".equals(desigid)) ||("null".equals(desigid)))
				desigid="0";
			String sql = " SELECT * FROM  com_m_desig  ";
			sql = sql + " WHERE  INT_DESIGID = "
					+ Integer.parseInt(desigid.trim());
			desigName = "";		
			rs = st.executeQuery(sql);
			if (rs.next())
				desigName = rs.getString("CHR_DESIGNAME").trim();
			return desigName;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return desigName;
	}

	public static String getDistrict() {
		String district = "";
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = " SELECT * FROM  com_m_district ";
			district = "";
			rs = st.executeQuery(sql);
			while (rs.next())
				district = district + rs.getString("INT_DISTRICTID") + "+"
						+ rs.getString("CHR_DISTRICT").trim() + "+ ~";
			return district;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return district;
	}

	public static boolean getAnyRecordExisist(String table, String whereField,
			String whereid, String intorstring) {
		boolean flag = false;
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "";
			int ssql = Integer.parseInt(intorstring);
			if (ssql == 0)
				sql = " SELECT * FROM " + table.toUpperCase() + " WHERE "
						+ whereField + " = '" + whereid + "'";
			else
				sql = " SELECT * FROM " + table.toUpperCase() + " WHERE "
						+ whereField + " = " + Integer.parseInt(whereid);

			rs = st.executeQuery(sql);
			int rcount = 0;
			if (rs.next())
				rcount = rs.getInt(1);

			if (rcount < 1)
				return flag;
			else
				return true;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return flag;
	}

	public static boolean getAnyRecordExisist2(String subQuery) {
		boolean flag = false;
		try {
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(subQuery);
			int rcount = 0;
			if (rs.next())
				rcount = rs.getInt(1);
			if (rcount < 1)
				return flag;
			else
				return true;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		
		}
		return flag;
	}

	public static String getAnyValue(String selectfield, String table,
			String whereField, String whereid, String intorstring) {
		String stringValue = "";
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "";
			int ssql = Integer.parseInt(intorstring);
			if (ssql == 0)
				sql = " SELECT " + selectfield + " FROM " + table.toUpperCase()
						+ " WHERE " + whereField + " = '" + whereid + "'";
			else
				sql = " SELECT " + selectfield + " FROM " + table.toUpperCase()
						+ " WHERE " + whereField + " = "
						+ Integer.parseInt(whereid);

			stringValue = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				stringValue = "" + rs.getString(selectfield).trim();

			return stringValue;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return stringValue;
	}

	public static String getAnyValue2(String sql, String selectfield) {
		String stringValue = "";
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			stringValue = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				stringValue = "" + rs.getString(selectfield).trim();

			return stringValue;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return stringValue;
	}

	public static int getAnyMaxValue(String selectfield, String table,
			String whereField, String whereid, String intorstring) {
		int intValue = 0;
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "";
			int ssql = Integer.parseInt(intorstring);
			if (ssql == 0)
				sql = " SELECT MAX(" + selectfield + ") FROM "
						+ table.toUpperCase() + " WHERE " + whereField + " = '"
						+ whereid + "'";
			else
				sql = " SELECT MAX(" + selectfield + ") FROM "
						+ table.toUpperCase() + " WHERE " + whereField + " = "
						+ Integer.parseInt(whereid);

			intValue = 0;
			rs = st.executeQuery(sql);
			if (rs.next())
				intValue = rs.getInt(1);
			return intValue;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return intValue;
	}

	public static String getAnyValueCombo(String table, String field1,
			String field2) {
		String stringValue = "";
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = " SELECT * FROM " + table.toUpperCase();
			stringValue = "";
			
			rs = st.executeQuery(sql);
			while (rs.next())
				stringValue = stringValue + rs.getString(field1).trim() + "$"
						+ rs.getString(field2).trim() + "$ ~";
			
			return stringValue;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return stringValue;
	}

	// String sql =" SELECT MAX(INT_PRO_ID) FROM PAY_M_EMP_PROMOTION WHERE
	// CHR_EMPID = '"+staffid[u]+"'";

	public static String getDistrictName(String field, String districtid) {
		String stringValue = "";
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = " SELECT " + field
					+ " FROM  com_m_district  WHERE INT_DISTRICTID = "
					+ Integer.parseInt(districtid);
			stringValue = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				stringValue = "" + rs.getString(field).trim();

			return stringValue;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return stringValue;
	}

	public static String getStaffValue(String field, String staffid) {
		String stringValue = "";
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = " SELECT " + field
					+ " FROM  com_m_staff  WHERE CHR_EMPID = '" + staffid + "'";
			stringValue = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				stringValue = "" + rs.getString(field).trim();

			return stringValue;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return stringValue;
	}

	public static String getTableValue(String table, String field,
			String staffid) {
		String stringValue = "";
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = " SELECT " + field + " FROM " + table.toUpperCase()
					+ " WHERE CHR_EMPID = '" + staffid + "'";
			stringValue = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				stringValue = "" + rs.getString(field).trim();
			//System.out.println(stringValue);
			return stringValue;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return stringValue;
	}

public static String getTableAllValue(String sql) 
{
		String stringValue = "";
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			stringValue = "";
			rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			String d="";
			while(rs.next())
			{	
				for(int u=1; u<=rsmd.getColumnCount();u++)
				{
					d=""+rs.getString(u);
					if("".equals(d)||"null".equals(d))
						d="-";
					stringValue = stringValue +d+"~";
				}	
				stringValue = stringValue+"#";
			}		
			return stringValue;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return stringValue;
	}



public static String getTableAllValues(String sql) 
{
		String stringValue = "";
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			stringValue = "";
			rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			String d="";
			while(rs.next())
			{	
				for(int u=1; u<=rsmd.getColumnCount();u++)
				{
					d=""+rs.getString(u);
					if("".equals(d)||"null".equals(d))
						d="-";
					stringValue = stringValue +d+"~";
				}
					
				
				
			}		
			return stringValue;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return stringValue;
	}

public static String[][] getTableAllValuesArray(String sql) 
{
		String stringValue[][] ;
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			int colcount = rsmd.getColumnCount();
			int rowcount =0;
			while(rs.next())
				rowcount = rowcount +1;
			String svalue[][] = new String[rowcount][colcount];
			rs = st.executeQuery(sql);
			int i=0;
			while(rs.next())
			{	
				for(int u=0; u<rsmd.getColumnCount();u++)
					svalue[i][u] = ""+rs.getString((u+1));
				i= i+1;
				
			}		
			 
			stringValue = svalue;
			
			return stringValue;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return null;
	}

public static int getTableRow(String sql) 
{
		int rcount =0;
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			int rowcount =0;
			while(rs.next())
				rowcount = rowcount +1;
			
			rcount=rowcount;
			return rowcount;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			 
		}
		return rcount;
	}


}
