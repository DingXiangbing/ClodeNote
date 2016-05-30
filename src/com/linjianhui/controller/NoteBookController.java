package com.linjianhui.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.WebBindingInitializer;
import org.springframework.web.context.request.WebRequest;

import com.linjianhui.entity.NoteBook;
import com.linjianhui.entity.Result;
import com.linjianhui.entity.User;
import com.linjianhui.service.NoteBookService;
import com.linjianhui.util.TimestampEditor;

/**
 * 希望在执行该Controller时置换时间类型的Editor，需要实现WebBindingIngInitializer
 * @author 林剑辉
 *
 */
@Controller
@RequestMapping("/notebook")
public class NoteBookController implements WebBindingInitializer{
	@Resource
	private NoteBookService service;
	/**
	 * 删除笔记
	 */
	@RequestMapping("/del.do")
	@ResponseBody
	public Result delete(String bookId){
		service.delete(bookId);
		return new Result();
	}
	/**
	 * 修改笔记本
	 */
	@RequestMapping("/rename.do")
	@ResponseBody
	public Result rename(NoteBook book){
		service.rename(book);
		return new Result();
	}
	/**
	 * 添加笔记本
	 */
	@RequestMapping("/add.do")
	@ResponseBody
	public Result add(String noteBookName,HttpSession session){
		User user = (User)session.getAttribute("user");
		NoteBook nb=service.add(noteBookName, user.getCn_user_id());
		return new Result(nb);
	}
	/**
	 * 查询用户普通笔记本
	 * @param session
	 * @return
	 */
	@RequestMapping("/findNormal.do")
	@ResponseBody
	public Result findNormal(HttpSession session){
		User user=(User)session.getAttribute("user");
		String userid=user.getCn_user_id();
		List<NoteBook> list=service.findNormal(userid);
		return new Result(list);
	}
	/**
	 * 查询用户特殊笔记本
	 * @param session
	 * @return
	 */
	@RequestMapping("/findSepical.do")
	@ResponseBody
	public Result findSepical(HttpSession session){
		User user=(User)session.getAttribute("user");
		String userid=user.getCn_user_id();
		List<NoteBook> list=service.findSepical(userid);
		return new Result(list);
	}
	/**
	 * InitBinder每次访问这个Controller的方法前，先执行该方法的initBinder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder, WebRequest request) {
		//注册自己的Editor
		binder.registerCustomEditor(java.sql.Timestamp.class, new TimestampEditor());
	}
}
