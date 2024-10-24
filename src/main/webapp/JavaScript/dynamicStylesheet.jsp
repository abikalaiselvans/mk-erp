<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
			String sline="";
			String defaulttheme=CommonFunctions.QueryExecute("SELECT CHR_THEME FROM m_user WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'")[0][0];
			String defaultthemerow=CommonFunctions.QueryExecute("SELECT CHR_THEMEROW FROM m_user WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'")[0][0];
			
			
			String fileName =request.getRealPath("/")+"/JavaScript/style.txt";
			//System.out.println(fileName);
			java.io.FileReader fr = new java.io.FileReader(fileName);
			java.io.BufferedReader br = new java.io.BufferedReader(fr);
			String strfline ="";
			sline=" <style type=\"text/css\"> ";
			sline = sline + "\n <!--";
			while((strfline=br.readLine())!= null )	
			{
				sline=sline +"\n " +strfline;
			}
			
			sline=sline +"\n .headerImgBackground  ";
			sline=sline +"\n { ";
			sline=sline +"\n 		background-color:"+defaulttheme+"; ";
			sline=sline +"\n        background-image: url('../img/headerbg1.jpg');  ";
			sline=sline +"\n        background-repeat:repeat ";
			sline=sline +"\n } ";
			
			 


			sline=sline +"\n .TableDesign ";
			sline=sline +"\n { ";
			sline=sline +"\n   border:1px solid;  ";
			sline=sline +"\n  border-color:#484848;";
			sline=sline +"\n  border-radius:10px;";
			sline=sline +"\n  -moz-border-radius:10px;";
			sline=sline +"\n  text-align:center;";
			sline=sline +"\n  background-color:"+defaulttheme+"; ";
			sline=sline +"\n  font:Arial, Helvetica, sans-serif;";
			sline=sline +"\n  font-style:normal;";
			sline=sline +"\n  color:#FFFFFF;";
			sline=sline +"\n  height: 30px;";
			sline=sline +"\n  width:90%;";
			sline=sline +"\n  box-shadow: 3px 3px 3px #484848;";
			sline=sline +"\n } ";
			 	
			sline=sline +"\n  .ButtonHead";
			sline=sline +"\n { ";
			sline=sline +"\n  border:2px solid #a1a1a1;";
			sline=sline +"\n  padding:5px 5px;";
			sline=sline +"\n  background:"+defaulttheme+"; ";
			sline=sline +"\n  width:auto;";
			sline=sline +"\n  font:Arial;";
			sline=sline +"\n  font-weight:bold;";	
			sline=sline +"\n  margin: 0px 0 0px 0;";
			sline=sline +"\n  font-size:14px;";
			sline=sline +"\n  font-weight: bold;";
			sline=sline +"\n  color: #ffffff; ";
			sline=sline +"\n  border-radius:10px; ";
			sline=sline +"\n  -moz-border-radius:5px;";
			sline=sline +"\n  box-shadow: 5px 5px 5px #888888;";
			sline=sline +"\n  }";
 
	  		sline=sline +"\n .MRow2  ";
			sline=sline +"\n { ";
			sline=sline +"\n 		background-color:"+defaultthemerow+"; ";
			sline=sline +"\n 		FONT-WEIGHT: normal; ";
			sline=sline +"\n 		FONT-SIZE: 10px; ";
			sline=sline +"\n 		COLOR: #000000; ";
			sline=sline +"\n 		LINE-HEIGHT: 15px; ";
			sline=sline +"\n 		FONT-FAMILY: Verdana; ";
			sline=sline +"\n 		TEXT-DECORATION: none; ";
			sline=sline +"\n } "; 
			
			 
			sline=sline +"\n  .tableBackg"; 
			sline=sline +"\n { "; 
			sline=sline +"\n 	background-color:"+defaultthemerow+"; ";
			sline=sline +"\n  }"; 
			
			sline=sline +"\n  "; 
			sline=sline +"\n  "; 
			sline=sline +"\n  "; 
			
			
			
 




			 
			
		/*	sline=sline +"\n .BackGround { "; 
				sline=sline +"\n BACKGROUND-COLOR: "+defaulttheme+"; ";
				sline=sline +"\n FONT: bold 11px tahoma, verdana, geneva, lucida, 'lucida grande', arial, "; 
					sline=sline +"\n helvetica, sans-serif; "; 
				sline=sline +"\n COLOR: #000000; "; 
				sline=sline +"\n PADDING-TOP: 3px; "; 
				sline=sline +"\n WHITE-SPACE: nowrap "; 
			sline=sline +"\n } "; 
*/

			
			sline = sline + "\n -->";
			sline = sline + "\n  </style> ";
			//sline = sline.replaceAll("#484848", defaulttheme);
			out.println(sline);
			br.close();
			fr.close(); 
			/*
			sline="<style type='text/css'>";
			sline=sline +" .headerImgBackground  ";
			sline=sline +" { ";
			sline=sline +" background-color:"+defaulttheme+"; ";
			sline=sline +" } ";
			sline = sline + " </style>"; */
			out.println(sline);
			
			
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
