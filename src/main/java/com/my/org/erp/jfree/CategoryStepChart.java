package com.my.org.erp.jfree;

import java.awt.Color;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.renderer.category.CategoryItemRenderer;
import org.jfree.chart.renderer.category.CategoryStepRenderer;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.general.DatasetUtilities;
import org.jfree.ui.ApplicationFrame;
import org.jfree.ui.RefineryUtilities;

public class CategoryStepChart extends ApplicationFrame {

    public CategoryStepChart(String tietel) {
        super(tietel);

        final CategoryDataset dataset = createDataset();
        final JFreeChart chart = createChart(dataset);
        final ChartPanel chartPanel = new ChartPanel(chart);
        chartPanel.setPreferredSize(new java.awt.Dimension(600, 350));
        setContentPane(chartPanel);
    }

    private CategoryDataset createDataset() {

        double[][] run = new double[][]{
            {5, 4, 3, 6, 7, 8, 3, 6, 3, 12},
            {9, 2, 2, 6, 8, 4, 0, 8, 9, 11}
        };

        double[][] runRate = new double[2][10];
        float team1run = 0;
        float team2run = 0;
        for (int i = 0; i < run[0].length; i++) {
            
            team1run += run[0][i];
            team2run += run[1][i];

            runRate[0][i] = team1run / (i+1);
            runRate[1][i] = team2run / (i+1);
        }
        return DatasetUtilities.createCategoryDataset("Team ", "", runRate);
    }

    private JFreeChart createChart(CategoryDataset dataset) {

        final CategoryItemRenderer renderer = new CategoryStepRenderer(true);
        final CategoryAxis domainAxis = new CategoryAxis("Over");
        final ValueAxis rangeAxis = new NumberAxis("Run Rate");
        final CategoryPlot plot = new CategoryPlot(dataset, domainAxis, rangeAxis, renderer);
        final JFreeChart chart = new JFreeChart("Score Bord", plot);

        chart.setBackgroundPaint(new Color(249, 231, 236));
        return chart;

    }

    public static void main(String args[]) {
        CategoryStepChart chart = new CategoryStepChart("Candle Stick Chart");
        chart.pack();
        RefineryUtilities.centerFrameOnScreen(chart);
        chart.setVisible(true);
    }
}