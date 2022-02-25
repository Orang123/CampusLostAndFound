<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
<title>感谢信信息详情</title>
<style type="text/css">
	body {
		width: 100%;
		margin: 0;
		background: #F3F3FA;
	}
	.middle-content{
		background:#fff;
		width: 1250px;
		margin: 10px auto;
	}
	.thanks-detail{
		width:550px;
		font-family:'仿宋';
		padding:20px;
		border:2px solid #a0b1c4;/*#cacaca*/
		box-shadow: 10px 10px 5px #888888;
	}
	.thanks-header{
		position:relative;
		font-family: microsoft yahei;
		font-size: 20px;
		background:#eee;
		border-radius: 3px;
		height:40px;
		line-height: 40px;
		padding-left: 5px;
	}
	.thanks-content{
		width:450px;
		height:160px;
		border: 6px solid #EAEAEA;
		font-size: 18px;
		text-indent: 20px;
	}
</style>
</head>
<body>
	<header>
		<jsp:include page="../header.jsp"></jsp:include>
	</header>
	<div class="middle-content">
		<div class="thanks-detail">
			<div class="thanks-header">
				<span style="font-weight: bolder;">${thanksLetter.title}</span>
				<span style="position: absolute;right:5px;">${thanksLetter.user.username}  发表于: ${fn:substring(thanksLetter.publishTime,0,16)}</span>
			</div>
			<br>
			<div class="thanks-content">${thanksLetter.content}</div>
		</div>
	</div>
	<footer>
		<jsp:include page="../footer.jsp"></jsp:include>
	</footer>
</body>
</html>