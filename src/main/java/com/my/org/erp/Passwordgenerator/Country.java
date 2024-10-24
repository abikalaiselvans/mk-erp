package com.my.org.erp.Passwordgenerator;

class Country implements Comparable<Country> 
{
   
	public Country(String name, String alpha2,String alpha3, Integer numericCode) 
	{
        this.name = name;
        this.alpha2Code = alpha2;
        this.alpha3Code = alpha3;
        this.numericCode = numericCode;
    }
    
	private int numericCode;
    private String alpha2Code;
    private String alpha3Code;
    private String name;
 
    public int getNumericCode() {
        return numericCode;
    }
 
    public void setNumericCode(int numericCode) {
        this.numericCode = numericCode;
    }
 
    public String getAlpha2Code() {
        return alpha2Code;
    }
 
    public void setAlpha2Code(String alpha2Code) {
        this.alpha2Code = alpha2Code;
    }
 
    public String getAlpha3Code() {
        return alpha3Code;
    }
 
    public void setAlpha3Code(String alpha3Code) {
        this.alpha3Code = alpha3Code;
    }
 
    public String getName() {
        return name;
    }
 
    public void setName(String name) {
        this.name = name;
    }
 
    @Override
    public String toString() {
        return alpha2Code + ", " + alpha3Code + ", " + name;
    }
 
   
    public int compareTo(Country o) 
    {
        if(this.numericCode < o.numericCode)
            return -1;
        if(this.numericCode > o.numericCode)
            return 1;
        return 0;
    }
}
 