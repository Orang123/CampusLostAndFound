package cn.edu.xtu.lostfound.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;

import cn.edu.xtu.lostfound.dao.CommentDao;
import cn.edu.xtu.lostfound.entity.Comment;
import cn.edu.xtu.lostfound.service.CommentService;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDao commentDao;
	
	@Override
	public int addComment(Comment comment) {
		return commentDao.insert(comment);
	}

	@Override
	public int showCommentNums(Integer goodsId) {
		return commentDao.selNumsByGoodsId(goodsId);
	}

	@Override
	public List<Comment> showCommentInfo(Integer pageNum, Integer pageSize, Integer goodsId) {
		PageHelper.startPage(pageNum, pageSize);
		return commentDao.selInfoByGoodsId(goodsId);
	}
	
	@Override
	public int searchCommentNums(Comment comment) {
		return commentDao.selNumsByConditions(comment);
	}
	
	@Override
	public List<Comment> searchCommentInfo(Integer pageNum, Integer pageSize, Comment comment) {
		PageHelper.startPage(pageNum, pageSize);
		return commentDao.selInfoByConditions(comment);
	}
	
	@Override
	public Comment showCommentDetail(Integer id) {
		return commentDao.selInfoById(id);
	}
	
	@Override
	public int removeComment(Integer id) {
		return commentDao.deleteById(id);
	}

}
