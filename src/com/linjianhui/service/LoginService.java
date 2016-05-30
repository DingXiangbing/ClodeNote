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
 * 用于处理登录
 * @author 林剑辉
 */
// 将该组件交给spring容器管理
// 实现保存笔记类型的接口
@Service
public class LoginService implements SystemConstant {
	/**
	 * 创建用户方法 User 包含用户名，密码，昵称
	 * @return
	 */
	@Resource
	private UserMapper userMapper;
	@Resource
	private NoteBookMapper noteBookMapper;

	/**
	 * 修改密码
	 */
	public boolean changepsw(String new_password,String last_password,User user){
		if(user==null||new_password==null||last_password==null){
			throw new RuntimeException("不准传入空值");
		}
		//判断用户输入的旧密码
		if(user.getCn_user_password().equals(Md5Util.md5(last_password))){
			user.setCn_user_password(Md5Util.md5(new_password));
			//将加密后的新用户交给mybatis处理
			userMapper.changepwd(user);
			return true;
		}else{
			//原密码输入不正确
			return false;
		}
	}
	/**
	 * 检查用户名密码是否正确
	 * @param username
	 * @param password
	 * @return
	 */
	public Map<String,Object> findUserForCheck(String username,String password){
		if(username==null||password==null){
			 throw new RuntimeException("空值");
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
	 * 注册业务
	 * @param user
	 * @return
	 */
	public boolean addUser(User user) {
		if (user == null){// 每一个方法应该都设置一个独立的判断，这样团队开发的时候如果别人调用该方法，就可以避免出错
		// 交给spring的aop来统一解决
			throw new RuntimeException();
		}
		// 查询该用户名是否存在
		User u = userMapper.findByName(user.getCn_user_name());
		if (u == null) {// 用户名不重复
			// 1.对密码进行加密
			String password = Md5Util.md5(user.getCn_user_password());
			user.setCn_user_password(password);
			// 2.给用户设定一个id
			user.setCn_user_id(UUID.randomUUID().toString());
			// 3.将用户信息存入数据库
			userMapper.save(user);
			// 4.给新用户分配4个笔记本
			initNoteBook(user.getCn_user_id());
			return true;
		} else {
			// 用户名重复
			return false;
		}
	}

	/**
	 * 给用户初始化4个笔记本，传入该用户的id
	 */
	private  void initNoteBook(String userID) {
		// 默认笔记本
		NoteBook n1 = new NoteBook();
		n1.setCn_notebook_name(NB_TYPE_CODE_NORMAL);
		n1.setCn_notebook_createtime(new Timestamp(System.currentTimeMillis()));
		n1.setCn_notebook_desc("默认笔记本");
		n1.setCn_notebook_id(UUID.randomUUID().toString());
		n1.setCn_notebook_type_id(NB_TYPE_PUSH);
		n1.setCn_user_id(userID);
		noteBookMapper.save(n1);
		// 回收站笔记本
		NoteBook n2 = new NoteBook();
		n2.setCn_notebook_name(NB_TYPE_CODE_RECYCLE);
		n2.setCn_notebook_createtime(new Timestamp(System.currentTimeMillis()));
		n2.setCn_notebook_desc("回收站笔记本");
		n2.setCn_notebook_id(UUID.randomUUID().toString());
		n2.setCn_notebook_type_id(NB_TYPE_RECYCLE);
		n2.setCn_user_id(userID);
		noteBookMapper.save(n2);
		// 收藏笔记本
		NoteBook n3 = new NoteBook();
		n3.setCn_notebook_name(NB_TYPE_CODE_FAVORITES);
		n3.setCn_notebook_createtime(new Timestamp(System.currentTimeMillis()));
		n3.setCn_notebook_desc("收藏笔记本");
		n3.setCn_notebook_id(UUID.randomUUID().toString());
		n3.setCn_notebook_type_id(NB_TYPE_FAVORITES);
		n3.setCn_user_id(userID);
		noteBookMapper.save(n3);
		// 活动分享笔记本
		NoteBook n4 = new NoteBook();
		n4.setCn_notebook_name(NB_TYPE_CODE_ACTION);
		n4.setCn_notebook_createtime(new Timestamp(System.currentTimeMillis()));
		n4.setCn_notebook_desc("活动分享笔记本");
		n4.setCn_notebook_id(UUID.randomUUID().toString());
		n4.setCn_notebook_type_id(NB_TYPE_ACTION);
		n4.setCn_user_id(userID);
		noteBookMapper.save(n4);
	}
}
