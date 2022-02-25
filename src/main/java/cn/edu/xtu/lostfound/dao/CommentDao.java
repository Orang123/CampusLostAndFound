package cn.edu.xtu.lostfound.dao;

import java.util.List;

import cn.edu.xtu.lostfound.entity.Comment;

public interface CommentDao {
	
	int insert(Comment comment);
	
	int selNumsByGoodsId(Integer goodsId);
	
	List<Comment> selInfoByGoodsId(Integer goodsId);
	
	int selNumsByConditions(Comment comment);
	
	List<Comment> selInfoByConditions(Comment comment);
	
	Comment selInfoById(Integer id);
	
	int deleteById(Integer id);
	
}
