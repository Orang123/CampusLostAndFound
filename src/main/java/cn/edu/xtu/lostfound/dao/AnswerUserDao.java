package cn.edu.xtu.lostfound.dao;

import java.util.List;

import cn.edu.xtu.lostfound.entity.AnswerUser;

public interface AnswerUserDao {
	
	AnswerUserDao selInfoById(Integer id);
	
	List<AnswerUser> selInfoByGoodsId(Integer goodsId);
	
	int insert(AnswerUser answerUser);
	
	int deleteById(Integer id);
	
	List<Integer> selInfoByUsername(String username);
}
