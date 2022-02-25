<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
<title>成功案例</title>
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
	/* #F3F3FA肉色*/
	.success-info{
		width:800px;
		height:650px;
		overflow:auto;
	    border: 6px solid #EAEAEA;
		box-shadow: 5px 5px 5px #888888;
		font-family: '仿宋';
	}
	table{
		width:100%;
		border-collapse: collapse;
		border-spacing:0;
	}
	table th{
		text-indent:20px;
		height:40px;
		text-align:center;
		font-family: "楷体";
		background-image: url("resources/images/th.gif"); 
		background-size: 100% 100%;
	}
	table tbody tr{
		font-family: "仿宋";
	}
	table tbody tr:nth-child(even) {
		background: #f5f8fa;
	}
	table tbody tr:hover{
		background: #e5ebee;
	}
	table tbody td{
		height:35px;
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
	.more-info{
		text-align: center;
	}
	.more-info span{
		font-size:20px;
	}
	#click-more{
		cursor: pointer;
	}
	#click-more:hover{
		color: red;
	}
</style>
</head>
<body>
	<header>
		<jsp:include page="header.jsp"></jsp:include>
	</header>
	<div class="middle-content">
		<div class="success-info">
			<table>
				<thead>
					<tr>
						<th>事件类型</th>
						<th>发布信息者</th>
						<th>(寻物:拾到者)||(招领:失主)</th>
						<th>物品名称</th>
						<th>信息发布时间</th>
					</tr>
				</thead>
				<tbody class="info-tbody">
					
				</tbody>
			</table>
			<div class="more-info">
			
			</div>
			<div class="success-total">
				<p>
					该平台使用至今,累计为大家寻找到失物<span id="lost" style="font-weight: bolder;"></span>件,归还拾物<span id="found" style="font-weight: bolder;"></span>件,平台需要大家的支持并竭诚为大家服务!
				</p>
			</div>
		</div>
	</div>
	
	<footer>
		<jsp:include page="footer.jsp"></jsp:include>
	</footer>
	
	<script type="text/javascript">
		
		var moreInfoPageNum=2,moreInfoPageSize=2,dataTotal,currentTotal=0;//再次加载时是从第三页开始加载的,因为此时每页的尺寸是2条数据,而此前已经加载了4条数据
		getDataNums();
		
		function getDataNums() {
			$.ajax({
				url:"${pageContext.request.contextPath}/getGoodsNums",
				data:{infoType:"",state:1},
				type:"GET",
				dataType:"json",
				success:function(data){
					dataTotal=data;
					loadData(1,4);//首先加载4条数据作为第一页
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
		
		function loadData(pageNum,pageSize){
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
							res+=
								"<tr>"+
								    "<td>"+goodsInfo[i].infoType+"</td>"+
								    "<td>"+goodsInfo[i].user.username+"</td>"+
								    "<td>"+goodsInfo[i].answerUser.username+"</td>"+
									"<td>"+
										  "<a href='${pageContext.request.contextPath}/showGoodsDetail?id="+goodsInfo[i].id+"&infoType="+goodsInfo[i].infoType+"' class='goods-detail'>"+goodsInfo[i].goodsName+"</a>"+
									"</td>"+
									"<td>"+goodsInfo[i].publishTime.substring(0,16)+"</td>"+
									
								"</tr>";
							currentTotal++;//现在已经加载了多少条数据
						}
						$(".info-tbody").append(res);
						if(currentTotal>=dataTotal){
							$(".more-info").html("<span>没有更多成功案例了...</span>");
						}
						else{
							moreInfoPageNum++;
							$(".more-info").html("<span id='click-more' onclick='loadData("+moreInfoPageNum+","+moreInfoPageSize+")'>点击加载更多成功案例...</span>");
						}
					}
					else{
						$(".more-info").html("<span>暂无成功案例...</span>");
					}
				}
			});
		}
	</script>
</body>
</html>