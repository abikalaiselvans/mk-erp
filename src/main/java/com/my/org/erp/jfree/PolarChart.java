package com.my.org.erp.jfree;


import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.data.xy.XYDataset;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;
import org.jfree.ui.ApplicationFrame;
import org.jfree.ui.RefineryUtilities;

public class PolarChart extends ApplicationFrame {

    public PolarChart(String titel) {
        super(titel);

        XYDataset dataset = createDataset();
        JFreeChart chart = createChart(dataset);
        
        ChartPanel chartPanel = new ChartPanel(chart);
        chartPanel.setPreferredSize(new java.awt.Dimension(600, 600));
        setContentPane(chartPanel);
    }

    private XYDataset createDataset() {
        final XYSeriesCollection data = new XYSeriesCollection();
        XYSeries series = new XYSeries("Average Size");
        series.add(45, 40.0);
        series.add(135.0, 45.0);
        series.add(270.0, 40.0);
        data.addSeries(series);
        return data;
    }

    private JFreeChart createChart(XYDataset dataset) {
        JFreeChart chart = ChartFactory.createPolarChart(
            "Polar Chart", dataset, true, true, false
        ); 
        return chart;
    }

    public static void main(final String[] args) {
        PolarChart chart = new PolarChart("Polar Chart");
        chart.pack();
        RefineryUtilities.centerFrameOnScreen(chart);
        chart.setVisible(true);
    }
}

