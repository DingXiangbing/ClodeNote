package com.linjianhui.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.linjianhui.entity.Note;
import com.linjianhui.entity.Result;
import com.linjianhui.entity.Share;
import com.linjianhui.entity.User;
import com.linjianhui.service.NoteService;
/**
 * �ʼ�ģ��
 * @author �ֽ���
 */
@Controller
@RequestMapping("/note")
public class NoteController {
	@Resource
	private NoteService service;
	@ResponseBody
	@RequestMapping("/find.do")
	public Result find(String noteBookId){
		List<Note> list=service.findNotes(noteBookId);
		return new Result(list);
	}
	/**
	 * ��ӱʼ�
	 */
	@RequestMapping("/add.do")
	@ResponseBody
	public Result saveNote(HttpSession session,String cn_notebook_id,String noteTitle){
		User user=(User)session.getAttribute("user"); 
		Note note=service.saveNote(noteTitle, user.getCn_user_id(), cn_notebook_id);
		return new Result(note);
	}
	/**
	 * �޸ıʼǱ�����
	 */
	@RequestMapping("/change.do")
	@ResponseBody
	public Result change(Note note){
		service.changeNote(note);
		return new Result();
	}
	/**
	 * ��ѯ�û�����վ�ʼ�
	 */
	@ResponseBody
	@RequestMapping("/recycle.do")
	public Result findRecycle(String noteBookId,HttpSession session){
		User user=(User)session.getAttribute("user");
		List<Note> list=service.findRecycle(noteBookId,user.getCn_user_id());
		return new Result(list);
	}
	/**
	 * ���ʼ��������վ
	 */
	@RequestMapping("/movetorecycle.do")
	@ResponseBody
	public Result moveToRecycle(Note note){
		service.moveToRecycle(note);
		return new Result();
	}
	/**
	 * ɾ������վ�ʼ�,�����ղصıʼ�
	 */
	@RequestMapping("/delete.do")
	@ResponseBody
	public Result delete(String noteID){
		service.delete(noteID);
		return new Result();
	}
	@ResponseBody
	@RequestMapping("/addShare.do")
	public Result addShare(Note note){
		service.addShare(note);
		return new Result();
	}
	/**
	 * ��������ıʼ�
	 */
	@ResponseBody
	@RequestMapping("/search.do")
	public Result search(String condition,int currentPage){
		List<Share> list=service.search(condition, currentPage);
		return new Result(list);
	}
	/**
	 * �鿴�ղرʼǱ��µ����бʼ�
	 */
	@RequestMapping("/findFavority.do")
	@ResponseBody
	public Result findFavority(String noteBookId,HttpSession session){
		User user=(User)session.getAttribute("user");
		List<Note> list=service.findRecycle(noteBookId, user.getCn_user_id());
		return new Result(list);
	}
	/**
	 * �ղر��˷���ıʼ�
	 */
	@RequestMapping("/saveFavority.do")
	@ResponseBody
	public Result saveFavority(Share share,HttpSession session){
		User user=(User)session.getAttribute("user");
		service.saveFavority(share,user.getCn_user_id());
		return new Result();
	}
}







