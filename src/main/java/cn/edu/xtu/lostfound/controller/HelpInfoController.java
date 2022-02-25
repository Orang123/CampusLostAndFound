package cn.edu.xtu.lostfound.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;

//import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.edu.xtu.lostfound.entity.HelpInfo;
import cn.edu.xtu.lostfound.service.HelpInfoService;

@Controller
public class HelpInfoController {
	
	@Autowired
	private HelpInfoService helpInfoService;
	
	@RequestMapping("/forwardHelpPage")
	public ModelAndView forwardHelpPage(String divClass){
		//request.setAttribute("divClass", divClass);
		ModelAndView modelAndView = new ModelAndView("forward:helpCenter.jsp");
		modelAndView.addObject("divClass", divClass);
		return modelAndView;
		//return "forward:helpCenter.jsp";
	}
	
	@RequestMapping("/publishHelpInfo")
	public void publishHelpInfo(HelpInfo helpInfo,PrintWriter out) {
		Date tasktime = new Date(System.currentTimeMillis());
	    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    helpInfo.setPublishTime(df.format(tasktime));
		helpInfoService.addHelpInfo(helpInfo);
		out.write("成功添加一条帮助信息");
		//这里用forward会使得 页面加载不出来数据和css信息,这是因为之前的页面本身就在admin下超链接也在admin下,而现在的转发是从admin/admin/showHelpInfoList.jsp,admin之前的那个根目录转发的,改为redirect就好了
	}
	
	@RequestMapping("/getHelpInfoNums")
	@ResponseBody
	public String getHelpInfoNums() {
		return String.valueOf(helpInfoService.showHelpNums());
	}
	
	@RequestMapping("/loadHelpInfoData")
	@ResponseBody
	public List<HelpInfo> loadHelpInfoData(){
		return helpInfoService.showHelpInfo();
	}
	
	@RequestMapping("/editHelpInfo")
	public ModelAndView editHelpInfo(Integer id) {
		ModelAndView modelAndView=new ModelAndView("admin/editHelpInfo");
		HelpInfo helpInfo=helpInfoService.showHelpInfoDetail(id);
		modelAndView.addObject("helpInfo", helpInfo);
		return modelAndView;
	}
	
	@RequestMapping("/saveHelpInfo")
	public void saveHelpInfo(HelpInfo helpInfo,PrintWriter out) {
		helpInfoService.editHelpInfo(helpInfo);
		out.write("帮助信息修改成功");
	}
	
	@RequestMapping("/removeHelpInfo")
	public void removeHelpInfo(Integer id,PrintWriter out) {
		helpInfoService.removeHelpInfo(id);
		//out.print("<script language='javascript'>alert('成功删除一条帮助信息');</script>"); springmvc里把这种原生态的拼接代码的方式 屏蔽了可能,js脚本失效
		out.write("删除成功");
		//这里用forward会使得 页面加载不出来数据和css信息,这是因为之前的页面本身就在admin下超链接也在admin下,而现在的转发是从admin/admin/showHelpInfoList.jsp,admin之前的那个根目录转发的,改为redirect就好了
	}
	
}
