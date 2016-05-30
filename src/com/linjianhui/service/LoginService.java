package com.linjianhui.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.linjianhui.dao.NoteBookMapper;
import com.linjianhui.dao.UserMapper;
import com.linjianhui.entity.NoteBook;
import com.linjianhui.entity.User;
import com.linjianhui.util.Md5Util;
import com.linjianhui.util.SystemConstant;

/**
 * ���ڴ����¼
 * @author �ֽ���
 */
// �����������spring��������
// ʵ�ֱ���ʼ����͵Ľӿ�
@Service
public class LoginService implements SystemConstant {
	/**
	 * �����û����� User �����û��������룬�ǳ�
	 * @return
	 */
	@Resource
	private UserMapper userMapper;
	@Resource
	private NoteBookMapper noteBookMapper;

	/**
	 * �޸�����
	 */
	public boolean changepsw(String new_password,String last_password,User user){
		if(user==null||new_password==null||last_password==null){
			throw new RuntimeException("��׼�����ֵ");
		}
		//�ж��û�����ľ�����
		if(user.getCn_user_password().equals(Md5Util.md5(last_password))){
			user.setCn_user_password(Md5Util.md5(new_password));
			//�����ܺ�����û�����mybatis����
			userMapper.changepwd(user);
			return true;
		}else{
			//ԭ�������벻��ȷ
			return false;
		}
	}
	/**
	 * ����û��������Ƿ���ȷ
	 * @param username
	 * @param password
	 * @return
	 */
	public Map<String,Object> findUserForCheck(String username,String password){
		if(username==null||password==null){
			 throw new RuntimeException("��ֵ");
		}
		User u=userMapper.findByName(username);
		Map<String,Object> map=new HashMap<String, Object>();
		if(u==null){
			map.put("flag", USER_NAME_ERROR);
		}else{
			if(!Md5Util.md5(password).equals(u.getCn_user_password())){
				map.put("flag", PASSWORD);
			}else{
				map.put("flag", SUCCESS);
				map.put("user", u);
			}
		}
		return map;
	}
	/**
	 * ע��ҵ��
	 * @param user
	 * @return
	 */
	public boolean addUser(User user) {
		if (user == null){// ÿһ������Ӧ�ö�����һ���������жϣ������Ŷӿ�����ʱ��������˵��ø÷������Ϳ��Ա������
		// ����spring��aop��ͳһ���
			throw new RuntimeException();
		}
		// ��ѯ���û����Ƿ����
		User u = userMapper.findByName(user.getCn_user_name());
		if (u == null) {// �û������ظ�
			// 1.��������м���
			String password = Md5Util.md5(user.getCn_user_password());
			user.setCn_user_password(password);
			// 2.���û��趨һ��id
			user.setCn_user_id(UUID.randomUUID().toString());
			// 3.���û���Ϣ�������ݿ�
			userMapper.save(user);
			// 4.�����û�����4���ʼǱ�
			initNoteBook(user.getCn_user_id());
			return true;
		} else {
			// �û����ظ�
			return false;
		}
	}

	/**
	 * ���û���ʼ��4���ʼǱ���������û���id
	 */
	private  void initNoteBook(String userID) {
		// Ĭ�ϱʼǱ�
		NoteBook n1 = new NoteBook();
		n1.setCn_notebook_name(NB_TYPE_CODE_NORMAL);
		n1.setCn_notebook_createtime(new Timestamp(System.currentTimeMillis()));
		n1.setCn_notebook_desc("Ĭ�ϱʼǱ�");
		n1.setCn_notebook_id(UUID.randomUUID().toString());
		n1.setCn_notebook_type_id(NB_TYPE_PUSH);
		n1.setCn_user_id(userID);
		noteBookMapper.save(n1);
		// ����վ�ʼǱ�
		NoteBook n2 = new NoteBook();
		n2.setCn_notebook_name(NB_TYPE_CODE_RECYCLE);
		n2.setCn_notebook_createtime(new Timestamp(System.currentTimeMillis()));
		n2.setCn_notebook_desc("����վ�ʼǱ�");
		n2.setCn_notebook_id(UUID.randomUUID().toString());
		n2.setCn_notebook_type_id(NB_TYPE_RECYCLE);
		n2.setCn_user_id(userID);
		noteBookMapper.save(n2);
		// �ղرʼǱ�
		NoteBook n3 = new NoteBook();
		n3.setCn_notebook_name(NB_TYPE_CODE_FAVORITES);
		n3.setCn_notebook_createtime(new Timestamp(System.currentTimeMillis()));
		n3.setCn_notebook_desc("�ղرʼǱ�");
		n3.setCn_notebook_id(UUID.randomUUID().toString());
		n3.setCn_notebook_type_id(NB_TYPE_FAVORITES);
		n3.setCn_user_id(userID);
		noteBookMapper.save(n3);
		// �����ʼǱ�
		NoteBook n4 = new NoteBook();
		n4.setCn_notebook_name(NB_TYPE_CODE_ACTION);
		n4.setCn_notebook_createtime(new Timestamp(System.currentTimeMillis()));
		n4.setCn_notebook_desc("�����ʼǱ�");
		n4.setCn_notebook_id(UUID.randomUUID().toString());
		n4.setCn_notebook_type_id(NB_TYPE_ACTION);
		n4.setCn_user_id(userID);
		noteBookMapper.save(n4);
	}
}
