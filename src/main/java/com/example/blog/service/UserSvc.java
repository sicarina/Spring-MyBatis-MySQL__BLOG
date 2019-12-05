package com.example.blog.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.blog.model.User;
import com.example.blog.repository.UserRepository;

@Service
public class UserSvc {

	@Autowired
	UserRepository UserRep;
	
	public User selectUsername(String username) {
		return UserRep.selectUsername(username);
	}
	
	public int insert(User user) {
		int result = 0;
		try {
			result = UserRep.insert(user);
		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		
		return result;
	}
	
	public User login(User user) {
		return UserRep.login(user);
	}
	
	public int update(User user) {
		int result = 0;
		try {
			result = UserRep.update(user);
		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		
		return result;
	}

	public int updatePw(User user) {
		int result = 0;
		try {
			result = UserRep.updatePw(user);
		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		
		return result;
	}

	public int updateProfile(User user) {
		int result = 0;
		try {
			result = UserRep.updateProfile(user);
		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		
		return result;
	}

	public int updateProfileNull(int id) {
		int result = 0;
		try {
			result = UserRep.updateProfileNull(id);
		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		
		return result;
	}
	
	public int delete(int id) {
		int result = 0;
		try {
			result = UserRep.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		
		return result;
	}
}
