package com.my.org.erp.file;
import java.io.*;
import java.net.*;


public class Fastsearch
{

	// entry point
	//
	
	public static void main(String[] arguments)
	{
		System.out.println ("hello");
		Fastsearch p = null;
		p = new Fastsearch();
		p.Test();
	}

	public Fastsearch()
	{
	}

	public void Test()
	{
		System.out.println ("Test");
		String szfile = lecture("c:\\USERCTRL.htm",false);
		long dwStart = System.currentTimeMillis();
		testcase(szfile,"my pattern",100);
		testcase(szfile,"IPropertyBag",100);
		testcase(szfile,"WebClient",100);
		testcase(szfile,"developer",100);
		testcase(szfile,"the",100);
		long dwEnd = System.currentTimeMillis();
		long dwDuration = dwEnd - dwStart;
		System.out.println ("duration = " + dwDuration + " milliseconds");

	}


	public void testcase(String s, String pattern, int nbtimes)
	{
		for (int k = 0; k < nbtimes; k++)
		{
			int nb = 0;
			int i,j;
			i = 0;
			while ( (j = s.indexOf(pattern,i))> -1 )
			{
				i = j + pattern.length();
				nb++;
			}

	/*		if (k==0)
				System.out.println (nb + " occurences");*/
		}
	}


	public String lecture (String nom, boolean bKeepEOL)
	{

		String szTemp="";
		// build a EOL string
		byte[] myEOL= { 0x0D, 0x0A };
		String szEOL=new String(myEOL);
		InputStream is=null;
		try 
		{
			// il s'agit d'ouvrir le fichier en extrayant d'abord le chemin d'accès complet
			String s=new String(System.getProperty("user.dir")); // propriété système "user.dir"
			
			// for DEBUG
			System.out.println ("System property user dir = " + s);

			// puis en transformant les anti-slashs de MS-DOS en slashs d'Unix puis en passant
			// l'adresse URL complète protocole="file:"  + séparateur="//"
			// + host=<void> + séparateur="/"
			// + file="c:/jdk1.1.4/code/compta"
			// + un séparateur + un nom quelconque (arst.html) qui va être viré automatiquement
			// par le générateur d'URL et remplacé par le fichier à ouvrir dans l'URL réel.
			//URL mon_url=new URL("file:///c:/jdk1.1.4/code/compta/arst.html");
			URL mon_url=new URL("file:///"+s.replace('\\','/')+"/USERCTRL.html"); // s.replace('\\','/')

			is = new URL(mon_url, nom).openStream();
			// for DEBUG
			//if (is!=null) System.out.println ("Ouverture du fichier \""+nom+"\"\n");

			// ici lecture effective du flux par lignes entières
			BufferedReader d = new BufferedReader(new InputStreamReader(is)); 

			while (d.ready()) // on continue à lire tant qu'il y a des enregistrements à lire
			{
				// ligne 1= description entité, ligne 2= son nom
				szTemp += d.readLine();
				if (bKeepEOL)
				{
					szTemp += szEOL;
				}
			}

		} 
		catch(Exception e) 
		{
			 System.out.println(e.getMessage());
		}

		try 
		{
			if (is != null)
			is.close();
		}
		catch(Exception e) 
		{
		}

		return szTemp;

	} // end lecture(...)

}


