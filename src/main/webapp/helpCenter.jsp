<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
<title>帮助中心</title>
<script type="text/javascript" src="resources/js/jquery-3.4.1.js"></script>
<style type="text/css">
	body{
		background: #F3F3FA;
	}
	.middle-content{
		background:#fff;
		width: 1250px;
		margin: 10px auto;
	}
	.middle-content::after{/* 解决浮动塌陷问题,middle-content里只有浮动元素时,它的高度没有被撑起来,在其后加一个清楚浮动流块级元素*/
		content: "";
		display: block;
		clear: left;
	}
	.help-menu{
		width:300px;
		height:400px;
		float: left;
		border: 6px solid #EAEAEA;
		font-family: '仿宋';
		box-shadow: 5px 5px 5px #888888;
	}
	.help-info{
		width: 280px;
		margin: 10px auto;
	}
	.help-link{
		position:relative;
		height: 30px;
		line-height: 30px;
	}
	.help-link img{
		margin-right: 10px;
	}
	.help-link>a{
		position:absolute;
		right:2px;
		color: black;
		font-weight: bolder;
	}
	.help-link>a:hover{
		color: red;
	}
	.help-info ul{
		width:280px;
		margin: 0 auto;
		padding: 0;
		list-style: none;
	}
	.help-info ul li{
		cursor: pointer;
		background: #fff;
	}
	.help-info ul li:hover{
		color: red;
		text-decoration: underline;
	}
	.online-chat{
		width:280px;
		margin: 10px auto;/*margin auto居中必须设置width,而且还不能是浮动元素*/
	}
	.online-chat a{
		text-align:center;
		display:block;
		width:280px;
		height:50px;
		background: #FF0000;
		line-height:50px;
		color: #fff;
		font-weight:bolder;
		text-decoration: none;
		font-size: 22px;
	}
	.online-chat a:hover{
		background: #FF4500;
	}
	.help-content{
		float: left;
		margin-left: 10px;
		width: 700px;
		height:400px;
		border: 6px solid #EAEAEA;
		font-family: '仿宋';
		box-shadow: 5px 5px 5px #888888;
	}
	.help-content div{
		display: none;
		margin-top: 15px;
	}
	.help-content h3{
		text-align: center;
		font-family: 'microsoft yahei';
	}
	.help-content p{
		margin: 10px auto;
		text-align: 20px;
		font-size: 15px;
		width: 600px;
		text-indent: 30px;
	}
</style>
</head>
<body>
	<header>
		<jsp:include page="header.jsp"></jsp:include>
	</header>
	
	<div class="middle-content">
		<div class="help-menu">
			<div class="help-info">
				<div class="help-link">
					<img style="width: 55px;height: 30px;" src="resources/images/the_new.jpg">
					<img style="width: 80px;height: 30px;" src="resources/images/help.jpg">
				</div>
				<hr width="100%">
				<ul>
					<li id="help-list1">湘潭大学失物招领平台使用规范</li><!-- 这里之前因为用a标签导致点击后跳转到本页面又重新加载一遍,导致看不出效果 -->
				</ul>
			</div>
			<hr width="95%">
			<div class="online-chat">
				<a href="chat/chattingroom.jsp" onclick="return judgeIsLogin();" target="_blank">在线交流</a>
			</div>
			<hr width="95%">
		</div>
		<div class="help-content">
			<div class="help-item1">
				<h3>湘潭大学失物招领平台使用规范</h3>
				<p style="text-align: center;">湘潭大学失物招领平台QQ群:496113313</p>
				<p>一、如果您在校园内拾得他人遗失的物品,可登录失物招领平台,自行发布失物招领信息,寻找失主,也可以在湘潭大学失物招领QQ群里发布招领信息。</p>
				<p>二、如果您有遗失物品在查找无果后,可自行登录失物招领信息平台查看有无您正寻找的物品招领信息。如果没有,可以自行发布寻物信息,或在湘潭大学失物招领QQ群里发布寻物信息。　</p>
				<p>三、遗失物品领取时,凭学生证、身份证、借阅证等有效证件。代他人领取的,还须出示失主的委托书、失主身份证件。</p>
				<p>拾金不昧是中华民族的传统美德,希望广大师生充分利用这个平台,发扬拾金不昧的优秀品质，自助助人。也希望通过我们的努力,能够切实加强师生管理自身财产安全的意识,营造良好的学习与生活环境,构建和谐、温馨校园。</p>
				<p style="text-align: right;">2020-02-23 22:10</p>
			</div>
		</div>
	</div>
	
	<footer>
		<jsp:include page="footer.jsp"></jsp:include>
	</footer>
	
	<script type="text/javascript">
		loadData();
		function loadData(){
			$.ajax({
				url:"${pageContext.request.contextPath}/loadHelpInfoData",
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.length){
						var res= "";
						var li="";
						var helpInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
						var index=2;
						for(var i=0;i<helpInfo.length;i++,index++){
							li+="<li id='help-list"+index+"'>"+helpInfo[i].title+"</li>";
							res+=
								"<div class='help-item"+index+"'>"+
									"<h3>"+helpInfo[i].title+"</h3>"+
									"<p>"+helpInfo[i].content+"</p>"+
									"<p style='text-align: right;'>"+helpInfo[i].publishTime.substring(0,16)+"</p>"+
								"</div>";
						}
						$(".help-info ul").append(li);
						$(".help-content").append(res);
					}
					initDisplay();//这里ajax里拼接的代码段 要获取dom元素必须放置在 success(){}里调用相关的函数才会获取到,否则无法获取到对应的dom节点
					clickShow();
				}
			});
		}
		
		function initDisplay() {
			if("${empty divClass}"=="true"){
				$(".help-item1").css("display","block");
				$("#help-list1").css("background","#eee");
			}
			else{
				$(".help-item${divClass}").css("display","block");
				$("#help-list${divClass}").css("background","#eee");
			}
		}
		
		function clickShow() {
			$(".help-info ul li").each(function () {
				$(this).click(function () {
					$(this).css("background","#eee");
					var itemIndex=$(this).attr("id").substr(9);
					var liClassId=$(this).attr("id");
					$(".help-info ul li").each(function () {
						if($(this).attr("id")!=liClassId)//这里不能$(this)!=liClass直接拿之前 $(this)的jquery对象的副本做比较,好像并不能相等
							$(this).css("background","#fff");
					});
					$(".help-content div").each(function () {
						if($(this).attr("class").substr(9)==itemIndex)
							$(this).fadeIn();
						else
							$(this).css("display","none");
					});
				});
			});
		}
	
	</script>
</body>
</html>