<%@taglib prefix="test" uri="/WEB-INF/SubstrDescriptor.tld"%>
 
 
    <title>JSP Custom Taglib example: Substr function</title>
 
 
    SUBSTR(KALAISELVAN JAVA, 1, 6) is 
    <font color="blue">
    <test:substring input="KALAISELVAN JAVA" start="1" end="6">
    </test:substring></font>