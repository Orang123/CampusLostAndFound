<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.css"/>
<script type="text/javascript" src="resources/js/jquery-3.4.1.js"></script>
<title>修改用户密码</title>
<style type="text/css">
	.edit-password{
		margin:10px 10px;
		padding:20px;
		width:720px;
		border:2px solid #a0b1c4;/*#cacaca*/
		box-shadow: 5px 5px 5px #888888;/*这个垂直下部的阴影如果iframe的高度好过总高度产生滑动条阴影会失效 */
	}
	.form-item{
		margin-top: 10px;
		font-family: '仿宋';
	}
	.form-item input[type=button]{
		width:50px;
		height:35px;
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
	<div class="edit-password">
		<form action="" id="edit-form">
			<input type="hidden" name="id" value="${loginUser.id}"/>
			<input type="hidden" name="loginName" value="${loginUser.username}"/>
			<div class="form-item">
				<font id="return-message" style="color: red"></font>
			</div>
			<div class="form-item">
				<label style="margin-left: 32px;">旧密码:</label>
				<input type="password" name="oldPassword"/>
			</div>
			<div class="form-item">
				<label style="margin-left: 32px;">新密码:</label>
				<input type="password" name="password"/>
			</div>
			<div class="form-item">
				<label>确认新密码:</label>
				<input type="password" name="confirmPassword"/>
			</div>
			<div class="form-item">
				<input type="button" onclick="edit()" value="提交"/>&nbsp;
				<input type="button" onclick="reset()" value="重置">
			</div>
		</form>
	</div>
	<script type="text/javascript">
		function edit() {
			$.ajax({
				url:"${pageContext.request.contextPath}/editPassword",
				data:$('#edit-form').serialize(),
				type:"POST",
				datatype:"html",
				success:function(data){
					if(data!="密码修改成功"){
						$("#return-message").html(data);
					}
					else{
						reset();
						alert("密码修改成功");
					}
				}
			});
		};
		
		function reset() {
			$("#edit-form input[type='password']").each(function () {
				$(this).val("");
			});
			$("#return-message").html("");
		};
	</script>
</body>
</html>