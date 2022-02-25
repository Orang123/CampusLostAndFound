<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>主页头部</title>
<style type="text/css">
			body{
				/* padding: 0; */
				margin: 0;
			}
			.top-main{
				margin:0 auto;
				width:1250px;
				/* height:330px; */
			}
			.xtu-pic{
				position:relative;
				width: 100%;
				height: 265px;
				/*padding: 1px;*/
				background: url(resources/images/XTU.jpg);
				background-size: 100% 100%;
			}
			.link-mark{
				width:100%;
				height:70px;
				/* font-size: 0; */
				background-image: url(resources/images/headbg.png);
			}
			.enter{
				float: left;
				/* display: inline-block; 这里不知为何整体都向下偏移了*/
			}
			#nav-mark{
				height:40px;
				margin-left: 20px;
				margin-top: 28px;
				background-image: url(resources/images/nav.png);
			}
			#nav-mark ul{
				margin-top: 16px;
				padding-left: 40px;
			}
			#nav-mark li{
				display: inline-block;
				/* float: left; */
				margin-right: 15px;
			}
			#nav-mark li a{
				color:white;
				padding: 0 4px;
				display: block;
				text-decoration: none;
				font-family:"微软雅黑";
				font-size: 18px;
			}
			#nav-mark li a:hover{
				color:#DC143C;
				background: white;
			}
			#login-enter{
				height:47px;
				line-height:47px;
				margin-top:20px;
				margin-left: 10px;
			}
			#login-enter a{
				color:white;
				line-height:47px;
				display: block;
				text-decoration: none;
				font-family:"微软雅黑";
				font-size: 16px;
			}
			#login-enter li{
				overflow:hidden;
				color:white;
				display: block;
				font-family:"微软雅黑";
				font-size: 16px;
			}
			#welcome{
				max-width:140px;
				text-overflow:ellipsis;/*超出的部分显示为省略号*/
				white-space: nowrap;/*文本不会换行，文本会在在同一行上继续，直到遇到 <br> 标签为止*/
			}
			#login-enter a:hover{
				color:#DC143C;
				background: white;
			}
			.search-form{
				position:absolute;
				right:0;
				bottom:0;
			}
			.search{
				height:38px;
				font-size: 0;
			}
			#search-text{
				width:180px;
				height:25px;
				/* float: left; */
				margin-left: 2px;
				margin-top:2px;
				color:gainsboro;
				border:1px solid #B22222;
				background-image: url(resources/images/search_btn.ico);
				background-repeat: no-repeat;
				background-size: 25px;
				padding-left: 25px;
			}
			#search-btn{
				height:28px;
				margin-top:2px;
				/* float: left; */
				border:1px solid #B22222;
				color: #FFFFFF;
				cursor: pointer;
				background-image: url(resources/images/headbg.png);
			}
			#advanced-search{
				display:inline-block;
				text-decoration:none;
				height:26px;
				/* float: left; */
				border:1px solid #B22222;
				color: #FFFFFF;
				cursor: pointer;
				background-image: url(resources/images/headbg.png);
			}
			#search-btn:hover{
				background: #FF4500;
			}
			#advanced-search:hover{
				background: #FF4500;
			}
			#login-enter li{
				display: inline-block;
				margin-left: 5px;
			}
</style>
</head>
<body>
	<div class="top-main">
			<header class="xtu-pic">
				<form class="search-form" method="get" action="searchGoodsTitle">
					<div class="search">
						<input type="text" id="search-text" name="title" placeholder="请输入要搜索的物品" />
						<input type="submit" id="search-btn" value="搜索" />
						<a id="advanced-search" href="searchGoods.jsp" style="font-size: initial;">高级搜索</a>
						<input type="hidden" name="state" value="0">
					</div>
				</form>
			</header>
			<nav class="link-mark">
				<div class="enter">
					<a href="https://www.xtu.edu.cn/" target="_blank"><img src="resources/images/logo.png" ></a>
				</div>
				<!-- setGoodsInfoType?infoType=寻物,这种传值方式 如果是传给另一个jsp只能用java代码的getParameter来请求不能用${infoType},${infoType}等效于request.getAttribute("infoType")它的传值只能是后台setAttribute("infoType")设置-->
				<div id="nav-mark" class="enter">
					<ul style="list-style: none;">
						<li><a href="home.jsp">首页</a></li>
						<li><a href="setGoodsInfoType?infoType=寻物&url=showGoodsList">寻物信息</a></li>
						<li><a href="setGoodsInfoType?infoType=招领&url=showGoodsList">招领信息</a></li>
						<li><a href="showThanksList.jsp">感谢墙</a></li>
						<li><a href="successEvents.jsp">成功案例</a></li>
						<li><a href="helpCenter.jsp">帮助中心</a></li>
						<li><a href="aboutUs.jsp">关于我们</a></li>
					</ul>
				</div>
				<div id="login-enter" class="enter">
					<ul style="list-style: none;margin:0;padding:0;">
						<c:if test="${empty loginUser}">
							<li><a href="login.jsp"><img src="resources/images/login.ico" >登录</a></li>
							<li><a href="register.jsp">注册</a></li>
						</c:if>
						<c:if test="${not empty loginUser}">
							<li id="welcome">欢迎,亲爱的${loginUser.username}</li>
							<li><a href="personalInfo.jsp" onclick="return judgeIsLogin();">个人中心</a></li>
							<li><a href="userLogout">注销</a></li>
						</c:if>
					</ul>
				</div>
			</nav>
	</div>
	<script type="text/javascript">
		function judgeIsLogin() {
			if("${empty loginUser}"=="true"){
				alert("请先登录");
				return false;
			}
			return true;
		}
	</script>
</body>
</html>