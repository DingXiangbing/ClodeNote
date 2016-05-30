package com.linjianhui.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.linjianhui.dao.NoteBookMapper;
import com.linjianhui.entity.NoteBook;
import com.linjianhui.util.SystemConstant;

/**
 * 笔记本模块service
 * @author 林剑辉
 *
 */

@Service
public class NoteBookService implements SystemConstant{
	@Resource
	private NoteBookMapper mapper;
	/**
	 * 删除笔记本
	 */
	public void delete(String noteBookId){
		if(noteBookId==null){
			throw new RuntimeException("传入空值");
		}
		mapper.delete(noteBookId);
	}
	
	/**
	 * 修改笔记本
	 */
	public void rename(NoteBook book){
		if(book==null){
			throw new RuntimeException("空值");
		}
		mapper.rename(book);
	}
	/**
	 * 添加普通笔记本
	 */
	public NoteBook add(String noteBookName,String userid){
		if(noteBookName==null||userid==null){
			throw new RuntimeException("空值");
		}
		NoteBook nb=new NoteBook();
		nb.setCn_notebook_id(UUID.randomUUID().toString());
		nb.setCn_notebook_name(noteBookName);
		nb.setCn_user_id(userid);
		nb.setCn_notebook_createtime(new Timestamp(System.currentTimeMillis()));
		nb.setCn_notebook_type_id(NB_TYPE_NORMAL);
		mapper.save(nb);
		return nb;
	}
	/**
	 * 查询用户普通笔记本
	 * @param userid
	 * @return
	 */
	public List<NoteBook> findNormal(String userid){
		if(userid==null){
			throw new RuntimeException("空值");
		}
		List<NoteBook> list=mapper.findNormal(userid);
		return list;
	}
	/**
	 * 查询用户特殊笔记本
	 * @param userid
	 * @return
	 */
	public List<NoteBook> findSepical(String userid){
		if(userid==null){
			throw new RuntimeException("空值");
		}
		return mapper.findSpecial(userid);
	}
}
