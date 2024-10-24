package com.my.org.erp.messenger.client;
public interface CListenThreadListener
{
  public void onDataReceived(String data);
  public void onDataError(int id, String description);
}