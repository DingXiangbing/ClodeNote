package com.linjianhui.util;
/**
 * 放系统级常量
 * @author 林剑辉
 */
public interface SystemConstant {
	//声明笔记本类型id
	String NB_TYPE_FAVORITES="1";
	String NB_TYPE_RECYCLE="2";
	String NB_TYPE_ACTION="3";
	String NB_TYPE_PUSH="4";
	String NB_TYPE_NORMAL="5";
	//声明笔记本类型编码
	String NB_TYPE_CODE_FAVORITES="favorites";
	String NB_TYPE_CODE_RECYCLE="recycle";
	String NB_TYPE_CODE_ACTION="action";
	String NB_TYPE_CODE_PUSH="push";
	String NB_TYPE_CODE_NORMAL="normal";
	//设置笔记类型
	
	//登录校验结果
	int SUCCESS=0;
	int USER_NAME_ERROR=1;
	int PASSWORD=2;
	//修改密码校验
	int CHANGEPSWTRUE=0;
	int CHANGEPSWFALSE=1;
	//设置每页显示的条数
	int PAGESIZE=8;
}
