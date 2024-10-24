package com.my.org.erp.test.imageupload;
import java.lang.reflect.InvocationTargetException;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.builder.ToStringBuilder;

public class BeanUtilsCopyPropertiesTest {

	public static void main(String[] args) {

		FromBean fromBean = new FromBean("fromBean", "fromBeanAProp", "fromBeanBProp");
		ToBean toBean = new ToBean("toBean", "toBeanBProp", "toBeanCProp");
		System.out.println(ToStringBuilder.reflectionToString(fromBean));
		System.out.println(ToStringBuilder.reflectionToString(toBean));
		try {
			System.out.println("Copying properties from fromBean to toBean");
			BeanUtils.copyProperties(toBean, fromBean);
		} catch (IllegalAccessException e) {
			 System.out.println(e.getMessage());
		} catch (InvocationTargetException e) {
			 System.out.println(e.getMessage());
		}
		System.out.println(ToStringBuilder.reflectionToString(fromBean));
		System.out.println(ToStringBuilder.reflectionToString(toBean));
	}
}
