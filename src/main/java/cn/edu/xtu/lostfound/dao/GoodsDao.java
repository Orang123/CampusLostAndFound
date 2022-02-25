package cn.edu.xtu.lostfound.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.edu.xtu.lostfound.entity.Goods;

public interface GoodsDao {
	
	int selAllNums(@Param("infoType")String infoType,@Param("state")Integer state);
	
	List<Goods> selAllInfo(@Param("infoType")String infoType,@Param("state")Integer state);
	
	int insert(Goods goods);
	
	int selNumsByConditions(Goods goods);
	
	List<Goods> selInfoByConditions(Goods goods);
	
	Goods selInfoById(Integer id);
	
	int updateStateById(@Param("state")Integer state,@Param("id")Integer id,@Param("auid")Integer auid);
	
	int deleteById(Integer id);
	
	int selNumsByAuId(@Param("infoType")String infoType,@Param("list")List<Integer> list);
	
	List<Goods> selInfoByAuId(@Param("infoType")String infoType,@Param("list")List<Integer> list);
	
}
