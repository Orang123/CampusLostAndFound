<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- <meta> 元素可提供有关页面的元信息meta-information,比如针对搜索引擎和更新频度的描述和关键词. -->
		<meta charset="UTF-8">
		<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pagination.css"/>
		<!-- bootstrap.css会对a标签:hover进行下划线和color的渲染,某些input、font也会发生些许变化 -->
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pagination.js"></script>
		<title>搜索失物</title>
		<style type="text/css">
			body{
				background: #F3F3FA;
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
			.search-aside{
				width:800px;
				margin:10px 0;
				height:300px;
				border: 6px solid #EAEAEA;
				box-shadow: 5px 5px 5px #888888;
				font-family: '仿宋';
			}
			.search-condition{
				width:450px;
				margin: 15px auto;
			}
			.search-condition ul{
				margin: 0px;
				padding:0px;
				list-style: none;
			}
			.search-condition ul li{
				margin-bottom: 5px;
			}
			#search-button,#reset-button{
				width:50px;
				height:30px;
				color:#fff;
				font-size:20px;
				background: #007BFF;/*#5A98DE*/
				padding: 0 5px;
				border: none;
				border-radius: 5px;
				font-weight: bolder;
			}
			#search-button:hover{
				background:#0069D9;
			}
			#reset-button:hover{
				background:#0069D9;
			}
			.search-result{
				width:800px;
				margin:15px 0;
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
		<jsp:include page="header.jsp"></jsp:include>
	</header>
	
	<div class="middle-content">
	
		<div class="search-aside">
			<form action="" class="search-condition">
				<ul>
					<li>
						<label>事件类型:</label>
						<select name="infoType" id="info-type">
							<option selected="selected" style="display: none" value="">点击下拉</option>
							<option value ="">全部</option>
							<option value ="寻物">寻物</option>
							<option value ="招领">招领</option>
						</select>
					</li>
					<li>
						<label style="margin-left: 32px;">标题:</label>
						<input type="text" name="title" id="title" style="width: 350px;"/>
					</li>
					<li>
						<label>物品名称:</label>
						<input type="text" name="goodsName" id="goods-name"/>
					</li>
					<li>
						<label>物品类型:</label>
						<select name="goodsType" id="goods-type">
							<option selected="selected" style="display: none" value="">点击下拉</option>
							<option value ="">全部物品</option>
							<option value ="卡类证件">卡类证件</option>
							<option value ="电子数码">电子数码</option>
							<option value ="书籍资料">书籍资料</option>
							<option value ="随身物品">随身物品</option>
							<option value ="衣物饰品">衣物饰品</option>
							<option value ="其它物品">其它物品</option>
						</select>
					</li>
					<li>
						<label>发生地点:</label>
						<input type="text" name="happenPlace" id="happen-place"/>
					</li>
					<li>
						<label>发生时间:</label>
						<input type="datetime-local" name="happenTime" id="happen-time" />
					</li>
					<li>
						<input type="hidden" name="state" id="state" value="0">
					</li>
					<li>
						<input type="button" id="search-button" value="查询" /> &nbsp;
						<input type="button" id="reset-button" value="重置" />
					</li>
				</ul>
			</form>
		</div>
	
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
		<jsp:include page="footer.jsp"></jsp:include>
	</footer>
	
</body>
<script type="text/javascript">

	$(function(){
		var goods;
		//pagination();
		
		$("#search-button").click(function () {
			pagination();
		});
		
		function pagination() {
			goods={infoType:$("#info-type").val(),
				   title:$("#title").val(),
				   goodsName:$("#goods-name").val(),
				   goodsType:$("#goods-type").val(),
				   happenPlace:$("#happen-place").val(),
				   happenTime:$("#happen-time").val(),
				   state:$("#state").val()};
			
			$.ajax({
				url:"${pageContext.request.contextPath}/getSearchNums",
				data:$(".search-condition").serialize(),
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
					else
						$(".search-tbody").html("");
						
				}
			});
		}
		
		$("#reset-button").click(function () {
			reset();
		})
		
		function reset() {
			$(".search-condition input").each(function () {
				if($(this).attr("type")!="button" && $(this).attr("type")!="hidden")
					$(this).val("");
			});
			//这里下拉列表只有第一次点重置有用 不知何原因
			/*$("select option").each(function () {
				console.log($(this).html());
				if($(this).attr("value")==""){//这个if能进入 而且attr selected也设置了对应的属性
					$(this).attr("selected","selected");
					return;//没用
					console.log($(this).html()+"dasd");
				}
			});*/
			//if($(this).text()=="全部" || $(this).text()=="全部物品")
		}
		
	});

</script>
</html>