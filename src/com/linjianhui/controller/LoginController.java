package com.linjianhui.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.linjianhui.entity.Result;
import com.linjianhui.entity.User;
import com.linjianhui.service.LoginService;
import com.linjianhui.util.SystemConstant;

/**
 * ��¼��Controller
 * @author �ֽ���
 */
@Controller
@RequestMapping("/login")
public class LoginController implements SystemConstant{

	@Resource
	private LoginService login;
	/**
	 * �޸�����
	 */
	@RequestMapping("/changepsw.do")
	@ResponseBody
	public Result changepsw(String new_password,String last_password,HttpSession session){
		//�ж��Ƿ�����ֵ
		if(new_password==""||last_password==""){
			return new Result(null);
		}
		User user=(User)session.getAttribute("user");
		boolean b=login.changepsw(new_password,last_password,user);
		return new Result(b);
	}
	/**
	 * �˳���¼
	 */
	@RequestMapping("/logout.do")
	@ResponseBody
	public Result logout(HttpSession session){
		//ע��session
		session.invalidate();
		return new Result();
	}
	/**
	 * ע��
	 * @param user
	 * @return
	 */
	@RequestMapping("/register.do")
	@ResponseBody
	public Result login(User user){
		boolean b=login.addUser(user);
		return new Result(b);
	}
	
	/**
	 * ��¼
	 * @param username
	 * @param password
	 * @param session
	 * @return
	 */
	@RequestMapping("/login.do")
	@ResponseBody
	public Result checkLogin(String username,String password,HttpSession session){
		Map<String,Object> map=login.findUserForCheck(username, password);
		//��map�еõ���¼״̬��Ϣ���жϵ�¼״̬
		if(map.get("flag").equals(SUCCESS)){
			User user=(User)map.get("user");
			session.setAttribute("user", user);//����¼���û��󶨴�session��
		}
		return new Result(map);
	}
}
