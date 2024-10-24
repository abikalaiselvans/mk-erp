package com.my.org.erp.messenger.client;
public interface CPrivateMessageListener
{
  public void onSendMessage(String to, String message);
  public void onClosePrivateMessage(String remoteUsername);
}