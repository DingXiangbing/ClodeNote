package com.linjianhui.dao;

import java.util.List;

import com.linjianhui.entity.NoteBook;

/**
 * 笔记操作
 * @author 林剑辉
 *
 */
public interface NoteBookMapper {
	//保存笔记本
	public void save(NoteBook note);
	//根据用户id查询普通笔记本
	public List<NoteBook>findNormal(String userid);
	//根据用户id查询特殊笔记本
	public List<NoteBook> findSpecial(String userid);
	//重命名笔记本
	public void rename(NoteBook book);
	//删除笔记本
	public void delete(String bookId);
}
