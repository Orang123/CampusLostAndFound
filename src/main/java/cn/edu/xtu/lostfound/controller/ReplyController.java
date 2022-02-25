package cn.edu.xtu.lostfound.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.edu.xtu.lostfound.entity.Reply;
import cn.edu.xtu.lostfound.service.ReplyService;

@Controller
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping("/publishReply")
	public void publishReply(Reply reply,PrintWriter out) {
		Date tasktime = new Date(System.currentTimeMillis());
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		reply.setPublishTime(df.format(tasktime));
		replyService.addReply(reply);
		out.write("发表回复成功");
	}
	
	@RequestMapping("/removeReply")
	public void removeReply(Integer id,PrintWriter out) {
		replyService.removeReply(id);
		out.write("成功删除一条回复");
	}
	
}
