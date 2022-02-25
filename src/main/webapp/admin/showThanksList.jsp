<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- <meta> 元素可提供有关页面的元信息meta-information,比如针对搜索引擎和更新频度的描述和关键词. -->
		<meta charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.css"/>
		<link type="text/css" rel="stylesheet" href="../resources/css/pagination.css"/>
		<script src="../resources/js/jquery-3.4.1.js"></script>
		<script type="text/javascript" src="../resources/js/pagination.js"></script>
		<title>感谢信列表</title>
		<style type="text/css">
			body{
				width:100%;
				margin:0;
			}
			.place{
				background: url("../resources/images/place_bg.gif");
				background-size: 100% 100%;
			}
			.place ul{
				margin: 0;
				padding:0;
				list-style: none;
				display: inline-block;
			}
			.place span{
				font-weight: bolder;
			}
			.place ul li{
				height:40px;
				line-height:40px;
				display: inline-block;
				padding-right:12px;
				background: url("../resources/images/place-link.gif") no-repeat right;
				margin-left: 5px;
			}
			.place ul li:last-child{
				background: none;
			}
			.search-aside{
				width:680px;
				margin:5px auto;
				height:220px;
				border: 6px solid #EAEAEA;
				box-shadow: 5px 5px 5px #888888;
				font-family: '仿宋';
			}
			.search-form{
				width:450px;
				margin: 15px auto;
			}
			.search-form ul{
				margin: 0px;
				padding:0px;
				list-style: none;
			}
			.search-form ul li{
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
				width:680px;
				height:310px;
				margin:10px auto;
				border: 6px solid #EAEAEA;
				box-shadow: 5px 5px 5px #888888;
			}
			.thanks-tbody a{
				color:black;
			}
			.thanks-tbody a:hover{
				color:red;
				text-decoration:none;
			}
			table {
				width:100%;/* 试着修改分页部分的宽度*/
				border-collapse: collapse;/*会忽略 border-spacing(默认是为0的) 和 empty-cells 属性。*/
				/*border-spacing:0;*/
				/*border: 1px solid black;*/
				/*margin-left: 50px;*/
			}
			table th{
				text-indent:20px;
				text-align:center;
				font-family: "楷体";
				height:40px;
				background: url("../resources/images/th.gif");
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
			.wr-page{
				text-align: center;
			}
			.thanks-tbody span{
				color: black;
				cursor: pointer;
			}
			.thanks-tbody span:hover{
				color: red;
			}
		</style>
	</head>
<body>
	<div class="place">
		<span>位置:</span>
		<ul>
			<li>后台管理</li>
			<li>感谢信信息管理</li>
			<li>感谢信列表</li>
		</ul>
	</div>
	<div class="search-aside">
		<form action="" class="search-form">
			<ul class="search-item">
				<li>
					<label style="margin-left: 32px;">标题:</label>
					<input type="text" name="title" id="title" style="width: 350px"/>
				</li>
				<li>
					<label style="margin-left: 32px;">内容:</label>
					<input type="text" name="content" id="content" style="width: 350px"/>
				</li>
				<li>
					<label>发布时间:</label>
					<input type="datetime-local" name="publishTime" id="publish-time" />
				</li>
				<li>
					<label>发布者id:</label>
					<input type="text" name="user.id" id="user-id">
				</li>
				<li>
					<input type="button" id="search-button" value="查询" /> &nbsp;
					<input type="button" id="reset-button" value="重置" />
				</li>
			</ul>
		</form>
	</div>
	<div class="search-result">
		<!-- 这个table的border如果设置为="" 会导致表格产生分割线,等同于border="1",这里是在table标签里的border而不是style里的border两个意义不同-->
		<table>
				<thead>
					<tr>
						<th>感谢信id</th>
						<th>发布时间</th>
						<th>标题</th>
						<th>发布者</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody class="thanks-tbody">
				
				</tbody>
		</table>
		<div class="wr-page">

		</div>
	</div>
</body>
<script type="text/javascript">
	var thanksLetter;
	pagination();
	
	$("#search-button").click(function () {
		pagination();
	});
	
	function pagination() {
		thanksLetter={title:$("#title").val(),
					  content:$("#content").val(),
					  publishTime:$("publish-time").val(),
				   	  user:{"id":$("#user-id").val()}};
		$.ajax({
			url:"${pageContext.request.contextPath}/searchThanksNums",
			data:$(".search-form").serialize(),
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
				loadData(1,6);
			}
		});
	}
	
	function loadData(pageNum,pageSize){
		$.ajax({
			url:"${pageContext.request.contextPath}/searchThanksData",
			data:{"pageNum":pageNum,"pageSize":pageSize,"conditions":JSON.stringify(thanksLetter)},
			type:"POST",
			dataType:"json",
			success:function(data){
				var res= "";
				if(data.length){
					var thanksInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
					for(var i=0;i<thanksInfo.length;i++){
						res+=
						"<tr>"+
							"<td>"+thanksInfo[i].id+"</td>"+
							"<td>"+thanksInfo[i].publishTime.substring(0,16)+"</td>"+
							"<td>"+
								  "<a target='_blank' href='${pageContext.request.contextPath}/showThanksDetail?id="+thanksInfo[i].id+"'>"+thanksInfo[i].title+"</a>"+
							"</td>"+
							"<td>"+thanksInfo[i].user.username+"</td>"+
							"<td>"+
								  "<span onclick='confirmRemove("+thanksInfo[i].id+")' >删除</span>"+
							"</td>"+
						"</tr>";
					}
				}
				$(".thanks-tbody").html(res);
			}
		});
	}
	
	$("#reset-button").click(function () {
		reset();
	});
	
	function reset() {
		$(".search-form input").each(function () {
			if($(this).attr("type")!="button")
				$(this).val("");
		});
	}
	
	function confirmRemove(id) {
		if(confirm("确定要删除这条感谢信信息吗?")==false)
			return false;
		$.ajax({
			url:"${pageContext.request.contextPath}/removeThanks",
			data:{"id":id},
			type:"GET",
			datatype:"html",
			success:function(data){
				if(data=="删除成功")
					pagination();
			}
		});
	}
	
</script>
</html>