package cn.edu.xtu.lostfound.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.edu.xtu.lostfound.entity.Comment;
import cn.edu.xtu.lostfound.entity.Goods;
import cn.edu.xtu.lostfound.service.CommentService;
import cn.edu.xtu.lostfound.service.GoodsService;
import net.sf.json.JSONObject;

@Controller
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	@Autowired
	private GoodsService goodsService;
	
	@RequestMapping("/publishComment")
	public void publishComment(Comment comment,PrintWriter out) {
		//获取当前距1970年的相隔秒
		Date tasktime = new Date(System.currentTimeMillis());
		// 设置日期输出的格式
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		comment.setPublishTime(df.format(tasktime));
		commentService.addComment(comment);
		out.write("发布成功");
	}
	
	@RequestMapping("/getCommentsNums")
	@ResponseBody
	public String getCommentsNums(Integer goodsId) {
		return String.valueOf(commentService.showCommentNums(goodsId));
	}
	
	@RequestMapping("/loadCommentsData")
	@ResponseBody
	public List<Comment> loadCommentsData(@RequestParam(required = true)int pageNum,
			@RequestParam(required = true)int pageSize,Integer goodsId){
		return commentService.showCommentInfo(pageNum, pageSize, goodsId);
	}
	
	@RequestMapping("/searchCommentsNums")
	@ResponseBody
	public String getSearchNums(Comment conditions) {
		return String.valueOf(commentService.searchCommentNums(conditions));
	}
	
	@RequestMapping("/searchCommentsData")
	@ResponseBody
	public List<Comment> loadSearchData(@RequestParam(required = true)int pageNum,
			  							@RequestParam(required = true)int pageSize, String conditions){
		JSONObject json=JSONObject.fromObject(conditions);
		Comment comment=(Comment)JSONObject.toBean(json, Comment.class);
		List<Comment> list = commentService.searchCommentInfo(pageNum, pageSize, comment);
		return list;
	}
	
	@RequestMapping("/showCommentDetail")
	public ModelAndView showCommentDetail(Integer commentId,Integer goodsId) {
		ModelAndView modelAndView=new ModelAndView("admin/commentDetail");
		Comment comment=commentService.showCommentDetail(commentId);
		Goods goods=goodsService.showGoodsDetail(goodsId);
		modelAndView.addObject("comment", comment);
		modelAndView.addObject("goods", goods);
		return modelAndView;
	}
	
	@RequestMapping("/removeComment")
	public void removeComment(Integer id,PrintWriter out) {
		commentService.removeComment(id);
		out.write("成功删除一条评论");
	}
	
}
