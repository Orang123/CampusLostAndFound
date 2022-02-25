package cn.edu.xtu.lostfound.controller;

import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.edu.xtu.lostfound.entity.AnswerUser;
import cn.edu.xtu.lostfound.service.AnswerUserService;

@Controller
public class AnswerUserController {
	
	@Autowired
	private AnswerUserService answerUserService;
	
	@RequestMapping("/publishAnswer")
	public void publishAnswer(AnswerUser answerUser,PrintWriter out) {
		answerUserService.addAnsUser(answerUser);
		out.write("发起回应成功");
	}
	
	@RequestMapping("/removeAnsUser")
	public void removeAnsUser(Integer id,PrintWriter out) {
		answerUserService.removeAnsUser(id);
		out.write("移除该用户回应信息成功");
	}
	
}
