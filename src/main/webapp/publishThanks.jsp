<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"/>
<script type="text/javascript" src="resources/js/jquery-3.4.1.js"></script>
<title>发布感谢信息</title>
<style type="text/css">
	body{
		padding:0;
		margin: 0;	
		width: 100%;
		background: #F3F3FA;
		/*overflow-y:hidden;*/
	}
	header input{
		font-size: 14px;
	}
	header #search-btn,header #advanced-search{
		height: 25px;
	}
	.middle-content{
		background:#fff;
		width: 1250px;
		margin: 10px auto;
	}
	.publish-thanks{
		padding:20px;
		width:720px;
		border:2px solid #a0b1c4;/*#cacaca*/
		box-shadow: 10px 10px 5px #888888;/*这个垂直下部的阴影如果iframe的高度好过总高度产生滑动条阴影会失效 */
	}
	.form-item{
		margin-top: 10px;
		font-family: '仿宋';
	}
	#thanks-content{
		box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.16);
		border-radius: 3px;
		resize:none;
	}
	.form-item input[type=submit]{
		width:120px;
		height:40px;
		color:#fff;
		font-size:20px;
		background: #007BFF;/*#5A98DE*/
		padding: 0 5px;
		border: none;
		border-radius: 5px;
		font-weight: bolder;
	}
	.form-item input[type=submit]:hover{
		background:#0069D9;/*#6AA2E0 #0069D9 #1E90FF*/
	}
</style>
</head>
<body>
	<header>
		<jsp:include page="header.jsp"></jsp:include>
	</header>
	<div class="middle-content">
		<div class="publish-thanks">
			<h5 style="font-family: '楷体';font-weight: bolder;">发布感谢信</h5>
			<form action="${pageContext.request.contextPath}/publishThanks" method="get">
				<input type="hidden" name="user.id" value="${loginUser.id}">
				<div class="form-item">
					<label>标题:</label>&nbsp;&nbsp;
					<input type="text" name="title" style="width:500px" id="title"/>
				</div>
				<div class="form-item">
					<label>内容:</label>&nbsp;&nbsp;
					<textarea id="thanks-content" rows="5" cols="59" name="content" id="content"></textarea>
				</div>
				<div class="form-item">
					<input type="submit" value="发表感谢信" id="publish-btn">
				</div>
			</form>
		</div>
	</div>
	<footer>
		<jsp:include page="footer.jsp"></jsp:include>
	</footer>
	<!-- form action="publishThanks" 这里publishThanks前面不能加/,否则会导致Web访问url里没有CamppusLostAndFound项目名 -->
	<script type="text/javascript">
		$("#publish-btn").click(function () {
			if( $("#title").val()=="" || $("#content").val()=="" ){
				alert("请检查感谢信信息是否填写完整");
				return false;
			}
			alert("以成功发布感谢信信息");
		});
	</script>
</body>
</html>