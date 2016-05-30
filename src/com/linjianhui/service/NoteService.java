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
 * �ʼ�ģ��service
 * @author �ֽ���
 *
 */
@Service
public class NoteService implements SystemConstant{
	@Resource
	private NoteMapper mapper;
	@Resource
	private ShareMapper shareMapper;
	/**
	 * ��ѯ�ʼ�
	 */
	public List<Note> findNotes(String noteBookId){
		if(noteBookId==null){
			throw new RuntimeException("����Ϊ��");
		}
		List<Note> list=mapper.findByNoteBookId(noteBookId);
		return list;
	}
	/**
	 * �����ʼ�
	 */
	public Note saveNote(String noteTitle,String userID,String noteBookId){
		if(noteBookId==null||userID==null||noteTitle==null){
			throw new RuntimeException("����Ϊ��");
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
	 * �޸ıʼ�
	 */
	public void changeNote(Note note){
		if(note==null){
			throw new RuntimeException("��������Ϊ��");
		}
		note.setCn_note_last_modify_time(System.currentTimeMillis());
		mapper.changeNote(note);
	}
	/**
	 * ���ݻ���վ�ʼǱ�id��ѯ����վ�ʼ�
	 */
	public List<Note> findRecycle(String noteBookId,String userID){
		if(noteBookId==null){
			throw new RuntimeException("��ֵ");
		}
		List<Note> list=mapper.findRecycle(noteBookId,userID);
		
		return list;
	}
	/**
	 * ���ʼ��������վ
	 */
	public void moveToRecycle(Note note){
		if(note==null){
			throw new RuntimeException("��ֵ");
		}
		mapper.changeNote(note);
	}
	/**
	 * ɾ������վ�ʼ� 
	 */
	public void delete(String noteID){
		if(noteID==null){
			throw new RuntimeException("��ֵ");
		}
		mapper.delete(noteID);
	}
	/**
	 * ����ʼ�
	 * 1.Ҫ���жϷ�������Ƿ���ڸ÷���ʼǣ����о͸��ǣ�û�о�����
	 * 2.ֱ��ִ��ɾ����Ȼ���ٲ���ʼ�
	 */
	public void addShare(Note note){
		if(note==null){
			throw new RuntimeException("��ֵ");
		}
		//��ɾ����ǰ�ʼǶ�Ӧ�ķ�������
		shareMapper.deleteByNoteId(note.getCn_note_id());
		//������������
		Share s=new Share();
		s.setCn_note_id(note.getCn_note_id());
		s.setCn_share_body(note.getCn_note_body());
		s.setCn_share_id(UUID.randomUUID().toString());
		s.setCn_share_title(note.getCn_note_title());
		shareMapper.save(s);
	}
	/**
	 * ����
	 */
	public List<Share> search(String condition,int currentPage){
		if(condition==null){
			throw new RuntimeException("��ֵ");
		}
		return shareMapper.findByPage(condition, currentPage, PAGESIZE);
	}
	/**
	 * �ղرʼ�
	 */
	public void saveFavority(Share share,String userID){
		if(share==null||userID==null){
			throw new RuntimeException("���������ֵ");
		}
		Note note=new Note();
		note.setCn_user_id(userID);
		note.setCn_note_body(share.getCn_share_body());
		note.setCn_note_title(share.getCn_share_title());
		note.setCn_note_type_id(NB_TYPE_CODE_FAVORITES);
		note.setCn_notebook_id(share.getCn_share_id());//�����share_id��ҳ��˸ĳ��˸��û����ղرʼǱ�id
		note.setCn_note_id(UUID.randomUUID().toString());
		note.setCn_note_create_time(System.currentTimeMillis());
		note.setCn_note_last_modify_time(System.currentTimeMillis());
		//System.out.println(share.getCn_note_id());
		mapper.save(note);
	}
}


