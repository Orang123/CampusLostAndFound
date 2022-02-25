package cn.edu.xtu.lostfound.service;

import java.util.List;

import cn.edu.xtu.lostfound.entity.Comment;

public interface CommentService {
	
	int addComment(Comment comment);
	
	int showCommentNums(Integer goodsId);
	
	List<Comment> showCommentInfo(Integer pageNum,Integer pageSize,Integer goodsId);
	
	int searchCommentNums(Comment comment);
	
	List<Comment> searchCommentInfo(Integer pageNum,Integer pageSize,Comment comment);
	
	Comment showCommentDetail(Integer id);
	
	int removeComment(Integer id);
	
}
