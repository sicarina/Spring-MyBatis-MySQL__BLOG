package com.example.blog.repository;

import com.example.blog.model.User;

public interface UserRepository {
	User selectUsername(String username);
	int insert(User user);
	User login(User user);
	int update(User user);
	int updatePw(User user);
	int updateProfile(User user);
	int updateProfileNull(int id);
	int delete(int id);
}
