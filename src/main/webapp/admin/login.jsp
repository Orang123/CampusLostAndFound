<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="../resources/images/favicon.ico" type="image/x-icon" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<title>管理员登陆</title>
<style type="text/css">
	/*清除IE浏览器中input元素的删除和查看密码图标 */
	::-ms-clear, ::-ms-reveal{
    	display: none;
	}
	body{
		margin:0;
		padding-top:1px;/* 这里为了避免login-content和body的margin-top重叠,导致body的height增大*/
		height:728px;
		background: url("../resources/images/admin_login_bg.jpg") no-repeat;
		background-size: 100% 100%;
	}
	.title{
		margin-top:30px;
		text-align: center;
	}
	.title img{
		box-shadow: 5px 5px 5px #888888;
	}
	.login-content{
		padding-top:1px;/*父容器设置padding-top和overflow:hidden可解决 第一个子容器设置margin-top后和父容器发生外边距合并,一个盒子如果没有上补白padding-top，那么这个盒子的上边距会和其内部文档流中的第一个子元素的上边距重叠。 */
		width:650px;
		height:320px;
		margin: 80px auto;
		box-shadow: 8px 8px 8px #888888;
		background: url("../resources/images/manage_login_bg.png") no-repeat;
		background-size: 100% 100%;
	}
	#login-form{
		width: 280px;
		margin-top:70px;
		margin-left:268px;
	}
	.form-item{
		margin-bottom:15px;
		position: relative;
	}
	.form-item label{
		background-image: url(../resources/images/login-icons.png);
		background-position:0 0;
		position: absolute;/* 这里设置绝对定位一方面它脱离文档流使得display为inline-block,这样设置的宽高才有意义,行级元素不能设置宽高,另一方面它就可以浮动在input上*/
		top:1px;
		left:1px;
		width:38px;
		height:38px;
		border-right:1px solid #bdbdbd;
	}
	.form-item input{
		width: 100%;
		padding: 10px 0 10px 47px;
		outline: none;
		box-sizing: border-box;/*设置为border-box怪异盒模型,使得input button类型与text类型方便对齐*/
	}
	#kaptcha-img{
		width:100px;
		vertical-align:middle;
		height:40px;
		cursor: pointer;
		position: absolute;
		right:0px;
	}
	#login-btn{
		padding: 5px 0;
		font-size: 20px;
		border-radius: 5px;
		cursor:pointer;
		border: 0;
		color:#fff;
		background: #5A98DE;
	}
	#login-btn:hover{
		background: #6AA2E0;
	}
	.footer{
		font-size:12px;
		font-family:'microsoft yahei';
		margin-top:155px;
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
		<img src="../resources/images/lostfound.png" width="400px" height="100px">
	</div>
	
	<div class="login-content">
		<form id="login-form">
			<div class="form-item">
				<font id="return-message" style="color: red"></font>
			</div>
			<div class="form-item">
				<label for="username"></label>
				<input type="text" id="username" name="username" placeholder="用户名" maxlength="20" autocomplete="off"/>
			</div>
			<div class="form-item">
				<label for="password" style="background-position: -48px 0;"></label>
				<input type="password" id="password" name="password" placeholder="密码" maxlength="20"/>
			</div>
			<div class="form-item">
				<label for="verifyCode" style="background-image: url(../resources/images/verifycode1.png);background-size:100% 100%;"></label>
				<input type="text" id="verifyCode" name="verifyCode" placeholder="验证码" autocomplete="off" maxlength="4"/>
				<img alt="加载验证码失败" id="kaptcha-img" src="../kaptchaCode">
			</div>
			<div class="form-item">
				<input type="button" id="login-btn" onclick="login()" value="登 陆"/>
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
		if("${not empty loginAdmin}"=="true")
			window.location.href="home.jsp";
		function login() {
			$.ajax({
				url:"${pageContext.request.contextPath}/adminLogin",
				data:$('#login-form').serialize(),
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data!="登陆成功"){
						$("#return-message").html(data);
						$('#kaptcha-img').attr('src','../kaptchaCode?'+new Date().getTime());						
					}
					else{
						alert(data);
						window.location.href="home.jsp";						
					}
				}
			});
		};
		$("#username").focus(function () {
			$(this).prev().css("background-position","0 -48px");
		});
		
		$("#username").blur(function () {
			$(this).prev().css("background-position","0 0");
		});
		
		$("#password").focus(function () {
			$(this).prev().css("background-position","-48px -48px");
		});
		
		$("#password").blur(function () {
			$(this).prev().css("background-position","-48px 0");
		});
		
		$("#verifyCode").focus(function () {
			$(this).prev().css("background-image","url(../resources/images/verifycode2.png)");
		});
		
		$("#verifyCode").blur(function () {
			$(this).prev().css("background-image","url(../resources/images/verifycode1.png)");
		});
		
		$('#kaptcha-img').click(function () {
			$('#kaptcha-img').attr('src','../kaptchaCode?'+new Date().getTime());
		});
	</script>

</body>
</html>