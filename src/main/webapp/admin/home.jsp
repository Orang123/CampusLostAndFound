<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="../resources/images/favicon.ico" type="image/x-icon" />
<title>后台管理</title>
<script type="text/javascript" src="../resources/js/jquery-3.4.1.js"></script>
<style type="text/css">
	body{
		font-family: 'microsoft yahei';
		margin: 0;
		padding: 0;
	}
	#top-menu{
		color:white;
		background-image: url("../resources/images/top_menu_bg.gif");
		background-size:100% 100%;
		height:100px;
	}
	#top-menu li{
		display: inline;
		margin-left: 5px;
	}
	#top-menu li a{
		color: white;
		text-decoration: none;
	}
	#top-menu li a:hover{
		color: red;
	}
	ul{
		list-style: none;
	}
	#left-nav-menu{
		width:190px;
		float: left;
		height:628px;
		background: #f0f9fd;
	}
	.left-nav-title{
		color:white;
		height:40px;
		line-height:40px;
		background:	url("../resources/images/menu_title_bg.gif") repeat-x;
		position: relative;
	}
	.left-nav-title i{
		position: absolute;
		width: 20px;
		height: 21px;
		top: 9px;
		background-image: url("../resources/images/leftico.png");
	}
	.left-nav-title span{
		margin-left: 30px;
	}
	#left-nav-menu ul{
		font-size:14px;
		margin: 0;
		padding: 0;
	}
	#left-nav-menu .li-01 div{
		background:url("../resources/images/left_item_bg.gif") repeat-x;
		height:35px;
		line-height:35px;
		position:relative;
		cursor: pointer;
		font-weight: bolder;
		/*border: solid black 1px;*/
	}
	.li-01 div i{
		position: absolute;
		top:10px;
		width: 16px;
		height: 16px;
		background-image:url("${pageContext.request.contextPath}/resources/images/leftico01.png");
	}
	.li-01 div span{
		margin-left: 25px;
	}
	.li-01 div span:hover{
		color: #00A4AC;
	}
	#left-nav-menu .li-01 ul{
		display: none;
	}
	.li-01 li a{
		display:block;
		height:35px;
		line-height:35px;
		color:black;
		text-decoration: none;
		position: relative;
		width: 100%;
	}
	.li-01 li a:hover{
		color:#00A4AC;
	}	
	.li-01 li a .left-pic{
		position: absolute;
		top:9px;
		left:15px;
		width: 16px;
		height: 16px;
		background-image:url("../resources/images/list.gif");
	}
	.li-01 li a.active{/*是选择类名为 active 的 a 对其生效*/
		background: url("../resources/images/selected_left_item.png");
		background-size:100% 100%;
		color: white;
	}
	.li-01 li a.active .left-pic{/*是选择类名为 active 的 a下的left-pic类 对其生效*/
		background-image:url("../resources/images/list1.gif");
	}
	.li-01 li a.active .right-pic{
		position:absolute;
		width:6px;
		height:11px;
		background-image:url("../resources/images/right_pic.png");
		top:11px;
		right: 0px;
	}
	.li-01 li a span{
		margin-left:35px;
	}
	#middle-content{
		margin-left:190px;
		height:595px;
	}
	.footer{
		font-size:12px;
		text-align: center;
		/*#e2e9ea #f7fbfc*/
		background: #e2e9ea;
	}
	.footer a{
		color:black;
		text-decoration: none;
	}
	.footer a:hover{
		color: red;
		text-decoration: underline;
	}
</style>
</head>
<body>
	
	<div id="top-menu">
		<h3 style="margin: 0;display: inline-block;">湘潭大学失物招领平台后台管理系统</h3>
		<ul style="float: right;padding: 0px;margin: 0px;">
			<c:if test="${empty loginAdmin}">
				<li><a href="login.jsp">登陆</a></li>
				<li><a href="">注册</a></li>
			</c:if>
			<c:if test="${not empty loginAdmin}">
				<li>欢迎,亲爱的${loginAdmin.username}</li>
				<li><a href="${pageContext.request.contextPath}/adminLogout">注销</a></li>
			</c:if>
		</ul>
	</div>
	
	<!-- ul默认是有margin和padding的
		 padding这里必须设置为0li标签才能和顶部的ul对齐 
	 	 margin这里设置为0才能和外部的div间距为0 -->
	<div id="left-nav-menu">
		<div class="left-nav-title">
			<i></i><span>菜单栏</span>
		</div>
		<ul>
			<li class="li-01">
				<div>
					<i></i><span>后台首页</span>
				</div>
				<ul>
					<li>
						<a href="#">
							<i class="left-pic"></i><span>后台首页</span><i class="right-pic"></i>
						</a>
					</li>
				</ul>
			</li>
			<li class="li-01">
				<div>
					<i></i><span>用户信息管理</span>
				</div>
				<ul >
					<li>
						<a href="showUserList.jsp" target="content">
							<i class="left-pic"></i><span>用户信息列表</span><i class="right-pic"></i>
						</a>
					</li>
					<li>
						<a href="addUser.jsp" target="content">
							<i class="left-pic"></i><span>添加用户</span><i class="right-pic"></i>
						</a>
					</li>
					<li>
						<a href="editPassword.jsp" target="content">
							<i class="left-pic"></i><span>修改密码</span><i class="right-pic"></i>
						</a>
					</li>
				</ul>
			</li>
			<li class="li-01">
				<div>
					<i></i><span>物品信息管理</span>
				</div>
				<ul >
					<li>
						<a href="../forwardGoodsInfoType?infoType=寻物&url=showGoodsList" target="content">
							<i class="left-pic"></i><span>寻物信息列表</span><i class="right-pic"></i>
						</a>
					</li>
					<li>
						<a href="../forwardGoodsInfoType?infoType=招领&url=showGoodsList" target="content">
							<i class="left-pic"></i><span>招领信息列表</span><i class="right-pic"></i>
						</a>
					</li>
				</ul>
			</li>
			<li class="li-01">
				<div>
					<i></i><span>感谢信信息管理</span>
				</div>
				<ul >
					<li>
						<a href="showThanksList.jsp" target="content">
							<i class="left-pic"></i><span>感谢信列表</span><i class="right-pic"></i>
						</a>
					</li>
				</ul>
			</li>
			<li class="li-01">
				<div>
					<i></i><span>评论信息管理</span>
				</div>
				<ul >
					<li>
						<a href="showCommentList.jsp" target="content">
							<i class="left-pic"></i><span>评论列表</span><i class="right-pic"></i>
						</a>
					</li>
				</ul>
			</li>
			<li class="li-01">
				<div>
					<i></i><span>帮助信息管理</span>
				</div>
				<ul>
					<li>
						<a href="showHelpInfoList.jsp" target="content">
							<i class="left-pic"></i><span>帮助信息列表</span><i class="right-pic"></i>
						</a>
					</li>
					<li>
						<a href="publishHelpInfo.jsp" target="content">
							<i class="left-pic"></i><span>添加帮助信息</span><i class="right-pic"></i>
						</a>
					</li>
				</ul>
			</li>
		</ul>
	</div>
	<div id="middle-content">
		<iframe name="content" width="100%" height="100%" srcdoc="欢迎使用失物招领后台管理系统" style="border: 0;">
		</iframe>
	</div>
	<div class="footer">
		<a href="https://www.xtu.edu.cn/" target="_blank">学校主页</a>
		&nbsp;|&nbsp;
		<a href="http://jwxt.xtu.edu.cn/jsxsd/" target="_blank">教务管理系统</a>
		&nbsp;|&nbsp;
		<a href="https://portal2020.xtu.edu.cn" target="_blank">信息门户</a>
		&nbsp;|&nbsp;
		<a href="http://cie.xtu.edu.cn/ciextu_new/" target="_blank">信息工程学院</a>
		<br>
		Copyright &copy; 2019 - 2020 Orang Inc. All Rights Reserved.
	</div>
	<script type="text/javascript">
			
		//bind里的 function不能直接写showOrClose() 这是一种固定的写法
		$(".li-01 div").each(function () {
			$(this).click(function () {
				showOrClose($(this).next());
			});
		});
		
		
		$(".li-01 li a").click(function () {
			if("${empty loginAdmin}"=="true"){
				alert("请先登录");
				return false;
			}
			$(".li-01 li a.active").removeClass("active");//将之前所选择的a标签渲染的active类去除掉
			$(this).addClass("active");//将现在点击的active类对当前a生效
		});
		
		function showOrClose(obj){
			if(obj.css("display")=='none')
				obj.slideDown("fast");
			else
				obj.slideUp("fast");
		};
		//这种function judgeIsLogin判断是否登录只能用在提交表单和点击超链接才可以单独写一个判断函数
		//判断方法:onclick="return judgeIsLogin();"(超链接) onsubmit="return judgeIsLogin();"(表单)
	</script>
</body>
</html>