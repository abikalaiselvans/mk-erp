package properties;

import java.util.Properties;
import java.util.ResourceBundle;

public class PropertiesFunctions
{

	public static String getModuleTitle(String shortname) 
	{
		String erppackage = "";
		try 
		{
			
			Properties properties = new Properties();
        	properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("properties/ERP_PACKAGE.properties"));
        	erppackage = properties.getProperty(shortname);
            return erppackage.trim();
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
		return erppackage;
		 
	}
   
	
	public static String getPropertyValue(String propFileName, String key)  
    {  
        ResourceBundle bundle = ResourceBundle.getBundle(propFileName);  
        String strVal = bundle.getString(key);
        if (strVal == null)  
        {  
            strVal = "";  
        }  
        bundle = null;  
        return strVal;  
    }  
	
}
