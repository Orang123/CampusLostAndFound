package cn.edu.xtu.lostfound.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;

import cn.edu.xtu.lostfound.dao.UserDao;
import cn.edu.xtu.lostfound.entity.User;
import cn.edu.xtu.lostfound.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userDao;

	@Override
	public User userLogin(User user) {
		return userDao.selByNameAndPassword(user);
	}
	
	@Override
	public int userRegister(User user) {
		return userDao.insertUser(user);
	}
	@Override
	public int editUser(User user) {
		return userDao.update(user);
	}
	
	@Override
	public int searchUserNums(User user) {
		return userDao.selNumsByConditions(user);
	}

	@Override
	public List<User> searchUserInfo(int pageNum, int pageSize, User user) {
		PageHelper.startPage(pageNum, pageSize);
		return userDao.selByConditions(user);
	}

	@Override
	public int deleteUser(int id) {
		return userDao.deleteById(id);
	}

	@Override
	public int addUser(User user) {
		return userDao.insertUser(user);
	}

	@Override
	public User judgeUsername(String username) {
		return userDao.selByUsername(username);
	}

	@Override
	public User judgeQQ(String qq) {
		return userDao.selByQQ(qq);
	}

	@Override
	public User judgeEmail(String email) {
		return userDao.selByEmail(email);
	}
	
	@Override
	public User judgeEditUsername(Integer id, String username) {
		return userDao.selByEditUsername(id, username);
	}
	
	@Override
	public User judgeEditQQ(Integer id, String qq) {
		return userDao.selByEditQQ(id, qq);
	}
	
	@Override
	public User judgeEditEmail(Integer id, String email) {
		return userDao.selByEditEmail(id, email);
	}
	
	@Override
	public User showUserDetail(Integer id) {
		return userDao.selById(id);
	}
	
	@Override
	public User editUserDetail(Integer id) {
		return userDao.editById(id);
	}
	
}
