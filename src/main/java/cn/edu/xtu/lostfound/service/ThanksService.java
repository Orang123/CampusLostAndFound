package cn.edu.xtu.lostfound.service;

import java.util.List;

import cn.edu.xtu.lostfound.entity.ThanksLetter;

public interface ThanksService {

	int addThanks(ThanksLetter thanksLetter);
	
	int showThanksNums();
	
	List<ThanksLetter> showThanksInfo(int pageNum,int pageSize);
	
	int searchThanksNums(ThanksLetter thanksLetter);
	
	List<ThanksLetter> searchThanksInfo(int pageNum,int pageSize,ThanksLetter thanksLetter);
	
	ThanksLetter showThanksDetail(int id);
	
	int removeThanks(Integer id);
	
	int showMyThanksNums(Integer uId);
	
	List<ThanksLetter> showMyThanksInfo(int pageNum,int pageSize,Integer uId);
	
}
