<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户信息列表</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pagination.css"/>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pagination.js"></script>
<style type="text/css">
	body{
		margin: 0;
		padding: 0;
	}
	a{
		color:black;
		text-decoration: none;
	}
	a:hover{
		color:red;
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
		width:730px;
		margin:5px auto;
		height:260px;
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
	#search-button,#reset-button,#export-button{
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
	#export-button:hover{
		background:#0069D9;
	}
	.search-result{
		width:730px;
		margin:15px auto;
		height:300px;
		border: 6px solid #EAEAEA;
		box-shadow: 5px 5px 5px #888888;
	}
	.search-tbody a{
		color: black;
	}
	.search-tbody a:hover{
		color: red;
		text-decoration: none;
	}
	table{
		width:100%;
		border-collapse: collapse;
	}
	/*一般不给tr设置背景色,这样在同一行会出现背景色的间断,可以将背景色设置在td上 */
	table th{
		text-indent:20px;/* 设置这个是为了能使得th宽度增大,不直接设置宽度是因为每个th文字内容不同,文字内容多的可能会受限,当然设置padding也是等效的*/
		/*padding-left:20px;margin是无效的*/
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
		/*padding-left:20px;*/
		height:35px;
		text-align:center;
		text-indent:20px;
	}
	.wr-page{
		text-align:center;
	}
	.search-tbody span{
		color: black;
		cursor: pointer;
	}
	.search-tbody span:hover{
		color: red;
	}
</style>
</head>
<body>
	<div class="place">
		<span>位置:</span>
		<ul>
			<li>后台管理</li>
			<li>用户信息管理</li>
			<li>用户信息列表</li>
		</ul>
	</div>

	<div class="search-aside">
	
		<form action="" class="search-form">
			<ul class="search-item">
				<li>
					<label>用户名:</label>
					<input type="text" name="username" id="username"/>
				</li>
				<li>
					<label style="margin-left: 32px;">QQ:</label>
					<input type="text" name="qq" id="qq"/>
				</li>
				<li>
					<label style="margin-left: 16px;">邮箱:</label>
					<input type="email" name="email" id="email"/>
				</li>
				<li>
					<label>用户组:</label>
					<select name="role" id="role">
						<option selected="selected" style="display: none" value="">点击下拉</option>
						<option value="">全部用户</option>
						<option value="-1">黑名单</option>
						<option value="0">普通用户</option>
						<option value="1">群聊管理员</option>
						<option value="2">后台管理员</option>
					</select>
				</li>
				<li>
					<label>是否禁言:</label>
					<select name="startTime" id="start-time">
						<option selected="selected" style="display: none" value="">点击下拉</option>
						<option value="">全部用户</option>
						<option value="-1">正常发言</option>
						<option value="0">已被禁言</option>
					</select>
				</li>
				<li>
					<input type="button" id="search-button" value="查询" /> &nbsp;
					<input type="button" id="reset-button" value="重置" /> &nbsp;
					<input type="button" style="width: 100px;" id="export-button" value="导出Excel" onclick="exportExcel()">
				</li>
			</ul>
		</form>
	</div>
	
	<div class="search-result">
		<table>
			<thead>
				<tr>
					<th>用户id</th>
					<th>用户名</th>
					<th>QQ</th>
					<th>邮箱</th>
					<th>用户组</th>
					<th>是否禁言</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody class="search-tbody">
		
			</tbody>
		</table>
		<div class="wr-page">

		</div>
	</div>
	
	<script type="text/javascript">

			
		var user;
		pagination();
			
			/*$("#saveUserInfo").click(function() {表单数据转化json的方式
		        var formObject = {};
		        var formArray =$("#userInfo").serializeArray();
		        $.each(formArray,function(i,item){
		            formObject[item.name] = item.value;
		        });
		        $.ajax({
		            url:"user/addUser",
		            type:"post",
		            contentType: "application/json; charset=utf-8",
		            data: JSON.stringify(formObject),
		            dataType: "json",
		            success:function(data){
		                alert(data.msg);
		            },
		            error:function(e){
		                alert("错误！！");
		            }
		        });
		    });*/
			//serialize()方法得到的结果并不是json的格式而是"username=&qq=&email=&role=0"
			//serializeArray()方法得到的结果为[{"name":"username","value":""},{"name":"qq","value":""},{"name":"email","value":""},{"name":"role","value":"0"}]是json的格式
			//console.log(user);{username: "", qq: "", email: "", role: "0"}
			//JSON.stringify()方法将一个 JavaScript 值（对象或者数组）转换为一个 JSON 字符串
			//console.log(JSON.stringify(user));{"username":"","qq":"","email":"","role":"0"} 区别只是username是否加了引号
		$("#search-button").click(function () {
			pagination();
		});
			
		function pagination() {
			user={username:$("#username").val(),
				  qq:$("#qq").val(),
				  email:$("#email").val(),
				  role:$("#role").val(),
				  startTime:$("#start-time").val()};
				
			$.ajax({
				url:"${pageContext.request.contextPath}/getUserNums",
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

		//其实这里data的传递不是必须非要用json的,可以自己构造成username=das&password=123采用&拼接这样
		function loadData(pageNum,pageSize){
			$.ajax({
				url:"${pageContext.request.contextPath}/loadUserData",
				data:{"pageNum":pageNum,"pageSize":pageSize,"conditions":JSON.stringify(user)},
				type:"GET",
				dataType:"json",
				success:function(data){
					var res= "";
					if(data.length){
						var usersInfo=data;//如果返回是HashMap这里应是data.list,HashMap可以封装多个list
						/* c:if 不是html标签
						     该标签是在服务器端解析后,生产html传回浏览器
						     而你的jq是运行在浏览器上的,所以,该标签不起作用*/
						for(var i=0;i<usersInfo.length;i++){
							res+=
							"<tr>"+
								"<td>"+usersInfo[i].id+"</td>"+
								"<td>"+usersInfo[i].username+"</td>"+
								"<td>"+usersInfo[i].qq+"</td>"+
								"<td>"+usersInfo[i].email+"</td>"+
								"<td>";
									if(usersInfo[i].role==-1)
										res+="黑名单";
									else if(usersInfo[i].role==0)
										res+="普通用户";
									else if(usersInfo[i].role==1)
										res+="群聊管理员";
									else
										res+="后台管理员";
							res+=
								"</td>"+
								"<td>";
									if(usersInfo[i].startTime == -1)
										res+="否";
									else
										res+="是";
							res+="</td>"+
								"<td>";
									if(usersInfo[i].role!=2 || (usersInfo[i].id == "${loginAdmin.id}"))
									  res+="<a href='${pageContext.request.contextPath}/editUserInfo?id="+usersInfo[i].id+"'>编辑</a>";
									if(usersInfo[i].role!=2)
									  res+="|<span onclick='confirmDelete("+usersInfo[i].id+")'>删除</span>";
											
								"</td>"+
							"</tr>";
						}
					}
					$(".search-tbody").html(res);
				}
			});
		};
			
		$("#reset-button").click(function () {
			reset();
		});
			
		function reset() {
			$(".search-form input").each(function () {
				if($(this).attr("type")!="button")
					$(this).val("");
			});
			//这里下拉列表只有第一次点重置有用 不知何原因
			/*$("select option").each(function () {
				if($(this).attr("value")==""){
					$(this).attr("selected","selected");
					console.log("xx");						
				}
			});*/
		}
			
		function confirmDelete(id) {
			if(confirm("确定要删除这条用户信息吗?")==false)
				return false;
			$.ajax({
				url:"${pageContext.request.contextPath}/deleteUser",
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
       		usersForm.enctype = "multipart/form-data";
 			// 对该 form 执行提交
            usersForm.submit();
            // 删除该 form
            document.body.removeChild(usersForm);
        } 
		
		function exportExcel(tableDiv,url,excelName) {
			/* 
			innerHTML:从对象的起始位置到终止位置的全部内容,不包括Html标签。
			outerHTML:除了包含innerHTML的全部内容外, 还包含对象标签本身。
			*/
			var tableHtml=$(".search-result table").prop("outerHTML");//attribute表示HTML文档节点的属性，property表示JS对象的属性,jquery prop()方法可获取原生js对象的property属性
            makeFromSubmit("${pageContext.request.contextPath}/exportExcel", "用户信息列表", tableHtml);
        }
			
	</script>
</body>
</html>