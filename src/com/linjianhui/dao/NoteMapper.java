package com.linjianhui.dao;

import java.util.List;

import com.linjianhui.entity.Note;

public interface NoteMapper {
	//��ѯ�ʼ�
	public List<Note> findByNoteBookId(String NoteBookId);
	//����ʼ�
	public void save(Note note);
	//�޸ıʼǱ�
	public void changeNote(Note note);
	//��ѯ����վ�ʼ�,�����û�id��ѯ
	public List<Note> findRecycle(String nootBookID,String userID);
	//ɾ������վ�ʼ�
	public void delete(String noteID);
}
