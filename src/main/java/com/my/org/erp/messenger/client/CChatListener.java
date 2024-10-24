package com.my.org.erp.messenger.client;
public interface CChatListener
{
  public void onSendMessageToAll(String message);
  public void onInitiatePrivateMessage(String username);
}