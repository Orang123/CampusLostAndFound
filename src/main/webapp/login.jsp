<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户登陆页面</title>
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
<script type="text/javascript" src="resources/js/jquery-3.4.1.js"></script>
<style type="text/css">
	::-ms-clear, ::-ms-reveal{
    	display: none;
	}
	body{
		padding-top:1px;
		margin:0;
		height:728px;/* 刚好设置为一个浏览器窗体的高度*/
		background-image: url("resources/images/login_bg.jpg");
		background-size: 100% 100%;
		background-repeat: no-repeat;
	}
	.title{
		margin-top:50px;
		text-align: center;
	}
	.title img{
		box-shadow: 10px 10px 5px #888888;
	}
	.login-content{
	    margin: 50px auto;
		width:350px;
		border:2px solid #a0b1c4;
		box-shadow: 8px 8px 8px #888888;
		background: #fff;
	}
	.info-title{
		position: relative;
		margin-top:15px;
		margin-bottom: 25px;
	}
	#verify-pic{
		width:50px;
		height:50px;
		background-image: url(resources/images/user_login.png);
		background-size: 100% 100%;
		position: absolute;
		left:18px;
	}
	#mark-text{
		display: inline-block;
		margin:5px 0 0 30px;
		padding-left:40px;
		color: red;
		font-size: 26px;
		font-family: 'microsoft yahei';
		font-weight: bold;
	}
	#login-form div{
		margin-bottom: 15px;
		text-align: center;
	}
	.login-input{
		position: relative;
	}
	#return-message{
		color: red;
		font-family: 'microsoft yahei';
	}
	#login-form label{
		background-image: url(resources/images/login-icons.png);
		background-position:0 0;
		position: absolute;/* 这里设置绝对定位一方面它脱离文档流,这样设置的宽高才有意义,行级元素不能设置宽高,另一方面它就可以浮动在input上*/
		width:38px;
		height:38px;
		top:1px;
		left:23px;
		border-right:1px solid #bdbdbd;
	}
	input[type=text],input[type=password]{
		width:73%;
		padding: 9px 0 10px 47px;
		outline: none;
		font-family: 'microsoft yahei';
	}
	.clear-btn{
		visibility:hidden;
		width: 14px;
		height: 14px;
		background-image:url(resources/images/login-icons.png);
		background-position:-25px -143px;
		cursor:pointer;
		position: absolute;
		left:309px;
		top:13px;
	}
	.clear-btn:hover{
		background-position:-50px -143px;
	}
	.kaptcha-img{
		padding:0;
		width: 305px;
		background-image: url(resources/images/kaptcha-bg.jpg);
		margin:0 auto;
		border: 1px solid #bdbdbd;
	}
	#kaptcha-img{
		width:150px;
		vertical-align:middle;
		height:40px;
		cursor: pointer;
	}
	#login-btn{
		width:309px;
		height:30px;
		padding:5px 0;
		margin-left:-2px;
		box-sizing:content-box;/*type=button或submit时box-sizing默认为border-box怪异盒模型,这时width宽度不计入paddinghe border,回导致和上面的text不能对齐 */
		border: none;
		border-radius:5px;
		background: #FF0000;
		color:white;
		cursor: pointer;
		font-size:20px;
		font-weight: bold;
		font-family: 'microsoft yahei';
	}
	#login-btn:hover{
		background: #FF4500;
	}
	.footer{
		font-size:12px;
		font-family:'microsoft yahei';
		margin-top:120px;
		text-align: center;
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
	<div class="title">
		<img src="resources/images/lostfound.png" width="350px" height="100px">
	</div>
	<div class="login-content">
		<div class="info-title">
			<label id="verify-pic" for="mark-text" ></label>
			<span id="mark-text" >用户登录</span>
		</div>
		<form action="" id="login-form">
			<div>
				<span id="return-message" style="color: red"></span>
			</div>
			<div class="login-input">
				<label for="username"></label>
				<input type="text" id="username" name="username" placeholder="用户名" maxlength="20"/>
				<span class="clear-btn"></span>
			</div>
			<div class="login-input">
				<label for="password" style="background-position: -48px 0;"></label>
				<input type="password" id="password" name="password" placeholder="密码" maxlength="20"/>
				<span class="clear-btn"></span>
			</div>
			<div class="kaptcha-img">
				<img alt="验证码加载失败,请点击图片" src="kaptchaCode" id="kaptcha-img">
			</div>
			<div class="login-input">
				<label for="verifyCode" style="background-image: url(resources/images/verifycode1.png);background-size:100% 100%;left:21px;"></label>
				<input type="text" id="verifyCode" name="verifyCode" placeholder="验证码" autocomplete="off" maxlength="4"/>
				<span class="clear-btn"></span>
			</div>
			<div>
				<input type="button" id="login-btn" onclick="login()" value="登  陆"/>
			</div>
		</form>
	
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
	
		function login() {
			$.ajax({
				url:"${pageContext.request.contextPath}/userLogin",
				data:$('#login-form').serialize(),
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data!="登陆成功"){
						$("#return-message").html(data);
						$('#kaptcha-img').attr('src','kaptchaCode?'+new Date().getTime());
					}
					else{
						alert(data);
						window.location.href="home.jsp";
					}
				}
			});
		};
		
		$('#kaptcha-img').click(function () {
			$('#kaptcha-img').attr('src','kaptchaCode?'+new Date().getTime());
		});
		
		$("#username").focus(function () {
			$(this).prev().css("background-position","0 -48px");
		});
		
		$("#username").blur(function () {
			$(this).prev().css("background-position","0 0");
		});
		
		$("#username,#password,#verifyCode").bind("input propertychange",function () {
			if($(this).val()!=""){
				if($(this).next().css("visibility")=="hidden")
					$(this).next().css("visibility","visible");
			}
			else
				$(this).next().css("visibility","hidden");
		});
		
		$(".clear-btn").mousedown(function (event) {
			event.preventDefault();
		});
		
		$(".clear-btn").click(function () {
			$(this).prev().val("");
			$(this).css("visibility","hidden");
			$(this).prev().focus();//这里是应对本身焦点不在输入框时,点击叉叉,焦点要回到输入框
		});
		
		$("#password").focus(function () {
			$(this).prev().css("background-position","-48px -48px");
		});
		
		$("#password").blur(function () {
			$(this).prev().css("background-position","-48px 0");
		});
		
		$("#verifyCode").focus(function () {
			$(this).prev().css("background-image","url(resources/images/verifycode2.png)");
		});
		
		$("#verifyCode").blur(function () {
			$(this).prev().css("background-image","url(resources/images/verifycode1.png)");
		});
		
	</script>
</body>
</html>