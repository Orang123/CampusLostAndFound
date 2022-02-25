<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
<title>关于我们</title>
<style type="text/css">
	body{
		background: #F3F3FA;
	}
	.middle-content{
		background:#fff;
		width: 1250px;
		margin: 10px auto;
	}
	.content-info{
		width: 800px;
		height:400px;
		border: 6px solid #EAEAEA;
		font-family: '仿宋';
		box-shadow: 5px 5px 5px #888888;
	}
	.content-info h3{
		text-align: center;
		font-family: 'microsoft yahei';
	}
	.content-info p{
		text-align: 20px;
		width: 700px;
	}
	
</style>
</head>
<body>
	<header>
		<jsp:include page="header.jsp"></jsp:include>
	</header>
	<div class="middle-content">
		<div class="content-info">
			<h3>关于本平台</h3>
			<p style="margin: 10px auto;text-indent: 30px;">
    			湘潭大学失物招领平台由Orang创立于2020年2月,旨在为方便失主寻找丢失物品、拾主归还捡拾物品和减轻失物招领中心的管理员的工作负担,以及发扬拾金不昧的美好品德和提高大学生的道德水平。
			</p>
			<h3>联系方式</h3>
			<p style="margin-left: 80px;">
				电话：18091005122<br>   
				Email:orang_913@qq.com<br>  
				地址：湖南省湘潭市雨湖区羊牯塘<br>  
				邮编：411105
			</p>
		</div>
	</div>
	<footer>
		<jsp:include page="footer.jsp"></jsp:include>
	</footer>
</body>
</html>