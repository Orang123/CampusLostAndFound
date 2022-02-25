package cn.edu.xtu.lostfound.entity;

public class User implements Comparable<User>{
	
	private Integer id;
	private String username;
	private String password;
	private String qq;
	private String email;
	private Integer role;//-1表示黑名单用户(拒绝连接、发布信息),0表示普通用户,1表示群聊管理员,2表示后台管理员
	private Long startTime;//禁言开始时间 这里时间都是距离1970年的毫秒数 数据库字段默认-1代表正常发言
	private Long forbidTalkDuration;//禁言时长
	
	public User() {
		super();
	}
	
	
	public User(Integer id, Integer role) {
		super();
		this.id = id;
		this.role = role;
	}

	public User(Integer id, String username, String password, String qq, String email, Integer role, Long startTime,
			Long forbidTalkDuration) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.qq = qq;
		this.email = email;
		this.role = role;
		this.startTime = startTime;
		this.forbidTalkDuration = forbidTalkDuration;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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

	public Integer getRole() {
		return role;
	}

	public void setRole(Integer role) {
		this.role = role;
	}
	
	public Long getStartTime() {
		return startTime;
	}

	public void setStartTime(Long startTime) {
		this.startTime = startTime;
	}

	public Long getForbidTalkDuration() {
		return forbidTalkDuration;
	}

	public void setForbidTalkDuration(Long forbidTalkDuration) {
		this.forbidTalkDuration = forbidTalkDuration;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", qq=" + qq + ", email="
				+ email + ", role=" + role + ", startTime=" + startTime + ", forbidTalkDuration=" + forbidTalkDuration
				+ "]";
	}
	
	@Override
	public int compareTo(User o) {
		return o.getRole()-this.role;//按照用户的权限降序排列,权限越大的越靠前,升序对调相减顺序
	}
	
}
