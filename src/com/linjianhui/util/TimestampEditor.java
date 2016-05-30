package com.linjianhui.util;

import java.beans.PropertyEditorSupport;
import java.sql.Timestamp;

/**
 * ��������ת���������Խ�ҳ�洫���long�͵�����ת�ͳ�java.sql.Timestamp
 * @author �ֽ���
 */
public class TimestampEditor extends PropertyEditorSupport{
	/*
	 * ����ҳ�洫������ݣ�����ת�ͺ�ע���Ŀ�꣬
	 * �����ֵ����ҳ�洫���ֵ
	 */
	@Override
	public void setAsText(String text){
		if(text==null){
			//�������Ĳ���Ϊ�գ�ֱ�ӽ�nullע���Ŀ��
			setValue(null);
		}else{
			//���������Ϊ�գ�����ת����ʱ���ʽ,ע���Ŀ��
			Timestamp t=new Timestamp(Long.parseLong(text)); 
			setValue(t);
		}
		
	}
}
