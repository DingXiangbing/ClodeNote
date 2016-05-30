package com.linjianhui.dao;

import java.util.List;

import com.linjianhui.entity.NoteBook;

/**
 * �ʼǲ���
 * @author �ֽ���
 *
 */
public interface NoteBookMapper {
	//����ʼǱ�
	public void save(NoteBook note);
	//�����û�id��ѯ��ͨ�ʼǱ�
	public List<NoteBook>findNormal(String userid);
	//�����û�id��ѯ����ʼǱ�
	public List<NoteBook> findSpecial(String userid);
	//�������ʼǱ�
	public void rename(NoteBook book);
	//ɾ���ʼǱ�
	public void delete(String bookId);
}
