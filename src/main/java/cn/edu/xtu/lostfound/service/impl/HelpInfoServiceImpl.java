package cn.edu.xtu.lostfound.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.xtu.lostfound.dao.HelpInfoDao;
import cn.edu.xtu.lostfound.entity.HelpInfo;
import cn.edu.xtu.lostfound.service.HelpInfoService;

@Service
public class HelpInfoServiceImpl implements HelpInfoService{
	
	@Autowired
	private HelpInfoDao helpInfoDao;

	@Override
	public int addHelpInfo(HelpInfo helpInfo) {
		return helpInfoDao.insert(helpInfo);
	}
	
	@Override
	public int showHelpNums() {
		return helpInfoDao.selAllNums();
	}

	@Override
	public List<HelpInfo> showHelpInfo() {
		return helpInfoDao.selAllInfo();
	}
	
	@Override
	public HelpInfo showHelpInfoDetail(Integer id) {
		return helpInfoDao.selInfoById(id);
	}
	
	@Override
	public int editHelpInfo(HelpInfo helpInfo) {
		return helpInfoDao.update(helpInfo);
	}
	
	@Override
	public int removeHelpInfo(Integer id) {
		return helpInfoDao.deleteById(id);
	}
	
}
