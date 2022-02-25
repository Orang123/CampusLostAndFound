package cn.edu.xtu.lostfound.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
//import java.util.HashMap;
import java.util.List;
//import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

//import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import cn.edu.xtu.lostfound.entity.Goods;
import cn.edu.xtu.lostfound.service.AnswerUserService;
import cn.edu.xtu.lostfound.service.GoodsService;
import net.sf.json.JSONObject;

@Controller
public class GoodsController {
	
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private AnswerUserService answerUserService;
	
	@RequestMapping("/setGoodsInfoType")
	public ModelAndView setGoodsInfoType(String infoType,String url) {
		ModelAndView modelAndView=new ModelAndView(url);
		modelAndView.addObject("infoType", infoType);
		return modelAndView;
	}
	
	@RequestMapping("/publishGoods")
	public String publishGoods(Goods goods) {
		//获取当前距1970年的相隔秒
		Date tasktime = new Date(System.currentTimeMillis());
	    // 设置日期输出的格式
	    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    goods.setPublishTime(df.format(tasktime));
		goodsService.addGoods(goods);
		return "forward:home.jsp";
	}
	
	@RequestMapping("/uploadFile")
	@ResponseBody
	public String uploadFile(HttpServletRequest req,MultipartFile uploadFile,Integer flag) throws JsonProcessingException {
		String originalFilename = uploadFile.getOriginalFilename();
		String realPath;
		if(flag == null)
			realPath = req.getServletContext().getRealPath("resources/upload_goods_pic");
		else
			realPath = req.getServletContext().getRealPath("resources/upload_files");
		if(uploadFile!=null && originalFilename!=null && realPath!=null) {
			String newFileName=UUID.randomUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
//			System.out.println(realPath);
			try {
				uploadFile.transferTo(new File(realPath+"/"+newFileName));
				//在项目的本地路径下再保存一份备份,以防移除tomcat服务器时项目上传资源丢失,但是这里第二次用这个transferTo方法会报错"File has already been moved - cannot be transferred again"
				//原因是因为http post文件流只可以接收读取一次，传输完毕则关闭流.
				//uploadFile.transferTo(new File("D:/eclipse/2019-09_workspace/CampusLostAndFound/src/main/webapp/resources/upload_files"+"/"+newFileName));
				//FileUtils.copyFile(new File(realPath+"/"+newFileName), new File("D:/eclipse/2019-09_workspace/CampusLostAndFound/src/main/webapp/resources/upload_files"+"/"+newFileName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			//会在原先的字符串上前后多加双引号,转化为json格式
			return new ObjectMapper().writeValueAsString(newFileName);//这里可以采用out.write()的方式的,但bootstrap input插件默认只能json传递
		}
		return "上传失败";
	}
	
	@RequestMapping("/searchGoodsTitle")
	public ModelAndView searchGoodsTitle(String title,String state) {
		ModelAndView modelAndView=new ModelAndView("searchGoodsTitle");
		modelAndView.addObject("title", title);
		modelAndView.addObject("state", state);
		return modelAndView;
	}
	
	@RequestMapping("/getSearchNums")
	@ResponseBody
	public String getSearchNums(Goods conditions) {
		//对象无法接受json的格式,只能接受&连接起来的string username=ax&password=123 这种
		return String.valueOf(goodsService.searchGoodsNums(conditions));
	}
	
	@RequestMapping("/loadSearchData")
	@ResponseBody
	public List<Goods> loadSearchData(@RequestParam(required = true)int pageNum,
			  							@RequestParam(required = true)int pageSize, String conditions){
		//将conditions json字符串转化为json对象
		JSONObject json=JSONObject.fromObject(conditions);
		//将json对象转化为java对象,这里java对象中必须要有无参的构造方法才行,要不会报net.sf.json.JSONException: java.lang.NoSuchMethodException: init
		//这里ObjectMapper也可以转化
		Goods goods=(Goods)JSONObject.toBean(json, Goods.class);
		List<Goods> list = goodsService.searchGoodsInfo(pageNum, pageSize, goods);
		return list;
	}
	
	@RequestMapping("/showGoodsDetail")
	public ModelAndView showGoodsDetail(Integer id,String infoType) {
		ModelAndView modelAndView=new ModelAndView("goodsDetail");
		Goods lostGoods=goodsService.showGoodsDetail(id);
		modelAndView.addObject("goods", lostGoods);
		modelAndView.addObject("infoType", infoType);
		return modelAndView;
	}
	
	@RequestMapping("/changeGoodsState")
	public void changeGoodsState(Integer state, Integer id,Integer auid,PrintWriter out) {
		goodsService.changeGoodsState(state, id, auid);
		out.write("物品状态已改变");
	}
	
	@RequestMapping("/getGoodsNums")
	@ResponseBody
	public String getGoodsNums(String infoType,Integer state) {
		return String.valueOf(goodsService.showGoodsNums(infoType,state));
	}
	
	@RequestMapping("/loadGoodsData")
	@ResponseBody
	public List<Goods> loadGoodsData(@RequestParam(required = true)int pageNum,
			@RequestParam(required = true)int pageSize,String infoType,Integer state){
		return goodsService.showGoodsInfo(pageNum, pageSize,infoType,state);
	}
	
	@RequestMapping("/removeGoods")
	public void removeGoods(Integer id,PrintWriter out) {
		goodsService.removeGoods(id);
		out.write("删除成功");
	}
	
	@RequestMapping("/getFinishedGoodsNums")
	@ResponseBody
	public String getFinishedGoodsNums(String infoType,String username) {
		List<Integer> list=answerUserService.showAuIdByUsername(username);
		if(list.size()== 0) return "0";//如果list里什么都没有 即list=[]则不进行select from where id in list的查找会出错
		return String.valueOf(goodsService.showFinishedGoodsNums(infoType,list));
	}
	
	@RequestMapping("/loadFinishedGoodsData")
	@ResponseBody
	public List<Goods> loadFinishedGoodsData(@RequestParam(required = true)int pageNum,
			@RequestParam(required = true)int pageSize,String infoType,String username) {
		List<Integer> list=answerUserService.showAuIdByUsername(username);
		return goodsService.showFinishedGoodsInfo(pageNum,pageSize,infoType,list);
	}
	
}
