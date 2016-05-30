package com.linjianhui.test;

import java.sql.Timestamp;
import java.util.UUID;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.linjianhui.dao.NoteBookMapper;
import com.linjianhui.dao.UserMapper;
import com.linjianhui.entity.NoteBook;
import com.linjianhui.entity.User;
import com.linjianhui.service.LoginService;

public class testCase {
	/**
	 * 测试findByName
	 */
	@Test
	public void test1(){
		ApplicationContext ac=new ClassPathXmlApplicationContext("applicationContext.xml");
		
		UserMapper dao=ac.getBean("userMapper",UserMapper.class);
		User user=dao.findByName("zhoujia");
		System.out.println(user);
	}
	@Test
	public void test2(){
		ApplicationContext ac=new ClassPathXmlApplicationContext("applicationContext.xml");
		User user=new User();
		user.setCn_user_desc("关羽");
		user.setCn_user_id(UUID.randomUUID().toString());//随机生成一个随机的id对象，不重复
		user.setCn_user_name("guanyu");
		user.setCn_user_password("123456");
		UserMapper dao=ac.getBean("userMapper",UserMapper.class);
		dao.save(user);
	}
	@Test
	public void test3(){
		ApplicationContext ac=new ClassPathXmlApplicationContext("applicationContext.xml");
		NoteBook note=new NoteBook();
		note.setCn_notebook_name("jsd1412");
		note.setCn_notebook_desc("笔记本");
		note.setCn_notebook_createtime(new Timestamp(System.currentTimeMillis()));
		note.setCn_notebook_type_id("5");
		note.setCn_notebook_id(UUID.randomUUID().toString());
		note.setCn_user_id("68744907-653b-44e0-9e1b-7780a77f15f0");
		NoteBookMapper dao=ac.getBean("noteMapper",NoteBookMapper.class);
		dao.save(note);
	}
	/**
	 * 测试注册
	 */
	@Test
	public void test4(){
		@SuppressWarnings("resource")
		ApplicationContext ac=new ClassPathXmlApplicationContext("applicationContext.xml");
		LoginService login=ac.getBean("loginService",LoginService.class);
		User user=new User();
		user.setCn_user_name("zhangfei");
		user.setCn_user_desc("张飞");
		user.setCn_user_password("123456");
		login.addUser(user);
	}
	@Test
	public void test5(){
		ApplicationContext ac=new ClassPathXmlApplicationContext("applicationContext.xml");
		LoginService login=ac.getBean("loginService",LoginService.class);
		login.findUserForCheck("linjianhui", "123456");
		System.out.println();
	}
}







