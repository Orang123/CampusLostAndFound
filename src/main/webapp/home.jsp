<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
<script type="text/javascript" src="resources/js/jquery-3.4.1.js"></script>
<title>主页</title>
<style type="text/css">
	body{
		margin: 0;
		background: #F3F3FA;
		/*overflow-x: hidden;*/
	}
	.middle-content{
		background:#fff;
		margin:0 auto;
		width:1250px;
		padding: 0;
		height:920px;
	}
	.latest{
		width:1238px;
		margin-bottom:10px;
		border: 6px solid #EAEAEA;
	}
	.latest-header{
		margin:5px 0;
		position:relative;
		height: 30px;
		line-height: 30px;
    }
	.latest-header img{
		margin-right: 10px;
	}
	.latest-info{
		width: 100%;/* 和下面的浮动内容对齐,实际设在800px会好点*/
		height: 190px;/* 因为设置overflow:hidden的缘故,这里高度要能包含图片下部的goodsName*/
		overflow: hidden;/*这里要使得溢出的内容被覆盖,采用scrollLeft水平滚动条来推移显示 */
	}
	.inner-container{
		width: 400%;/* 这里的宽度一定要溢出父容器的宽度,并且能够容纳两个ul的宽度使得能浮动在一条直线上要高于200*8*2=3200px才能向左紧跟浮动在一条直线上*/
	}
	.container1,.container2{
		float: left;
		margin-right: 2px;
	}
	.latest-ul{
		margin:0;
		padding: 0;
		list-style: none;
	}
	.latest-ul li{
		display:inline-block;
		width: 200px;
		margin-right: 15px;
		text-align: center;
	}
	.latest-ul li img{
		border:5px solid 	#D2B48C;
	}
	.latest-ul li a{
		color:black;
		text-decoration: none;
	}
	
	.latest-ul li a:hover{
		color: red;
		text-decoration: underline;
	}
	.lost-info{
		float: left;
		font-size:14px;
		width:300px;
		height:650px;
	    border: 6px solid #EAEAEA;
		box-shadow: 4px 4px 4px #888888;
	}
	.found-info{
		width:300px;
		font-size:14px;
		margin-left:10px;
		float: left;
		height:650px;
	    border: 6px solid #EAEAEA;
		box-shadow: 4px 4px 4px #888888;
	}
	.lost-header,.found-header{
		position:relative;
		height: 30px;
		line-height: 30px;
    }
	.lost-header img,.found-info img{
		margin-right: 10px;
	}
	.lost-header a,.found-header a{
		position:absolute;
		right:2px;
		color: black;
		font-weight: bolder;
		text-decoration: none;
	}
	.lost-header>a:hover{
		text-decoration:underline;
		color: red;
	}
	.found-header>a:hover{
		text-decoration:underline;
		color: red;
	}
	table{
		margin-top:5px;
		border-collapse: collapse;
		border-spacing:0;
	}
	table th{
		text-indent:10px;
		width:150px;
		height:40px;
		text-align:center;
		font-family: "楷体";
		background-image: url("resources/images/th.gif"); 
		background-repeat: no-repeat;
		background-size: 100% 100%;
	}
	table tbody tr{
		height:35px;
		font-family: "仿宋";
	}
	table tbody tr:nth-child(even) {
		background: #f5f8fa;
	}
	table tbody tr:hover{
		background: #e5ebee;
	}
	table tbody td{
		text-align:center;
		text-indent:20px;
	}
	.goods-detail{
		text-decoration:none;
		color:black;
	}
	.goods-detail:hover{
		color:red;
	}
	.right-aside{
		width:300px;
		height:650px;
		margin-left:10px;
		float: left;
		border: 6px solid #EAEAEA;
		font-family: '仿宋';
		box-shadow: 4px 4px 4px #888888;
	}
	.signboard{
		width:280px;
		margin: 5px auto;
	}
	.publish-info{
		width:280px;
		margin: 10px auto;/*margin auto居中必须设置width,而且还不能是浮动元素*/
	}
	.extend-function{
		width:250px;
		margin: 10px auto;
	}
	.publish-info a,.extend-function a{
		text-align:center;
		display:block;
		width:100%;
		height:38px;
		background: #FF0000;
		line-height:38px;
		color: #fff;
		font-weight:bolder;
		text-decoration: none;
		font-size: 22px;
	}
	.publish-info a:hover {
		background: #FF4500;
	}
	.extend-function a:hover{
		background: #FF4500;
	}
	.success-aside{
		font-size:13px;
		text-align: center;
	}
	.success-aside .success-title{
		margin:0 auto;
		display:block;
		width:280px;
		height:38px;
		background: #FF0000;
		line-height:38px;
		color: #fff;
		font-weight:bolder;
		font-size: 22px;
	}
	.success-info{
		padding:0;
		margin:0;
		list-style: none;
	}
	.success-info li{
		width: 280px;
		margin: 0 auto;
	}
	.help-info{
		width: 272px;
		height:650px;
		margin-left:10px;
		float: left;
		border: 6px solid #EAEAEA;
		box-shadow: 4px 4px 4px #888888;
		font-family: '仿宋';
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
		text-decoration:none;
		position:absolute;
		right:2px;
		color: black;
		font-weight: bolder;
	}
	.help-link>a:hover{
		color: red;
		text-decoration: underline;
	}
	.help-info ul{
		width:250px;
		margin: 0 auto;
		padding: 0;
		list-style: none;
	}
	.help-info ul a{
		color: black;
		text-decoration: none;
	}
	.help-info ul a:hover{
		color: red;
		text-decoration: underline;
	}
</style>
</head>
<body>
	<header>
		<jsp:include page="header.jsp"></jsp:include>
	</header>
	<div class="middle-content">
		<div class="latest">
			<div class="latest-header">
				<img style="width: 55px;height: 30px;" src="resources/images/the_new.jpg">
			</div>
			<div class="latest-info">
				<div class="inner-container">
					<div class="container1">
						<ul class="latest-ul">
						
						</ul>
					</div>
					<div class="container2">
				
					</div>
				</div>
			</div>
		</div>
		<div class="lost-info">
			<div class="lost-header">
				<img style="width: 55px;height: 30px;" src="resources/images/the_new.jpg">
				<img style="width: 80px;height: 30px;" src="resources/images/lost.jpg">
				<a href="setGoodsInfoType?infoType=寻物&url=showGoodsList" target="_blank">>></a>
			</div>
			<hr width="95%">
			<table>
				<thead>
					<tr>
						<th>标题</th>
						<th>丢失时间</th>
					</tr>
				</thead>
				<tbody class="lost-tbody">
					
				</tbody>
			</table>
		</div>
		<div class="found-info">
			<div class="found-header">
				<img style="width: 55px;height: 30px;" src="resources/images/the_new.jpg">
				<img style="width: 80px;height: 30px;" src="resources/images/found.jpg">
				<a href="setGoodsInfoType?infoType=招领&url=showGoodsList" target="_blank">>></a>
			</div>
			<hr width="95%">
			<table>
				<thead>
					<tr>
						<th>标题</th>
						<th>发现时间</th>
					</tr>
				</thead>
				<tbody class="found-tbody">
					
				</tbody>
			</table>
		</div>
		<div class="help-info">
			<div class="help-link">
				<img style="width: 55px;height: 30px;" src="resources/images/the_new.jpg">
				<img style="width: 80px;height: 30px;" src="resources/images/help.jpg">
				<a href="helpCenter.jsp" style="font-size: 14px;font-family: 'Microsoft YaHei';" target="_blank">>></a>
			</div>
			<hr width="95%">
			<ul>
				<li><a href="forwardHelpPage?divClass=1">湘潭大学失物招领平台使用规范</a></li>
			</ul>
			<hr width="95%">
			<div class="extend-function">
				<a href="chat/chattingroom.jsp" onclick="return judgeIsLogin();" target="_blank">在线交流</a>
				<br>
				<a href="admin/login.jsp" target="_blank">后台管理</a>
			</div>
			<hr width="95%">
		</div>
		<div class="right-aside">
			<div class="signboard">
				<img src="resources/images/signboard.jpg" width="100%" height="280px">
			</div>
			<div class="publish-info">
				<a href="setGoodsInfoType?infoType=寻物&url=publishGoods" onclick="return judgeIsLogin();" target="_blank">发布寻物信息</a><br>
				<a href="setGoodsInfoType?infoType=招领&url=publishGoods" onclick="return judgeIsLogin();" target="_blank">发布招领信息</a>
			</div>
			<hr width="95%">
			<div class="success-aside">
				<span id="success-title">成功案例展示区</span>
				<ul class="success-info">
				
				</ul>
				<p>
					该平台使用至今,累计为大家寻找到失物<span id="lost" style="font-weight: bolder;"></span>件,归还拾物<span id="found" style="font-weight: bolder;"></span>件,平台需要大家的支持并竭诚为大家服务!
				</p>
			</div>
		</div>
	</div>
	<footer style="margin-top: 10px;">
		<jsp:include page="footer.jsp"></jsp:include>
	</footer>
	
	<script type="text/javascript">
		loadData(1,13,"寻物","lost-tbody");
		loadData(1,13,"招领","found-tbody");
		loadSuccessData(1,6);
		loadHelpData();
		
		function loadData(pageNum,pageSize,infoType,tbody){
			$.ajax({
				url:"${pageContext.request.contextPath}/loadGoodsData",
				data:{"pageNum":pageNum,"pageSize":pageSize,"infoType":infoType,"state":0},
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.length){
						var res= "";
						var goodsInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
						for(var i=0;i<goodsInfo.length;i++){
							res+=
								"<tr>"+
									"<td>"+
										  "<a href='${pageContext.request.contextPath}/showGoodsDetail?id="+goodsInfo[i].id+"&infoType="+goodsInfo[i].infoType+"' class='goods-detail' target='_blank'>"+goodsInfo[i].title+"</a>"+
									"</td>"+
									"<td>"+goodsInfo[i].happenTime.substring(0,10)+"</td>"+
								"</tr>";
						}
						$("."+tbody).html(res);
					}
				}
			});
		}
		
		function loadSuccessData(pageNum,pageSize){
			$.ajax({
				url:"${pageContext.request.contextPath}/loadGoodsData",
				data:{"pageNum":pageNum,"pageSize":pageSize,"infoType":"","state":1},
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.length){
						var res= "";
						var goodsInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
						for(var i=0;i<goodsInfo.length;i++){
							if(goodsInfo[i].infoType=="寻物"){
								res+=
									"<li>"+
										  "拾到者:"+goodsInfo[i].answerUser.username+"在失物平台上将拾到的"+goodsInfo[i].goodsName+"还给失主了!"+
									"</li>";
							}
							else{
								res+=
									"<li>"+
										 "失主:"+goodsInfo[i].answerUser.username+"在招领平台上已经找到丢失的"+goodsInfo[i].goodsName+"了!"+
									"</li>";
							}
						}
						$(".success-info").html(res);
					}
					else{
						$(".success-info").html("暂时还没有成功案例...");
					}
				}
			});
			$.ajax({
				url:"${pageContext.request.contextPath}/getGoodsNums",
				data:{infoType:"寻物",state:1},
				type:"GET",
				dataType:"json",
				success:function(data){
					$("#lost").text(data);
				}
			});
			$.ajax({
				url:"${pageContext.request.contextPath}/getGoodsNums",
				data:{infoType:"招领",state:1},
				type:"GET",
				dataType:"json",
				success:function(data){
					$("#found").text(data);
				}
			});
		}
		
		function judgeIsLogin() {
			if("${empty loginUser}"=="true"){
				alert("请先登录");
				return false;
			}
			return true;
		}
		
		function loadLatestInfo(pageNum,pageSize) {
			$.ajax({
				url:"${pageContext.request.contextPath}/loadGoodsData",
				data:{"pageNum":pageNum,"pageSize":pageSize,"infoType":"","state":0},
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.length){
						var res= "";
						var goodsInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
						for(var i=0;i<goodsInfo.length;i++){
							res+=
								"<li>"+
									"<a href='${pageContext.request.contextPath}/showGoodsDetail?id="+goodsInfo[i].id+"&infoType="+goodsInfo[i].infoType+"' target=_'blank'>"+
									"<img width='200px' height='150px' src='${pageContext.request.contextPath}/resources/upload_goods_pic/"+goodsInfo[i].imgUrl+"'/>"+goodsInfo[i].goodsName+"</a>"+
								"</li>";
						}
						$(".latest-ul").html(res);
					}
				}
			});
		}
		
		loadLatestInfo(1,8);
		var latestInfo=document.getElementsByClassName("latest-info")[0];
		var container1=document.getElementsByClassName("container1")[0];
		var container2=document.getElementsByClassName("container2")[0];
		container2.innerHTML=container1.innerHTML;//复制一个ul,两个ul浮动连接起来这样就能铺满,div 水平方向就不会有空余
		//scrollLeft是指水平滚动条,jquery可直接$().scrollLeft()调用或赋值
		latestInfo.scrollLeft=0;//初始的水平滚动条在0位置处
		function autoMove() {
			if(latestInfo.scrollLeft>=container1.offsetWidth)//offsetWidth等于width+padding+margin,在jquery中等效outerWidth(),innerWidth()只包含padding
				latestInfo.scrollLeft=0;
			else
				latestInfo.scrollLeft+=5;
		}
		var timer=setInterval(autoMove,50);//每50ms执行一次autoMove()
		latestInfo.onmouseover=function (){
			clearInterval(timer);//这里停止之前设置的timer
		}
		latestInfo.onmouseout=function (){
			timer=setInterval(autoMove,50);//这里一定要对timer重新赋值,因为之前的timer在mouseover里已经停止了
		}
		
		function loadHelpData(){
			$.ajax({
				url:"${pageContext.request.contextPath}/loadHelpInfoData",
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.length){
						var res= "";
						var helpInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
						var index=2;
						for(var i=0;i<helpInfo.length;i++,index++){
							res+=
								"<li>"+
									"<a href='forwardHelpPage?divClass="+index+"'>"+helpInfo[i].title+"</a>"+
								"</li>";
						}
						$(".help-info ul").append(res);
					}
				}
			});
		}
		
	</script>
</body>
</html>