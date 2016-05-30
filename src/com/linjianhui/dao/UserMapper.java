package com.linjianhui.dao;

import com.linjianhui.entity.User;

public interface UserMapper {
	User findByName(String userName);
	void save(User user);
	void changepwd(User user);
}
