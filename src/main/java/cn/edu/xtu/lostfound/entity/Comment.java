package cn.edu.xtu.lostfound.entity;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(value = {"handler"})
public class Comment {
	private Integer id;
	private String publishTime;//评论发表时间
	private String content;//评论内容
	private Integer goodsId;
	private User user;//发表评论的用户
	private Integer replyNums;//该评论下发布的回复的数目 这里没有用jstl的fn标签求是因为这里是放在script标签里的ajax里,不能使用jstl标签库,浏览器无法解析
	private List<Reply> listReply;//该评论下发布的回复信息
	
	public Comment() {
		super();
	}

	public Comment(Integer id, String publishTime, String content, Integer goodsId, User user, Integer replyNums,
			List<Reply> listReply) {
		super();
		this.id = id;
		this.publishTime = publishTime;
		this.content = content;
		this.goodsId = goodsId;
		this.user = user;
		this.replyNums = replyNums;
		this.listReply = listReply;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Integer getReplyNums() {
		return replyNums;
	}

	public void setReplyNums(Integer replyNums) {
		this.replyNums = replyNums;
	}

	public List<Reply> getListReply() {
		return listReply;
	}

	public void setListReply(List<Reply> listReply) {
		this.listReply = listReply;
	}

	@Override
	public String toString() {
		return "Comment [id=" + id + ", publishTime=" + publishTime + ", content=" + content + ", goodsId=" + goodsId
				+ ", user=" + user + ", replyNums=" + replyNums + ", listReply=" + listReply + "]";
	}
	
}
