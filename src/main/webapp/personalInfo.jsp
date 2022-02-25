<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
<title>个人信息</title>
<script type="text/javascript" src="resources/js/jquery-3.4.1.js"></script>
<style type="text/css">
	body{
		font-family: 'microsoft yahei';
		margin: 0;
		padding: 0;
		background: #F3F3FA;
	}
	.middle-content{
		background:#fff;
		width: 1238px;
		margin: 10px auto;
		border: 6px solid #EAEAEA;
		box-shadow: 5px 5px 5px #888888;
	}
	.middle-content::after{/* 解决浮动塌陷问题,middle-content里只有浮动元素时,它的高度没有被撑起来,在其后加一个清楚浮动流块级元素*/
		content: "";
		display: block;
		clear: left;
	}
	ul{
		list-style: none;
	}
	#left-nav-menu{
		width:190px;
		float: left;
		height:628px;
		background: #FAFAFA;
	}
	.left-nav-title{
		color:white;
		height:40px;
		line-height:40px;
		background:	url("resources/images/menu_title_bg.gif") repeat-x;
		position: relative;
	}
	.left-nav-title i{
		position: absolute;
		width: 25px;
		height: 23px;
		top: 9px;
		background-image: url("resources/images/personalInfo.png");
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
		background:#eff0f0;
		height:35px;
		line-height:35px;
		position:relative;
		cursor: pointer;
		font-weight: bolder;
		border-bottom: solid black 1px;
	}
	.li-01 div i{
		position: absolute;
		top:10px;
		width: 16px;
		height: 16px;
		background-image:url("resources/images/leftico02.png");
	}
	.li-01 div span{
		margin-left: 25px;
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
		background: url("resources/images/selected_left_item.png");
		background-size:100% 100%;
		color: white;
	}	
	.li-01 li a .left-pic{
		position: absolute;
		top:9px;
		left:15px;
		width: 16px;
		height: 16px;
		background-image:url("resources/images/list.gif");
	}
	.li-01 li a.active{/*是选择类名为 active 的 a 对其生效*/
		background: url("resources/images/selected_left_item.png");
		background-size:100% 100%;
		color: white;
	}
	.li-01 li a.active .left-pic{/*是选择类名为 active 的 a下的left-pic类 对其生效*/
		background-image:url("resources/images/list1.gif");
	}
	.li-01 li a.active .right-pic{
		position:absolute;
		width:6px;
		height:11px;
		background-image:url("resources/images/right_pic.png");
		top:11px;
		right: 0px;
	}
	.li-01 li a span{
		margin-left:35px;
	}
	.right-content{
		margin-left:190px;
		height: 650px;
	}
</style>
</head>
<body>
	<header>
		<jsp:include page="header.jsp"></jsp:include>
	</header>
	<div class="middle-content">
		<div id="left-nav-menu">
			<div class="left-nav-title">
				<i></i><span>个人信息栏</span>
			</div>
			<ul>
				<li class="li-01">
					<div>
						<i></i><span>个人首页</span>
					</div>
					<ul>
						<li>
							<a href="changePassword.jsp" target="content">
								<i class="left-pic"></i><span>修改密码</span><i class="right-pic"></i>
							</a>
						</li>
					</ul>
				</li>
				<li class="li-01">
					<div>
						<i></i><span>个人发布失物</span>
					</div>
					<ul>
						<li>
							<a href="setGoodsInfoType?infoType=寻物&url=myGoods" target="content">
								<i class="left-pic"></i><span>我的寻物信息</span><i class="right-pic"></i>
							</a>
						</li>
						<li>
							<a href="setGoodsInfoType?infoType=招领&url=myGoods" target="content">
								<i class="left-pic"></i><span>我的招领信息</span><i class="right-pic"></i>
							</a>
						</li>
					</ul>
				</li>
				<li class="li-01">
					<div>
						<i></i><span>个人认领或归还物品</span>
					</div>
					<ul >
						<li>
							<a href="setGoodsInfoType?infoType=寻物&url=myFinishedTransaction" target="content">
								<i class="left-pic"></i><span>我的拾物归还信息</span><i class="right-pic"></i>
							</a>
						</li>
						<li>
							<a href="setGoodsInfoType?infoType=招领&url=myFinishedTransaction" target="content">
								<i class="left-pic"></i><span>我的失物认领信息</span><i class="right-pic"></i>
							</a>
						</li>
					</ul>
				</li>
				<li class="li-01">
					<div>
						<i></i><span>个人发布感谢信</span>
					</div>
					<ul>
						<li>
							<a href="myThanks.jsp" target="content">
								<i class="left-pic"></i><span>我的感谢信</span><i class="right-pic"></i>
							</a>
						</li>
					</ul>
				</li>
			</ul>
		</div>
		
		<div class="right-content">
			<iframe name="content" width="100%" height="100%" srcdoc="欢迎,亲爱的${loginUser.username}" style="border: 0;">
			</iframe>
		</div>
	</div>
	
	<footer>
		<jsp:include page="footer.jsp"></jsp:include>
	</footer>
	
	<script type="text/javascript">
			
		$(".li-01 div").mouseover(function () {
			$(this).css("background","#C0C0C0");
		});
		
		$(".li-01 div").mouseout(function () {
			$(this).css("background","#eff0f0");
		});
		
		//bind里的 function不能直接写showOrClose() 这是一种固定的写法
		$(".li-01 div").each(function () {
			$(this).click(function () {
				showOrClose($(this).next());
			});
		});
		
		
		$(".li-01 li a").click(function () {
			if("${empty loginUser}"=="true"){
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