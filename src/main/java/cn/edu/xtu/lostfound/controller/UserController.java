package cn.edu.xtu.lostfound.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;

import cn.edu.xtu.lostfound.entity.User;
import cn.edu.xtu.lostfound.service.UserService;
import cn.edu.xtu.lostfound.utils.MD5Util;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
	private Producer captchaProducer;
	
	@RequestMapping("/userLogin")
	public void userLogin(User user,String verifyCode,HttpServletResponse response,HttpSession session) throws IOException {
		PrintWriter out=response.getWriter();
		if(user.getUsername().isEmpty()) {
			out.write("您还没有输入用户名!");
			return;
		}
		if(user.getPassword().isEmpty()) {
			out.write("您还没有输入密码!");			
			return;
		}
		if(verifyCode.isEmpty()) {
			out.write("您还没有输入验证码!");
			return;
		}
		user.setPassword(MD5Util.getMD5String(user.getPassword()));
		User res=userService.userLogin(user);
		if(res!=null) {
			String realKaptchaCode=(String)session.getAttribute(Constants.KAPTCHA_SESSION_KEY);
			if(verifyCode.equalsIgnoreCase(realKaptchaCode)) {
				session.setAttribute("loginUser", res);//这里是设置res而不是user
				out.write("登陆成功");				
			}
			else
				out.write("登陆失败,验证码错误!");
		}
		else 
			out.write("登陆失败,用户名或密码错误!");
	}
	
	@RequestMapping("/userLogout")
	public String logOut(HttpSession session) {
		session.removeAttribute("loginUser");
		session.invalidate();
		return "redirect:home.jsp";
	}
	
	@RequestMapping("/usernameJudge")
	public void usernameJudge(String username,HttpServletResponse response) throws IOException {
		PrintWriter out=response.getWriter();
		if(!username.isEmpty()) {
			User user=userService.judgeUsername(username);
			if(user!=null)
				out.write("该用户名已被使用,请重新输入!");
			else
				out.write("该用户名可正常使用");
		}
		else
			out.write("用户名不能为空,请重新填写!");
	}
	
	@RequestMapping("/passwordJudge")
	public void passwordJudge(String password,PrintWriter out) {
		if(password.length()<6)
			out.write("密码不能少于6个字符!");
		else if(password.length()>25)
			out.write("密码不能多于25个字符!");
		else
			out.write("密码符合要求");
	}
	
	@RequestMapping("/qqJudge")
	public void qqJudge(String qq,PrintWriter out) {
		if(!qq.matches("^\\d+$"))
			out.write("QQ号码为纯数字，请重新输入!");
		else if(qq.length()<5)
			out.write("QQ号码的长度小于5位，请重新输入!");
		else if(qq.length()>10)
			out.write("QQ号码的长度超过10位，请重新输入!");
		else {
			User user=userService.judgeQQ(qq);
			if(user!=null)
				out.write("该QQ号码已被注册!");
			else
				out.write("QQ号码格式符合标准");
		}
	}
	
	@RequestMapping("/emailJudge")
	public void emailJudge(String email,PrintWriter out) {
		//另一种写法
		//Pattern pattern=Pattern.compile("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+\\.[a-zA-Z0-9_-]+$");
		//Matcher matcher=pattern.matcher(email);
		//matcher.matches()
		if(email.matches("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+\\.[a-zA-Z0-9_-]+$")) {		
			User user=userService.judgeEmail(email);
			if(user!=null)
				out.write("该邮箱已被注册!");
			else
				out.write("邮箱格式正确");
		}
		else
			out.write("邮箱格式错误!");
	}
	
	@RequestMapping("/verifyCode")
	public void verifyCode(String verifyCode,HttpSession session,PrintWriter out) {
		String realKaptchaCode=(String)session.getAttribute(Constants.KAPTCHA_SESSION_KEY);
		if(verifyCode.equalsIgnoreCase(realKaptchaCode)) 
			out.write("输入验证码正确");
		else
			out.write("输入验证码错误!");
	}
	
	@RequestMapping("/userRegister")
	public String userRegister(User user) {
		user.setPassword(MD5Util.getMD5String(user.getPassword()));
		userService.userRegister(user);
		return "redirect:home.jsp";
	}
	
	@RequestMapping("/kaptchaCode")
	public void getKaptchaCode(HttpServletRequest request,HttpServletResponse response) throws IOException {
		response.setDateHeader("Expires", 0);
		// Set standard HTTP/1.1 no-cache headers.
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		// Set IE extended HTTP/1.1 no-cache headers (use addHeader).
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		// Set standard HTTP/1.0 no-cache header.
		response.setHeader("Pragma", "no-cache");
		// return a jpeg
		response.setContentType("image/jpeg");
		// create the text for the image
		String capText=captchaProducer.createText();
		// store the text in the session ,把验证码的值存在session中
		request.getSession().setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);
		// create the image with the text
		BufferedImage image=captchaProducer.createImage(capText);
		ServletOutputStream out=response.getOutputStream();
		// write the data out
		ImageIO.write(image, "jpg", out);
		try {
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			out.close();
		}
	}
	
}
