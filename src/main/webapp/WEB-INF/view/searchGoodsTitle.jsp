<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pagination.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pagination.js"></script>
<title>模糊查询失物标题</title>
<style type="text/css">
	body{
		background: #F3F3FA;
	}
	.middle-content{
		background:#fff;
		width: 1250px;
		margin: 10px auto;
	}
	.search-result{
		width:800px;
		height:400px;
		border: 6px solid #EAEAEA;
		box-shadow: 5px 5px 5px #888888;
	}
	table{
		width:100%;
		border-collapse: collapse;
		border-spacing:0;
	}
	table thead tr{
		background: url("resources/images/th.gif");
		background-size: 100% 100%;
	}
	table th{
		text-indent:20px;
		text-align:center;
		font-family: "楷体";
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
		text-align:center;
		text-indent:20px;
	}
	.goods-detail{
		color:black;
	}
	.goods-detail:hover{
		text-decoration:none;
		color:red;
	}
	.wr-page{
		text-align:center;
	}
</style>
</head>
<body>
	<header>
		<jsp:include page="../header.jsp"></jsp:include>
	</header>
	<div class="middle-content">
		<div class="search-result">
			<table>
				<thead>
					<tr>
						<th>事件类型</th>
						<th>标题</th>
						<th>物品名称</th>
						<th>物品类型</th>
						<th>发生地点</th>
						<th>发生时间</th>
						<th>物品图片</th>
					</tr>
				</thead>
				<tbody class="search-tbody">
			
				</tbody>
			</table>
		
			<div class="wr-page">

			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="../footer.jsp"></jsp:include>
	</footer>
	
	<script type="text/javascript">
		var goods;
		pagination();
		function pagination() {
			goods={title:"${title}",
			       state:"${state}"};
			//传递goods整体一定得封装成json的格式才行,后台接收也应是字符串String
			$.ajax({
				url:"${pageContext.request.contextPath}/getSearchNums",
				data:{title:goods.title,state:goods.state},
				type:"POST",
				dataType:"json",
				success:function(data){
					$(".wr-page").wrpage(data,{
						items_per_page: 4,
						wr_current: 1,
						cb: function(pageNum,pageSize) {//cb:callback回调函数,调用ajax异步请求后台控制器
						loadData(pageNum,pageSize);
						}	
					});
					loadData(1,4);
				}
			});
		}
	
		//之所以这里conditions没用表单序列化是因为和pageNum、pageSize构成了json字符串,而表单序列化是&连接的
		function loadData(pageNum,pageSize){
			$.ajax({
				url:"${pageContext.request.contextPath}/loadSearchData",
				data:{"pageNum":pageNum,"pageSize":pageSize,"conditions":JSON.stringify(goods)},
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.length){
						var res= "";
						var goodsInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
						for(var i=0;i<goodsInfo.length;i++){
							//"<a href='${pageContext.request.contextPath}/showGoodsDetail?id="+goodsInfo[i].id+"&infoType="+goodsInfo[i].infoType+"' class='goods-detail' target='content'>"+goodsInfo[i].title+"</a>"+
							res+=
							"<tr>"+
								"<td>"+goodsInfo[i].infoType+"</td>"+
								"<td>"+
									"<a href='${pageContext.request.contextPath}/showGoodsDetail?id="+goodsInfo[i].id+"&infoType="+goodsInfo[i].infoType+"' class='goods-detail' target='content'>"+goodsInfo[i].title+"</a>"+
								"</td>"+
								"<td>"+goodsInfo[i].goodsName+"</td>"+
								"<td>"+goodsInfo[i].goodsType+"</td>"+
								"<td>"+goodsInfo[i].happenPlace+"</td>"+
								"<td>"+goodsInfo[i].happenTime.substring(0,16)+"</td>"+
								"<td>"+ 
									"<img alt='图片加载失败' width='50px' height='50px' src='${pageContext.request.contextPath}/resources/upload_files/"+goodsInfo[i].imgUrl+"'/>"+
								"</td>"+
							"</tr>";
						}
						$(".search-tbody").html(res);
					}
				}
			});
		}
		
	</script>
</body>
</html>