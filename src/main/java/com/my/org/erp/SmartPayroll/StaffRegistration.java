package com.my.org.erp.SmartPayroll;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

import DBConnection.DBCon;

import com.my.org.erp.ServiceLogin.DateUtil;

public class StaffRegistration {
	static java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat(
			"yyyy-MM-dd");

	static java.util.Date date = new java.util.Date();

	static String updatedate = "" + datetime.format(date);

	@SuppressWarnings("deprecation")
	static String month = DateUtil.getMonth(date.getMonth() + 1);

	@SuppressWarnings("deprecation")
	static int year = 1900 + date.getYear();

	public static String collectAllowanceField() {
		String fields = "";
		try {
			String sql = "SELECT * FROM PAY_M_ALLOWANCE";
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			fields = "";
			while (rs.next())
				fields = fields + rs.getString(1) + "~";
			return fields;

		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}

	public static String collectAllowanceFieldName() {
		String fields = "";
		try {
			String sql = "SELECT * FROM PAY_M_ALLOWANCE";
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			fields = "";
			while (rs.next())
				fields = fields + rs.getString(2) + "~";
			return fields;

		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}

	public static String collectRecoveryField() {
		String fields = "";
		try {
			String sql = "SELECT * FROM PAY_M_RECOVERY";
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			fields = "";
			while (rs.next())
				fields = fields + rs.getString(1) + "~";
			return fields;

		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}

	public static String collectRecoveryFieldName() {
		String fields = "";
		try {
			String sql = "SELECT * FROM PAY_M_RECOVERY";
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			fields = "";
			while (rs.next())
				fields = fields + rs.getString(2) + "~";
			return fields;

		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}

	public static String pfandEsiRecordExist(String staffid, int type) {
		String returnString = "";
		try {
			String staffId = staffid;
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "";

			if (type == 0) {
				sql = "SELECT * FROM  com_m_staff  ";
				sql = sql + " WHERE CHR_EMPID = '" + staffId + "'";
				String dbId = "";
				returnString = "";
				rs = st.executeQuery(sql);
				if (rs.next())
					dbId = "" + rs.getString("CHR_PFNO").trim();

				if ((dbId.equalsIgnoreCase("null"))
						|| (dbId.equalsIgnoreCase("")))
					returnString = "---";
				else
					returnString = dbId;
			}

			if (type == 1) {
				sql = "SELECT * FROM  com_m_staff  ";
				sql = sql + " WHERE CHR_EMPID = '" + staffId + "'";
				String dbId = "";
				returnString = "";
				rs = st.executeQuery(sql);
				if (rs.next())
					dbId = "" + rs.getString("CHR_ESINO").trim();
				if ((dbId.equalsIgnoreCase("null"))
						|| (dbId.equalsIgnoreCase("")))
					returnString = "---";
				else
					returnString = dbId;
			}

			return returnString;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}

	public static boolean allowanceRecordExist(String staffid) {
		boolean flag = false;
		try {
			String staffId = staffid;
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT * FROM PAY_T_ALLOWANCE CHR_EMPID";
			sql = sql + " WHERE  CHR_EMPID = '" + staffId + "'";
			String dbId = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				dbId = "" + rs.getString("CHR_EMPID").trim();
			if ((dbId.equalsIgnoreCase("null")) || (dbId.equalsIgnoreCase("")))
				flag = false;
			else
				flag = true;

			return flag;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return flag;
	}

	public static boolean recoveryRecordExist(String staffid) {
		boolean flag = false;
		try {
			String staffId = staffid;
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT * FROM PAY_T_RECOVERY CHR_EMPID";
			sql = sql + " WHERE  CHR_EMPID = '" + staffId + "'";
			String dbId = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				dbId = "" + rs.getString("CHR_EMPID").trim();
			if ((dbId.equalsIgnoreCase("null")) || (dbId.equalsIgnoreCase("")))
				flag = false;
			else
				flag = true;

			return flag;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return flag;
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

	public static String getAllowanceSalaryDetails(String staffid, String field) {
		String fields = "";
		try {
			String sql = "SELECT * FROM PAY_T_SALARYALLOWANCE WHERE CHR_EMPID = '"
					+ staffid + "'";
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			if (rs.next())
				fields = rs.getString(field);
			if (fields.equals("") || fields.equals("null"))
				fields = "0";
			return fields;

		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}

	public static String getRecoverySalaryDetails(String staffid, String field) {
		String fields = "";
		try {
			String sql = "SELECT * FROM PAY_T_SALARYRECOVERY WHERE CHR_EMPID = '"
					+ staffid + "'";
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			if (rs.next())
				fields = rs.getString(field);

			if (fields.equals("") || fields.equals("null"))
				fields = "0";

			return fields;

		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}

	public static boolean advanceRecordExist(String staffid) {
		boolean flag = false;
		try {
			String staffId = staffid;
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT COUNT(*) FROM PAY_M_ADVANCE ";
			sql = sql + " WHERE  CHR_ADVID = '" + staffId + "' ";
			sql = sql + " AND CHR_DUESTATUS = 'O'";
			@SuppressWarnings("unused")
			String dbId = "";
			rs = st.executeQuery(sql);
			int rcount = 0;
			if (rs.next())
				rcount = rs.getInt(1);
			if (rcount < 1)
				flag = false;
			else
				flag = true;
			return flag;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return flag;
	}

	public static String getAdvanceAmount(String staffid) {
		String advAmount = "";
		try {
			String sql = "SELECT * FROM PAY_M_ADVANCE WHERE CHR_ADVID = '"
					+ staffid + "'";
			sql = sql + " AND CHR_DUESTATUS = 'O'";
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			if (rs.next())
				advAmount = "" + rs.getString("INT_BALAMT");

			if (advAmount.equals("") || advAmount.equals("null"))
				advAmount = "0.0";
			return advAmount;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}

	public static String getAdvanceRecord(String advId) {
		String advRecord = "";
		try {
			String sql = "SELECT * FROM PAY_M_ADVANCE WHERE CHR_ADVID = '"
					+ advId + "'";
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			advRecord = "";
			if (rs.next())
				for (int u = 1; u <= rsmd.getColumnCount(); u++)
					advRecord = advRecord + rs.getString(u) + "~";
			return advRecord;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}

	public static boolean messbillRecordExist(String staffid) {
		boolean flag = false;
		try {
			String staffId = staffid;
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT * FROM PAY_M_MESSBILL ";
			sql = sql + " WHERE  CHR_EMPID = '" + staffId + "' ";
			sql = sql + " AND INT_YEAR =" + year + " AND CHR_MONTH = '" + month
					+ "'";
			String dbId = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				dbId = "" + rs.getString("CHR_EMPID").trim();
			if ((dbId.equalsIgnoreCase("null")) || (dbId.equalsIgnoreCase("")))
				flag = false;
			else
				flag = true;

			return flag;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return flag;
	}

	public static String getMessbillAmount(String staffid) {
		String advAmount = "";
		try {
			String sql = "SELECT INT_CASHAMT FROM PAY_M_MESSBILL ";
			sql = sql + " WHERE  CHR_EMPID = '" + staffid + "' ";
			sql = sql + " AND INT_YEAR =" + year + " AND CHR_MONTH = '" + month
					+ "'";
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			if (rs.next())
				advAmount = rs.getString("INT_CASHAMT");
			if (advAmount.equals("") || advAmount.equals("null"))
				advAmount = "0.0";
			return advAmount;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}

	public static String getRandomMessbillAmount(String staffid, int year,
			String month) {
		String advAmount = "";
		try {
			String sql = "SELECT INT_CASHAMT ,CHR_CHEQUENO FROM PAY_M_MESSBILL ";
			sql = sql + " WHERE  CHR_EMPID = '" + staffid + "' ";
			sql = sql + " AND INT_YEAR =" + year + " AND CHR_MONTH = '" + month
					+ "'";
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			if (rs.next())
				advAmount = rs.getString("INT_CASHAMT") + "~"
						+ rs.getString("CHR_CHEQUENO") + "~";

			if (advAmount.equals("") || advAmount.equals("null"))
				advAmount = "0.0~0.0~";
			return advAmount;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}

	public static boolean cessationRecordExist(String staffid) {
		boolean flag = false;
		try {
			String staffId = staffid;
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT COUNT(*) FROM pay_m_emp_termination ";
			sql = sql + " WHERE  CHR_EMPID = '" + staffId + "' ";
			@SuppressWarnings("unused")
			String dbId = "";
			rs = st.executeQuery(sql);
			int rcount = 0;
			if (rs.next())
				rcount = rs.getInt(1);
			if (rcount < 1)
				flag = false;
			else
				flag = true;
			return flag;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return flag;
	}

	public static String getCessation(String staffid) {
		String cessationValue = "";
		try {
			String sql = "SELECT * FROM pay_m_emp_termination ";
			sql = sql + " WHERE  CHR_EMPID = '" + staffid + "' ";
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			if (rs.next())
				cessationValue = rs.getString("DT_TERM_DATE");

			if (cessationValue.equals("") || cessationValue.equals("null"))
				cessationValue = "0";
			return cessationValue;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}

	public static boolean transferRecordExist(String staffid) {
		boolean flag = false;
		try {
			@SuppressWarnings("unused")
			String staffId = staffid;
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT COUNT(INT_TRANS_ID) FROM pay_m_emp_transfer WHERE CHR_EMPID = '"
					+ staffid + "'";
			System.out.println(sql);
			@SuppressWarnings("unused")
			String dbId = "";
			rs = st.executeQuery(sql);
			int rcount = 0;
			if (rs.next())
				rcount = rs.getInt(1);

			if (rcount < 1)
				flag = false;
			else
				flag = true;

			return flag;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return flag;
	}

	public static String getTransferValue(String staffid) {
		String transferValue = "";
		try {
			String sql = "SELECT MAX(INT_TRANS_ID) FROM PAY_M_EMP_TRANSFER WHERE CHR_EMPID = '"
					+ staffid + "'";
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			int tid = 0;
			if (rs.next())
				tid = Integer.parseInt(rs.getString(1));

			sql = "SELECT * FROM PAY_M_EMP_TRANSFER ";
			sql = sql + " WHERE  CHR_EMPID = '" + staffid + "' ";
			sql = sql + " AND INT_TRANS_ID = " + tid;
			rs = st.executeQuery(sql);
			if (rs.next()) {
				transferValue = transferValue + rs.getString("INT_TRANS_ID")
						+ "~";
				transferValue = transferValue + rs.getString("DT_TRANSFERDATE")
						+ "~";
				transferValue = transferValue
						+ rs.getString("INT_FROMDISTRICTID") + "~";
				transferValue = transferValue
						+ rs.getString("INT_TODISTRICTID") + "~";
				transferValue = transferValue + rs.getString("CHR_REASON")
						+ "~";
				transferValue = transferValue + rs.getString("DT_OF_RELEAVE")
						+ "~";
			}
			return transferValue;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
		return null;
	}
}
