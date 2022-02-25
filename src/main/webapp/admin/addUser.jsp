<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<meta charset="UTF-8">
<title>添加用户</title>
<style type="text/css">
	.place{
		background: url("../resources/images/place_bg.gif");
		background-size: 100% 100%;
	}
	.place ul{
		margin: 0;
		padding:0;
		list-style: none;
		display: inline-block;
	}
	.place span{
		font-weight: bolder;
	}
	.place ul li{
		height:40px;
		line-height:40px;
		display: inline-block;
		padding-right:12px;
		background: url("../resources/images/place-link.gif") no-repeat right;
		margin-left: 5px;
	}
	.place ul li:last-child{
		background: none;
	}
	.add-user{
		margin:15px auto;
		padding:20px;
		width:720px;
		border:2px solid #a0b1c4;/*#cacaca*/
		box-shadow: 10px 10px 5px #888888;/*这个垂直下部的阴影如果iframe的高度好过总高度产生滑动条阴影会失效 */
	}
	.form-item{
		margin-top: 10px;
		font-family: '仿宋';
	}
	.form-item input[type=button]{
		width:50px;
		height:40px;
		color:#fff;
		font-size:20px;
		background: #007BFF;/*#5A98DE*/
		padding: 0 5px;
		border: none;
		border-radius: 5px;
		font-weight: bolder;
	}
	.form-item input[type=button]:hover{
		background:#0069D9;/*#6AA2E0 #0069D9 #1E90FF*/
	}
</style>
</head>
<body>
	<div class="place">
		<span>位置:</span>
		<ul>
			<li>后台管理</li>
			<li>用户信息管理</li>
			<li>添加用户</li>
		</ul>
	</div>
	<div class="add-user">
		<form action="" class="adduser-form">
			<div class="form-item">
				<label>用户名:</label>
				<input type="text" name="username" id="username"/>
				<font id="username-message"></font>
			</div>
			<div class="form-item">
				<label style="margin-left: 16px;">密码:</label>
				<input type="password" name="password" id="password"/>
				<font id="password-message"></font>
			</div>
			<div class="form-item">
				<label style="margin-left: 32px;">QQ:</label>
				<input type="text" name="qq" id="qq"/>
				<font id="qq-message"></font><br>
			</div>
			<div class="form-item">
				<label style="margin-left: 16px;">邮箱:</label>
				<input type="text" name="email" id="email"/>
				<font id="email-message"></font>
			</div>
			<div class="form-item">
				<label>用户组:</label>
				<select name="role">
					<option value="-1">黑名单</option>
					<option value="0" selected="selected">普通用户</option>
					<option value="1">群聊管理员</option>
					<option value="2">后台管理员</option>
				</select>
			</div>
			<div class="form-item">
				<input type="button" id="publish-btn" value="提交"  /> &nbsp;
				<input type="button" id="reset" value="重置">
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
		$("#username").blur(function () {
			$.ajax({
				url:"${pageContext.request.contextPath}/usernameJudge",
				data:{"username":$("#username").val()},
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data=="该用户名可正常使用")
						$("#username-message").attr("color","green");
					else
						$("#username-message").attr("color","red");
					$("#username-message").html(data);
				}
			});
		});
		
		$("#password").blur(function () {
			$.ajax({
				url:"${pageContext.request.contextPath}/passwordJudge",
				data:{"password":$("#password").val()},
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data=="密码符合要求")
						$("#password-message").attr("color","green");
					else
						$("#password-message").attr("color","red");
					$("#password-message").html(data);
				}
			});
		});
		
		$("#qq").blur(function () {
			$.ajax({
				url:"${pageContext.request.contextPath}/qqJudge",
				data:{"qq":$("#qq").val()},
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data=="QQ号码格式符合标准")
						$("#qq-message").attr("color","green");
					else
						$("#qq-message").attr("color","red");
					$("#qq-message").html(data);
				}
			});
		});
		
		$("#email").blur(function () {
			$.ajax({
				url:"${pageContext.request.contextPath}/emailJudge",
				data:{"email":$("#email").val()},
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data=="邮箱格式正确")
						$("#email-message").attr("color","green");
					else
						$("#email-message").attr("color","red");
					$("#email-message").html(data);
				}
			});
		});
		
		$("#publish-btn").click(function () {
			var flag=false;
			$("#adduser-form input").each(function () {
				if($(this).attr("type")!="submit" && $(this).attr("type")!="button"){
					if($(this).val()==""){
						alert("请将用户信息补充完整");
						flag=true;
						return false;
					}
				}
			});
			
			$("#adduser-form font").each(function () {
				if($(this).attr("color")=="red"){
					alert("请检查用户信息,有部分错误");
					flag=true;
					return false;
				}
			});
			if(flag) return false;
			$.ajax({
				url:"${pageContext.request.contextPath}/addUser",
				data:$(".adduser-form").serialize(),
				type:"POST",
				dataType:"html",
				success:function(data){
					if(data=="成功添加一条用户信息"){
						alert(data);
						reset();
					}
				}
			});
		});
		
		$("#reset").click(function () {
			reset();
		});
		
		function reset() {
			$(".adduser-form input").each(function () {
				if($(this).attr("type")!="submit" && $(this).attr("type")!="button")
					$(this).val("");
			});
			
			$(".adduser-form font").each(function () {
				$(this).html("");
			});
		};
		
	</script>
</body>
</html>