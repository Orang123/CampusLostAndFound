package cn.edu.xtu.lostfound.entity;

/**
 * 
 * @author Orang
 *
 */
public class Message {
	
	private Integer type;//-1代表上线提示,0代表设立或取消群聊管理员内容,1代表聊天内容
	private String senderName;
	private String content;
	private String date;
	private Integer loadUserId;//-1 代表聊天页面无需再次加载用户信息,正数代表 对管理员权利以及 禁言操作时需要重新加载用户信息
	
	public Message() {
		super();
	}

	public Message(Integer type, String senderName, String content, String date, Integer loadUserId) {
		super();
		this.type = type;
		this.senderName = senderName;
		this.content = content;
		this.date = date;
		this.loadUserId = loadUserId;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	public Integer getLoadUserId() {
		return loadUserId;
	}

	public void setLoadUserId(Integer loadUserId) {
		this.loadUserId = loadUserId;
	}

	@Override
	public String toString() {
		return "Message [type=" + type + ", senderName=" + senderName + ", content=" + content + ", date=" + date
				+ ", loadUserId=" + loadUserId + "]";
	}
	
}
