package cn.edu.xtu.lostfound.websocket;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import org.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import cn.edu.xtu.lostfound.entity.Message;
import cn.edu.xtu.lostfound.entity.User;

/**
 * socket处理器
 * @author Orang
 *
 */
@Component
//也可extends AbstractWebSocketHandler实现,覆盖的方法更多些
public class ChatWebSocketHandler implements WebSocketHandler {
	//key:user.id value:WebSocketSession
	private static final Map<Integer, WebSocketSession> userSocketSessionMap;
	private static final Map<Integer, User> onlineUsers;
	private static final Map<String, Object> sendData;
	private static List<User> sortUsersList;
	
	static {//ConcurrentHashMap是在满足HashTable的线程安全的条件下对其的改进,数据存取采取分段上锁的方式,来提高线程的并发执行性能
		userSocketSessionMap=new ConcurrentHashMap<Integer, WebSocketSession>();
		onlineUsers=new ConcurrentHashMap<Integer, User>();
		sendData=new ConcurrentHashMap<String, Object>();
	}
	
	//格式化日期
	private static String getFormatDate() {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	}
	
	//根据用户的角色加上修饰
	private static String judgeUserRole(User user) {
		if(user.getRole()==1 || user.getRole()==2)
			return "管理员-"+user.getUsername();
		else
			return user.getUsername();
	}
	
	
	//计算两个Date()之间的时间间隔
	private static String getDateInterval(Date startDate, Date endDate) {
	    long nd = 1000 * 24 * 60 * 60;
	    long nh = 1000 * 60 * 60;
	    long nm = 1000 * 60;
	    // long ns = 1000;
	    // 获得两个时间的毫秒时间差异
	    long diff = endDate.getTime() - startDate.getTime();
	    // 计算差多少天
	    long day = diff / nd;
	    // 计算差多少小时
	    long hour = diff % nd / nh;
	    // 计算差多少分钟
	    long min = diff % nd % nh / nm;
	    // 计算差多少秒//输出结果
	    // long sec = diff % nd % nh % nm / ns;
	    String res="";
	    if(day != 0)
	    	res+=day+"天";
	    if(hour != 0)
	    	res+=hour+"小时";
	    if(min != 0)
	    	res+=min+"分钟";
	    return res;
	}
	
	/*
	 * 对在线用户按照权限降序排列,需设置同步方法保证排序时sortUserList是线程安全的
	 * 不对sortUsersList加锁是因为这样在sendData.put("onlineUsers", sortUsersList)不会得到及时更新
	 */
	private synchronized static void sortUsersList() {//同步对象锁,获取锁释放锁触发的条件是进入这个同步代码块
			sortUsersList=new ArrayList<User>(onlineUsers.values());//这种JDK提供的数据结构对象不能强制转换会出错,需要利用构造器 构造
			Collections.sort(sortUsersList);
	}
	
	/**
	 * 建立连接后(需要先握手)
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		User user=(User)session.getAttributes().get("loginUser");
		if(user != null) {
			if(userSocketSessionMap.get(user.getId()) == null) {//此处其实也不必判断User和map.get是否为null,在这个运转逻辑下不会出错,为了保险吧
				userSocketSessionMap.put(user.getId(), session);
				if(onlineUsers.get(user.getId()) == null);{
					onlineUsers.put(user.getId(), user);
					sortUsersList();
				}
			}
			sendData.put("msg", new Message(-1, "系统广播", judgeUserRole(user)+"上线了", getFormatDate(),-1));
			sendData.put("onlineUsers", sortUsersList);//这里有可能在发送的时候sortUsersList刚好被重新赋值,但其本身是个引用指针,jvm自动调节或许也不会出现问题,要么是修改后的list要么就是原先的list,应该不会为空
			handleMessage(session, new TextMessage(new JSONObject(sendData).toString()));//将Map转化为json字符串
		}
	}
	
	/**
	 * 关闭连接后,当前聊天页面如被关闭或重新链接url就会触发
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
		User user=(User)session.getAttributes().get("loginUser");//这个下线不会判断前端页面的httpsession的loginUser是否下线(而是session的attribute map的loginUser),即使注销,这里还是会再次通知下线
		if(user != null) {
			userSocketSessionMap.remove(user.getId());
			onlineUsers.remove(user.getId());
			sortUsersList();
			sendData.put("msg", new Message(-1, "系统广播", judgeUserRole(user)+"下线了", getFormatDate(),-1));
			sendData.put("onlineUsers", sortUsersList);
			handleMessage(session, new TextMessage(new JSONObject(sendData).toString()));
		}
		/*if(session.isOpen())这里session是已经关闭了的,因为方法是afterclosed,底层已经关闭了
			session.close();*/
	}
	
	/**
	 * 消息传输错误处理,这个暂时还不清楚什么情况下会触发
	 */
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		User user=(User)session.getAttributes().get("loginUser");//这个下线不会判断前端页面的httpsession的loginUser是否下线(而是session的attribute map的loginUser),即使注销,这里还是会再次通知下线
		if(user != null) {
			userSocketSessionMap.remove(user.getId());
			onlineUsers.remove(user.getId());
			sortUsersList();
			sendData.put("msg", new Message(-1, "系统广播", judgeUserRole(user)+"下线了", getFormatDate(),-1));
			sendData.put("onlineUsers", sortUsersList);
			handleMessage(session, new TextMessage(new JSONObject(sendData).toString()));
		}
		if(session.isOpen())//这里不知道是否session已经关闭
			session.close();
	}
	
	/**
	 * 消息处理，在客户端js通过Websocket API(WebSocket.send())发送的消息会经过这里，然后进行相应的处理
	 */
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		if(message.getPayload() == null || message.getPayloadLength() == 0)
			return;
		broadcast((TextMessage)message);
	}
	/**
	 * 给所有在线的用户转发消息
	 * @param message
	 * synchronized可保证先发送的消息在转发时永远都出现在后发送消息的前部,因为发送消息是开辟了Thread去执行,实际的执行顺序有可能不会是Date的先后顺序
	  *  同时也可避免(远程 endpoint 处于 [TEXT_PARTIAL_WRITING] 状态，是被调用方法的无效状态)即:
	  *  不同的线程会遍历到某一个session并且调用sendMessage发送消息
	 *  (同一个session消息发送冲突了，也就是说同一个时刻,多个线程向一个websocket写数据冲突了即线程不安全)，就会报上面的异常。
	 */
	private synchronized void broadcast(TextMessage message) {
		Iterator<Entry<Integer, WebSocketSession>> it=userSocketSessionMap.entrySet().iterator();
		while(it.hasNext()) {
			Entry<Integer, WebSocketSession> entry=it.next();
			WebSocketSession wssession=entry.getValue();
			//这里的WebSocketSession因为是多线程并发的,所以有可能其它用户关闭聊天窗或出错导致websocketsession关闭
			if(wssession.isOpen()) {
				new Thread(new Runnable() {//这里之所以采用多线程并发,是因为可以提高转发效率,不必等待给上个用户发送完毕再开始给下个用户发送,是一用户转发线程开启,循环就会从新开始另一用户转发线程,同时并发(可有效消除不同用户接受同一消息的时间间隔),但也会导致后发送的消息先执行完sendMessage因此在同步方法上要设置synchronized(同步)
					@Override
					public void run() {
						try {
							if(wssession.isOpen())
								entry.getValue().sendMessage(message);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}).start();
			}
		}
	}
	/**
	 * 移除聊天用户,列为黑名单
	 * 这里并不设置同步方法,可有效提高并发性能,因为map已经采用了ConcurrentHashMap是线程安全的
	 * @param user
	 * @throws Exception
	 */
	public void removeChatUser(User user) throws Exception {
		WebSocketSession wssession=userSocketSessionMap.get(user.getId());
		userSocketSessionMap.remove(user.getId());
		onlineUsers.remove(user.getId());
		sortUsersList();
		sendData.put("msg", new Message(-1, "系统广播", user.getUsername()+"已被管理员踢出群聊,列入黑名单", getFormatDate(),user.getId()));
		sendData.put("onlineUsers", sortUsersList);
		broadcast(new TextMessage(new JSONObject(sendData).toString()));//这里若是要发移除信息通知给用户,即sessionMap在转发后再移除session会导致可能,在还没转发时session已被移除,导致转发出错,因为是多线程的
		if(wssession.isOpen())
			wssession.close();//这里会间接调用afterConnectionClosed()方法
	}
	
	/*
	 * 设置群聊管理员
	 */
	public void setChatAdmin(User user) {
		onlineUsers.get(user.getId()).setRole(1);
		sortUsersList();
		sendData.put("msg", new Message(0, "系统广播", user.getUsername()+"已被后台管理员设置为群聊管理员", getFormatDate(),user.getId()));
		sendData.put("onlineUsers", sortUsersList);
		broadcast(new TextMessage(new JSONObject(sendData).toString()));//这里如果同时设置了两个群聊管理员,新的群聊管理员的权限在第一次设置的广播转发已经实现了,只是通知信息没转发
	}
	
	/*
	 * 取消群聊管理员
	 */
	public void cancelChatAdmin(User user) {
		onlineUsers.get(user.getId()).setRole(0);
		sortUsersList();
		sendData.put("msg", new Message(0, "系统广播", user.getUsername()+"已被后台管理员取消群聊管理员", getFormatDate(),user.getId()));
		sendData.put("onlineUsers", sortUsersList);
		broadcast(new TextMessage(new JSONObject(sendData).toString()));//这里如果同时设置了两个群聊管理员,新的群聊管理员的权限在第一次设置的广播转发已经实现了,只是通知信息没转发
	}
	
	/*
	 * 聊天禁言
	 */
	public void forbidChat(User user) {
		onlineUsers.get(user.getId()).setStartTime(user.getStartTime());
		long startTime=user.getStartTime();
		long endTime=startTime+user.getForbidTalkDuration();
		sendData.put("msg", new Message(0, "系统广播", user.getUsername()+"已被管理员禁言"+getDateInterval(new Date(startTime), new Date(endTime)), getFormatDate(),user.getId()));
		sendData.put("onlineUsers", sortUsersList);
		broadcast(new TextMessage(new JSONObject(sendData).toString()));
	}
	
	/*
	 * 解除聊天禁言
	 */
	public void removeForbidChat(User user) {
		onlineUsers.get(user.getId()).setStartTime(user.getStartTime());
		sendData.put("msg", new Message(0, "系统广播", user.getUsername()+"已被管理员解除禁言", getFormatDate(),user.getId()));
		sendData.put("onlineUsers", sortUsersList);
		broadcast(new TextMessage(new JSONObject(sendData).toString()));
	}
	
	/*
	 * 用户之前被禁言,到了禁言时间期限,发言自动解除禁言标志
	 */
	public void autoRemoveForbidChat(User user) {
		onlineUsers.get(user.getId()).setStartTime(user.getStartTime());
		sortUsersList();//这里是为了更新sortUsersList里的startTime,目的不在排序
	}
	
	/*
	 * 是否支持部分消息
	 */
	@Override
	public boolean supportsPartialMessages() {
		return false;
	}

}
