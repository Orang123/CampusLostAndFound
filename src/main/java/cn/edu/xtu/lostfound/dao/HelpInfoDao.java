package cn.edu.xtu.lostfound.dao;

import java.util.List;

import cn.edu.xtu.lostfound.entity.HelpInfo;

public interface HelpInfoDao {
	
	int insert(HelpInfo helpInfo);
	
	int selAllNums();
	
	List<HelpInfo> selAllInfo();
	
	int update(HelpInfo helpInfo);
	
	int deleteById(Integer id);
	
	HelpInfo selInfoById(Integer id);
	
}
