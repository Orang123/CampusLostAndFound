<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>评论信息详情</title>
<style type="text/css">
	body {
		width: 100%;
		margin: 0;
	}
	.comment-detail{
		width:700px;
		font-family:'仿宋';
		margin:15px auto;
		padding:20px;
		border:2px solid #a0b1c4;/*#cacaca*/
		box-shadow: 10px 10px 5px #888888;
	}
	.comment-header{
		width:680px;
		position:relative;
		font-family: microsoft yahei;
		font-size: 20px;
		background:#eee;
		border-radius: 3px;
		height:40px;
		line-height: 40px;
		padding-left: 5px;
	}
	.comment-content{
		width:600px;
		height:160px;
		border: 6px solid #EAEAEA;
		font-size: 18px;
		text-indent: 20px;
	}
</style>
</head>
<body>
	<div class="comment-detail">
		<div class="comment-header">
			<span style="font-weight: bolder;">
				<c:if test="${goods.infoType == '寻物'}">
					寻物标题:
				</c:if>
				<c:if test="${goods.infoType == '招领'}">
					招领标题:
				</c:if>
				${goods.title}
			</span>
			<span style="position: absolute;right:5px;">${comment.user.username}  发表于: ${comment.publishTime}</span>
		</div>
		<br>
		<div class="comment-content">${comment.content}</div>
	</div>
</body>
</html>