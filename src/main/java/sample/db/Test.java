package sample.db;

import java.sql.Connection;

public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 

		GetConnection c= new GetConnection();
		Connection con = null;
		con = c.getJNDIConnection();
		System.out.println(""+con);
	}

}
