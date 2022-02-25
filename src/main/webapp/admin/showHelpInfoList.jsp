<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- <meta> 元素可提供有关页面的元信息meta-information,比如针对搜索引擎和更新频度的描述和关键词. -->
		<meta charset="UTF-8">
		<link type="text/css" rel="stylesheet" href="../resources/css/pagination.css"/>
		<script src="../resources/js/jquery-3.4.1.js"></script>
		<script type="text/javascript" src="../resources/js/pagination.js"></script><!-- 这里url采取forward 会导致../相对路径出错,用redirect -->
		<title>帮助信息列表</title>
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
			.help-info{
				width:1100px;
				height:500px;
				margin:10px 10px;
				border: 6px solid #EAEAEA;
				box-shadow: 5px 5px 5px #888888;
			}
			table {
				width:100%;/* 试着修改分页部分的宽度*/
				border-collapse: collapse;/*会忽略 border-spacing(默认是为0的) 和 empty-cells 属性。*/
				/*border-spacing:0;*/
				/*border: 1px solid black;*/
				/*margin-left: 50px;*/
			}
			table th{
				height:40px;
				text-indent:20px;
				text-align:center;
				font-family: "楷体";
				/*height:40px;*/
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
				/*height:35px;*/
				text-align:center;
				text-indent:20px;
			}
			.helpInfo-tbody a{
				color: black;	
			}
			.helpInfo-tbody a:hover{
				color: red;
			}
			.helpInfo-tbody span{
				color: black;
				cursor: pointer;
			}
			.helpInfo-tbody span:hover{
				color: red;
			}
			.wr-page{
				text-align: center;
			}
			#export-button{
				width:50px;
				height:30px;
				color:#fff;
				font-size:20px;
				background: #007BFF;/*#5A98DE*/
				padding: 0 5px;
				border: none;
				border-radius: 5px;
				font-weight: bolder;
				font-family: '仿宋';
			}
			#export-button:hover{
				background:#0069D9;
				cursor:pointer;
			}
		</style>
	</head>
<body>
	<div class="place">
		<span>位置:</span>
		<ul>
			<li>后台管理</li>
			<li>帮助信息管理</li>
			<li>帮助信息列表</li>
		</ul>
	</div>
	<div class="help-info">
		<!-- 这个table的border如果设置为="" 会导致表格产生分割线,等同于border="1",这里是在table标签里的border而不是style里的border两个意义不同-->
		<table>
				<thead>
					<tr>
						<th>id</th>
						<th style="width: 230px;">标题</th>
						<th>内容</th>
						<th style="width: 150px;">发布时间</th>
						<th style="width: 100px;">发布者</th>
						<th style="width: 100px;">操作</th>
					</tr>
				</thead>
				<tbody class="helpInfo-tbody">
				
				</tbody>
		</table>
		<div class="wr-page">

		</div>
		<input type="button" style="width: 100px;" id="export-button" value="导出Excel" onclick="exportExcel()">
	</div>
</body>
<script type="text/javascript">
	
	pagination();
	function pagination() {
		$.ajax({
			url:"${pageContext.request.contextPath}/getHelpInfoNums",
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
			url:"${pageContext.request.contextPath}/loadHelpInfoData",
			data:{"pageNum":pageNum,"pageSize":pageSize},
			type:"POST",
			dataType:"json",
			success:function(data){
				var res= "";
				if(data.length){
					var helpInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
					for(var i=0;i<helpInfo.length;i++){
						res+=
						"<tr>"+
							"<td>"+helpInfo[i].id+"</td>"+
							"<td>"+helpInfo[i].title+"</td>"+
							"<td style='text-align:left;'>"+helpInfo[i].content+"</td>"+
							"<td>"+helpInfo[i].publishTime.substring(0,16)+"</td>"+
							"<td>"+helpInfo[i].user.username+"</td>"+
							"<td>"+
								  "<a href='${pageContext.request.contextPath}/editHelpInfo?id="+helpInfo[i].id+"&title="+helpInfo[i].title+"&content="+helpInfo[i].content+"'>编辑</a>|"+
								  "<span onclick='confirmRemove("+helpInfo[i].id+")'>删除</span>"+
							"</td>"+
						"</tr>";
					}
				}
				$(".helpInfo-tbody").html(res);
			}
		});
	}
	
	function confirmRemove(id) {
		if(confirm("确定要删除这条帮助信息吗?")==false)
			return false;
		$.ajax({
			url:"${pageContext.request.contextPath}/removeHelpInfo",
			data:{"id":id},
			type:"GET",
			datatype:"html",
			success:function(data){
				if(data=="删除成功")
					pagination();
			}
		});
	}
	
	function makeFromSubmit(url, excelName, tableHtml) {
        // 创建一个 form
        var usersForm = document.createElement("form");
        // 添加到 body 中
        document.body.appendChild(usersForm);
        // 创建输入
        var input1 = document.createElement("input");
        input1.name = "excelName";
        input1.value = excelName;
        var input2 = document.createElement("input");
        input2.name = "tableHtml";
        input2.value = tableHtml;
        // 将输入框插入到 form 中
        usersForm.appendChild(input1);
        usersForm.appendChild(input2);
        // form 的提交方式
        usersForm.method = "POST";
        // form 提交路径 
        usersForm.action = url;
        //以附件方式 解决数据量大的问题
   		usersForm.enctype = "multipart/form-data";//不对字符编码。
        // 对该 form 执行提交
        usersForm.submit();
        // 删除该 form
        document.body.removeChild(usersForm);
    } 
	
	function exportExcel(tableDiv,url,excelName) {
		var tableHtml=$(".help-info table").prop("outerHTML");//attribute表示HTML文档节点的属性，property表示JS对象的属性,jquery prop()方法可获取原生js对象的property属性
        makeFromSubmit("${pageContext.request.contextPath}/exportExcel", "帮助信息列表", tableHtml);
    }
	
</script>
</html>