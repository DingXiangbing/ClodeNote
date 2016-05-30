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
 * �ʼǱ�ģ��service
 * @author �ֽ���
 *
 */

@Service
public class NoteBookService implements SystemConstant{
	@Resource
	private NoteBookMapper mapper;
	/**
	 * ɾ���ʼǱ�
	 */
	public void delete(String noteBookId){
		if(noteBookId==null){
			throw new RuntimeException("�����ֵ");
		}
		mapper.delete(noteBookId);
	}
	
	/**
	 * �޸ıʼǱ�
	 */
	public void rename(NoteBook book){
		if(book==null){
			throw new RuntimeException("��ֵ");
		}
		mapper.rename(book);
	}
	/**
	 * �����ͨ�ʼǱ�
	 */
	public NoteBook add(String noteBookName,String userid){
		if(noteBookName==null||userid==null){
			throw new RuntimeException("��ֵ");
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
	 * ��ѯ�û���ͨ�ʼǱ�
	 * @param userid
	 * @return
	 */
	public List<NoteBook> findNormal(String userid){
		if(userid==null){
			throw new RuntimeException("��ֵ");
		}
		List<NoteBook> list=mapper.findNormal(userid);
		return list;
	}
	/**
	 * ��ѯ�û�����ʼǱ�
	 * @param userid
	 * @return
	 */
	public List<NoteBook> findSepical(String userid){
		if(userid==null){
			throw new RuntimeException("��ֵ");
		}
		return mapper.findSpecial(userid);
	}
}
