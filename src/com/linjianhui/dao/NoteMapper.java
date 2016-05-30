package com.linjianhui.dao;

import java.util.List;

import com.linjianhui.entity.Note;

public interface NoteMapper {
	//查询笔记
	public List<Note> findByNoteBookId(String NoteBookId);
	//保存笔记
	public void save(Note note);
	//修改笔记本
	public void changeNote(Note note);
	//查询回收站笔记,根据用户id查询
	public List<Note> findRecycle(String nootBookID,String userID);
	//删除回收站笔记
	public void delete(String noteID);
}
