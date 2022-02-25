package cn.edu.xtu.lostfound.websocket;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
//import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
//import org.springframework.web.socket.server.HandshakeInterceptor;

/**
 * WebSocket配置处理器
 * @author Orang
 * @configuration 用于定义配置类,替换xml配置文件类似<beans>,被注解的类内部包含有一个或多个被@Bean注解的方法,这些方法将会被AnnotationConfigApplicationContext或AnnotationConfigWebApplicationContext类进行扫描,并用于构建bean定义,初始化Spring容器.
 */
//@Configuration
@Component
@EnableWebSocket //实现socket通信业务处理的处理
public class ChatWebSocketConfig implements WebSocketConfigurer{
	
	@Autowired
	private ChatWebSocketHandler chatWebSocketHandler;
	@Autowired
	private ChatHandshakeInterceptor chatHandshakeInterceptor;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(chatWebSocketHandler, "/websocket").addInterceptors(chatHandshakeInterceptor);//这里的websocket socketjs代表ws协议下要访问的url
		registry.addHandler(chatWebSocketHandler, "/sockjs").addInterceptors(chatHandshakeInterceptor).withSockJS();
		/*registry.addHandler(chatWebSocketHandler(), "/ws").addInterceptors(chatHandshakeInterceptor());
		registry.addHandler(chatWebSocketHandler(), "/ws/sockjs").addInterceptors(chatHandshakeInterceptor()).withSockJS();*/
	}
	
	/*@Bean////在java中进行显式配置,产生一个Bean对象，然后这个Bean对象交给Spring管理
	ChatWebSocketHandler chatWebSocketHandler() {//方法权限不能是private或final
		return new ChatWebSocketHandler();
	}
	
	@Bean
	ChatHandshakeInterceptor chatHandshakeInterceptor() {
		return new ChatHandshakeInterceptor();
	}*/
	
}
