<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="resources/css/pagination.css"/>
<script src="resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="resources/js/pagination.js"></script>
<title>我的${infoType}归还或认领信息</title>
<style type="text/css">
	.top-warning span{
		font-family: "仿宋";
		font-size:22px;
	}
	.goods-info img,.right-aside img{
		width:50px;
		height:50px;
	}
	.goods-info{
		height:600px;
		border:2px solid #a0b1c4;/*#cacaca*/
		float: left;
		box-shadow: 5px 5px 5px #888888;
	}
	table{
		border-collapse: collapse;
		border-spacing:0;
		/*border-style: none;*/
		/*border: 1px solid black;*/
	}
	table th{
		text-indent:20px;
		text-align:center;
		font-family: "楷体";
		background: url("resources/images/th.gif");
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
		text-align:center;
		text-indent:20px;
	}
	.goods-detail{
		color:black;
	}
	.goods-detail:hover{
		color:red;
	}
	.wr-page{
		text-align: center;
	}
</style>
</head>
<body>
	<div class="goods-info">
		<div class="top-warning">
			<img src="${pageContext.request.contextPath}/resources/images/tzico.jpg" style="vertical-align: bottom;">
			<span>
				<b>
					我的<c:if test="${infoType=='寻物'}">拾物归还</c:if><c:if test="${infoType=='招领'}">失物认领</c:if>信息
				</b>
			</span>
		</div>
		<table>
			<thead>
				<tr>
					<th>标题</th>
					<th>
						<c:if test="${infoType=='寻物'}">失物名称</c:if>
						<c:if test="${infoType=='招领'}">拾物名称</c:if>
					</th>
					<th>
						<c:if test="${infoType=='寻物'}">失物类型</c:if>
						<c:if test="${infoType=='招领'}">拾物类型</c:if>
					</th>
					<th>
						<c:if test="${infoType=='寻物'}">丢失地点</c:if>
						<c:if test="${infoType=='招领'}">拾到地点</c:if>
					</th>
					<th>
						<c:if test="${infoType=='寻物'}">丢失时间</c:if>
						<c:if test="${infoType=='招领'}">拾到时间</c:if>
					</th>
					<th>
						<c:if test="${infoType=='寻物'}">失物状态:</c:if>
						<c:if test="${infoType=='招领'}">拾物状态:</c:if>
					</th>
					<th>
						<c:if test="${infoType=='寻物'}">失物图片</c:if>
						<c:if test="${infoType=='招领'}">拾物图片</c:if>
					</th>
				</tr>
			</thead>
			<tbody class="goods-tbody">
				
			</tbody>
		</table>
		<div class="wr-page">

		</div>
	</div>
	<script type="text/javascript">
		pagination();
		function pagination() {
			$.ajax({
				url:"${pageContext.request.contextPath}/getFinishedGoodsNums",
				data:{infoType:"${infoType}",username:"${loginUser.username}"},
				type:"POST",
				dataType:"json",
				success:function(data){
					$(".wr-page").wrpage(data,{
						items_per_page: 6,
						wr_current: 1,
						cb: function(pageNum,pageSize) {//cb:callback回调函数,调用ajax异步请求后台控制器
							loadData(pageNum,pageSize);
						}	
					});
					if(data)//如果list里什么都没有 即list=[] data(数量)=0则不进行select from where id in list的查找会出错
						loadData(1,6);
				}
			});
		}
		
		function loadData(pageNum,pageSize){
			$.ajax({
				url:"${pageContext.request.contextPath}/loadFinishedGoodsData",
				data:{"pageNum":pageNum,"pageSize":pageSize,infoType:"${infoType}",username:"${loginUser.username}"},
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
									"<a target='_blank' href='${pageContext.request.contextPath}/showGoodsDetail?id="+goodsInfo[i].id+"&infoType="+goodsInfo[i].infoType+"' class='goods-detail'>"+goodsInfo[i].title+"</a>"+
								"</td>"+
								"<td>"+goodsInfo[i].goodsName+"</td>"+
								"<td>"+goodsInfo[i].goodsType+"</td>"+
								"<td>"+goodsInfo[i].happenPlace+"</td>"+
								"<td>"+goodsInfo[i].happenTime.substring(0,16)+"</td>"+
								"<td>";
									if(goodsInfo[i].infoType=='寻物')
										res+="已找到";
									else
										res+="已认领";
							res+=
								"</td>"+
								"<td>"+
									  "<img alt='图片加载失败' src='${pageContext.request.contextPath}/resources/upload_files/"+goodsInfo[i].imgUrl+"'/>"+
								"</td>"+
							"</tr>";
						}
						$(".goods-tbody").html(res);
					}
					else
						$(".goods-tbody").html("");
				}
			});
		}
	</script>
</body>
</html>