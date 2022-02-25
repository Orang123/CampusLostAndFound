<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.css"/>
<script type="text/javascript" src="../resources/js/jquery-3.4.1.js"></script>
<title>发布帮助信息</title>
<style type="text/css">
	body{
		padding:0;
		margin: 0;	
		width: 100%;
		/*overflow-y:hidden;*/
	}
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
		margin-bottom: 0;/* 这里不知道为什么会多出来margin-bottom*/
	}
	.place ul li:last-child{
		background: none;
	}
	.publish-helpInfo{
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
	#helpInfo-content{
		box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.16);
		border-radius: 3px;
		resize:none;
	}
	.form-item input[type=button]{
		width:130px;
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
			<li>帮助信息管理</li>
			<li>添加帮助信息</li>
		</ul>
	</div>
	
	<div class="publish-helpInfo">
		<h5 style="font-family: '楷体';font-weight: bolder;">发布帮助信息</h5>
		<form action="" class="helpInfo-form">
			<input type="hidden" name="user.id" value="${loginAdmin.id}">
			<div class="form-item">
				<label>标题:</label>&nbsp;&nbsp;
				<input type="text" name="title" style="width:500px" id="title"/>
			</div>
			<div class="form-item">
				<label>内容:</label>&nbsp;&nbsp;
				<textarea id="helpInfo-content" rows="5" cols="59" name="content"></textarea>
			</div>
			<div class="form-item">
				<input type="button" value="发布帮助信息" id="publish-btn">
			</div>
		</form>
	</div>
	<!-- form action="publishThanks" 这里publishThanks前面不能加/,否则会导致Web访问url里没有CamppusLostAndFound项目名 -->
	<script type="text/javascript">
		function reset() {
			$("input[name=title]").val("");
			$("#helpInfo-content").val("");
		}
		$("#publish-btn").click(function () {
			if($("#title").val()=="" || $("#helpInfo-content").val()==""){
				alert("请检查帮助信息是否填写完整");
				return false;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/publishHelpInfo",
				data:$(".helpInfo-form").serialize(),
				type:"POST",
				dataType:"html",
				success:function(data){
					if(data=="成功添加一条帮助信息"){
						alert(data);
						reset();
					}
				}
			});
		});
	</script>
</body>
</html>