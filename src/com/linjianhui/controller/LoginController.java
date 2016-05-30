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
 * 登录的Controller
 * @author 林剑辉
 */
@Controller
@RequestMapping("/login")
public class LoginController implements SystemConstant{

	@Resource
	private LoginService login;
	/**
	 * 修改密码
	 */
	@RequestMapping("/changepsw.do")
	@ResponseBody
	public Result changepsw(String new_password,String last_password,HttpSession session){
		//判断是否传来空值
		if(new_password==""||last_password==""){
			return new Result(null);
		}
		User user=(User)session.getAttribute("user");
		boolean b=login.changepsw(new_password,last_password,user);
		return new Result(b);
	}
	/**
	 * 退出登录
	 */
	@RequestMapping("/logout.do")
	@ResponseBody
	public Result logout(HttpSession session){
		//注销session
		session.invalidate();
		return new Result();
	}
	/**
	 * 注册
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
	 * 登录
	 * @param username
	 * @param password
	 * @param session
	 * @return
	 */
	@RequestMapping("/login.do")
	@ResponseBody
	public Result checkLogin(String username,String password,HttpSession session){
		Map<String,Object> map=login.findUserForCheck(username, password);
		//从map中得到登录状态信息，判断登录状态
		if(map.get("flag").equals(SUCCESS)){
			User user=(User)map.get("user");
			session.setAttribute("user", user);//将登录的用户绑定带session中
		}
		return new Result(map);
	}
}
