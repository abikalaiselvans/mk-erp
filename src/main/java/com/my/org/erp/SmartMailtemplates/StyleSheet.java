package com.my.org.erp.SmartMailtemplates;

public class StyleSheet 
{

	public static String  styleSheet()
    {
    	String content="";
    	try
    	{ 
    		content = "<style type='text/css'> ";
			content = content + ".boldEleven { ";
			content = content + "	FONT-WEIGHT: normal; ";
			content = content + "	FONT-SIZE: 10px; ";
			content = content + "	COLOR: #000000; ";
			content = content + "	LINE-HEIGHT: 15px; ";
			content = content + "	FONT-FAMILY: Verdana; ";
			content = content + "	TEXT-DECORATION: none; ";
			content = content + "	text-align: left; ";
			content = content + "} ";
			
			content = content + ".TableDesign ";
			content = content + "{ ";
			content = content + "border:1px solid; ";
			content = content + "border-color:#484848; ";
			content = content + "border-radius:10px; ";
			content = content + "-moz-border-radius:10px;   ";
			content = content + "text-align:center; ";
			content = content + "background-color:#484848; ";
			content = content + "font:Arial, Helvetica, sans-serif; ";
			content = content + "font-style:normal; ";
			content = content + "color:#FFFFFF; ";
			content = content + "height: 30px; ";
			content = content + "width:90%; ";
			content = content + "box-shadow: 3px 3px 3px #484848; ";
			content = content + "} ";
			
			content = content + ".whiteMedium ";
			content = content + "{ ";
			content = content + "	font:Arial; ";
			content = content + "	font-weight:bold; ";
			content = content + "	margin: 0px 0 0px 0; ";
			content = content + "	font-size:14px; ";
			content = content + "	font-weight: bold; ";
			content = content + "	color: #ffffff; ";
			content = content + "} ";
			content = content + "</style> ";
			content = content + "<br><br>";
    		
    		return content;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return content;
	}
}
