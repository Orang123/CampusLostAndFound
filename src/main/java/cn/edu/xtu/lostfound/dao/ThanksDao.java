package cn.edu.xtu.lostfound.dao;

import java.util.List;

import cn.edu.xtu.lostfound.entity.ThanksLetter;

public interface ThanksDao {
	
	int insert(ThanksLetter thanksLetter);
	
	int selAllNums();
	
	List<ThanksLetter> selAllInfo();
	
	int selNumsByConditions(ThanksLetter thanksLetter);
	
	List<ThanksLetter> selInfoByConditions(ThanksLetter thanksLetter);
	
	ThanksLetter selInfoById(int id);
	
	int deleteById(Integer id);
	
	int selNumsByUId(Integer uId);
	
	List<ThanksLetter> selInfoByUId(Integer uId);
	
}
