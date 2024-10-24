package com.my.org.erp.examples;

 
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/*
 * 
 * 
 * 				create table SerialTest(
									name 	 BLOB,
									viewname VARCHAR2(30)
									);


 */

public class PersonPersistInDB
{

	static String userid = "root", password = "mythra";
	static String url = "jdbc:mysql://localhost:3306/smartcampus";
	static int count = 0;
	static Connection con = null;
	static String s;
	public static void main(String[] args) 
	{
		Connection con = getJDBCConnection();
		PersonDetails person1 = new PersonDetails("hemanth", 10, "Male");
		PersonDetails person2 = new PersonDetails("bob", 12, "Male");
		PersonDetails person3 = new PersonDetails("Richa", 10, "Female");
		PreparedStatement ps;
		try 
		{
			ps = con.prepareStatement("INSERT INTO SerialTest VALUES (?, ?)");
			write(person1, ps);
			ps.execute();
			write(person2, ps);
			ps.execute();
			write(person3, ps);
			ps.execute();
			ps.close();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM SerialTest");
			while (rs.next()) 
			{
				Object obj = read(rs, "Name");
				PersonDetails p = (PersonDetails) obj;
				System.out.println(p.getName() + "\t" + p.getAge() + "\t"+ p.getSex());
			}
			rs.close();
			st.close();
		} 
		catch (Exception e) 
		{
		}
	}
	
	public static void write(Object obj, PreparedStatement ps) throws SQLException, IOException 
	{
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ObjectOutputStream oout = new ObjectOutputStream(baos);
		oout.writeObject(obj);
		oout.close();
		ps.setBytes(1, baos.toByteArray());
		ps.setInt(2, ++count);
	}
	
	public static Object read(ResultSet rs, String column) throws SQLException, IOException, ClassNotFoundException 
	{
		byte[] buf = rs.getBytes(column);
		if (buf != null) 
		{
			ObjectInputStream objectIn = new ObjectInputStream(	new ByteArrayInputStream(buf));
			return objectIn.readObject();
		}
		return null;
	}


	
	
	
	public static void write1(Object obj, PreparedStatement ps)	throws SQLException, IOException 
	{
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ObjectOutputStream oout = new ObjectOutputStream(baos);
			oout.writeObject(obj);
			oout.close();
			byte[] buf = baos.toByteArray();
			s = null;//new sun.misc.BASE64Encoder().encode(buf);
			ps.setString(1, s);
			// ps.setBytes(1, Base64.byteArrayToBase64(baos.toByteArray()));
			ps.setBytes(1, baos.toByteArray());
			ps.setInt(2, ++count);
	}
	
	public static Object read1(ResultSet rs, String column)throws SQLException, IOException, ClassNotFoundException 
	{
			byte[] buf = null;// new sun.misc.BASE64Decoder().decodeBuffer(s);
			// byte[] buf = Base64.base64ToByteArray(new
			// String(rs.getBytes(column)));
			if (buf != null) 
			{
				ObjectInputStream objectIn = new ObjectInputStream(	new ByteArrayInputStream(buf));
				Object obj = objectIn.readObject(); // Contains the object
				PersonDetails p = (PersonDetails) obj;
				System.out.println(p.getName() + "\t" + p.getAge() + "\t"+ p.getSex());
			}
			return null;
	}

	
	public static Connection getJDBCConnection() 
	{
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
		} 
		catch (java.lang.ClassNotFoundException e) 
		{
			System.err.print("ClassNotFoundException: ");
			System.err.println(e.getMessage());
		}
		
		try 
		{
			con = DriverManager.getConnection(url, userid, password);
		} 
		catch (SQLException ex) 
		{
			System.err.println("SQLException: " + ex.getMessage());
		}
		return con;
	}
}