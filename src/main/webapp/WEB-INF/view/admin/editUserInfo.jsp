<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>编辑用户信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.js"></script>
<script type="text/javascript" src="resources/js/timeInput.js"></script>

<style type="text/css">
	.place{
		background: url("resources/images/place_bg.gif");
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
		background: url("resources/images/place-link.gif") no-repeat right;
		margin-left: 5px;
	}
	.place ul li:last-child{
		background: none;
	}
	.edit-userInfo{
		margin:15px auto;
		padding:20px;
		width:720px;
		border:2px solid #a0b1c4;/*#cacaca*/
		box-shadow: 10px 10px 5px #888888;/*这个垂直下部的阴影如果iframe的高度好过总高度产生滑动条阴影会失效 */
	}
	.form-item{
		margin-top: 10px;
		font-family: '仿宋';
	}
	.form-item input[type=button]{
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
	.form-item input[type=button]:hover{
		background:#0069D9;/*#6AA2E0 #0069D9 #1E90FF*/
	}
	#forbid-time{
		display: none;
	}
	.wrapper1,.wrapper2,.wrapper3{
		margin-right: 10px;
		display: inline-block;
	}
	#day:after{
		content: "天";
		font-size: 18px;
		line-height: 30px;
	}
	#hour:after{
		content: "小时";
		font-size: 18px;
		line-height: 30px;
	}
	#minute:after{
		content: "分钟";
		font-size: 18px;
		line-height: 30px;
	}
	.tips{
		margin-top: 10px;
		color: #7F7F7F;
	}
</style>
</head>
<body>
	<div class="place">
		<span>位置:</span>
		<ul>
			<li>后台管理</li>
			<li>用户信息管理</li>
			<li>编辑用户信息</li>
		</ul>
	</div>
	
	<div class="edit-userInfo">
		<form action="" id="edit-form">
			<input type="hidden" name="id" value="${userInfo.id}"/>
			<div class="form-item">
				<font id="return-message" style="color: red"></font>
			</div>
			<div class="form-item">
				<label>用户名:</label>
				<input type="text" name="username" value="${userInfo.username}"/>
			</div>
			<div class="form-item">
				<label style="margin-left: 32px;">QQ:</label>
				<input type="text" name="qq" value="${userInfo.qq}"/>
			</div>
			<div class="form-item">
				<label style="margin-left: 16px;">邮箱:</label>
				<input type="email" name="email" value="${userInfo.email}"/><br>
			</div>
			<div class="form-item">
				<label>用户组:</label>
				<select name="role">
					<option value="-1"<c:if test="${userInfo.role==-1}">selected="selected"</c:if> >黑名单</option>
					<option value="0"<c:if test="${userInfo.role==0}">selected="selected"</c:if> >普通用户</option>
					<option value="1"<c:if test="${userInfo.role==1}">selected="selected"</c:if> >群聊管理员</option>
					<option value="2"<c:if test="${userInfo.role==2}">selected="selected"</c:if> >后台管理员</option>
				</select>
			</div>
			<div class="form-item">
				<label>是否禁言:</label>
				<select name="startTime" id="start-time">
						<option value="-1"<c:if test="${userInfo.startTime == -1}">selected="selected"</c:if> >正常发言</option>
						<option id="set-forbid" value=""<c:if test="${userInfo.startTime >0 }">selected="selected"</c:if> >设置禁言</option>
				</select>
			</div>
			<div class="form-item" id="forbid-time">
				<label>禁言时长:</label>
				<input type="hidden" id="forbidTalkDuration" name="forbidTalkDuration" value="">
				<span></span>
			</div>
			<div class="form-item">
				<input type="button" onclick="edit()" value="编辑完成"  /> &nbsp;&nbsp;
				<input type="button" onclick="cancel()" value="取消编辑">
			</div>
		</form>	
	</div>
	
	<div class="modal fade" id="forbidChat-time" tabindex="-1" role="dialog"  aria-labelledby="myModalTitle" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalTitle">设置&nbsp;${userInfo.username}&nbsp;的禁言时长</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
				</div>
				<div class="modal-body">
					<div id="day" class="wrapper1"></div>
					<div id="hour" class="wrapper2"></div>
					<div id="minute" class="wrapper3"></div>
					<div class="tips">禁言时长不能超过30天</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="setforbidTalkDuration($('#day .num-input').val(),$('#hour .num-input').val(),$('#minute .num-input').val())">确定</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	
		function edit() {
			$.ajax({
				url:"${pageContext.request.contextPath}/saveUserInfo",
				data:$('#edit-form').serialize(),
				type:"POST",
				datatype:"html",
				success:function(data){
					if(data!="用户信息修改成功")
						$("#return-message").html(data);
					else{
						alert("该条用户信息修改成功");
						window.location.href="${pageContext.request.contextPath}/admin/showUserList.jsp";
					}
				}
			});
		};
		
		function cancel() {
			window.location.href="${pageContext.request.contextPath}/admin/showUserList.jsp";
		}
		
		function initModal() {
			$("#day input").val(0);
			$("#hour input").val(0);
			$("#minute input").val(0);
			$("#hour .num-input").removeAttr("disabled");
			$("#minute .num-input").removeAttr("disabled");
		}
		
		$("#start-time").change(function () {//当用于 select 元素时，change 事件会在选择某个选项时发生
			if($(this).find("option:selected").attr("id") == "set-forbid"){
				initModal();
				$("#forbidChat-time").modal("show");
			}
			else{
				$("#set-forbid").attr("value","");
				$("#forbidTalkDuration").attr("value","");
				$("#forbid-time").css("display","none");
			}
		});
		
		function setforbidTalkDuration(day,hour,minute) {
			var minute0=1000*60;
			var hour0=minute0*60;
			var day0=hour0*24;
			var forbidTalkDuration=minute0 * minute+hour0 * hour+day0 * day;
			if(forbidTalkDuration != 0){
				$("#set-forbid").attr("value",new Date().getTime());
				$("#forbidTalkDuration").attr("value",forbidTalkDuration);
				var res="";
				if(day != 0)
		    		res+=day+"天";
		    	if(hour != 0)
		    		res+=hour+"小时";
		    	if(minute != 0)
		    		res+=minute+"分钟";
				$("#forbid-time span").html(res);
				$("#forbid-time").css("display","block");
			}
		}
		
		var options={
			width: 100,//宽度
			positive: true,//允许输入正数
			negative: false,//允许输入负数
			//faq：positive，negative不能同时false，同时false按同时为true处理
			floatCount: 0,//小数点后保留位数
			//命名空间，防止样式冲突
			wrapperClass: 'num-input-wrap',//最外层容器
			inputClass: 'num-input',//input输入框
			addClass: 'add',//增加按钮
			subtractClass: 'subtract',//减少按钮
			interval: 1//增加&减少按钮每次变化的值	
		};
			
		$(".wrapper1").timeInput(options,30);
		$(".wrapper2").timeInput(options,23);
		$(".wrapper3").timeInput(options,59);

	    $("#day .num-input").bind("input propertychange",function () {//无法监听到 js脚本修改的value值变化
			if($(this).val() >= 30){
				$(this).val(30);
				$("#hour .num-input").val(0);
				$("#hour .num-input").attr("disabled",true);
				$("#minute .num-input").val(0);
				$("#minute .num-input").attr("disabled",true);
			}
			else{
				$("#hour .num-input").removeAttr("disabled");
				$("#minute .num-input").removeAttr("disabled");
			}
		});
			
		$("#hour .num-input").bind("input propertychange",function () {
			if($(this).val() >= 24)
				$(this).val(23);
		});
			
		$("#minute .num-input").bind("input propertychange",function () {
			if($(this).val() >= 60)
				$(this).val(59);
		});
		
	</script>
</body>
</html>