package cn.edu.xtu.lostfound.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(value = {"handler"})
public class Reply {
	
	private Integer id;
	private String publishTime;//回复发表时间
	private String content;//回复内容
	private Integer commentId;//与该回复关联的评论id
	private User repliedUser;//被回复的用户
	private User user;//发表回复的用户
	
	public Reply() {
		super();
	}
	
	public Reply(Integer id, String publishTime, String content, Integer commentId, User repliedUser, User user) {
		super();
		this.id = id;
		this.publishTime = publishTime;
		this.content = content;
		this.commentId = commentId;
		this.repliedUser = repliedUser;
		this.user = user;
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

	public Integer getCommentId() {
		return commentId;
	}

	public void setCommentId(Integer commentId) {
		this.commentId = commentId;
	}

	public User getRepliedUser() {
		return repliedUser;
	}

	public void setRepliedUser(User repliedUser) {
		this.repliedUser = repliedUser;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Reply [id=" + id + ", publishTime=" + publishTime + ", content=" + content + ", commentId=" + commentId
				+ ", repliedUser=" + repliedUser + ", user=" + user + "]";
	}
	
}
