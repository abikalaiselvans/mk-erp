package com.my.org.erp.messenger.client;
public interface CLoginListener
{
  public void onConnectRequest(String host, int port, String username);
  public void onLoginCancel();
}