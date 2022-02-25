package cn.edu.xtu.lostfound.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(value = {"handler"})
public class HelpInfo {
	
	private Integer id;
	private String title;
	private String publishTime;
	private String content;
	private User user;
	
	public HelpInfo() {
		super();
	}

	public HelpInfo(Integer id, String title, String publishTime, String content, User user) {
		super();
		this.id = id;
		this.title = title;
		this.publishTime = publishTime;
		this.content = content;
		this.user = user;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "HelpInfo [id=" + id + ", title=" + title + ", publishTime=" + publishTime + ", content=" + content
				+ ", user=" + user + "]";
	}
	
}
