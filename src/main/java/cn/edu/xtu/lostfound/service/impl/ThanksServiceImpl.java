package cn.edu.xtu.lostfound.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;

import cn.edu.xtu.lostfound.dao.ThanksDao;
import cn.edu.xtu.lostfound.entity.ThanksLetter;
import cn.edu.xtu.lostfound.service.ThanksService;

@Service
public class ThanksServiceImpl implements ThanksService {

	@Autowired
	ThanksDao thanksDao;
	
	@Override
	public int addThanks(ThanksLetter thanksLetter) {
		return thanksDao.insert(thanksLetter);
	}

	@Override
	public int showThanksNums() {
		return thanksDao.selAllNums();
	}

	@Override
	public List<ThanksLetter> showThanksInfo(int pageNum,int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return thanksDao.selAllInfo();
	}
	
	@Override
	public int searchThanksNums(ThanksLetter thanksLetter) {
		return thanksDao.selNumsByConditions(thanksLetter);
	}
	
	@Override
	public List<ThanksLetter> searchThanksInfo(int pageNum, int pageSize, ThanksLetter thanksLetter) {
		PageHelper.startPage(pageNum, pageSize);
		return thanksDao.selInfoByConditions(thanksLetter);
	}
	
	@Override
	public ThanksLetter showThanksDetail(int id) {
		return thanksDao.selInfoById(id);
	}
	
	@Override
	public int removeThanks(Integer id) {
		return thanksDao.deleteById(id);
	}
	
	@Override
	public int showMyThanksNums(Integer uId) {
		return thanksDao.selNumsByUId(uId);
	}
	
	@Override
	public List<ThanksLetter> showMyThanksInfo(int pageNum,int pageSize,Integer uId) {
		PageHelper.startPage(pageNum, pageSize);
		return thanksDao.selInfoByUId(uId);
	}

}
