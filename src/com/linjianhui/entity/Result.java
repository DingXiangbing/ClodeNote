package com.linjianhui.entity;
/**
 * 统一的返回结果
 * @author 林剑辉
 *
 */
public class Result {

	/*
	 *判断程序是否执行成功 ,默认为true
	 */
	private boolean success = true;
	/*
	 * 程序执行结果的提示信息
	 */
	private String message;
	/*
	 * 程序执行返回的业务数据
	 */
	private Object data;
	/*
	 * 默认的构造方法，无返回数据，执行成功，无提示信息
	 */
	public Result(){
		
	}
	/*
	 * 带一个参数的构造方法
	 */
	public Result(Object data) {
		super();
		this.data = data;
	}
	/*
	 * 带两个参数的构造方法
	 */
	public Result(boolean success, Object data) {
		super();
		this.success = success;
		this.data = data;
	}
	/*
	 * 带三个参数的构造方法
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









