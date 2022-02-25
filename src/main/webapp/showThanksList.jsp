<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- <meta> 元素可提供有关页面的元信息meta-information,比如针对搜索引擎和更新频度的描述和关键词. -->
		<meta charset="UTF-8">
		<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
		<link type="text/css" rel="stylesheet" href="resources/css/pagination.css"/>
		<script src="resources/js/jquery-3.4.1.js"></script>
		<script type="text/javascript" src="resources/js/pagination.js"></script>
		<title>感谢留言信息</title>
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
			.thanks-info{
				height:400px;
				border: 6px solid #EAEAEA;
				float: left;
				box-shadow: 5px 5px 5px #888888;
			}
			.top-warning span{
				font-family: "仿宋";
				font-size:22px;
			}
			.thanks-detail{
				color:black;
			}
			.thanks-detail:hover{
				color:red;
			}
			table {
				width:400px;/* 试着修改分页部分的宽度*/
				border-collapse: collapse;
				border-spacing:0;
				/*border: 1px solid black;*/
				/*margin-left: 50px;*/
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
			.right-aside{
				width:300px;
				height:400px;
				margin-left:10px;
				float: left;
				border: 6px solid #EAEAEA;
				font-family: '仿宋';
				box-shadow: 5px 5px 5px #888888;
			}
			.publish-thanks,.online-chat{
				width:280px;
				margin: 10px auto;/*margin auto居中必须设置width,而且还不能是浮动元素*/
			}
			.publish-thanks a,.online-chat a{
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
			.publish-thanks a:hover {
				background: #FF4500;
			}
			.online-chat a:hover{
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
		<jsp:include page="header.jsp"></jsp:include>
	</header>
	<div class="middle-content">
		<div class="thanks-info">
			<div class="top-warning">
				<img src="resources/images/tzico.jpg" style="vertical-align: bottom;"><span><b>感谢信</b></span>
			</div>
			<!-- 这个table的border如果设置为="" 会导致表格产生分割线,等同于border="1",这里是在table标签里的border而不是style里的border两个意义不同-->
			<table>
				<thead>
					<tr>
						<th>发布时间</th>
						<th>标题</th>
					</tr>
				</thead>
				<tbody class="thanks-tbody">
				
				</tbody>
			</table>
			<div class="wr-page" style="text-align: center;">

			</div>
		</div>
		<div class="right-aside">
			<div class="help-info">
				<div class="help-link">
					<img style="width: 55px;height: 30px;" src="resources/images/the_new.jpg">
					<img style="width: 80px;height: 30px;" src="resources/images/help.jpg">
					<a href="helpCenter.jsp">>></a>
				</div>
				<hr width="100%">
				<ul>
					<li><a href="forwardHelpPage?divClass=1">湘潭大学失物招领平台使用规范</a></li>
				</ul>
			</div>
			<hr width="95%">
			<div class="publish-thanks">
				<a href="${pageContext.request.contextPath}/publishThanks.jsp" onclick="return judgeIsLogin();">发布感谢信</a>
			</div>
			<hr width="95%">
			<div class="online-chat">
				<a href="chat/chattingroom.jsp" onclick="return judgeIsLogin();" target="_blank">在线交流</a>
			</div>
			<hr width="95%">
		</div>
	</div>
	<footer>
		<jsp:include page="footer.jsp"></jsp:include>
	</footer>
</body>
<script type="text/javascript">

	pagination();
	loadHelpData();
	function pagination() {
		$.ajax({
			url:"${pageContext.request.contextPath}/getThanksNums",
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
			url:"${pageContext.request.contextPath}/loadThanksData",
			data:{"pageNum":pageNum,"pageSize":pageSize},
			type:"POST",
			dataType:"json",
			success:function(data){
				if(data.length){
					var res= "";
					var thanksInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
					for(var i=0;i<thanksInfo.length;i++){
						res+=
						"<tr>"+
							"<td>"+thanksInfo[i].publishTime.substring(0,16)+"</td>"+
							"<td>"+"<a class='thanks-detail' href='${pageContext.request.contextPath}/showThanksDetail?id="+thanksInfo[i].id+"'>"+thanksInfo[i].title+"</a>"+"</td>"+
						"</tr>";
					}
					$(".thanks-tbody").html(res);
				}
			}
		});
	}
	
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