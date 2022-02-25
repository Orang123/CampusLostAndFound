package cn.edu.xtu.lostfound.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
//import java.util.regex.Matcher;
//import java.util.regex.Pattern;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Constants;

import cn.edu.xtu.lostfound.entity.User;
import cn.edu.xtu.lostfound.service.UserService;
import cn.edu.xtu.lostfound.utils.ConvertHtmlToExcel;
import cn.edu.xtu.lostfound.utils.MD5Util;
import net.sf.json.JSONObject;

@Controller
public class ManagerController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/forwardGoodsInfoType")
	public ModelAndView forwardGoodsInfoType(String infoType,String url) {
		ModelAndView modelAndView=new ModelAndView("forward:admin/"+url+".jsp");
		modelAndView.addObject("infoType", infoType);
		return modelAndView;
	}
	
	@RequestMapping("/adminLogin")
	public void adminLogin(User user,String verifyCode,HttpServletResponse response,HttpSession session) throws IOException {
		PrintWriter out=response.getWriter();
		if(user.getUsername().isEmpty()) {
			out.write("您还没有输入用户名!");
			return;
		}
		if(user.getPassword().isEmpty()) {
			out.write("您还没有输入密码!");			
			return;
		}
		user.setPassword(MD5Util.getMD5String(user.getPassword()));//将明文密码加密为32位MD5码 做查找
		User res=userService.userLogin(user);
		if(res!=null) {
			if(res.getRole() == 2 ) {
				String realKaptchaCode=(String)session.getAttribute(Constants.KAPTCHA_SESSION_KEY);
				if(verifyCode.equalsIgnoreCase(realKaptchaCode)) {
					session.setAttribute("loginAdmin", res);
					out.write("登陆成功");
				}
				else
					out.write("登陆失败,验证码错误!");
			}
			else
				out.write("登陆失败,您不是管理员!");
		}
		else
			out.write("登陆失败,用户名或密码错误!");
	}
	
	@RequestMapping("/adminLogout")
	public String logOut(HttpSession session) {
		session.removeAttribute("loginAdmin");
		session.invalidate();
		return "redirect:admin/home.jsp";
	}
	
	@RequestMapping("/editPassword")
	public void editPassword(User user,String loginName,String oldPassword,String confirmPassword,HttpServletResponse response) throws IOException {
		PrintWriter out=response.getWriter();
		User tmp=new User();
		tmp.setUsername(loginName);
		tmp.setPassword(MD5Util.getMD5String(oldPassword));
		if(userService.userLogin(tmp)==null)
			out.write("原始密码错误!");
		else {
			if(user.getPassword().length()<6)
				out.write("密码不能少于6个字符!");
			else if(user.getPassword().length()>25)
				out.write("密码不能多于25个字符!");
			else {
				if(user.getPassword().equals(confirmPassword)) {
					user.setPassword(MD5Util.getMD5String(confirmPassword));
					userService.editUser(user);
					out.write("密码修改成功");
				}
				else
					out.write("两次输入密码不一致!");
			}
		}
	}
	
	@RequestMapping("/getUserNums")
	@ResponseBody
	public String getUserNums(User conditions) {//对象无法接受json的格式,只能接受&连接起来的string username=ax&password=123 这种
		return String.valueOf(userService.searchUserNums(conditions));
	}
	
	@RequestMapping("/loadUserData")
	@ResponseBody
	public List<User> loadUserData(@RequestParam(required = true)int pageNum,
				@RequestParam(required = true)int pageSize, String conditions){
		//这里好像 形参@RequestBody 后跟User对象 可以接受json字符串 且成功配对,不过我试了不行
		//ajax data那端必须用JSON.stringify()处理这边String conditions才能配对解析到
		JSONObject json=JSONObject.fromObject(conditions);//这里调用json对象生产对象,string本身也得是json格式的才行,&拼接的不行
		User user=(User)JSONObject.toBean(json, User.class);
		return userService.searchUserInfo(pageNum, pageSize, user);
	}
	
	@RequestMapping("/editUserInfo")
	public ModelAndView editUserInfo(Integer id) {
		ModelAndView modelAndView=new ModelAndView("admin/editUserInfo");
		User userInfo=userService.editUserDetail(id);
		modelAndView.addObject("userInfo", userInfo);
		return modelAndView;
	}
	
	@RequestMapping("/saveUserInfo")
	public void saveUserInfo(User user,HttpServletResponse response) throws IOException {
		PrintWriter out=response.getWriter();
		if(!user.getUsername().isEmpty()) {
			User tmp=userService.judgeEditUsername(user.getId(), user.getUsername());
			if(tmp!=null) {
				out.write("该用户名已被使用,请重新输入!");
				return;
			}
		}
		else {
			out.write("用户名不能为空,请重新填写!");
			return;
		}
		if(!user.getQq().matches("^\\d+$")) {
			out.write("QQ号码为纯数字，请重新输入!");
			return;
		}
		else if(user.getQq().length()<5) {
			out.write("QQ号码的长度小于5位，请重新输入!");
			return;
		}
		else if(user.getQq().length()>10) {
			out.write("QQ号码的长度超过10位，请重新输入!");
			return;
		}
		else {
			User tmp=userService.judgeEditQQ(user.getId(),user.getQq());
			if(tmp!=null) {
				out.write("该QQ号码已被注册!");
				return;
			}
		}
		if(user.getEmail().matches("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+\\.[a-zA-Z0-9_-]+$")) {		
			User tmp=userService.judgeEditEmail(user.getId(),user.getEmail());
			if(tmp!=null) {
				out.write("该邮箱已被注册!");
				return;
			}
		}
		else {
			out.write("邮箱格式错误!");
			return;
		}
		userService.editUser(user);
		out.write("用户信息修改成功");
	}
	
	@RequestMapping("/deleteUser")
	public void deleteUser(Integer id,PrintWriter out) {
		userService.deleteUser(id);
		out.write("删除成功");
	}
	
	@RequestMapping("/addUser")
	public void addUser(User user,PrintWriter out) {
		user.setPassword(MD5Util.getMD5String(user.getPassword()));
		userService.addUser(user);
		out.write("成功添加一条用户信息");
	}
	
	@RequestMapping("/exportExcel")
	public void exportExcel(HttpServletRequest req, HttpServletResponse resp) {
		try {
            req.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        // 设置文件的mime类型
        resp.setContentType("application/vnd.ms-excel");
        // 存储编码后的文件名
        String excelName = "name";
        // 存储文件名称
        String n = req.getParameter("excelName");
        try {
            excelName = URLEncoder.encode(n, "utf-8");
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        resp.setHeader("content-disposition", "attachment;filename=" + excelName + ".xls;filename*=utf-8''" + excelName + ".xls");
        String tableHtml = req.getParameter("tableHtml");
        // 从session中删除saveExcelMsg属性
        req.getSession().removeAttribute("saveExcelMsg");
        // 定义一个输出流
        ServletOutputStream sos = null;
        HSSFWorkbook wb = ConvertHtmlToExcel.tableExportExcel(tableHtml);
        try {
            // 保存到文件中
            sos = resp.getOutputStream();
            wb.write(sos);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sos != null) {
                try {
                    sos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
	}
	
}
