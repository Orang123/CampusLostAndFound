package cn.edu.xtu.lostfound.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
//使用了mybatis级联查询，配置了懒加载模式,需要配置下述注解作用是json序列化时忽略bean中的一些属性序列化和反序列化时抛出的异常.
@JsonIgnoreProperties(value = {"handler"})
public class ThanksLetter {
	
	private Integer id;
	private String publishTime;
	private String title;
	private String content;
	private User user;
	
	public ThanksLetter() {
		super();
	}

	public ThanksLetter(Integer id, String publishTime, String title, String content, User user) {
		super();
		this.id = id;
		this.publishTime = publishTime;
		this.title = title;
		this.content = content;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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
		return "ThanksLetter [id=" + id + ", publishTime=" + publishTime + ", title=" + title + ", content=" + content
				+ ", user=" + user + "]";
	}
	
}
