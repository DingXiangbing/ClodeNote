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
 * ϣ����ִ�и�Controllerʱ�û�ʱ�����͵�Editor����Ҫʵ��WebBindingIngInitializer
 * @author �ֽ���
 *
 */
@Controller
@RequestMapping("/notebook")
public class NoteBookController implements WebBindingInitializer{
	@Resource
	private NoteBookService service;
	/**
	 * ɾ���ʼ�
	 */
	@RequestMapping("/del.do")
	@ResponseBody
	public Result delete(String bookId){
		service.delete(bookId);
		return new Result();
	}
	/**
	 * �޸ıʼǱ�
	 */
	@RequestMapping("/rename.do")
	@ResponseBody
	public Result rename(NoteBook book){
		service.rename(book);
		return new Result();
	}
	/**
	 * ��ӱʼǱ�
	 */
	@RequestMapping("/add.do")
	@ResponseBody
	public Result add(String noteBookName,HttpSession session){
		User user = (User)session.getAttribute("user");
		NoteBook nb=service.add(noteBookName, user.getCn_user_id());
		return new Result(nb);
	}
	/**
	 * ��ѯ�û���ͨ�ʼǱ�
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
	 * ��ѯ�û�����ʼǱ�
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
	 * InitBinderÿ�η������Controller�ķ���ǰ����ִ�и÷�����initBinder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder, WebRequest request) {
		//ע���Լ���Editor
		binder.registerCustomEditor(java.sql.Timestamp.class, new TimestampEditor());
	}
}
