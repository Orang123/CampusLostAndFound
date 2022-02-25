<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pagination.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pagination.js"></script>
<title>${infoType}信息详情</title>
<style type="text/css">
	body{
		width:100%;
		overflow-x:hidden; 
		background: #F3F3FA;
		/*overflow-y:hidden;*/
		/*margin-left:340px;*/
	}
	.middle-content{
		background:#fff;
		width: 1250px;
		margin: 10px auto;
	}
	.middle-content::after{/* 解决浮动塌陷问题,middle-content里只有浮动元素时,它的高度没有被撑起来,在其后加一个清楚浮动流块级元素*/
		content: "";
		display: block;
		clear: left;
	}
	.goods-detail{
		float: left;
		height:700px;
		border: 6px solid #EAEAEA;
		box-shadow: 5px 5px 5px #888888;
		font-family: '仿宋';
	}
	.title-info{
		border-bottom: 2px dotted #CBCBCB;
		padding-bottom: 5px;
	}
	table{
		width:430px;
		border-collapse: collapse;
	}
	table tr:nth-child(even) {
		background: #f5f8fa;
	}
	table tr:hover{
		background: #e5ebee;
	}
	table td{
		text-align:center;
	}
	#comment-content{
		width:415px;
		box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.16);
		border-radius: 3px;
		margin-left: 5px;
		font-family: '仿宋';/*这里会导致textarea的列数边窄*/
		resize:none;
	}
	#publish-button{
		margin-left: 345px;/* 行级元素和行间块状元素margin padding的top bottom都无效 left right也只是对同等级的行级和行间块状元素有效对无法参照父级元素*/
		width:80px;
		height:35px;
		color:#fff;
		font-size:16px;
		background: #007BFF;/*#5A98DE*/
		padding: 0 5px;
		border: none;
		border-radius: 5px;
		cursor: pointer;
		font-weight: bolder;
		font-family: '仿宋';
	}
	#publish-button:hover{
		background:#0069D9;/*#6AA2E0 #0069D9 #1E90FF*/
	}
	.answer-region{
		width:700px;
		height:210px;
		float: left;
		margin-left: 15px;
		border: 6px solid #EAEAEA;
		box-shadow: 5px 5px 5px #888888;
		font-family: '仿宋';
	}
	.answer-btn,.enter-ansUser{
		width:40px;
		height:18px;
		color:#fff;
		font-size:16px;
		background: #007BFF;/*#5A98DE*/
		padding: 0 2px;
		border: none;
		border-radius: 5px;
		cursor: pointer;
		font-weight: bolder;
		font-family: '仿宋';
	}
	.answer-btn:hover{
		background:#0069D9;/*#6AA2E0 #0069D9 #1E90FF*/
	}
	.enter-ansUser:hover{
		background:#0069D9;/*#6AA2E0 #0069D9 #1E90FF*/
	}
	.comment-area{
		float: left;
		width:700px;
		min-height:463px;
		max-height:463px;
		overflow:auto;
		margin-left: 15px;
		margin-top: 15px;
		border: 6px solid #EAEAEA;
		box-shadow: 5px 5px 5px #888888;
		font-family: '仿宋';
	}
	.comment-list{
		width:400px;
		list-style: none;
		margin: 10px auto;
		padding: 8px;
		border: 0px solid blue;
	}
	.comment-list span{
		font-family: 'microsoft yahei';
	}
	.comment-list>li{
		margin-bottom: 10px;
		padding-bottom:7px;
		border-bottom: 1px solid #CBCBCB;
	}
	.publish-reply{
		margin-left:5px;
		font-size:14px;
		color:#fff;
		border: none;
		border-radius: 5px;
		background: #8590a6;
	}
	.publish-reply:hover{
		background:#696969;
	}
	.comment-list>li>div>p{
		margin:7px 0; 
		padding-left: 5px;
	}
	.wr-page{
		width:500px;
		text-align:center;
		margin:0 auto;
	}
	.reply,.reply-son{
		padding-left: 20px;
		background-image: url("resources/images/reply1.png");
	}
	.remove-comment,.remove-reply{
		padding-top:5px;
		padding-left: 16px;
		background-image: url("resources/images/trash1.png");
	}
	.remove-comment,.reply,.remove-reply,.reply-son{
		visibility: hidden;
		font-size: 14px;
		cursor: pointer;
		color:#8590a6;/*#708090*/
		background-repeat: no-repeat;
	}
	/* 这里hover后面要改变的样式只能放置一个,否则会出错*/
	.comment-list li div:hover .remove-comment{
		visibility: visible;
	}
	/* 这里虽然是.reply类都显示出来,但是指当前li那行,而不是所有li的reply类都显示*/
	.comment-list li div:hover .reply{
		visibility: visible;
	}
	.reply-list{
		display:none;
		width:95%;
		max-height:305px;
		overflow:auto;
		list-style: none;
		margin: 0 0 0 10px;
		padding: 5px 10px;
	}
	.reply-list li{
		width:95%;
		margin-bottom:10px;
		padding-bottom:7px;
		border-bottom: 1px solid #CBCBCB;
		border-left: 4px solid #c5c5c5;
	}
	.reply-list li p{
		margin: 7px 0;
		padding-left: 5px;
	}
	.reply-list li:hover .remove-reply{
		visibility: visible;
	}
	.reply-list li:hover .reply-son{
		visibility: visible; 
	}
	/* hover前面的类一次也只能指定一个,否则会出错*/
	.remove-comment:hover{
		color:black;
		background-image: url("resources/images/trash2.png");
	}
	.reply:hover{
		background-image: url("resources/images/reply2.png");
		color:black;
	}
	.remove-reply:hover{
		color: black;
		background-image: url("resources/images/trash2.png");
	}
	.reply-son:hover{
		background-image: url("resources/images/reply2.png");
		color:black;
	}
	.look-over{
		padding-top:2px;
		padding-left: 17px;
		font-size: 14px;
		background-image: url("resources/images/magnifier1.png");
		background-repeat: no-repeat;
		cursor: pointer;
		color:#708090;
	}
	/* 这里同理,悬浮也只是当前li那行.reply变色,其它li行是不触发的*/
	.look-over:hover{
		color:black;
		background-image: url("resources/images/magnifier2.png");
	}
</style>
<% boolean flag=true;%>
</head>
<body>
	<header>
		<jsp:include page="../header.jsp"></jsp:include>
	</header>
	
	<div class="middle-content">
		<div class="goods-detail">
			<div class="title-info">
				<span style="font-family: '楷体';font-weight:bolder;font-size: 20px;">${infoType}信息详情</span>
				<span style="margin-left:30px;font-weight: bold;">${goods.user.username}</span> 发表于: ${goods.publishTime}
			</div>
			<br>
			<table border="1">
				<tr>
					<td>标题</td>
					<td>${goods.title}</td>
				</tr>
				<tr>
					<td>
						<c:if test="${infoType=='寻物'}">失物图片</c:if>
						<c:if test="${infoType=='招领'}">拾物图片</c:if>
					</td><!-- resources/upload_goods_pic是静态资源必须在springmvc.xml里配置静态资源映射,才能访问到 -->
					<td><img style="width: 280px;height:200px;" src="${pageContext.request.contextPath}/resources/upload_goods_pic/${goods.imgUrl}"/></td>
				</tr>
				<tr>
					<td>
						<c:if test="${infoType=='寻物'}">失物名称</c:if>
						<c:if test="${infoType=='招领'}">拾物名称</c:if>
					</td>
					<td>${goods.goodsName}</td>
				</tr>
				<tr>
					<td>
						<c:if test="${infoType=='寻物'}">失物类型</c:if>
						<c:if test="${infoType=='招领'}">拾物类型</c:if>
					</td>
					<td>${goods.goodsType}</td>
				</tr>
				<tr>
					<td>
						<c:if test="${infoType=='寻物'}">丢失地点</c:if>
						<c:if test="${infoType=='招领'}">拾到地点</c:if>
					</td>
					<td>${goods.happenPlace}</td>
				</tr>
				<tr>
					<td>
						<c:if test="${infoType=='寻物'}">丢失时间</c:if>
						<c:if test="${infoType=='招领'}">拾到时间</c:if>
					</td>
					<td>${goods.happenTime}</td>
				</tr>
				<tr>
					<td>发布者用户名</td>
					<td>${goods.user.username}</td>
				</tr>
				<tr>
					<td>发布者qq</td>
					<td>${goods.user.qq}</td>
				</tr>
				<tr>
					<td>发布者邮箱</td>
					<td>${goods.user.email}</td>
				</tr>
			</table>
			<br>
			<form action="" class="comment-form">
				<input type="hidden" name="goodsId" value="${goods.id}">
				<input type="hidden" name="user.id" value="${loginUser.id}">
				<textarea rows="7" cols="62" name="content" placeholder="请输入评论内容" id="comment-content"></textarea><br><br>
				<input type="button" id="publish-button" value="发表评论" >
			</form>
		</div>
		<div class="answer-region">
			<span style="font-family: '楷体';font-weight:bolder;font-size: 20px;">发布信息状态:</span>
			<c:if test="${goods.state==0}">
				<c:if test="${infoType=='寻物'}">
					<span style="font-size: 18px;">失物还未找到</span><br><br>
					<span style="font-size: 18px;">确认是该物品或与其描述相似的物品的发现者信息如下所示(点击确认代表认领):</span><br>
					<span style="font-size: 18px;font-weight: bolder;">申请人数:${fn:length(goods.listAUser)}</span>
					<!--  <span style="font-size: 18px;font-weight: bolder;">申请提供人数:${goods.listAUser.size()}</span> 这里fn:length()和 .size()都能用,只是都需要引入fn函数功能标签库才行-->
				</c:if>
				<c:if test="${infoType=='招领'}">
					<span style="font-size: 18px;">失主还未找到</span><br><br>
					<span style="font-size: 18px;">确认是该物品主人或与其描述相似的物品失主信息如下所示(点击确认代表认领):</span><br>
					<span style="font-size: 18px;font-weight: bolder;">申领人数:${goods.listAUser.size()}</span>
				</c:if>
				<br>
				<ul style="width:550px;height:56px;overflow:auto;list-style: none;margin: 0;padding: 0;border: 2px solid #eee;">
					<c:if test="${not empty goods.listAUser}">
						<c:forEach items="${goods.listAUser}" var="ansUser">
							<li>
								<span>用户名:${ansUser.username}</span>
								<span>QQ:${ansUser.qq}</span>
								<span>邮箱:${ansUser.email}</span>
								<c:if test="${ansUser.username eq loginUser.username}">
									<%flag=false; %>
								</c:if>
								<c:if test="${loginUser.username eq ansUser.username}">
									<c:if test="${infoType=='寻物'}">
										<input type="button" class="answer-btn" value="移除" onclick="removeAnsUser(${ansUser.id})" title="所持有的物品与失主描述不符,点击该按钮可撤销自己信息"/>
									</c:if>
									<c:if test="${infoType=='招领'}">
										<input type="button" class="answer-btn" value="移除" onclick="removeAnsUser(${ansUser.id})" title="所丢失的物品与该发现者描述不符,点击该按钮可撤销自己信息"/>
									</c:if>
								</c:if>
								<c:if test="${goods.user.id eq loginUser.id}">
									<c:if test="${infoType=='寻物'}">
										<input type="button" class="answer-btn" value="确认" onclick="changeGoodsState(1,${ansUser.id})" title="若要确认该发现者与你联系,已成功完成物品归还请点击该确认按钮,表示此次寻物活动已结束"/>
									</c:if>
									<c:if test="${infoType=='招领'}">
										<input type="button" class="answer-btn" value="确认" onclick="changeGoodsState(1,${ansUser.id})" title="若要确认该失主与你联系,已成功完成物品认领请点击该确认按钮,表示此次招领活动已结束"/>
									</c:if>
								</c:if>
							</li>
						</c:forEach>
					</c:if>
					<c:if test="${empty goods.listAUser}">
						暂无
					</c:if>
				</ul>
				<br>
				<%if(flag){ %>
				<c:if test="${(infoType=='寻物') and (loginUser.id ne goods.user.id)}">
					<span style="font-size: 18px;">你有发现该物品或与其描述相似物品,若愿意提供个人信息给失主,请点击右边按钮</span>
					<input type="button" class="enter-ansUser" value="提供" title="你有发现该物品或与其描述相似物品,若愿意提供个人信息给失主,请点击此按钮"/>
				</c:if>
				<c:if test="${(infoType=='招领') and (loginUser.id ne goods.user.id)}">
					<span style="font-size: 18px;">若该招领物品是你的,你愿意接收,请点击右边按钮将个人信息提供给发布者</span>
					<input type="button" class="enter-ansUser" value="提供" title="若该招领物品是你的,你愿意接收,请点击此按钮将个人信息提供给发布者"/>
				</c:if>
				<% }%>
			</c:if>
			<c:if test="${goods.state==1}">
				<c:if test="${infoType=='寻物'}">
					<span style="font-size: 18px;">失物已找到</span><br>
					<span style="font-size: 18px;">发现者信息如下:</span><br>
				</c:if>
				<c:if test="${infoType=='招领'}">
					<span style="font-size: 18px;">失主已认领</span><br>
					<span style="font-size: 18px;">失主信息如下:</span><br>
				</c:if>
				<div style="border: 1px solid blue;">
					<span>用户名:${goods.answerUser.username}</span>
					<span>QQ:${goods.answerUser.qq}</span>
					<span>邮箱:${goods.answerUser.email}</span>
				</div>
				<br>
				<c:if test="${goods.user.id eq loginUser.id}">
					<c:if test="${infoType=='寻物'}">
						<span style="font-size: 18px;">若此次交易出现点问题,想要移除该发现者重新发布失物信息,请点击右边取消按钮</span>
						<input type="button" class="answer-btn" value="取消"  onclick="changeGoodsState(0,null)" title="若此次交易出现点问题,想要移除该发现者重新发布失物信息,请点击此取消按钮">
					</c:if>
					<c:if test="${infoType=='招领'}">
						<span style="font-size: 18px;">若此次交易出现点问题,想要移除该认领者重新发布招领信息,请点击右边取消按钮</span>
						<input type="button" class="answer-btn" value="取消"  onclick="changeGoodsState(0,null)" title="若此次交易出现点问题,想要移除该认领者重新发布招领信息,请点击此取消按钮">
					</c:if>
				</c:if>
			</c:if>
		</div>
		<div class="comment-area">
			<div class="comment-title" style="margin-left:10px;margin-top:10px;">
				<span style="font-family: '楷体';font-weight:bolder;font-size: 20px;"></span>
			</div>
			<ul class="comment-list">
		
			</ul>
			<div class="wr-page">

			</div>
		</div>
	</div>

	<footer>
		<jsp:include page="../footer.jsp"></jsp:include>
	</footer>
	
	<script type="text/javascript">
			
		pagination(1);
	
		$(".enter-ansUser").click(function () {
			if("${empty loginUser}"=="true"){
				alert("请先登录");
				return false;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/publishAnswer",
				data:{"username":"${loginUser.username}","qq":"${loginUser.qq}","email":"${loginUser.email}","goodsId":"${goods.id}"},
				type:"POST",
				datatype:"html",
				success:function(data){
					if(data=="发起回应成功")
						window.location.href="${pageContext.request.contextPath}/showGoodsDetail?id=${goods.id}&infoType=${infoType}";
				}
			});
		});
		
		
		function changeGoodsState(state,auid) {
			$.ajax({
				url:"${pageContext.request.contextPath}/changeGoodsState",
				data:{"state":state,"id":"${goods.id}","auid":auid},
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data=="物品状态已改变")
						window.location.href="${pageContext.request.contextPath}/showGoodsDetail?id=${goods.id}&infoType=${infoType}";
				}
			});
		}
		
		function removeAnsUser(id) {
			$.ajax({
				url:"${pageContext.request.contextPath}/removeAnsUser",
				data:{"id":id},
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data=="移除该用户回应信息成功")
						window.location.href="${pageContext.request.contextPath}/showGoodsDetail?id=${goods.id}&infoType=${infoType}";
				}
			});
		}
	
		$("#publish-button").click(function () {
			if("${empty loginUser}"=="true"){
				alert("请先登录");
				return false;
			}
			if($("#comment-content").val().trim()==""){
				alert("请填写评论内容");
				return false;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/publishComment",
				data:$('.comment-form').serialize(),
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data=="发布成功")
						pagination(1);
				}
			});
			$("#comment-content").val("");
		});
			
		function removeComment(id,pageNum) {
			if(confirm("确定要删除这条评论吗?")==false)
				return false;
			$.ajax({
				url:"${pageContext.request.contextPath}/removeComment",
				data:{"id":id},
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data=="成功删除一条评论")
						pagination(pageNum);
				}
			});
		}
			
			
		
		function showReplyInputArea(obj,commentUsername) {
			var replyDiv=$(obj).parent().parent().next();//这里获得的var replyDiv已经是jquery对象了,下面find()也是同理
			var p=$(obj).parent();
			if(replyDiv.css("display")=="none"){
				replyDiv.find("input[type='text']").attr("placeholder","回复 "+commentUsername+" :");
				$(obj).html("取消回复");
				$(obj).css("visibility","visible");
				p.unbind("mouseenter").unbind("mouseleave");//这里得从新把之前点击回复设置的hover事件清除,否则取消回复在鼠标离开li元素时会消失
			}
			else{
				replyDiv.find("input[type='text']").val("");
				$(obj).html("回复");
				p.hover(function () {//这里要再设置hover,因为$(obj).css("visibility","hidden");会使得style中的hover失效
					$(obj).css("visibility","visible");
				},function (){
					$(obj).css("visibility","hidden");
				});
			}
			replyDiv.slideToggle("fast");
		}
			
		function showReplyArea(obj,replyUsername) {
			var replyDiv=$(obj).parent().next();//这里获得的var replyDiv已经是jquery对象了,下面find()也是同理
			var li=$(obj).parent().parent();//获取当前评论的li元素
			if(replyDiv.css("display")=="none"){
				replyDiv.find("input[type='text']").attr("placeholder","回复 "+replyUsername+" :");
				$(obj).html("取消回复");
				$(obj).css("visibility","visible");
				li.unbind("mouseenter").unbind("mouseleave");//这里得从新把之前点击回复设置的hover事件清除,否则取消回复在鼠标离开li元素时会消失
			}
			else{
				replyDiv.find("input[type='text']").val("");
				$(obj).html("回复");
				li.hover(function () {//这里要再设置hover,因为$(obj).css("visibility","hidden");会使得style中的hover失效
					$(obj).css("visibility","visible");
				},function (){
					$(obj).css("visibility","hidden");
				});
			}
			replyDiv.slideToggle("fast");
		}
			
		function showReplyList(obj,replyNums) {
			var replyList=$(obj).parent().parent().next().next();
			if(replyList.css("display")=="none")
				$(obj).html("收起回复");
			else
				$(obj).html("查看回复("+replyNums+")");
			replyList.slideToggle("fast");
		}
			
		function publishReply(obj,commentId,repliedUId,uId,pageNum) {
			if("${empty loginUser}"=="true"){
				alert("请先登录");
				return false;
			}
			var content=$(obj).prev().val().trim();
			if(content==""){
				alert("请填写回复内容");
				return false;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/publishReply",
				data:{"content":content,"commentId":commentId,"repliedUser.id":repliedUId,"user.id":uId},
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data=="发表回复成功")
						pagination(pageNum);
				}
			});
		}
			
		function removeReply(id,pageNum) {
			if(confirm("确定要删除这条回复吗?")==false)
				return false;
			$.ajax({
				url:"${pageContext.request.contextPath}/removeReply",
				data:{"id":id},
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data=="成功删除一条回复")
						pagination(pageNum);
				}
			});
		}
			
		function pagination(startPage) {
			$.ajax({
				url:"${pageContext.request.contextPath}/getCommentsNums",
				data:{goodsId:"${goods.id}"},
				type:"POST",
				dataType:"json",
				success:function(data){
					var res="";
					res+=data+"条评论";
					$(".comment-title span").html(res);
					$(".wr-page").wrpage(data,{
						items_per_page: 3,
						wr_current: startPage,
						cb: function(pageNum,pageSize) {//cb:callback回调函数,调用ajax异步请求后台控制器
								loadData(pageNum,pageSize);
						}	
					});
					loadData(startPage,3);
				}
			});
		}
				
		function loadData(pageNum,pageSize){
			$.ajax({
				url:"${pageContext.request.contextPath}/loadCommentsData",
				data:{"pageNum":pageNum,"pageSize":pageSize,"goodsId":"${goods.id}"},
				type:"GET",
				dataType:"json",
				success:function(data){
					if(data){
						var res= "";
						var commentsInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
						var replyNums,replyUsername;
						for(var i=0;i<commentsInfo.length;i++){
							replyNums=commentsInfo[i].replyNums;
							res+=
								"<li>"+
								      "<div>"+								
											"<p style='background:#eee;height:30px;line-height:30px;border-radius:3px;position:relative;'>"+"<span style='font-weight:bold;'>"+commentsInfo[i].user.username+"</span>"+"<span style='color:#8590a6;position:absolute;right:5px;'>发表于: "+commentsInfo[i].publishTime.substring(0,16)+"</span></p>"+
											"<p>"+commentsInfo[i].content+"</p>"+
											"<p>"+(commentsInfo[i].user.username=="${loginUser.username}"?"<span class='remove-comment' onclick='removeComment("+commentsInfo[i].id+","+pageNum+")'>删除</span>&nbsp;&nbsp;&nbsp;":"")
										 		 +(commentsInfo[i].user.username!="${loginUser.username}"?"<span class='reply' onclick='showReplyInputArea(this,\""+commentsInfo[i].user.username+"\")'>回复</span>&nbsp;&nbsp;&nbsp;":"")
										 		 +(replyNums==0?"":"<span class='look-over' onclick='showReplyList(this,"+replyNums+")'>查看回复("+replyNums+")</span>")+
											"</p>"+
									  "</div>"+
									"<div style='display:none;padding-left:5px;'>"+
										"<input type='text' />"+
										"<input type='button' class='publish-reply' value='发布' onclick='publishReply(this,"+commentsInfo[i].id+","+commentsInfo[i].user.id+",${loginUser.id},"+pageNum+")' />"+
									"</div>"+
									"<ul class='reply-list'>";
									for(var j=0;j<replyNums;j++){
										replyUsername=commentsInfo[i].listReply[j].user.username;
										res+=
											"<li>"+
												"<p style='background:#eee;height:25px;line-height:25px;border-radius:3px;position:relative;'>"+"<span style='font-weight:bold;margin-right:7px;'>"+replyUsername+"</span>"+"<span style='color:#8590a6;margin-right:7px;'> 回复 </span>"+"<span style='font-weight:bold;'>"+commentsInfo[i].listReply[j].repliedUser.username+"</span>"+"<span style='color:#8590a6;position:absolute;right:5px;'>"+commentsInfo[i].listReply[j].publishTime.substring(0,16)+"</span></p>"+
												"<p>"+commentsInfo[i].listReply[j].content+"</p>"+
												"<p>"+
													 (replyUsername=="${loginUser.username}"?"<span class='remove-reply' onclick='removeReply("+commentsInfo[i].listReply[j].id+","+pageNum+")'>删除</span>&nbsp;&nbsp;&nbsp;":"")+
													 (replyUsername!="${loginUser.username}"?"<span class='reply-son' onclick='showReplyArea(this,\""+replyUsername+"\")'>回复</span>":"")+
												"</p>"+
												"<div style='display:none;margin:0;padding:0;'>"+
													"<input type='text' />"+
													"<input type='button' class='publish-reply' value='发布' onclick='publishReply(this,"+commentsInfo[i].id+","+commentsInfo[i].listReply[j].user.id+",${loginUser.id},"+pageNum+")' />"+
												"</div>"+
											"</li>";
									}
									res+=
									"</ul>"+
								"</li>";
						}
						$(".comment-list").html(res);
					}
				}
			});
		}
					
	</script>
</body>
</html>