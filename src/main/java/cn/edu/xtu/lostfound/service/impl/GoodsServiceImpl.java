package cn.edu.xtu.lostfound.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;

import cn.edu.xtu.lostfound.dao.GoodsDao;
import cn.edu.xtu.lostfound.entity.Goods;
import cn.edu.xtu.lostfound.service.GoodsService;

@Service
public class GoodsServiceImpl implements GoodsService {
	@Autowired
	private GoodsDao goodsDao;
	
	@Override
	public int showGoodsNums(String infoType,Integer state) {
		return goodsDao.selAllNums(infoType,state);
	}

	@Override
	public List<Goods> showGoodsInfo(int pageNum,int pageSize,String infoType,Integer state) {
		PageHelper.startPage(pageNum, pageSize);
		return goodsDao.selAllInfo(infoType,state);
	}

	@Override
	public int addGoods(Goods goods) {
		return goodsDao.insert(goods);
	}
	
	@Override
	public int searchGoodsNums(Goods goods) {
		return goodsDao.selNumsByConditions(goods);
	}

	@Override
	public List<Goods> searchGoodsInfo(int pageNum,int pageSize,Goods goods) {
		PageHelper.startPage(pageNum, pageSize);
		return goodsDao.selInfoByConditions(goods);
	}

	@Override
	public Goods showGoodsDetail(Integer id) {
		return goodsDao.selInfoById(id);
	}

	@Override
	public int changeGoodsState(Integer state, Integer id,Integer auId) {
		return goodsDao.updateStateById(state, id, auId);
	}
	
	@Override
	public int removeGoods(Integer id) {
		return goodsDao.deleteById(id);
	}
	
	@Override
	public int showFinishedGoodsNums(String infoType,List<Integer> list) {
		return goodsDao.selNumsByAuId(infoType,list);
	}
	
	@Override
	public List<Goods> showFinishedGoodsInfo(int pageNum,int pageSize,String infoType,List<Integer> list) {
		PageHelper.startPage(pageNum, pageSize);
		return goodsDao.selInfoByAuId(infoType,list);
	}
	
}
