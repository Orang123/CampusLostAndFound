package cn.edu.xtu.lostfound.service;

import java.util.List;

import cn.edu.xtu.lostfound.entity.Goods;

public interface GoodsService {
	
	int showGoodsNums(String infoType,Integer state);
	
	List<Goods> showGoodsInfo(int pageNum,int pageSize,String infoType,Integer state);
	
	int addGoods(Goods goods);
	
	int searchGoodsNums(Goods goods);
	
	List<Goods> searchGoodsInfo(int pageNum,int pageSize,Goods goods);
	
	Goods showGoodsDetail(Integer id);
	
	int changeGoodsState(Integer state,Integer id,Integer auId);
	
	int removeGoods(Integer id);
	
	int showFinishedGoodsNums(String infoType,List<Integer> list);
	
	List<Goods> showFinishedGoodsInfo(int pageNum,int pageSize,String infoType,List<Integer> list);
	
}
