package com.my.org.erp.SmartReport;

import ar.com.fdvs.dj.domain.Style;

public class JasperReportDesignBean {
	private int Id;
	 private String fieldTitle;
	   private int filedWidth;
	   private Style fieldAlignment;
	   
	   public int getId() {
		      return Id;
		   }

		   public void setId(int Id) {
		      this.Id = Id;
		   }
	   public String getFieldTitle() {
	      return fieldTitle;
	   }

	   public void setFieldTitle(String fieldTitle) {
	      this.fieldTitle = fieldTitle;
	   }

	   public int getFiledWidth() {
	      return filedWidth;
	   }

	   public void setFiledWidth(int filedWidth) {
	      this.filedWidth = filedWidth;
	   }
	   public Style getFieldStyle() {
		      return fieldAlignment;
		   }
	   public void setFieldStyle(Style fieldAlignment) {
		      this.fieldAlignment = fieldAlignment;
		   }
	 
}


