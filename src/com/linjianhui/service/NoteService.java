package com.linjianhui.service;

import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.linjianhui.dao.NoteMapper;
import com.linjianhui.dao.ShareMapper;
import com.linjianhui.entity.Note;
import com.linjianhui.entity.Share;
import com.linjianhui.util.SystemConstant;

/**
 * 笔记模块service
 * @author 林剑辉
 *
 */
@Service
public class NoteService implements SystemConstant{
	@Resource
	private NoteMapper mapper;
	@Resource
	private ShareMapper shareMapper;
	/**
	 * 查询笔记
	 */
	public List<Note> findNotes(String noteBookId){
		if(noteBookId==null){
			throw new RuntimeException("参数为空");
		}
		List<Note> list=mapper.findByNoteBookId(noteBookId);
		return list;
	}
	/**
	 * 新增笔记
	 */
	public Note saveNote(String noteTitle,String userID,String noteBookId){
		if(noteBookId==null||userID==null||noteTitle==null){
			throw new RuntimeException("参数为空");
		}
		Note note=new Note();
		note.setCn_note_create_time(System.currentTimeMillis());
		note.setCn_note_id(UUID.randomUUID().toString());
		note.setCn_note_last_modify_time(System.currentTimeMillis());
		note.setCn_note_title(noteTitle);
		note.setCn_notebook_id(noteBookId);
		note.setCn_user_id(userID);
		mapper.save(note);
		return note;
	}
	/**
	 * 修改笔记
	 */
	public void changeNote(Note note){
		if(note==null){
			throw new RuntimeException("参数不能为空");
		}
		note.setCn_note_last_modify_time(System.currentTimeMillis());
		mapper.changeNote(note);
	}
	/**
	 * 根据回收站笔记本id查询回收站笔记
	 */
	public List<Note> findRecycle(String noteBookId,String userID){
		if(noteBookId==null){
			throw new RuntimeException("空值");
		}
		List<Note> list=mapper.findRecycle(noteBookId,userID);
		
		return list;
	}
	/**
	 * 将笔记移入回收站
	 */
	public void moveToRecycle(Note note){
		if(note==null){
			throw new RuntimeException("空值");
		}
		mapper.changeNote(note);
	}
	/**
	 * 删除回收站笔记 
	 */
	public void delete(String noteID){
		if(noteID==null){
			throw new RuntimeException("空值");
		}
		mapper.delete(noteID);
	}
	/**
	 * 分享笔记
	 * 1.要先判断分享表中是否存在该分享笔记，如有就覆盖，没有就新增
	 * 2.直接执行删除，然后再插入笔记
	 */
	public void addShare(Note note){
		if(note==null){
			throw new RuntimeException("空值");
		}
		//先删除当前笔记对应的分享数据
		shareMapper.deleteByNoteId(note.getCn_note_id());
		//新增分享数据
		Share s=new Share();
		s.setCn_note_id(note.getCn_note_id());
		s.setCn_share_body(note.getCn_note_body());
		s.setCn_share_id(UUID.randomUUID().toString());
		s.setCn_share_title(note.getCn_note_title());
		shareMapper.save(s);
	}
	/**
	 * 搜索
	 */
	public List<Share> search(String condition,int currentPage){
		if(condition==null){
			throw new RuntimeException("空值");
		}
		return shareMapper.findByPage(condition, currentPage, PAGESIZE);
	}
	/**
	 * 收藏笔记
	 */
	public void saveFavority(Share share,String userID){
		if(share==null||userID==null){
			throw new RuntimeException("不允许传入空值");
		}
		Note note=new Note();
		note.setCn_user_id(userID);
		note.setCn_note_body(share.getCn_share_body());
		note.setCn_note_title(share.getCn_share_title());
		note.setCn_note_type_id(NB_TYPE_CODE_FAVORITES);
		note.setCn_notebook_id(share.getCn_share_id());//这里的share_id在页面端改成了该用户的收藏笔记本id
		note.setCn_note_id(UUID.randomUUID().toString());
		note.setCn_note_create_time(System.currentTimeMillis());
		note.setCn_note_last_modify_time(System.currentTimeMillis());
		//System.out.println(share.getCn_note_id());
		mapper.save(note);
	}
}


