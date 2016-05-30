package com.linjianhui.entity;
/**
 * ͳһ�ķ��ؽ��
 * @author �ֽ���
 *
 */
public class Result {

	/*
	 *�жϳ����Ƿ�ִ�гɹ� ,Ĭ��Ϊtrue
	 */
	private boolean success = true;
	/*
	 * ����ִ�н������ʾ��Ϣ
	 */
	private String message;
	/*
	 * ����ִ�з��ص�ҵ������
	 */
	private Object data;
	/*
	 * Ĭ�ϵĹ��췽�����޷������ݣ�ִ�гɹ�������ʾ��Ϣ
	 */
	public Result(){
		
	}
	/*
	 * ��һ�������Ĺ��췽��
	 */
	public Result(Object data) {
		super();
		this.data = data;
	}
	/*
	 * �����������Ĺ��췽��
	 */
	public Result(boolean success, Object data) {
		super();
		this.success = success;
		this.data = data;
	}
	/*
	 * �����������Ĺ��췽��
	 */
	public Result(boolean success, String message, Object data) {
		super();
		this.success = success;
		this.message = message;
		this.data = data;
	}
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	
}









