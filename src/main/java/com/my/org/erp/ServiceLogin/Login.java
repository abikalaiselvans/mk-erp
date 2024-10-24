package com.my.org.erp.ServiceLogin;

import org.apache.struts.action.ActionForm;

public class Login extends ActionForm 
{
	String username,password;

	public String getUsername() 
	{
		return username;
	}

	public void setUsername(String username) 
	{
		this.username = username;
	}

	public String getPassword() 
	{
		return password;
	}

	public void setPassword(String password) 
	{
		this.password = password;
	}
}
