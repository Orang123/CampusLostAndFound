<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<!-- <meta> 元素可提供有关页面的元信息meta-information,比如针对搜索引擎和更新频度的描述和关键词. -->
		<meta charset="UTF-8">
		<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pagination.css"/>
		<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pagination.js"></script>
		<title>${infoType}信息页面</title>
		<style type="text/css">
			body{
				width:100%;
				margin:0;
				background: #F3F3FA;
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
			.top-warning span{
				font-family: "仿宋";
				font-size:22px;
			}
			.goods-info img,.right-aside img{
				width:50px;
				height:50px;
			}
			.goods-info{
				height:650px;
				border: 6px solid #EAEAEA;
				float: left;
				box-shadow: 5px 5px 5px #888888;
			}
			table{
				border-collapse: collapse;
				border-spacing:0;
				/*border-style: none;*/
				/*border: 1px solid black;*/
			}
			table thead tr{
				background: url("resources/images/th.gif");
				background-size: 100% 100%;
			}
			table th{
				text-indent:20px;
				text-align:center;
				font-family: "楷体";
			}
			table tbody tr{
				font-family: "仿宋";
			}
			table tbody tr:nth-child(even) {
				background: #f5f8fa;
			}
			table tbody tr:hover{
				background: #e5ebee;
			}
			table tbody td{
				text-align:center;
				text-indent:20px;
			}
			.goods-detail{
				color:black;
			}
			.goods-detail:hover{
				color:red;
			}
			.wr-page{
				text-align: center;
			}
			.right-aside{
				width:300px;
				height:650px;
				margin-left:10px;
				float: left;
				border: 6px solid #EAEAEA;
				font-family: '仿宋';
				box-shadow: 5px 5px 5px #888888;
			}
			.publish-goods,.online-chat{
				width:280px;
				margin: 10px auto;/*margin auto居中必须设置width,而且还不能是浮动元素*/
			}
			.publish-goods a,.online-chat a{
				text-align:center;
				display:block;
				width:280px;
				height:50px;
				background: #FF0000;
				line-height:50px;
				color: #fff;
				font-weight:bolder;
				text-decoration: none;
				font-size: 22px;
			}
			.publish-goods a:hover {
				background: #FF4500;
			}
			.online-chat a:hover {
				background: #FF4500;
			}
			.help-info{
				width: 280px;
				margin: 10px auto;
			}
			.help-link{
				position:relative;
				height: 30px;
				line-height: 30px;
			}
			.help-link img{
				margin-right: 10px;
			}
			.help-link>a{
				position:absolute;
				right:2px;
				color: black;
				font-weight: bolder;
				text-decoration: none;
			}
			.help-link>a:hover{
				color: red;
				text-decoration: underline;
			}
			.help-info ul{
				width:280px;
				margin: 0 auto;
				padding: 0;
				list-style: none;
			}
			.help-info ul a{
				color: black;
				text-decoration: none;
			}
			.help-info ul a:hover{
				color: red;
				text-decoration: underline;
			}
		</style>
	</head>
<body>
	<header>
		<jsp:include page="../header.jsp"></jsp:include>
	</header>
	<div class="middle-content">
		<div class="goods-info">
			<div class="top-warning" >
				<img src="${pageContext.request.contextPath}/resources/images/tzico.jpg" style="vertical-align: bottom;"><span><b>${infoType}启事</b></span>
			</div>
			<table>
				<thead>
					<tr>
						<th>标题</th>
						<th>
							<c:if test="${infoType=='寻物'}">失物名称</c:if>
							<c:if test="${infoType=='招领'}">拾物名称</c:if>
						</th>
					    <th>
							<c:if test="${infoType=='寻物'}">失物类型</c:if>
							<c:if test="${infoType=='招领'}">拾物类型</c:if>
						</th>
						<th>
							<c:if test="${infoType=='寻物'}">丢失地点</c:if>
							<c:if test="${infoType=='招领'}">拾到地点</c:if>
						</th>
						<th>
							<c:if test="${infoType=='寻物'}">丢失时间</c:if>
							<c:if test="${infoType=='招领'}">拾到时间</c:if>
						</th>
						<th>
							<c:if test="${infoType=='寻物'}">失物图片</c:if>
							<c:if test="${infoType=='招领'}">拾物图片</c:if>
						</th>
					</tr>
				</thead>
				<tbody class="goods-tbody">
				
				</tbody>
			</table>
			<div class="wr-page">

			</div>
		</div>
		<div class="right-aside">
			<div class="help-info">
				<div class="help-link">
					<img style="width: 55px;height: 30px;" src="resources/images/the_new.jpg">
					<img style="width: 80px;height: 30px;" src="resources/images/help.jpg">
					<a href="helpCenter.jsp">>></a>
				</div>
				<hr>
				<ul>
					<li><a href="forwardHelpPage?divClass=1">湘潭大学失物招领平台使用规范</a></li>
				</ul>
			</div>
			<hr width="95%">
			<div class="publish-goods">
				<a href="${pageContext.request.contextPath}/setGoodsInfoType?infoType=${infoType}&url=publishGoods" onclick="return judgeIsLogin();">发布${infoType}信息</a>
			</div>
			<hr width="95%">
			<div class="online-chat">
				<a href="chat/chattingroom.jsp" onclick="return judgeIsLogin();" target="_blank">在线交流</a>
			</div>
			<hr width="95%">
		</div>
	</div>
	<footer>
		<jsp:include page="../footer.jsp"></jsp:include>
	</footer>
</body>
<script type="text/javascript">
	//这个就是jq ready()的方法就是Dom Ready，他的作用或者意义就是:在DOM加载完成后就可以可以对DOM进行操作.
	$(function(){
		pagination();
		loadHelpData();
		function pagination() {
			$.ajax({
				url:"${pageContext.request.contextPath}/getGoodsNums",
				data:{infoType:"${infoType}",state:0},
				type:"POST",
				dataType:"json",
				success:function(data){
					$(".wr-page").wrpage(data,{
						items_per_page: 4,
						wr_current: 1,
						cb: function(pageNum,pageSize) {//cb:callback回调函数,调用ajax异步请求后台控制器
							loadData(pageNum,pageSize);
						}	
					});
					loadData(1,4);
				}
			});
		}
		
		function loadData(pageNum,pageSize){
			$.ajax({
				url:"${pageContext.request.contextPath}/loadGoodsData",
				data:{"pageNum":pageNum,"pageSize":pageSize,"infoType":"${infoType}","state":0},
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.length){
						var res= "";
						var goodsInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
						for(var i=0;i<goodsInfo.length;i++){
							res+=
								"<tr>"+
									"<td>"+
											"<a href='${pageContext.request.contextPath}/showGoodsDetail?id="+goodsInfo[i].id+"&infoType=${infoType}"+"' class='goods-detail'>"+goodsInfo[i].title+"</a>"+
									"</td>"+
									"<td>"+goodsInfo[i].goodsName+"</td>"+
									"<td>"+goodsInfo[i].goodsType+"</td>"+
									"<td>"+goodsInfo[i].happenPlace+"</td>"+
									"<td>"+goodsInfo[i].happenTime.substring(0,16)+"</td>"+
									"<td>"+ 
										"<img alt='图片加载失败' src='${pageContext.request.contextPath}/resources/upload_goods_pic/"+goodsInfo[i].imgUrl+"'/>"+
									"</td>"+
								"</tr>";
						}
						$(".goods-tbody").html(res);
					}
				}
			});
		}
	});
	//这个函数如果是按照input 标签内onclick属性绑定就一定要放在$(function(){})外部,因为onclick属性是在页面加载dom元素时就绑定的,但那时judgeIsLogin是放在$(function(){})要等待dom元素加载完才执行的
	//如果这个 函数是按照jquery的$("#id").click()绑定 可以放在$(function(){})内部,因为这个绑定事件本身就是要在dom元素加载完后才进行的,所以不会出现未定义
	function judgeIsLogin() {
		if("${empty loginUser}"=="true"){
			alert("请先登录");
			return false;
		}
		return true;
	}
	
	function loadHelpData(){
		$.ajax({
			url:"${pageContext.request.contextPath}/loadHelpInfoData",
			type:"POST",
			dataType:"json",
			success:function(data){
				if(data.length){
					var res= "";
					var helpInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
					var index=2;
					for(var i=0;i<helpInfo.length;i++,index++){
						res+=
							"<li>"+
								"<a href='forwardHelpPage?divClass="+index+"'>"+helpInfo[i].title+"</a>"+
							"</li>";
					}
					$(".help-info ul").append(res);
				}
			}
		});
	}

</script>
</html>