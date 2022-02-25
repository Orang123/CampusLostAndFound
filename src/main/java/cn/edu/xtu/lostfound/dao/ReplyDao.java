package cn.edu.xtu.lostfound.dao;

import java.util.List;

import cn.edu.xtu.lostfound.entity.Reply;

public interface ReplyDao {
	
	int insert(Reply reply);
	
	List<Reply> selInfoByCommentId(Integer commentId);
	
	int selNumsByCommentId(Integer commentId);
	
	int deleteById(Integer id);
	
}
