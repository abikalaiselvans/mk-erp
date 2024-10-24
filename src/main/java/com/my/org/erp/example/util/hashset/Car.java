/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.my.org.erp.example.util.hashset;

/**
 *
 * @author tunatore
 */
public class Car implements Comparable<Car>{

    private String name;
    private int motorPower;
    private int modelYear;

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the motorPower
     */
    public int getMotorPower() {
        return motorPower;
    }

    /**
     * @param motorPower the motorPower to set
     */
    public void setMotorPower(int motorPower) {
        this.motorPower = motorPower;
    }

    /**
     * @return the modelYear
     */
    public int getModelYear() {
        return modelYear;
    }

    /**
     * @param modelYear the modelYear to set
     */
    public void setModelYear(int modelYear) {
        this.modelYear = modelYear;
    }

    //this method will be used by TreeSet class
    //for sorting the car class elements according to Motor Power
    
    public int compareTo(Car carToCompare) {

        //return zero if two objects are equal
        if (this.motorPower == carToCompare.getMotorPower() ) {
            return 0;
        } //return -1 if the current object is smaller than the object compared
        else if (this.motorPower < carToCompare.getMotorPower()) {
            return -1;
        } //return 1 if the current object is bigger than the object compared
        else {
            return 1;
        }

    }

    
}
