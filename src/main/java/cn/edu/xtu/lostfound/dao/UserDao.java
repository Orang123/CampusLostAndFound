package cn.edu.xtu.lostfound.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.edu.xtu.lostfound.entity.User;

public interface UserDao {
	
	User selByNameAndPassword(User user);
	
	int update(User user);
	
	int selNumsByConditions(User user);
	
	List<User> selByConditions(User user);
	
	int deleteById(int id);
	
	int insertUser(User user);
	
	User selByUsername(String username);
	
	User selByQQ(String qq);
	
	User selByEmail(String email);
	
	User selById(Integer id);
	
	User editById(Integer id);
	
	User selByEditUsername(@Param("id")Integer id,@Param("username")String username);
	
	User selByEditQQ(@Param("id")Integer id,@Param("qq")String qq);
	
	User selByEditEmail(@Param("id")Integer id,@Param("email")String email);

}
