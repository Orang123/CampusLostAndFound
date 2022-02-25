package cn.edu.xtu.lostfound.service;

import java.util.List;

import cn.edu.xtu.lostfound.entity.HelpInfo;

public interface HelpInfoService {
	
	int addHelpInfo(HelpInfo helpInfo);
	
	int showHelpNums();
	
	List<HelpInfo> showHelpInfo();
	
	HelpInfo showHelpInfoDetail(Integer id);
	
	int editHelpInfo(HelpInfo helpInfo);
	
	int removeHelpInfo(Integer id);
	
}
