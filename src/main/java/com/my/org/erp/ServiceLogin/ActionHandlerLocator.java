 
package com.my.org.erp.ServiceLogin;


import java.io.IOException;

import java.util.HashMap;


import properties.PropertiesFunctions;

/**
* @author MythraKalaiselvan 
* @SmartERP version 1.2
*/

public class ActionHandlerLocator
{
    private static final Object ACTION_HANDLER = "ActionHandler";
    private static Object PACKAGE_NAME;
    
	private static HashMap actionHandlers = new HashMap();

    public ActionHandlerLocator()
    {
    }

     
	@SuppressWarnings("unchecked")
	public static ActionHandler locate(String action, String pack) throws IOException
    {
		actionHandlers.clear();
		if(!actionHandlers.containsKey(action))
        {
            //PACKAGE_NAME = CommonFunctions.getPackageName(pack);
            PACKAGE_NAME = PropertiesFunctions.getModuleTitle(pack.substring(0, 3));
        	 
            String className = getClassName(action.trim()).trim();
             
            try
            {
            	Class classObj = Class.forName(className.toString());
            	ActionHandler handler = (ActionHandler)classObj.newInstance();
                actionHandlers.put(action, handler);
                
            }
            catch(ClassNotFoundException e)
            {
                 System.out.println(e.getMessage());
            }
            catch(InstantiationException e)
            {
                 System.out.println(e.getMessage());
            }
            catch(IllegalAccessException e)
            {
                 System.out.println(e.getMessage());
            }
            catch(Exception e)
            {
                 System.out.println(e.getMessage());
            }
        }
        return (ActionHandler)actionHandlers.get(action);
    }

    private static String getClassName(String action)
    {
        String firstChar = action.substring(0, 1);
        String rest = action.substring(1);
        StringBuffer buffer = new StringBuffer();
        buffer.append(PACKAGE_NAME);
        buffer.append(firstChar.toUpperCase());
        buffer.append(rest);
        buffer.append(ACTION_HANDLER);
        return buffer.toString();
    }


}