package com.my.org.erp.jfree;

import java.awt.*;
import org.jfree.chart.*;
import org.jfree.data.category.*;
import org.jfree.chart.renderer.category.*;
import org.jfree.chart.plot.*;

public class Area
{
	public static void main(String arg[])
	{
	  DefaultCategoryDataset dataset = new DefaultCategoryDataset();
	  dataset.addValue(4.0, "Science", "Rahul");
	  dataset.addValue(3.0, "Maths", "Rahul");
	  dataset.addValue(5.0, "Science", "Vinod");
	  dataset.addValue(2.0,"Maths", "Vinod");
	  dataset.addValue(3.0, "Science", "Prashant");
	  dataset.addValue(5.0, "Maths", "Prashant");
	  dataset.addValue(6.0, "Science", "Tapan");
	  dataset.addValue(2.0, "Maths", "Tapan");
	  dataset.addValue(3.0,"Science", "Santosh");
	  dataset.addValue(5.0, "Maths", "Santosh");
	
	  JFreeChart chart = ChartFactory.createAreaChart
	   ("Comparison between Students Marks","Students", "Marks ",
	    dataset, PlotOrientation.VERTICAL, true,true, false);
	  chart.setBackgroundPaint(Color.yellow);
	  chart.getTitle().setPaint(Color.blue); 
	  CategoryPlot p = chart.getCategoryPlot(); 
	  p.setForegroundAlpha(0.7f);
	  p.setRangeGridlinePaint(Color.red); 
	  p.setDomainGridlinesVisible(true);
	  p.setDomainGridlinePaint(Color.black);
	  CategoryItemRenderer renderer = p.getRenderer();
	  renderer.setSeriesPaint(1, Color.red);
	  renderer.setSeriesPaint(0, Color.green);
	  ChartFrame frame1=new ChartFrame("Area Chart",chart);
	  frame1.setVisible(true);
	  frame1.setSize(300,300);
	  }
}