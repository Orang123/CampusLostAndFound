package cn.edu.xtu.lostfound.service;

import cn.edu.xtu.lostfound.entity.Reply;

public interface ReplyService {
	
	int addReply(Reply reply);
	
	int removeReply(Integer id);
	
}
