package cn.edu.xtu.lostfound.websocket;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import cn.edu.xtu.lostfound.entity.User;
import cn.edu.xtu.lostfound.service.UserService;
/**
 * Socket建立连接（握手）和断开（挥手）
 * @author Orang
 *
 */
@Component
//这里还可通过extends HttpSessionHandshakeInterceptor来实现可覆盖更多的方法
public class ChatHandshakeInterceptor implements HandshakeInterceptor {

	@Autowired
	private UserService userService;
	
	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
		if(request instanceof ServletServerHttpRequest) {
			ServletServerHttpRequest servletServerHttpRequest=(ServletServerHttpRequest)request;
			/*request.getSession(false);如果有session则获取session对象,没有则返回null 用户获取登录信息时
			  request.getSession();如果有session则返回该session对象，没有则创建再返回session对象 用户存取登录信息时*/
			HttpSession session=servletServerHttpRequest.getServletRequest().getSession(false);//尽量在前端控制是否登录,这里的session貌似永远都不为null
			if(session != null) {
				User user=(User)session.getAttribute("loginUser");
				if(user == null) 
					return false;//Unexpected response code: 200
				User user0=userService.showUserDetail(user.getId());//这里原先session中的userInfo role有可能还未更新
				attributes.put("loginUser", user0);//put的user不能为null,否则会报空指针异常,500代号,这里一定要设置select取出的
				return true;
			}
			else
				return false;
		}
		return false;
	}

	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception exception) {

	}

}
