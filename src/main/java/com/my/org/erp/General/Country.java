package com.my.org.erp.General;

import java.util.Locale;

public class Country 
{
	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
			try 
			{ 
				Locale[] locales = Locale.getAvailableLocales();
				for (int i = 0; i < locales.length; i++) 
				{
					@SuppressWarnings("unused")
					String iso = locales[i].getCountry();
					String name = locales[i].getDisplayCountry();
					System.out.println(name);
				} 
			} 
			catch (RuntimeException e) 
			{
				 System.out.println(e.getMessage());
			}
	}
}
