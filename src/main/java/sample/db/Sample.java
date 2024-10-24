package sample.db;

public class Sample {

	
	public static void main(String[] args) {
		
		try 
		{
			MsAccessfDBCon sd =new MsAccessfDBCon();
			sd.getConnection();
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
		
	}

}
