package com.linjianhui.util;

import java.beans.PropertyEditorSupport;
import java.sql.Timestamp;

/**
 * 日期类型转换器，可以将页面传入的long型的日期转型成java.sql.Timestamp
 * @author 林剑辉
 */
public class TimestampEditor extends PropertyEditorSupport{
	/*
	 * 接受页面传入的数据，将其转型后注入给目标，
	 * 传入的值就是页面传入的值
	 */
	@Override
	public void setAsText(String text){
		if(text==null){
			//如果传入的参数为空，直接将null注入给目标
			setValue(null);
		}else{
			//如果参数不为空，将其转换成时间格式,注入给目标
			Timestamp t=new Timestamp(Long.parseLong(text)); 
			setValue(t);
		}
		
	}
}
