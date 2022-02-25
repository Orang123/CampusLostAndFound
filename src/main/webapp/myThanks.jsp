<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="resources/css/pagination.css"/>
<script src="resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="resources/js/pagination.js"></script>
<title>我的感谢信</title>
<style type="text/css">
	.thanks-info{
		height:400px;
		float:left;
		border:2px solid #a0b1c4;/*#cacaca*/
		box-shadow: 5px 5px 5px #888888;
	}
	.top-warning span{
		font-family: "仿宋";
		font-size:22px;
	}
	.thanks-detail{
		color:black;
	}
	.thanks-detail:hover{
		color:red;
	}
	table {
		width:400px;/* 试着修改分页部分的宽度*/
		border-collapse: collapse;
		border-spacing:0;
		/*border: 1px solid black;*/
		/*margin-left: 50px;*/
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
	<div class="thanks-info">
		<div class="top-warning">
			<img src="resources/images/tzico.jpg" style="vertical-align: bottom;"><span><b>感谢信</b></span>
		</div>
		<!-- 这个table的border如果设置为="" 会导致表格产生分割线,等同于border="1",这里是在table标签里的border而不是style里的border两个意义不同-->
		<table>
			<thead>
				<tr>
					<th>发布时间</th>
					<th>标题</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody class="thanks-tbody">
				
			</tbody>
		</table>
		<div class="wr-page" style="text-align: center;">

		</div>
	</div>
	
	<script type="text/javascript">
		pagination();
		function pagination() {
			$.ajax({
				url:"${pageContext.request.contextPath}/getMyThanksNums",
				data:{"uId":"${loginUser.id}"},
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
	
		function loadData(pageNum,pageSize){
			$.ajax({
				url:"${pageContext.request.contextPath}/loadMyThanksData",
				data:{"pageNum":pageNum,"pageSize":pageSize,"uId":"${loginUser.id}"},
				type:"POST",
				dataType:"json",
				success:function(data){
					if(data.length){
						var res= "";
						var thanksInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
						for(var i=0;i<thanksInfo.length;i++){
							res+=
							"<tr>"+
								"<td>"+thanksInfo[i].publishTime+"</td>"+
								"<td>"+"<a target='_blank' class='thanks-detail' href='${pageContext.request.contextPath}/showThanksDetail?id="+thanksInfo[i].id+"'>"+thanksInfo[i].title+"</a>"+"</td>"+
								"<td>"+
								  	"<span onclick='confirmRemove("+thanksInfo[i].id+")' >删除</span>"+
								"</td>"+
							"</tr>";
						}
						$(".thanks-tbody").html(res);
					}
				}
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
</body>
</html>