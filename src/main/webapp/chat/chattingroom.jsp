<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="../resources/images/chat.ico" type="image/x-icon" />
<title>在线交流</title>
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.css"><!-- 模态框modal需要 -->
<script type="text/javascript" src="../resources/js/jquery-3.4.1.js"></script><!-- jquery库引用一定要放在各种插件引用的前面 -->
<script type="text/javascript" src="../resources/js/bootstrap.js"></script>
<script type="text/javascript" src="../resources/js/timeInput.js"></script>
<script type="text/javascript" src="../resources/js/sockjs.js"></script>
<script type="text/javascript" src="../resources/js/json2.js">/*用来兼容ie7及其以下版本的早期浏览器对JSON.parse和JSON.stringify的支持 */</script>
<style type="text/css">
	body{
		background: #F3F3FA;
	}
	.image-frame{
		display:flex;/*采用弹性布局来设置img水平垂直居中*/
		justify-content:center;
		align-items:center;
		overflow:auto;
	}
	.image-operate{
		margin-top:10px;
		text-align: center;
	}
	.image-operate span{
		display:inline-block;
		width: 48px;
		height: 48px;
	}
	.image-operate span:hover{
		background: #F1F1F1;
	}
	.chatting-frame{
		background:#fff;
		width: 551px;
		height: 610px;
		margin: 50px auto;
		border: 2px solid #a0b1c4;
		box-shadow: 5px 5px 5px #888888;
	}
	.top-frame{
		background: #E1AA8C;
		color: #fff;
		text-align: center;
		height: 30px;
		line-height:30px;
		font-weight: bolder;
	}
	.chatting-content{
		overflow-x:hidden;
		overflow-y:auto;
		width:397px;
		height:450px;
		float: left;
		border-bottom:  1px solid #CBCBCB;
		padding-bottom: 5px;
	}
	.chatting-content ul{
		list-style: none;
		margin: 0;
		padding: 0;
	}
	.selected-img{
		border: 3px solid #A9A9A9;
	}
	.message-item{
		width:370px;
		position:relative;
		margin: 10px 0 0 0;
	}
	.message-item p:first-child{
		font-size: 12px;
		margin: 0;
	}
	.message-item p:last-child{
		font-size: 12px;
		margin: 5px 0 0 0;
		border-radius:5px;
		padding: 8px 8px;
		width:auto; 
		display:inline-block !important; /* 这里是设置块级元素随着内容自适应宽度*/
		display:inline;
		max-width: 340px;
	}
	.chatting-notice{
		font-size: 14px;
		border-bottom: 3px solid #eeeeee;
	}
	.chatting-onlineUsers{
		width:150px;
		height:576px;
		float: right;/* 这里一定得是右浮动,如果是左浮,下方的编辑区左浮时会在此区域的下方导致和内容区域会有空隙,因为浮动参照的是相同方向浮动的兄弟元素和父容器*/
		border-left: 1px solid #CBCBCB;
		overflow: auto;
	}
	.chatting-onlineUsers ul{
		list-style:none;
		padding: 0;
		margin: 0;
	}
	.chatting-onlineUsers .user-list>li{
		width:100%;
		position: relative;
	}
	.user-list>li:hover{
		background: #F5F5F5;
	}
	.user-list>li.designate{
		background: #EEEEEE;
	}
	/*right-clk-menu*/
	.chatting-onlineUsers .user-list ul{/*要想让.active生效,ul就不能再标签内定义style属性,那样会覆盖掉.active的css*/
		z-index:5;/*这里的下面的li的pointer与.user-list可能在同一平面上 这会导致cursor的显示在相互覆盖的区域产生矛盾,因此要设置平面的堆叠顺序,使其不在同一平面上 */
		display:none;
		position:absolute;
		border:1px solid black;
	}
	.chatting-onlineUsers .user-list ul li{
		cursor: pointer;/* 不设置width会导致在父容器边缘点击,宽度会缩小到父容器内造成高度过高*/
	}
	.chatting-onlineUsers .user-list ul.active{/*这里如果只写.active,addClass时css并未能加载 */
		display:block;
	}
	.right-clk-menu{
		box-shadow: 3px 3px 3px #888888;
		border-radius: 2px;
		background: #fff;
	}
	.right-clk-menu li{
		width: 100px;
		text-align: center;
	}
	.right-clk-menu li:hover{
		background: #EEEEEE;
	}
	.wrapper1,.wrapper2,.wrapper3{
		margin-right: 10px;
		display: inline-block;
	}
	#day:after{
		content: "天";
		font-size: 18px;
		line-height: 30px;
	}
	#hour:after{
		content: "小时";
		font-size: 18px;
		line-height: 30px;
	}
	#minute:after{
		content: "分钟";
		font-size: 18px;
		line-height: 30px;
	}
	.tips{
		margin-top: 10px;
		color: #7F7F7F;
	}
	.edit-message{
		position:relative;
		float: left;
		width:397px;
		height:127px;
		font-size: 12px;
	}
	.edit-tool{
		position:relative;
		height:24px;
		border-bottom: 1px solid #CBCBCB;
	}
	.expression-aside{
		display:none;
		padding:5px;
		width:360px;
		border:1px solid #CBCBCB;
		position: absolute;
		bottom:29px;
		background:#fff;
		box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.16);
	}
	.expression-aside img{
		float: left;
		width: 24px;
		height: 24px;
		vertical-align: bottom;
	}
	.expression-aside img.selected{
		position: relative;
		bottom:2px;
	}
	.expression-aside img:hover{
		background: #F3F3F4;
	}
	.edit-tool span{
		display: inline-block;
		width: 24px;
		height: 24px;	
	}
	.edit-tool span.bg{
		background: #F1F1F1;
	}
	.edit-tool span:hover{
		background: #F1F1F1;
	}
	.edit-text{
		overflow-x:hidden;
		overflow-y:auto;
		outline:none;
		height:75px;
		padding: 5px 0 0 3px;
	}
	.edit-text.over{
		border:2px dashed #999999;
		background: #EEEEEE;
	}
	#send-btn{
		position: absolute;
		right: 20px;
		bottom: 3px;
		color:#fff;
		background: #E1A37E;/*#5A98DE*/
		padding: 0 5px;
		border: none;
		width: 45px;
		height: 25px;
		outline: none;
	}
	#send-btn:hover{
		background:#E1AA8C;
	}
</style>
</head>
<body onclick='hideMenu()' oncontextmenu='hideMenu()'>
	<div class="modal fade" id="original-image" tabindex="-1" role="dialog"  aria-labelledby="myModalTitle" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalTitle">查看图片</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
				</div>
				<div class="modal-body">
					<div class="image-frame"></div>
					<div class="image-operate">
						<span style="background-image: url('../resources/images/reduce.png');" onclick="enlargeOrReduce(0)"></span>
						<font id="percentage" style="margin: 0 10px;position: relative;bottom:20px;"></font>
						<span style="background-image: url('../resources/images/enlarge.png');" onclick="enlargeOrReduce(1)"></span>
						<span style="background-image: url('../resources/images/rotate.png');margin-left: 50px;" onclick="rotateImage()"></span>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="forbidChat-time" tabindex="-1" role="dialog"  aria-labelledby="myModalTitle" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalTitle">设置&nbsp;<span id="username"></span>&nbsp;的禁言时长</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
				</div>
				<div class="modal-body">
					<input type="hidden" id="user-id">
					<div id="day" class="wrapper1"></div>
					<div id="hour" class="wrapper2"></div>
					<div id="minute" class="wrapper3"></div>
					<div class="tips">禁言时长不能超过30天</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="forbidChat($('#user-id').val(),$('#username').html(),$('#day .num-input').val(),$('#hour .num-input').val(),$('#minute .num-input').val())">确定</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="chatting-frame">
		<div class="top-frame">
			湘潭大学校园失物招领在线交流平台
		</div>
		<div class="chatting-content">
			<ul>
			</ul>
		</div>
		<div class="chatting-onlineUsers">
			<div class="chatting-notice">
			
			</div>
			<div style="font-size: 14px;">群成员</div>
			<ul class="user-list">
			</ul>
		</div>
		<div class="edit-message">
			<div class="edit-tool">
				<div class="expression-aside">
					<img src="../resources/images/chat-expression/0.png" title="微笑">
					<img src="../resources/images/chat-expression/1.png" title="伤心">
					<img src="../resources/images/chat-expression/2.png" title="美女">
					<img src="../resources/images/chat-expression/3.png" title="发呆">
					<img src="../resources/images/chat-expression/4.png" title="墨镜">
					<img src="../resources/images/chat-expression/5.png" title="哭">
					<img src="../resources/images/chat-expression/6.png" title="羞">
					<img src="../resources/images/chat-expression/7.png" title="哑">
					<img src="../resources/images/chat-expression/8.png" title="睡">
					<img src="../resources/images/chat-expression/9.png" title="哭">
					<img src="../resources/images/chat-expression/10.png" title="囧">
					<img src="../resources/images/chat-expression/11.png" title="怒">
					<img src="../resources/images/chat-expression/12.png" title="调皮">
					<img src="../resources/images/chat-expression/13.png" title="笑">
					<img src="../resources/images/chat-expression/14.png" title="惊讶">
					<img src="../resources/images/chat-expression/15.png" title="难过">
					<img src="../resources/images/chat-expression/16.png" title="酷">
					<img src="../resources/images/chat-expression/17.png" title="汗">
					<img src="../resources/images/chat-expression/18.png" title="抓狂">
					<img src="../resources/images/chat-expression/19.png" title="吐">
					<img src="../resources/images/chat-expression/20.png" title="笑">
					<img src="../resources/images/chat-expression/21.png" title="快乐">
					<img src="../resources/images/chat-expression/22.png" title="奇">
					<img src="../resources/images/chat-expression/23.png" title="傲">
					<img src="../resources/images/chat-expression/24.png" title="饿">
					<img src="../resources/images/chat-expression/25.png" title="累">
					<img src="../resources/images/chat-expression/26.png" title="吓">
					<img src="../resources/images/chat-expression/27.png" title="汗">
					<img src="../resources/images/chat-expression/28.png" title="高兴">
					<img src="../resources/images/chat-expression/29.png" title="闲">
					<img src="../resources/images/chat-expression/30.png" title="努力">
					<img src="../resources/images/chat-expression/31.png" title="骂">
					<img src="../resources/images/chat-expression/32.png" title="疑问">
					<img src="../resources/images/chat-expression/33.png" title="秘密">
					<img src="../resources/images/chat-expression/34.png" title="乱">
					<img src="../resources/images/chat-expression/35.png" title="疯">
					<img src="../resources/images/chat-expression/36.png" title="哀">
					<img src="../resources/images/chat-expression/37.png" title="鬼">
					<img src="../resources/images/chat-expression/38.png" title="打击">
					<img src="../resources/images/chat-expression/39.png" title="bye">
					<img src="../resources/images/chat-expression/40.png" title="汗">
					<img src="../resources/images/chat-expression/41.png" title="抠">
					<img src="../resources/images/chat-expression/42.png" title="鼓掌">
					<img src="../resources/images/chat-expression/43.png" title="糟糕">
					<img src="../resources/images/chat-expression/44.png" title="恶搞">
					<img src="../resources/images/chat-expression/45.png" title="什么">
					<img src="../resources/images/chat-expression/46.png" title="什么">
					<img src="../resources/images/chat-expression/47.png" title="累">
					<img src="../resources/images/chat-expression/48.png" title="看">
					<img src="../resources/images/chat-expression/49.png" title="难过">
					<img src="../resources/images/chat-expression/50.png" title="难过">
					<img src="../resources/images/chat-expression/51.png" title="坏">
					<img src="../resources/images/chat-expression/52.png" title="亲">
					<img src="../resources/images/chat-expression/53.png" title="吓">
					<img src="../resources/images/chat-expression/54.png" title="可怜">
					<img src="../resources/images/chat-expression/55.png" title="刀">
					<img src="../resources/images/chat-expression/56.png" title="水果">
					<img src="../resources/images/chat-expression/57.png" title="酒">
					<img src="../resources/images/chat-expression/58.png" title="篮球">
					<img src="../resources/images/chat-expression/59.png" title="乒乓">
					<img src="../resources/images/chat-expression/60.png" title="咖啡">
					<img src="../resources/images/chat-expression/61.png" title="美食">
					<img src="../resources/images/chat-expression/62.png" title="动物">
					<img src="../resources/images/chat-expression/63.png" title="鲜花">
					<img src="../resources/images/chat-expression/64.png" title="枯">
					<img src="../resources/images/chat-expression/65.png" title="唇">
					<img src="../resources/images/chat-expression/66.png" title="爱">
					<img src="../resources/images/chat-expression/67.png" title="分手">
					<img src="../resources/images/chat-expression/68.png" title="生日">
					<img src="../resources/images/chat-expression/69.png" title="电">
					<img src="../resources/images/chat-expression/70.png" title="炸弹">
					<img src="../resources/images/chat-expression/71.png" title="刀子">
					<img src="../resources/images/chat-expression/72.png" title="足球">
					<img src="../resources/images/chat-expression/73.png" title="瓢虫">
					<img src="../resources/images/chat-expression/74.png" title="翔">
					<img src="../resources/images/chat-expression/75.png" title="月亮">
					<img src="../resources/images/chat-expression/76.png" title="太阳">
					<img src="../resources/images/chat-expression/77.png" title="礼物">
					<img src="../resources/images/chat-expression/78.png" title="抱抱">
					<img src="../resources/images/chat-expression/79.png" title="拇指">
					<img src="../resources/images/chat-expression/80.png" title="贬低">
					<img src="../resources/images/chat-expression/81.png" title="握手">
					<img src="../resources/images/chat-expression/82.png" title="剪刀手">
					<img src="../resources/images/chat-expression/83.png" title="抱拳">
					<img src="../resources/images/chat-expression/84.png" title="勾引">
					<img src="../resources/images/chat-expression/85.png" title="拳头">
					<img src="../resources/images/chat-expression/86.png" title="小拇指">
					<img src="../resources/images/chat-expression/87.png" title="拇指八">
					<img src="../resources/images/chat-expression/88.png" title="食指">
					<img src="../resources/images/chat-expression/89.png" title="ok">
				</div>
				<input type="file" id="upload-pic" style="display: none;">
				<span style="background-image: url('../resources/images/chat-expression/expression.png');" onclick="showExpression(this)" title="选择表情"></span>
				<span style="background-image: url('../resources/images/send_pic.png');" onclick="uploadPic()" title="发送本地图片"></span>
			</div>
			<div class="edit-text" contenteditable="true"></div>
			<input type="button" id="send-btn" value="发送" onclick="sendMessage()">
		</div>
	</div>
	<script type="text/javascript">
		var webSocket,user,onlineUsers;
		
		if("${not empty loginUser}"=="true")
			loadUserInfo("${loginUser.id}",1);
		//这里用来及时获取user.role信息,因为一旦用户role被管理员修改,其session还是之前的user,所以需要及时获取role做下一步判断
		function loadUserInfo(id,flag) {//ajax在返回data时会自动将json字符串转化为js 对象
			$.ajax({//ajax是异步的,及是并行的另启动了一个小线程去和其余代码块并行执行,如果其余代码块依赖于ajax的data,需要将其余代码块在success块里调用,否则会出现,ajax为执行完毕,其余代码块已经使用到data会出错
				url:"${pageContext.request.contextPath}/loadUserInfo",
				data:{"id":id},
				type:"POST",
				dataType:"json",
				success:function(data){
					user=data;						
					if(flag) loadWebSocket();
					else loadOnlineUsers();
				}
			});
		}
		
		function loadWebSocket() {
			if(user.role!=-1){//被移出群聊加入黑名单的用户不能加入聊天室
				if('WebSocket' in window)//Chrome Edge IE11 Firefox均支持
					webSocket=new WebSocket("ws://"+location.host+"${pageContext.request.contextPath}"+"/websocket");			
				else if('MozWebSocket' in window)//可能兼容老板火狐
					webSocket=new MozWebSocket("ws://"+location.host+"${pageContext.request.contextPath}"+"/websocket");		
				else//较低版本的浏览器那时 08年以前没诞生H5(推出websocket协议),不支持ws协议,所以采取轮询向下兼容如:IE7及其以下版本均不支持ws,及08年以前的老板浏览器
					webSocket=new SockJS("ws://"+location.host+"${pageContext.request.contextPath}"+"/sockjs");
			
				console.log(webSocket.readyState);//0 - 表示连接尚未建立。
				console.log("websocket:表示连接尚未建立");
				webSocket.onopen=function(event){
					console.log(webSocket.readyState);//1 表示连接已建立，可以进行通信。
					console.log("WebSocket:session已连接");
				};
			
				webSocket.onmessage=function(event){
					console.log(webSocket.readyState);//1 表示连接已建立，可以进行通信。
					console.log("WebSocket:收到一条消息");
					var data=JSON.parse(event.data);//js自带将json字符串转化为js对象,不过不支持IE7及其以下版本的早期浏览器
					var msg=data.msg;
					var messageText;
					var adminName;
					if(user.role == 1 || user.role == 2)
						adminName="管理员-"+user.username;
					else adminName=user.username;
					if(msg.senderName == adminName){
						messageText="<li class='message-item' style='text-align:right;'>"+
											"<p>"+"我"+"&nbsp;"+msg.date+"</p>"+
											"<p style='background: #A6D4F2; text-align:left;'>"+msg.content+"</p>"+
									 "</li>";
					}
					else if(msg.senderName == "系统广播"){
						messageText="<li class='message-item' style='margin-left:15px;'>"+
											"<p>"+msg.senderName+"&nbsp;"+msg.date+"</p>"+
											"<p style='background: #FFC666;'>"+msg.content+"</p>"+
					 				"</li>";
					}
					else{
						messageText="<li class='message-item' style='margin-left:15px;'>"+
											"<p>"+msg.senderName+"&nbsp;"+msg.date+"</p>"+
											"<p style='background: #E5E5E5;'>"+msg.content+"</p>"+
				 					 "</li>";
					}
					if(msg.type==-1){//系统通知信息,在线用户数会改变
						onlineUsers=data.onlineUsers;
						$(".chatting-notice").html("当前在线人数:"+onlineUsers.length);
						loadOnlineUsers(onlineUsers);
					}
					else if(msg.type==0){//系统通知 设置或取消群聊管理员信息 或者被禁言或解除禁言信息
						onlineUsers=data.onlineUsers;
						if(msg.loadUserId == user.id)
							loadUserInfo(user.id,0);
						else
							loadOnlineUsers();
					}
					$(".chatting-content ul").append(messageText);
					adjustImgSize();
					scrollToBottom(document.getElementsByClassName('chatting-content')[0]);
				};
			
				var flag=0;
				webSocket.onerror=function(event){//只有Firefox关闭服务器 tomcat时会触发,Chrome和Edge不会触发
					alert("发生错误,连接已断开");
					flag=1;//避免移除用户信息触发
					console.log(webSocket.readyState);//3 表示连接已经关闭或者连接不能打开。
					console.log("WebSocket:发生错误");
					$(".chatting-notice").html("连接服务器发生错误...");
					//webSocket.close();连接出错时会自动调用onclose()方法,无需主动调用
				};
			
				webSocket.onclose=function(event){//Chrome和Edge在关闭服务器时只会触发onclose
					if(flag==0)//Chrome和Edge在关闭服务器时会错误提示此信息
						alert("您已被管理员移出群聊并列入黑名单,有问题请联系管理员");
					console.log(webSocket.readyState);//3 表示连接已经关闭或者连接不能打开。
					console.log("WebSocket:session已关闭");
					//webSocket.close();		
				};
			}
			else
				alert("您已被列入黑名单,如有疑问请联系管理员");
		}
		//聊天内容图片自适应比例放缩
		function adjustImgSize() {
			var chatMsgWidth=324,scaleFactor;//chatMsgWidth的临界参考 conent-p的max-width
			var width,height;
			$(".message-item:last p:last img").each(function () {
				if($(this).attr("title") == null){
					width=$(this).attr("data-width");//获取其本地图片的原始宽高
					height=$(this).attr("data-height");
					$(this).css("width",width+"px");
					$(this).css("height",height+"px");
					if(width>chatMsgWidth){
						scaleFactor=chatMsgWidth/width;//缩放的比例因子
						if(height*scaleFactor<250){
							$(this).css("width",chatMsgWidth+"px");
							$(this).css("height",(height*scaleFactor)+"px");
						}
						else{
							scaleFactor=250/height;
							$(this).css("width",(width*scaleFactor)+"px");
							$(this).css("height","250px");
						}
					}
					else if(height>250){
						scaleFactor=250/height;
						$(this).css("width",(width*scaleFactor)+"px");
						$(this).css("height","250px");
					}
					$(this).css("border-radius","5px");
				}
			});
		}
		
		var rotateAngle,index;
		//初始化modal-dialog,不设置任何设备宽度
		function initDialog() {
			index=17;
			rotateAngle=0;
			$("#percentage").text("100%");
			$("#original-image .modal-dialog").removeClass("modal-sm");
			$("#original-image .modal-dialog").removeClass("modal-lg");
			$("#original-image .modal-dialog").removeClass("modal-xl");
		}
		
		var originalWidth,originalHeight;
		//双击图片查看详情 自适应比例放缩
		function showOriginalImage(obj) {
			initDialog();
			var width,height,scaleFactor;
			if($(obj).attr("title") == null){
				width=$(obj).attr("data-width");
				height=$(obj).attr("data-height");
				//bootstrap modal 设备宽度 modal-xl:1140px modal-lg:800px modal-default:500px modal-sm:300px
				if(width>1100){
					scaleFactor=1100/width;
					width=1100;
					height=height*scaleFactor;
					$("#original-image .modal-dialog").addClass("modal-xl");
				}
				else if(width<=1100 && width>780)
					$("#original-image .modal-dialog").addClass("modal-xl");
				else if(width<=780 && width>480)
					$("#original-image .modal-dialog").addClass("modal-lg");
				else if(width<=480 && width>280){
					//中等宽度 默认不需要加修饰类
				}
				else//sm 小型设备
					$("#original-image .modal-dialog").addClass("modal-sm");
				var image=$(obj).clone();//clone(true) true代表 连同onclick此类触发事件 也复制,clone()代表不复制触发事件
				image.css("width",width+"px");
				image.css("height",height+"px");
				image.css("margin","0");//将之前的margin清除,img的margin居中好像不管用
				/*image.css("position","absolute");这里可通过绝对定位设置img水平垂直 居中,但这样就需要在顺时针旋转的时候也同时平移
				image.css("top","50%");
				image.css("left","50%");
				image.css("transform","translate(-50%,-50%)");此时图片左上角位于div中心点,translate 在水平坐标x轴向左移动自身宽度的50%,在垂直坐标y轴向上移动自身高度的50%,这样就可实现水平垂直居中*/
				$(".image-frame").html(image);
				$(".image-frame").css("min-height",height+"px");
				$(".image-frame").css("max-height",height+"px");
				originalWidth=width;
				originalHeight=height;
				$("#original-image").modal("show");
			}
		}
		
		//从100%基础开始  下标16为第一个减少的百分比  下标18为第一个增加的百分比 下标17用来过渡100%基数 下标0是最小的缩小的比例,下标33是最大放大比例
		function enlargeOrReduce(flag) {
			var values=[0.05,0.06,0.07,0.08,0.09,0.11,0.13,0.16,0.19,0.23,0.28,0.33,0.40,0.48,0.58,0.69,0.83,1.00,1.20,1.44,1.73,2.08,2.50,3.00,3.60,4.32,5.18,6.22,7.46,8.95,10.74,12.89,15.47,16.00];//最小缩小到%5,最大放大到%1600
			if(flag == 1){
				if(index!=33)
					index++;
			}
			else{
				if(index != 0)
					index--;
			}
			$("#percentage").text(Math.round(values[index]*100)+"%");
			$(".image-frame img").css("width",originalWidth*values[index]+"px");
			$(".image-frame img").css("height",originalHeight*values[index]+"px");
		}
		
		function rotateImage() {
			rotateAngle+=90;
			$(".image-frame img").css("transform","rotate("+rotateAngle+"deg)");
		}
		
		function scrollToBottom(objFrame){
			objFrame.scrollTop = objFrame.scrollHeight;
		}
		
		function loadOnlineUsers() {
			var res="";
			for(var i=0;i<onlineUsers.length;i++){
				//这种动态拼接html的事件监听最好用onclick这种事件监听函数写在标签属性里,否则加载时页面未拼接完整,采用jquery可能会识别不到
				res+=
					"<li oncontextmenu='showMenu(this)'>"+
					 	"<span style='display:none;'>"+onlineUsers[i].id+"</span>"+
						"<span style='";
						if(onlineUsers[i].role == 2)
							res+="background:url(\"../resources/images/first_admin.png\") no-repeat;";
						else if(onlineUsers[i].role == 1)
							res+="background:url(\"../resources/images/second_admin.png\") no-repeat;";
							res+="padding-left:17px;font-size:14px;'>"+onlineUsers[i].username+"</span>"+
					 	"<ul class='right-clk-menu'>";
					 		if(user.role==2 && onlineUsers[i].role==0)
					 			res+="<li onclick='setChatAdmin(this)'>设为管理员</li>";
					 		if(user.role==2 && onlineUsers[i].role==1)
					 			res+="<li onclick='cancelChatAdmin(this)'>取消管理员</li>";
					 		if((user.role==1 || user.role==2) && onlineUsers[i].role!=2 && user.role!=onlineUsers[i].role){
					 			if(onlineUsers[i].startTime==-1)
					 				res+="<li data-toggle='modal' onclick='transmitValue("+onlineUsers[i].id+",\""+onlineUsers[i].username+"\")'>禁言</li>";
					 			else
					 				res+="<li onclick='removeForbidChat("+onlineUsers[i].id+",\""+onlineUsers[i].username+"\")'>解除禁言</li>";
					 			res+="<li onclick='removeChatUser(this)'>移出群聊</li>";
					 		}
					 res+=
					 	"</ul>"+
					"</li>";
			}
			$(".chatting-onlineUsers .user-list").html(res);
		}
		
		function removeChatUser(obj) {
			$.ajax({
				url:"${pageContext.request.contextPath}/removeChatUser",
				data:{"id":$(obj).parent().prev().prev().html()},
				type:"POST",
				dataType:"text",
				success:function(data){
					if(data=='已将用户移出群聊,并列入黑名单')
						alert(data);
				}
			});
		}
		
		function showMenu(obj) {
			event.preventDefault();//阻止浏览器默认的右键菜单栏
			event.stopPropagation();//阻止子元素的事件向父元素冒泡,防止父元素的右击事件触发
			hideMenu();//将之前显示的ul隐藏
			$(obj).find("ul").css("left",event.offsetX);
			$(obj).find("ul").css("top",event.offsetY);
			$(obj).find("ul").addClass("active");
			$(obj).addClass("designate");
		}
		
		function hideMenu() {
			$(".designate").removeClass("designate");
			$(".active").removeClass("active");
			$(".expression-aside").slideUp("fast");//True - 显示所有元素,False - 隐藏所有元素
			$(".edit-tool span").removeClass("bg");
			$(".selected-img").removeClass("selected-img");
		}
		
		function showExpression(obj) {
			event.stopPropagation();//阻止事件向上冒泡 触发body的点击事件
			if($(".expression-aside").css("display") == "none")
				$(obj).addClass("bg");
			else
				$(obj).removeClass("bg");
			$(".expression-aside").toggle(500);
		}
		
		$(".expression-aside img").click(function () {
			$(this).attr("draggable",false);
			$(".edit-text").append($(this).clone());//text-area不能用html()和append()添加
		});
		
		$(".expression-aside img").hover(function () {
			var lastStr=$(this).attr("src").substr(36);
			$(this).addClass("selected");
			$(this).attr("src","../resources/images/chat-expression/"+lastStr.replace("png","gif"));
		},function () {
			var lastStr=$(this).attr("src").substr(36);
			$(this).removeClass("selected");
			$(this).attr("src","../resources/images/chat-expression/"+lastStr.replace("gif","png"));
		});
		
		$("#upload-pic").change(function () {
			if($(this)[0].files[0] != null){
				uploadAjax($(this)[0].files[0]);
				$(this).val("");//每次都初始化为空,可以再次选择相同的图片使其触发change事件				
			}
		});
		
		/* 上传图片 */
		function uploadAjax(uploadFile) {
			var formData=new FormData();
			formData.append("uploadFile",uploadFile);
			formData.append("flag",1);//标记为1 代表上传到tomcat服务器resources/upload_files临时文件夹里
			$.ajax({
				url:"${pageContext.request.contextPath}/uploadFile",
				data:formData,
				type:"POST",
				contentType: false,//必须false才会自动加上正确的Content-Type,是为了避免 JQuery 对其操作,从而失去分界符,而使服务器不能正常解析文件
				processData: false,//必须false才会避开jQuery对 formdata 的默认处理,XMLHttpRequest会对 formdata 进行正确的处理
				dataType:"json",
				success:function(data){
					setImgSize(uploadFile,data);
				}
			});
		}
		
		/* 聊天编辑区设置图片的尺寸*/
		function setImgSize(imgFile,data) {
			var width,height,scaleFactor;
			var image=new Image();
			image.onload=function(){
				width=this.width;
				height=this.height;
				if(width>200){
					scaleFactor=200/width;
					if(height*scaleFactor<120){//判断按照宽度缩放的比例下,高度是否合理
						width=200;
						height=height*scaleFactor;
					}
					else{
						scaleFactor=120/height;//这个比例因子肯定是比按照宽度缩放更小的,因此宽度只会更小
						height=120;
						width=width*scaleFactor;
					}
				}
				else if(height>120){
					scaleFactor=120/height;
					height=120;
					width=width*scaleFactor;//因为width实际宽度本身就比200小,所以放缩后的宽度无需再判断
				}
				$(".edit-text").append("<img style='margin:2.5px 5px 2.5px 0px;width:"+width+"px;height:"+height+"px;vertical-align:bottom;' data-width='"+this.width+"' data-height='"+this.height+"' draggable='false' src='../resources/upload_files/"+data+"' ondblclick='showOriginalImage(this)' onclick='selectedPic(this)'/>");//data-width data-height封装好 原始图片的尺寸
				scrollToBottom(document.getElementsByClassName("edit-text")[0]);
			}
			var reader=new FileReader();
			reader.onload=function(imgFile){//reader.onload不能套image.onload 否则Eclipse编辑器会报错,分开写
				image.src=imgFile.target.result;
			}
			reader.readAsDataURL(imgFile);
		}
		
		function selectedPic(obj) {
			event.stopPropagation();//阻止子元素的事件向父元素冒泡,防止父元素的左击事件触发有remove掉刚add上的selected-img类
			$(".selected-img").removeClass("selected-img");
			$(obj).addClass("selected-img");
		}
		
		function uploadPic() {
			$("#upload-pic").click();
		}
		
		//$("").dragenter(); 直接这样写不识别这个方法
		$(".edit-text").bind("dragenter",function () {
			$(this).addClass("over");//添加背景和虚线边框
		});
	
		$(".edit-text").bind("drop",function (event) {
			//原生js的dataTransfer就是event的属性，而jQuery的dataTransfer在originalEvent里面
			uploadAjax(event.originalEvent.dataTransfer.files[0]);//将图片拖拽到 编辑信息栏时,将其上传并追加至div里 files是jquery对象,而files[0]才是真正的文件js对象
			$(this).removeClass("over");
		});
		
		$(".edit-text").bind("dragleave",function () {
			$(this).removeClass("over");
		});
		
		//阻止进行拖拽时浏览器的默认行为,即自动打开图片
		$("body").on({
			dragover: function (event) {
				event.preventDefault();
			},
			drop: function (event) {
				event.preventDefault();
			}
		});
		
		function sendMessage() {
			if(webSocket != null){
				if($(".edit-text").html().trim()=="")
					alert("内容不能为空");
				else{
					if(user.startTime == -1 || user.forbidTalkDuration <= (new Date().getTime()-user.startTime)){
						if(user.startTime != -1)
							autoRemoveForbidChat(user.id);					
						else
							webSocketSend(1,-1);
					}
					else
						alert("您已被禁言暂时无法发布信息");
				}
			}
			else
				alert("您尚未与服务器连接成功,请重试");
		}
		
		//设置按Enter键按下发送信息
		document.onkeydown=function(event){
			if(!event) event = window.event;
			if((event.keyCode || event.which) == 13)// e.keyCode IE e.which Firefox
				sendMessage();
		}
		
		//按enter键松下 要清空enter回车换行符
		document.onkeyup=function(event){
			if(!event) event = window.event;
			if((event.keyCode || event.which) == 13)// e.keyCode IE e.which Firefox
				$(".edit-text").html("");
		}
		
		function webSocketSend(type,loadUserId) {
			var username;
			if(user.role==1 || user.role==2)
				username="管理员-"+"${loginUser.username}";
			else
				username="${loginUser.username}";
			var msgStr={"msg":{"type":type,
						   	   "senderName":username,
						       "content":$(".edit-text").html(),
						       "date":new Date().format("yyyy-MM-dd hh:mm:ss"),
						       "loadUserId":loadUserId},
		                "onlineUsers":onlineUsers};
			$(".edit-text").html("");
			webSocket.send(JSON.stringify(msgStr));
		}
		
		//找到禁言时间自然到期的用户 修改器startTime,再将onlineUsers发送过去
		function findUserIndex() {
			for(var i=0;i<onlineUsers.length;i++)
				if(onlineUsers[i].id == user.id){
					onlineUsers[i].startTime=-1;
					break;
				}
		}
		
		function setChatAdmin(obj) {
			$.ajax({
				url:"${pageContext.request.contextPath}/setChatAdmin",
				data:{"id":$(obj).parent().prev().prev().html()},
				type:"POST",
				dataType:"text",
				success:function(data){
					if(data=="已将该用户设置为群聊管理员")
						alert(data);
				}
			});
		}
		
		function cancelChatAdmin(obj) {
			$.ajax({
				url:"${pageContext.request.contextPath}/cancelChatAdmin",
				data:{"id":$(obj).parent().prev().prev().html()},
				type:"POST",
				dataType:"text",
				success:function(data){
					if(data=="已取消该用户群聊管理员权限")
						alert(data);
				}
			});
		}
		
		function transmitValue(id,username) {
			$("#user-id").val(id);
			$("#username").html(username);
			$("#day input").val(0);
			$("#hour input").val(0);
			$("#minute input").val(0);
			$("#hour .num-input").removeAttr("disabled");
			$("#minute .num-input").removeAttr("disabled");
			$("#forbidChat-time").modal("show");
		}
		
		function forbidChat(id,username,day,hour,minute) {
			var startTime=new Date().getTime();
			var minute0=1000*60;
			var hour0=minute0*60;
			var day0=hour0*24;
			var forbidTalkDuration=minute0 * minute+hour0 * hour+day0 * day;
			if(forbidTalkDuration != 0){
				$.ajax({
					url:"${pageContext.request.contextPath}/forbidChat",//data这种json传输方式,后端既能以User对象接受,以能以属性分离的形式接收
					data:{"id":id,"username":username,"startTime":startTime,"forbidTalkDuration":forbidTalkDuration},
					type:"POST",
					dataType:"text",
					success:function(data){
						if(data=="已将该用户禁言")
							alert(data);
					}
				});
			}
		}
		
		function removeForbidChat(id,username) {
			$.ajax({
				url:"${pageContext.request.contextPath}/removeForbidChat",
				data:{"id":id,"username":username,"startTime":-1},
				type:"POST",
				dataType:"text",
				success:function(data){
					if(data=="该用户已被解除禁言")
						alert(data);
				}
			});
		}
		
		function autoRemoveForbidChat(id) {
			$.ajax({
				url:"${pageContext.request.contextPath}/autoRemoveForbidChat",
				data:{"id":id,"startTime":-1},
				type:"POST",
				dataType:"text",
				success:function(data){
					if(data=="您的禁言时间已到达期限,可正常聊天"){
						findUserIndex();//重新加载当前user对象的属性
						webSocketSend(0,id);
						alert(data);
					}
				}
			});
		}
		
		var options={
			width: 100,//宽度
		    positive: true,//允许输入正数
		    negative: false,//允许输入负数
		    //faq：positive，negative不能同时false，同时false按同时为true处理
		    floatCount: 0,//小数点后保留位数
		    //命名空间，防止样式冲突
		    wrapperClass: 'num-input-wrap',//最外层容器
		    inputClass: 'num-input',//input输入框
		    addClass: 'add',//增加按钮
		    subtractClass: 'subtract',//减少按钮
		    interval: 1//增加&减少按钮每次变化的值	
		};
		
	    $(".wrapper1").timeInput(options,30);
	    $(".wrapper2").timeInput(options,23);
	    $(".wrapper3").timeInput(options,59);

		$("#day .num-input").bind("input propertychange",function () {//无法监听到 js脚本修改的value值变化
			if($(this).val() >= 30){
				$(this).val(30);
				$("#hour .num-input").val(0);
				$("#hour .num-input").attr("disabled",true);
				$("#minute .num-input").val(0);
				$("#minute .num-input").attr("disabled",true);
			}
			else{
				$("#hour .num-input").removeAttr("disabled");
				$("#minute .num-input").removeAttr("disabled");
			}
		});
		
		$("#hour .num-input").bind("input propertychange",function () {
			if($(this).val() >= 24)
				$(this).val(23);
		});
		
		$("#minute .num-input").bind("input propertychange",function () {
			if($(this).val() >= 60)
				$(this).val(59);
		});
		
		Date.prototype.format = function(fmt) { 
		     var o = { 
		        "M+" : this.getMonth()+1,                 //月份 
		        "d+" : this.getDate(),                    //日 
		        "h+" : this.getHours(),                   //小时 
		        "m+" : this.getMinutes(),                 //分 
		        "s+" : this.getSeconds(),                 //秒 
		        // 季度
		        "q+" : Math.floor((this.getMonth()+3)/3), 
		        "S"  : this.getMilliseconds()             //毫秒 
		    }; 
		    if(/(y+)/.test(fmt)) {
		            fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
		    }
		     for(var k in o) {
		        if(new RegExp("("+ k +")").test(fmt)){
		             fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
		        }
		     }
		    return fmt; 
		}   
	
	</script>
</body>
</html>