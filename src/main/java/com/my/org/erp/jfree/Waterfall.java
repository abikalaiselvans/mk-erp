package com.my.org.erp.jfree;

import java.awt.*;
import org.jfree.chart.*;
import org.jfree.data.category.*;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.xy.*;
import org.jfree.data.*;
import org.jfree.chart.renderer.category.*;
import org.jfree.chart.plot.*;

public class Waterfall{
public static void main(String arg[]){
	DefaultCategoryDataset dataset = new DefaultCategoryDataset();
	dataset.addValue(3.0, "Salary", "Rahul");
	dataset.addValue(3.0, "Salary", "Prashant");
	dataset.addValue(2.0, "Salary", "Chandan");
	dataset.addValue(2.0, "Salary", "Vinod");
	dataset.addValue(10.0, "Salary", "Total");
	JFreeChart chart = ChartFactory.createWaterfallChart("Comparison between Employees","Employee", "Salary", dataset, PlotOrientation.VERTICAL, true,true, false);
	chart.getTitle().setPaint(Color.blue); 
	CategoryPlot p = chart.getCategoryPlot(); 
	p.setRangeGridlinePaint(Color.red); 
	p.setDomainGridlinesVisible(true);
	p.setDomainGridlinePaint(Color.black);
	ChartFrame frame1=new ChartFrame("WaterFall Chart",chart);
	frame1.setVisible(true);
	frame1.setSize(400,350);
	}
}