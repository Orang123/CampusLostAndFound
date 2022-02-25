package cn.edu.xtu.lostfound.entity;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

//import java.util.List;

//import java.util.Date;

//import org.springframework.format.annotation.DateTimeFormat;
@JsonIgnoreProperties(value = {"handler"})
public class Goods {
	
	//这里最好不要出现基本类型,因为如果这个参数在前端不传递到后端,按照默认""会报400 参数匹配异常错误
	private Integer id;//主键id
	private String infoType;//失物或招领信息
	private String title;//标题
	private String publishTime;//发布时间
	private String goodsName;//物品名称
	private String goodsType;//物品种类
	private String happenPlace;//丢失或发现地点
//	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private String happenTime;//丢失或发现时间
	private String imgUrl;//丢失或发现物品图片路径
	private Integer state;//0-发布 1-找到/认领
	private User user;//发布用户
	private AnswerUser answerUser;//发现用户或认领用户
	private List<AnswerUser> listAUser;//参与认领该物品发布信息的用户 之所以新建answer_user表是因为 这样一个人便可参与认领多条信息,否则user表主键的唯一性只能参与一条信息的认领,况且对user表本身的字段结构也有影响
	//private List<Comment> comment;//该公告信息的评论 不用list是因为这样分页的时候很繁琐
	
	public Goods() {
		super();
	}

	public Goods(Integer id, String infoType, String title, String publishTime, String goodsName, String goodsType,
			String happenPlace, String happenTime, String imgUrl, Integer state, User user, AnswerUser answerUser,
			List<AnswerUser> listAUser) {
		super();
		this.id = id;
		this.infoType = infoType;
		this.title = title;
		this.publishTime = publishTime;
		this.goodsName = goodsName;
		this.goodsType = goodsType;
		this.happenPlace = happenPlace;
		this.happenTime = happenTime;
		this.imgUrl = imgUrl;
		this.state = state;
		this.user = user;
		this.answerUser = answerUser;
		this.listAUser = listAUser;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getInfoType() {
		return infoType;
	}

	public void setInfoType(String infoType) {
		this.infoType = infoType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getGoodsType() {
		return goodsType;
	}

	public void setGoodsType(String goodsType) {
		this.goodsType = goodsType;
	}

	public String getHappenPlace() {
		return happenPlace;
	}

	public void setHappenPlace(String happenPlace) {
		this.happenPlace = happenPlace;
	}

	public String getHappenTime() {
		return happenTime;
	}

	public void setHappenTime(String happenTime) {
		this.happenTime = happenTime;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public AnswerUser getAnswerUser() {
		return answerUser;
	}

	public void setAnswerUser(AnswerUser answerUser) {
		this.answerUser = answerUser;
	}
	
	public List<AnswerUser> getListAUser() {
		return listAUser;
	}

	public void setListAuser(List<AnswerUser> listAUser) {
		this.listAUser = listAUser;
	}

	@Override
	public String toString() {
		return "Goods [id=" + id + ", infoType=" + infoType + ", title=" + title + ", publishTime=" + publishTime
				+ ", goodsName=" + goodsName + ", goodsType=" + goodsType + ", happenPlace=" + happenPlace
				+ ", happenTime=" + happenTime + ", imgUrl=" + imgUrl + ", state=" + state + ", user=" + user
				+ ", answerUser=" + answerUser + ", listAUser=" + listAUser + "]";
	}

}
