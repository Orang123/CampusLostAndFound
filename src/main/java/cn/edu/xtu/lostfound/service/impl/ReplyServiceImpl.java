package cn.edu.xtu.lostfound.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.xtu.lostfound.dao.ReplyDao;
import cn.edu.xtu.lostfound.entity.Reply;
import cn.edu.xtu.lostfound.service.ReplyService;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyDao replyDao;
	
	@Override
	public int addReply(Reply reply) {
		return replyDao.insert(reply);
	}
	
	@Override
	public int removeReply(Integer id) {
		return replyDao.deleteById(id);
	}

}
