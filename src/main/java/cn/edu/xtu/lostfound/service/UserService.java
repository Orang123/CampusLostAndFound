package cn.edu.xtu.lostfound.service;

import java.util.List;

import cn.edu.xtu.lostfound.entity.User;

public interface UserService {
	
	User userLogin(User user);
	
	int userRegister(User user);
	
	int editUser(User user);
	
	int deleteUser(int id);
	
	int addUser(User user);
	
	User judgeUsername(String username);
	
	User judgeQQ(String qq);
	
	User judgeEmail(String email);
	
	User judgeEditUsername(Integer id,String username);
	
	User judgeEditQQ(Integer id,String qq);
	
	User judgeEditEmail(Integer id,String email);
	
	int searchUserNums(User user);
	
	List<User> searchUserInfo(int pageNum,int pageSize,User user);
	
	User showUserDetail(Integer id);
	
	User editUserDetail(Integer id);
	
}
