package cn.edu.xtu.lostfound.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.xtu.lostfound.dao.AnswerUserDao;
import cn.edu.xtu.lostfound.entity.AnswerUser;
import cn.edu.xtu.lostfound.service.AnswerUserService;

@Service
public class AnswerUserServiceImpl implements AnswerUserService {
	
	@Autowired
	private AnswerUserDao answerUserDao;
	
	@Override
	public int addAnsUser(AnswerUser answerUser) {
		return answerUserDao.insert(answerUser);
	}

	@Override
	public int removeAnsUser(Integer id) {
		return answerUserDao.deleteById(id);
	}
	
	@Override
	public List<Integer> showAuIdByUsername(String username) {
		return answerUserDao.selInfoByUsername(username);
	}

}
