<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- <meta> 元素可提供有关页面的元信息meta-information,比如针对搜索引擎和更新频度的描述和关键词. -->
		<meta charset="UTF-8">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pagination.css"/>
		<!-- bootstrap.css会对a标签:hover进行下划线和color的渲染,某些input、font也会发生些许变化 -->
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/pagination.js"></script>
		<title>${infoType}信息列表</title>
		<style type="text/css">
			.place{
				background: url("${pageContext.request.contextPath}/resources/images/place_bg.gif");
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
				background: url("${pageContext.request.contextPath}/resources/images/place-link.gif") no-repeat right;
				margin-left: 5px;
				margin-bottom: 0;/* 这里不知道为什么会多出来margin-bottom*/
			}
			.place ul li:last-child{
				background: none;
			}
			.search-aside{
				width:1200px;
				margin:15px auto;
				height:330px;
				border: 6px solid #EAEAEA;
				box-shadow: 5px 5px 5px #888888;
				font-family: '仿宋';
			}
			.search-form{
				width:450px;
				margin: 15px auto;
			}
			ul{
				margin: 0px;
				padding:0px;
				list-style: none;
			}
			ul li{
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
				width:1200px;
				margin:15px auto;
				height:435px;
				border: 6px solid #EAEAEA;
				box-shadow: 5px 5px 5px #888888;
			}
			table{
				width:100%;
				border-collapse: collapse;
			}
			table thead tr{
			}
			table th{
				text-indent:20px;
				text-align:center;
				font-family: "楷体";
				height:40px;
				background: url("${pageContext.request.contextPath}/resources/images/th.gif");
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
			.search-tbody a{
				color: black;
			}
			.search-tbody a:hover{
				color: red;
				text-decoration: none;
			}
			.search-tbody span{
				color: black;
				cursor: pointer;
			}
			.search-tbody span:hover{
				color: red;
			}
			.wr-page{
				text-align:center;
			}
		</style>
	</head>
<body>

	<div class="place">
		<span>位置:</span>
		<ul>
			<li>后台管理</li>
			<li>物品信息管理</li>
			<li>
				<c:if test="${infoType=='寻物'}">寻物信息列表</c:if>
				<c:if test="${infoType=='招领'}">招领信息列表</c:if>
			</li>
		</ul>
	</div>
	
	<div class="search-aside">
		<form action="" class="search-form">
			<ul>
				<li>
					<input type="hidden" name="infoType" id="info-type" value="${infoType}">
				</li>
				<li>
					<label style="margin-left: 32px;">标题:</label>
					<input type="text" name="title" id="title" style="width: 350px;"/>
				</li>
				<li>
					<label>
						<c:if test="${infoType=='寻物'}">失物名称:</c:if>
						<c:if test="${infoType=='招领'}">拾物名称:</c:if>
					</label>
					<input type="text" name="goodsName" id="goods-name"/>
				</li>
				<li>
					<label>
						<c:if test="${infoType=='寻物'}">失物类型:</c:if>
						<c:if test="${infoType=='招领'}">拾物类型:</c:if>
					</label>
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
					<label>
						<c:if test="${infoType=='寻物'}">丢失地点:</c:if>
						<c:if test="${infoType=='招领'}">拾到地点:</c:if>
					</label>
					<input type="text" name="happenPlace" id="happen-place"/>
				</li>
				<li>
					<label>
						<c:if test="${infoType=='寻物'}">丢失时间:</c:if>
						<c:if test="${infoType=='招领'}">拾到时间:</c:if>
					</label>
					<input type="datetime-local" name="happenTime" id="happen-time" />
				</li>
				<li>
					<label>
						<c:if test="${infoType=='寻物'}">失物状态:</c:if>
						<c:if test="${infoType=='招领'}">拾物状态:</c:if>
					</label>
					<select name="state" id="state">
						<option selected="selected" style="display: none" value="">点击下拉</option>
						<option value="">所有状态</option>
						<c:if test="${infoType == '寻物'}">
							<option value="0">未找到</option>
							<option value="1">已找到</option>
						</c:if>
						<c:if test="${infoType == '招领'}">
							<option value="0">未认领</option>
							<option value="1">已认领</option>
						</c:if>
						<option></option>
					</select>
				</li>
				<li>
					<label style="margin-left: 15px;">
						<c:if test="${infoType == '寻物'}">失主id:</c:if>
						<c:if test="${infoType == '招领'}">拾物主id:</c:if>
					</label>
					<input type="text" name="user.id" id="user-id">
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
					<th>
						<c:if test="${infoType=='寻物'}">失物id</c:if>
						<c:if test="${infoType=='招领'}">拾物id</c:if>
					</th>
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
						<c:if test="${infoType=='寻物'}">失物状态</c:if>
						<c:if test="${infoType=='招领'}">拾物状态</c:if>
					</th>
					<th>
						<c:if test="${infoType=='寻物'}">失主名称</c:if>
						<c:if test="${infoType=='招领'}">拾物主名称</c:if>
					</th>
					<th>
						<c:if test="${infoType=='寻物'}">失物图片</c:if>
						<c:if test="${infoType=='招领'}">拾物图片</c:if>
					</th>
					<th style="width: 150px;">操作</th>
				</tr>
			</thead>
			<tbody class="search-tbody">
			
			</tbody>
		</table>
		
		<div class="wr-page">

		</div>
	</div>
	
	<script type="text/javascript">

		var goods;
		pagination();
		
		$("#search-button").click(function () {
			pagination();
		});

		function pagination() {
			//这里是json里嵌套json,构造goods中的user对象为其赋予id属性,当然也可以暂时先传过去,利用JSONObject中的getString(key)、getInt(key)得到setUserId
			goods={"infoType":$("#info-type").val(),
				   "title":$("#title").val(),
				   "goodsName":$("#goods-name").val(),
				   "goodsType":$("#goods-type").val(),
				   "happenPlace":$("#happen-place").val(),
				   "happenTime":$("#happen-time").val(),
				   "user":{"id":$("#user-id").val()},
				   "state":$("#state").val()};
			
			$.ajax({
				url:"${pageContext.request.contextPath}/getSearchNums",
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
							res+=
							"<tr>"+
								"<td>"+goodsInfo[i].id+"</td>"+
								"<td>"+
									"<a target='_blank' href='${pageContext.request.contextPath}/showGoodsDetail?id="+goodsInfo[i].id+"&infoType="+goodsInfo[i].infoType+"' class='goods-detail'>"+goodsInfo[i].title+"</a>"+
								"</td>"+
								"<td>"+goodsInfo[i].goodsName+"</td>"+
								"<td>"+goodsInfo[i].goodsType+"</td>"+
								"<td>"+goodsInfo[i].happenPlace+"</td>"+
								"<td>"+goodsInfo[i].happenTime.substring(0,16)+"</td>"+
								"<td>";
									if(goodsInfo[i].infoType=='寻物'){
										if(goodsInfo[i].state==0) res+="未找到";
										else res+="已找到";
									}
									else{
										if(goodsInfo[i].state==0) res+="未认领";
										else res+="已认领";
									}
							res+=
								"</td>"+
								"<td>"+goodsInfo[i].user.username+"</td>"+
								"<td>"+ 
									"<span  style='display:inline-block;width:50px;height:50px;background-size:100% 100%;background-image:url(\"${pageContext.request.contextPath}/resources/upload_goods_pic/"+goodsInfo[i].imgUrl+"\");cursor:default;'></span>"+//因为要导出excel必须是闭合标签,所以将img换成了span
								"</td>"+
								"<td>"+
									"<span onclick='confirmRemove("+goodsInfo[i].id+",\""+goodsInfo[i].infoType+"\")'>删除</span>";
									if(goodsInfo[i].state==1){
										if(goodsInfo[i].infoType == "寻物")
											res+="|<span onclick='changeGoodsState("+goodsInfo[i].id+",0,null,\""+goodsInfo[i].infoType+"\")'>取消找到</span>";
										else
											res+="|<span onclick='changeGoodsState("+goodsInfo[i].id+",0,null,\""+goodsInfo[i].infoType+"\")'>取消认领</span>";
									}
							res+=
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
		});
		
		function reset() {
			$(".search-form input").each(function () {
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
		
		function confirmRemove(id,infoType) {
			if(infoType=="寻物"){
				if(confirm("确定要删除这条失物信息吗?")==false)
					return false;
			}
			else{
				if(confirm("确定要删除这条拾物信息吗?")==false)
					return false;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/removeGoods",
				data:{"id":id},
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data=="删除成功")
						pagination();
				}
			});
		}
		
		function changeGoodsState(goodsId,state,auid,infoType) {
			if(infoType=="寻物"){
				if(confirm("确定要取消这条失物信息的成交状态吗?")==false)
					return false;
			}
			else{
				if(confirm("确定要取消这条拾物信息的成交状态吗?")==false)
					return false;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/changeGoodsState",
				data:{"id":goodsId,"state":state,"auid":auid},
				type:"GET",
				datatype:"html",
				success:function(data){
					if(data=="物品状态已改变")
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
			var tableHtml=$(".search-result table").prop("outerHTML");//attribute表示HTML文档节点的属性，property表示JS对象的属性,jquery prop()方法可获取原生js对象的property属性
            makeFromSubmit("${pageContext.request.contextPath}/exportExcel", "${infoType}"+"信息列表", tableHtml);
        }
		

	</script>
</body>
</html>