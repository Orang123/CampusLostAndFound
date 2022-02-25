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

import cn.edu.xtu.lostfound.entity.ThanksLetter;
import cn.edu.xtu.lostfound.service.ThanksService;
import net.sf.json.JSONObject;

@Controller
public class ThanksController {

	@Autowired
	ThanksService thanksService;
	
	@RequestMapping("/getThanksNums")
	@ResponseBody
	public String getThanksNums() {
		return String.valueOf(thanksService.showThanksNums());
	}
	
	@RequestMapping("/loadThanksData")
	@ResponseBody
	public List<ThanksLetter> loadData(@RequestParam(required = true)int pageNum,
			  							@RequestParam(required = true)int pageSize){
		List<ThanksLetter> list = thanksService.showThanksInfo(pageNum, pageSize);
		return list;
	}
	
	@RequestMapping("/searchThanksNums")
	@ResponseBody
	public String getSearchNums(ThanksLetter conditions) {//对象无法接受json的格式,只能接受&连接起来的string username=ax&password=123 这种
		return String.valueOf(thanksService.searchThanksNums(conditions));
	}
	
	@RequestMapping("/searchThanksData")
	@ResponseBody
	public List<ThanksLetter> loadSearchData(@RequestParam(required = true)int pageNum,
			  							@RequestParam(required = true)int pageSize, String conditions){
		//将conditions json字符串转化为json对象
		JSONObject json=JSONObject.fromObject(conditions);
		//将json对象转化为java对象,这里java对象中必须要有无参的构造方法才行,要不会报net.sf.json.JSONException: java.lang.NoSuchMethodException: init
		//这里ObjectMapper也可以转化
		ThanksLetter thanksLetter=(ThanksLetter)JSONObject.toBean(json, ThanksLetter.class);
		List<ThanksLetter> list = thanksService.searchThanksInfo(pageNum, pageSize, thanksLetter);
		return list;
	}
	
	@RequestMapping("/publishThanks")
	public String publishThanks(ThanksLetter thanksLetter) {
		//获取当前距1970年的相隔秒
		Date tasktime = new Date(System.currentTimeMillis());
	    // 设置日期输出的格式
	    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		thanksLetter.setPublishTime(df.format(tasktime));
		thanksService.addThanks(thanksLetter);
		return "forward:home.jsp";
	}
	
	@RequestMapping("/showThanksDetail")
	public ModelAndView showThanksDetail(int id) {
		ModelAndView modelAndView=new ModelAndView("thanksDetail");
		ThanksLetter thanksLetter=thanksService.showThanksDetail(id);
		modelAndView.addObject("thanksLetter", thanksLetter);
		return modelAndView;
	}
	
	@RequestMapping("/removeThanks")
	public void removeThanks(Integer id,PrintWriter out) {
		thanksService.removeThanks(id);
		out.write("删除成功");
	}
	
	@RequestMapping("/getMyThanksNums")
	@ResponseBody
	public String getMyThanksNums(Integer uId) {
		return String.valueOf(thanksService.showMyThanksNums(uId));
	}
	
	@RequestMapping("/loadMyThanksData")
	@ResponseBody
	public List<ThanksLetter> loadMyThanksInfo(@RequestParam(required = true)int pageNum,
				@RequestParam(required = true)int pageSize,Integer uId) {
		return thanksService.showMyThanksInfo(pageNum,pageSize,uId);
	}
	
}
