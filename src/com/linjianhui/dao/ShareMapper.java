package com.linjianhui.dao;

import java.util.List;

import com.linjianhui.entity.Share;

public interface ShareMapper {
	//�������ʼ�
	void save(Share share);
	//ɾ������ʼ�
	void deleteByNoteId(String noteID);
	//��ҳ��ѯ���з���ʼ�
	List<Share> findByPage(String condition,int begin,int pageSize);
}