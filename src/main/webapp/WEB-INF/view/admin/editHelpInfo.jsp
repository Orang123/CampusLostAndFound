<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>编辑帮助信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<style type="text/css">
	.place{
		background: url("resources/images/place_bg.gif");
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
		background: url("resources/images/place-link.gif") no-repeat right;
		margin-left: 5px;
	}
	.place ul li:last-child{
		background: none;
	}
	.eidt-helpInfo{
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
		width:100px;
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
			<li>编辑帮助信息</li>
		</ul>
	</div>
	<div class="eidt-helpInfo">
		<form action="" id="edit-form">
			<input type="hidden" name="id" value="${helpInfo.id}"/>
			<div class="form-item">
				<font id="return-message" style="color: red"></font>
			</div>
			<div class="form-item">
				<label>标题:</label>&nbsp;&nbsp;
				<input type="text" name="title" style="width:500px" value="${helpInfo.title}"/>
			</div>
			<div class="form-item">
				<label>内容:</label>&nbsp;&nbsp;
				<textarea id="helpInfo-content" rows="5" cols="59" name="content" >${helpInfo.content}</textarea>
			</div>
			<div class="form-item">
				<input type="button" onclick="edit()" value="编辑完成"  /> &nbsp;&nbsp;
				<input type="button" onclick="cancel()" value="取消编辑">
			</div>
		</form>	
	</div>
	<script type="text/javascript">
	
		function edit() {
			$.ajax({
				url:"${pageContext.request.contextPath}/saveHelpInfo",
				data:$('#edit-form').serialize(),
				type:"POST",
				datatype:"html",
				success:function(data){
					if(data!="帮助信息修改成功")
						$("#return-message").html(data);
					else{
						alert("该条帮助信息修改成功");
						window.location.href="${pageContext.request.contextPath}/admin/showHelpInfoList.jsp";
					}
				}
			});
		};
		
		function cancel() {
			window.location.href="${pageContext.request.contextPath}/admin/showHelpInfoList.jsp";
		}
		
	</script>
</body>
</html>