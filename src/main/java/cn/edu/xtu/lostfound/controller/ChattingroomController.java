package cn.edu.xtu.lostfound.controller;

import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.edu.xtu.lostfound.entity.User;
import cn.edu.xtu.lostfound.service.UserService;
import cn.edu.xtu.lostfound.websocket.ChatWebSocketHandler;

@Controller
public class ChattingroomController {
	
	@Autowired//这里充分体现了Spring IOC容器 注入的优势,这样我就能确切的引用Bean中所实例化的那个实体对象
	private ChatWebSocketHandler chatWebSocketHandler;
	@Autowired
	private UserService userService;
	
	@RequestMapping("/removeChatUser")
	public void removeChatUser(Integer id,PrintWriter out) throws Exception {
		User user=new User(id,-1);
		userService.editUser(user);
		chatWebSocketHandler.removeChatUser(userService.showUserDetail(id));
		out.write("已将用户移出群聊,并列入黑名单");
	}
	
	@RequestMapping("/loadUserInfo")
	@ResponseBody
	public User loadUserRole(Integer id) {
		return userService.showUserDetail(id);
	}
	
	@RequestMapping("/setChatAdmin")
	public void setChatAdmin(Integer id,PrintWriter out) {
		User user=new User(id,1);
		userService.editUser(user);
		chatWebSocketHandler.setChatAdmin(userService.showUserDetail(id));
		out.write("已将该用户设置为群聊管理员");
	}
	
	@RequestMapping("/cancelChatAdmin")
	public void cancelChatAdmin(Integer id,PrintWriter out) {
		User user=new User(id,0);
		userService.editUser(user);
		chatWebSocketHandler.cancelChatAdmin(userService.showUserDetail(id));
		out.write("已取消该用户群聊管理员权限");
	}
	
	@RequestMapping("/forbidChat")
	public void forbidChat(User user,PrintWriter out) {
		userService.editUser(user);
		chatWebSocketHandler.forbidChat(user);
		out.write("已将该用户禁言");
	}
	
	@RequestMapping("/removeForbidChat")
	public void removeForbidChat(User user,PrintWriter out) {
		userService.editUser(user);
		chatWebSocketHandler.removeForbidChat(user);
		out.write("该用户已被解除禁言");
	}
	
	@RequestMapping("/autoRemoveForbidChat")
	public void autoRemoveForbidChat(User user,PrintWriter out) {
		userService.editUser(user);
		chatWebSocketHandler.autoRemoveForbidChat(user);
		out.write("您的禁言时间已到达期限,可正常聊天");
	}
	
}
