<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fileinput.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/theme.css"/>
		<link rel="stylesheet" type="text/css" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fileinput.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/theme.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/zh.js"></script>
		<title>发布${infoType}信息</title>
		<style type="text/css">
			body{
				padding:0;
				margin: 0;	
				width: 100%;
				height:500px;
				background: #F3F3FA;
				/*overflow-y:hidden;*/
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
			.publish-goods{
				margin:0;
				padding:20px;
				width:720px;
				border:2px solid #a0b1c4;/*#cacaca*/
				box-shadow: 10px 10px 5px #888888;/*这个垂直下部的阴影如果iframe的高度好过总高度产生滑动条阴影会失效 */
			}
			.form-item{
				margin-top: 10px;
				font-family: '仿宋';
			}
			.form-item input[type=submit]{
				width:100px;
				height:40px;
				color:#fff;
				font-size:20px;
				background: #007BFF;/*#5A98DE*/
				padding: 0 5px;
				border: none;
				border-radius: 5px;
				font-weight: bolder;
			}
			.form-item input[type=submit]:hover{
				background:#0069D9;/*#6AA2E0 #0069D9 #1E90FF*/
			}
			
			/*.file-input .file-preview .file-drop-zone .file-drop-zone-title{
				width:150px;
				height:60px;
			}*/
			
		</style>
		
	</head>
<body>
	<header>
		<jsp:include page="../header.jsp"></jsp:include>
	</header>
	<div class="middle-content">
		<div class="publish-goods">
			<h5 style="font-family: '楷体';font-weight: bolder;">发布${infoType}信息</h5>
			<form action="${pageContext.request.contextPath}/publishGoods" method="get" style="margin: 0;">
				<input type="hidden" name="infoType" value="${infoType}">
				<input type="hidden" name="state" value="0">
				<input type="hidden" name="user.id" value="${loginUser.id}"/>
				<div class="form-item" style="margin-left: 32px;">
					<label>标题:</label>&nbsp;&nbsp;
					<input type="text" name="title" style="width:450px"/>
				</div>
				<div class="form-item">
					<label>
						<c:if test="${infoType=='寻物'}">失物名称:</c:if>
						<c:if test="${infoType=='招领'}">拾物名称:</c:if>
					</label>&nbsp;&nbsp;
					<input type="text" name="goodsName" />
				</div>
				<div class="form-item">
					<label>
						<c:if test="${infoType=='寻物'}">失物类型:</c:if>
						<c:if test="${infoType=='招领'}">拾物类型:</c:if>
					</label>&nbsp;&nbsp;
					<select name="goodsType" style="height: 30px;"><!-- 这里下拉栏没有右侧的边框 -->
						<option selected="selected" style="display: none" value="">点击下拉</option>
						<option value ="卡类证件">卡类证件</option>
						<option value ="电子数码">电子数码</option>
						<option value ="书籍资料">书籍资料</option>
						<option value ="随身物品">随身物品</option>
						<option value ="衣物饰品">衣物饰品</option>
						<option value ="其它物品">其它物品</option>
					</select>
				</div>
				<div class="form-item">
					<label>
						<c:if test="${infoType=='寻物'}">丢失地点:</c:if>
						<c:if test="${infoType=='招领'}">拾到地点:</c:if>
						&nbsp;
					</label>
					<input type="text" name="happenPlace" />
				</div>
				<div class="form-item">
					<label>
						<c:if test="${infoType=='寻物'}">丢失时间:</c:if>
						<c:if test="${infoType=='招领'}">拾到时间:</c:if>
						&nbsp;
					</label>
					<input type="datetime-local" name="happenTime" />
				</div>
				<div class="form-item" style="width: 400px;">
					<label>
					上传<c:if test="${infoType=='寻物'}">失物图片</c:if>
						<c:if test="${infoType=='招领'}">拾物图片</c:if>
					</label>
					<!-- 这里设置一个class="file" 就可让fileinput.js生效,而无需再在script里 用jquery id选择器绑定input type="file"-->
					<input type="file" id="my-pic" name="uploadFile" multiple data-preview-file-type="any" data-ref="imgUrl"/>
					<input type="hidden" name="imgUrl" />
				</div>
				<div class="form-item">
					<input type="submit" value="发布失物" id="publish-btn">
				</div>
			</form>
		</div>
	</div>
	<footer>
		<jsp:include page="../footer.jsp"></jsp:include>
	</footer>
		
	<script type="text/javascript">
		$("#my-pic").fileinput({
			uploadUrl:'${pageContext.request.contextPath}/uploadFile',
			allowedFileTypes:['image'],
			allowedPreviewTypes:['image'],
			allowedPreviewMimeTypes:['jpg','png','gif'],
			theme: 'fas',
			language: 'zh'
		});
		//异步上传成功返回结果处理
		$("#my-pic").on("fileuploaded",function (event,data,previewId,index){
			console.log("fileuploaded");
			var ref=$(this).attr("data-ref");
			$("input[name='"+ref+"']").val(data.response);
		});
		//异步上传失败返回结果处理
		$("#my-pic").on("fileerror",function (event,data,msg){
			console.log("fileerror");
			console.log(data);
		});
		
		$("#publish-btn").click(function () {
			var flag=true;
			$("input[type=text]").each(function () {
				if($(this).val==""){
					alert("请检查表单信息是否填写完整");
					flag=false;
					return false;
				}
			});
			if($("input[name=imgUrl]").val()=="" || $("input[name=happenTime]").val()=="" || $("select[name=goodsType]").val()==""){
				alert("请检查${infoType}表单信息是否填写完整");
				flag=false;
			}
			if(!flag) return false;
			alert("以成功发布${infoType}信息");
		});
	</script>

</body>
</html>