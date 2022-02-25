package cn.edu.xtu.lostfound.entity;

//发现用户或认领用户
public class AnswerUser {
	
	private Integer id;
	private String username;
	private String qq;
	private String email;
	private Integer goodsId;
	
	public AnswerUser() {
		super();
	}
	
	public AnswerUser(Integer id, String username, String qq, String email, Integer goodsId) {
		super();
		this.id = id;
		this.username = username;
		this.qq = qq;
		this.email = email;
		this.goodsId = goodsId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	@Override
	public String toString() {
		return "AnswerUser [id=" + id + ", username=" + username + ", qq=" + qq + ", email=" + email + ", goodsId="
				+ goodsId + "]";
	}
	
}
