package cn.edu.xtu.lostfound.service;

import java.util.List;

import cn.edu.xtu.lostfound.entity.AnswerUser;

public interface AnswerUserService {
	
	int addAnsUser(AnswerUser answerUser);
	
	int removeAnsUser (Integer id);
	
	List<Integer> showAuIdByUsername(String username);
	
}
