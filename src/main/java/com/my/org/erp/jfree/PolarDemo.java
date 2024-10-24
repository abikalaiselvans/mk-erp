package com.my.org.erp.jfree;

import java.awt.*;
import org.jfree.data.xy.*;
import org.jfree.chart.*;
import org.jfree.chart.renderer.category.*;
import org.jfree.chart.plot.*;

public class PolarDemo{
	public static void main(String args[]){
		XYSeries s1=new XYSeries("a");
		s1.add(20,5);
		s1.add(213,7);
		s1.add(160,2);
		XYSeries s2=new XYSeries("b");
		s2.add(360,2);
		s2.add(200,7);
		s2.add(145,5);
		XYSeries s3=new XYSeries("c");
		s3.add(225,9);
		s3.add(52,7);
		s3.add(260,9);
		XYSeriesCollection data=new XYSeriesCollection();
		data.addSeries(s1);
		data.addSeries(s2);
		data.addSeries(s3);
		XYDataset dataset=data;
		JFreeChart chart = ChartFactory.createPolarChart("Polar Chart",dataset,true,true, false);
		ChartFrame frame1=new ChartFrame("Polar Chart",chart);
		frame1.setVisible(true);
		frame1.setSize(300,300);
	}
}