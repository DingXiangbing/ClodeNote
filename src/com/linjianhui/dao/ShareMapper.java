package com.linjianhui.dao;

import java.util.List;

import com.linjianhui.entity.Share;

public interface ShareMapper {
	//保存分享笔记
	void save(Share share);
	//删除分享笔记
	void deleteByNoteId(String noteID);
	//分页查询所有分享笔记
	List<Share> findByPage(String condition,int begin,int pageSize);
}