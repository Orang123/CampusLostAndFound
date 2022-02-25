<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon" />
<title>用户注册页面</title>
<script type="text/javascript" src="resources/js/jquery-3.4.1.js"></script>
<style type="text/css">
	/*清除IE浏览器中input元素的删除和查看密码图标 */
	::-ms-clear, ::-ms-reveal{
    	display: none;
	}
	body{
		padding-top:1px;
		margin:0;
		font-family: 'microsoft yahei';
		height:728px;
		background-image: url("resources/images/register_bg.jpg");
		background-size: 100% 100%;
		background-repeat: no-repeat;
	}
	.title{
		margin-top:10px;
		text-align: center;
	}
	.title img{
		box-shadow: 5px 5px 5px #888888;
	}
	.register-content{
		width:350px;
		margin: 15px auto;
		border:2px solid #a0b1c4;
		box-shadow: 8px 8px 8px #888888;
		background: #fff;
	}
	.info-title{
		position: relative;
		margin-top:15px;
		margin-bottom: 25px;
	}
	#verify-pic{
		width:50px;
		height:50px;
		background-image: url(resources/images/user_login.png);
		background-size: 100% 100%;
		position: absolute;
		left:18px;
	}
	#mark-text{
		display: inline-block;
		margin:5px 0 0 30px;
		padding-left:40px;
		color: red;
		font-size: 26px;
		font-weight: bold;
	}
	#register-form{
		margin: 10px 0;
	}
	.form-item{
		width: 88%;
		margin:0 auto;
		margin-top:8px;
		position: relative;
	}
	.form-item label{
		background-image: url(resources/images/login-icons.png);
		background-position:0 0;
		position: absolute;/* 这里设置绝对定位一方面它脱离文档流使得display为inline-block,这样设置的宽高才有意义,行级元素不能设置宽高,另一方面它就可以浮动在input上*/
		top:1px;
		left:1px;
		width:38px;
		height:38px;
		border-right:1px solid #bdbdbd;
	}
	.form-item input{
		width: 100%;
		padding: 10px 0 10px 47px;
		outline: none;
		box-sizing: border-box;/*设置为border-box怪异盒模型,使得input button类型与text类型方便对齐*/
	}
	.i-cancel{
		display:none;
		background-image:url(resources/images/login-icons.png);
		background-position:-25px -143px;
		cursor:pointer;
		position: absolute;
		width: 14px;
		height: 14px;
		top:13px;
		right:7px;
	}
	.i-cancel:hover{
		background-position:-50px -143px;
	}
	#kaptcha-img{
		width:100px;
		vertical-align:middle;
		height:40px;
		cursor: pointer;
		position: absolute;
		right:0px;
	}
	.i-onview{
		visibility: hidden;
		background-image:url(resources/images/eye.png);
		background-size:100% 100%;
		cursor: pointer;
		position: absolute;
		width: 21px;
		height: 16px;
		top:13px;
		right:30px;
	}
	.i-status{
		display:none;
		background-image:url(resources/images/register_icons.png);
		background-position:0 -117px;
		width:16px;
		height:16px;
		position: absolute;
		top:13px;
		right:7px;
	}
	.caps-lock{
		display:none;
		width:90px;
		height:28px;
		font-size: 12px;;
		line-height: 28px;
		position: absolute;
		right:2px;
		bottom:42px;/* 以父级非静态定位的底部为参照点计算的*/
		background: #fef4e5;
		border: solid 1px #f6c090;
		color: #bc5212;
		text-align: center;
		border-radius: 3px;
	}
	.caps-lock i{
		width:10px; 
		height:10px;
		background: #fef4e5;
		border-right: 1px solid #f6c090;
		border-bottom: 1px solid #f6c090;
		transform: rotate(45deg);
		position: absolute;
		top:23px;/* 以父级非静态定位的顶部为参照点计算的*/
		left:40px;
	}
	.input-tip{
		visibility:hidden;
		width: 88%;
		margin: 0 auto;
		position: relative;
	}
	.i-tip{
		background-image:url(resources/images/register_icons.png);
		background-position:0 -100px;
		position: absolute;
		top:4px;
		left:0;
		width: 16px;
		height: 16px;
	}
	.i-text{
		margin-left:20px;
		font-size:11px;
		color:#c5c5c5;/*#ff9911*/
	}
	.email-suggest{
		display:none;
		z-index:1;/*为了使得email-suggest(绝对定位)遮盖住下部的inputTip,因为inputTip(相对定位)也是定位文档流,z-index堆叠顺序可能一样 */
		margin:0;
		padding:0;
		list-style:none;
		text-align:right;
		width: 100%;
		position: absolute;
		top:39px;
		border: solid 1px #ccc;
		box-sizing: border-box;
		background: #fff;
		box-shadow: 0px 2px 3px #888888;
	}
	.email-suggest li{
		font-size: 14px;
		height: 30px;
		line-height: 30px;
	}
	.email-suggest li:hover{
		cursor:pointer;
		background: #f6f6f6;
	}
	#register-btn{
		padding:5px 0;
		border: none;
		border-radius:5px;
		background: #FF0000;
		color:white;
		cursor: pointer;
		font-size:20px;
		font-weight: bold;
	}
	#register-btn:hover{
		background: #FF4500;
	}
	.footer{
		font-size:12px;
		font-family:'microsoft yahei';
		margin-top:20px;
		text-align: center;
	}
	.footer a{
		color:black;
		text-decoration: none;
	}
	.footer a:hover{
		color: red;
		text-decoration: underline;
	}
</style>
</head>
<body>
	<div class="title">
		<img src="resources/images/lostfound.png" width="350px" height="80px">
	</div>
	<div class="register-content">
		<div class="info-title">
			<label id="verify-pic" for="mark-text" ></label>
			<span id="mark-text" >用户注册</span>
		</div>
		<form action="${pageContext.request.contextPath}/userRegister" id="register-form" onsubmit="return checkForm();">
			<div class="form-item">
				<label for="username"></label><!-- autocomplete屏蔽浏览器输入框下拉历史的输入记录 -->
				<input type="text" id="username" name="username" placeholder="您的用户名" maxlength="20" autocomplete="off">
				<i class="i-cancel"></i><!-- 这里cancel和status没有合并为一个i标签是因为cancel有hover的用法会和status冲突 -->
				<i class="i-status"></i>
			</div>
			<div class="input-tip">
				<i class="i-tip"></i>
				<span class="i-text"></span>
			</div>
			
			<div class="form-item">
				<label for="password" style="background-position: -48px 0;"></label>
				<input type="password" id="password" name="password" placeholder="建议使用两种或两种以上的字符组合" maxlength="20">
				<i class="i-onview" title="点击显示密码"></i>
				<i class="i-status"></i>
				<span class="caps-lock">
					大写键已开启
					<i></i>
				</span>
			</div>
			<div class="input-tip">
				<i class="i-tip"></i>
				<span class="i-text"></span>
			</div>
			
			<div class="form-item">
				<label for="confirm-password" style="background-position: -48px 0;"></label>
				<input type="password" id="confirm-password" name="confirm-password" placeholder="请再次输入密码" maxlength="20">
				<i class="i-onview" title="点击显示密码"></i>
				<i class="i-status"></i>
				<span class="caps-lock">
					大写键已开启
					<i></i>
				</span>
			</div>
			<div class="input-tip">
				<i class="i-tip"></i>
				<span class="i-text"></span>
			</div>
			
			<div class="form-item">
				<label for="qq" style="background-image: url(resources/images/qq1.png);background-size:100% 100%;"></label>
				<input type="text" id="qq" name="qq" placeholder="请输入您的QQ" maxlength="10" autocomplete="off">
				<i class="i-cancel"></i><!-- 这里cancel和status没有合并为一个i标签是因为cancel有hover的用法会和status冲突 -->
				<i class="i-status"></i>
			</div>
			<div class="input-tip">
				<i class="i-tip"></i>
				<span class="i-text"></span>
			</div>
			
			<div class="form-item">
				<label for="email" style="background-image: url(resources/images/envelope1.png);background-size:100% 100%;"></label>
				<input type="text" id="email" name="email" placeholder="请输入您的邮箱" maxlength="320" autocomplete="off"><!-- autocomplete=off代表 隐藏历史记录结束下拉框 -->
				<i class="i-cancel"></i>
				<i class="i-status"></i>
				<ul class="email-suggest">
					<li>@qq.com</li>
					<li>@163.com</li>
					<li>@126.com</li>
					<li>@Gmail.com</li>
					<li>@Sohu.com</li>
					<li>@Sina.com</li>
				</ul>
			</div>
			<div class="input-tip">
				<i class="i-tip"></i>
				<span class="i-text"></span>
			</div>
			
			<div class="form-item">
				<label for="verifyCode" style="background-image: url(resources/images/verifycode1.png);background-size:100% 100%;"></label>
				<input type="text" id="verifyCode" name="verifyCode" placeholder="验证码" autocomplete="off" maxlength="4"/>
				<i class="i-cancel" style="right: 105px;"></i>
				<i class="i-status" style="right: 105px;"></i>
				<img alt="加载验证码失败" id="kaptcha-img" src="kaptchaCode">
			</div>
			<div class="input-tip">
				<i class="i-tip"></i>
				<span class="i-text"></span>
			</div>
			
			<input type="hidden" name="role" value="0"><!-- 用户角色都是普通用户 -->
			
			<div class="form-item">
				<input type="submit" id="register-btn" value="立 即 注 册">
			</div>
			
		</form>
	</div>
	<div class="footer">
		<a href="https://www.xtu.edu.cn/" target="_blank">学校主页</a>
		&nbsp;|&nbsp;
		<a href="http://jwxt.xtu.edu.cn/jsxsd/" target="_blank">教务管理系统</a>
		&nbsp;|&nbsp;
		<a href="https://portal2020.xtu.edu.cn" target="_blank">信息门户</a>
		&nbsp;|&nbsp;
		<a href="http://cie.xtu.edu.cn/ciextu_new/" target="_blank">信息工程学院</a>
		<br>
		Copyright &copy; 2019 - 2020 Orang Inc. All Rights Reserved.
	</div>
	<script type="text/javascript">
		
		var capsLockKey=false;//这个做法会导致在别的页面按下大写键,本页面并未能监听到,导致刚好错位,不过一般中国人打字中文的习惯很少会疏漏将大写键开着不关
		//大写键位作标记,方便焦点在输入密码框时显示提示信息
		//监听对象是body
			
		$("body").keydown(function (event) {
			//var e=event || window.event;
			if(event.keyCode==20){
				if(capsLockKey==false){//本身是关闭的,按下大写键后打开
					capsLockKey=true;
					if(document.activeElement.id=="password")//当焦点在密码输入框时才立即显示
						$("#password").parent().find("span").css("display","inline-block");
					else if(document.activeElement.id=="confirm-password")
						$("#confirm-password").parent().find("span").css("display","inline-block");
				}
				else{
					capsLockKey=false;
					$(".caps-lock").css("display","none");
				}
			}
		});
	
		//计算字符串长度,汉字算2个字符
		/*UTF-8：UTF-8一个(字符)占用(3)个字节，英文占用(1)个字节。
			GDK：GDK一个(字符)占用(2)个字节，英文占用(1)个字节。*/
		function getStringLen(val) {
			var len = 0;
			for (var i = 0; i < val.length; i++) {
				var a = val.charAt(i);
				if (a.match(/[^\x00-\xff]/ig) != null)
					len += 2;
				else
					len += 1;
			}
			return len;
		}
		//这里将RGB转成16进制颜色编码方便后续的css color条件判断能统一格式
		function colorRGBtoHex(color) {
	    	var rgb = color.split(',');
	    	var r = parseInt(rgb[0].split('(')[1]);
	    	var g = parseInt(rgb[1]);
	    	var b = parseInt(rgb[2].split(')')[0]);
	    	var hex = "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
	    	return hex;
		}
		
		function showInputTip(obj,text,backgroundPosition,color) {
			obj.find("span").html(text);
			obj.find("i").css("background-position",backgroundPosition);
			obj.find("span").css("color",color);
			if(obj.css("visibility")=="hidden")
				obj.css("visibility","visible");
		}

		$("#username").focus(function () {
			$(this).prev().css("background-position","0 -48px");
			if($(this).val()==""){
				var inputTip=$(this).parent().next();
				showInputTip(inputTip,"支持中文、英文、数字、'-'、'_'、的组合,4-20个字符","0 -100px","#c5c5c5");
			}
		});
		
		$("#username").bind("input propertychange",function () {
			var inputTip=$(this).parent().next();
			var reg=/^[a-zA-Z0-9\u4e00-\u9fa5_-]+$/;//这里是或的关系 支持中文
			if($(this).val()!=""){
				if($(this).next().css("display")=="none"){//第一次修改完,这时要把状态取消
					$(this).next().css("display","inline-block");
					$(this).next().next().css("display","none");
				}
				if(!reg.test($(this).val())){
					showInputTip(inputTip,"含有非法字符,仅支持汉字、字母、数字、'-'、'_'的组合!","-17px -100px","#ff9911");			
					return;
				}
			}
			else{
				$(this).next().css("display","none");
				if($(this).next().next().css("display")!="none")//光标选定一次性全部删除
					$(this).next().next().css("display","none");
			}
			if(inputTip.css("visibility")=="hidden"||colorRGBtoHex(inputTip.find("span").css("color"))=="#ff9911")/*用户名刚修改正确或用户名刚失去焦点有错误时 */
				showInputTip(inputTip,"支持中文、英文、数字、'-'、'_'、的组合,4-20个字符","0 -100px","#c5c5c5");
		});
	
		$("#username").blur(function () {
			$(this).prev().css("background-position","0 0");
			var inputTip=$(this).parent().next();
			var regNumber = /^\d+$/;
			if($(this).val()==""){
				inputTip.css("visibility","hidden");
			}
			else if(inputTip.find("span").html()=="含有非法字符,仅支持汉字、字母、数字、'-'、'_'的组合!"){
				
			}
			else if(getStringLen($(this).val())<4)
				showInputTip(inputTip,"长度只能在4-20个字符之间!","-17px -100px","#ff9911");
			else if(regNumber.test($(this).val()))
				showInputTip(inputTip,"用户名不能是纯数字,请重新输入!","-17px -100px","#ff9911");
			else{
				var input=$(this);//这里需要把username的this对象保存,因为在success里调用$(this)会调用成$.ajax
				$.ajax({
					url:"${pageContext.request.contextPath}/usernameJudge",
					data:{"username":$("#username").val()},
					type:"GET",
					datatype:"html",
					success:function(data){
						if(data=="该用户名可正常使用"){
							input.next().css("display","none");
							input.next().next().css("display","inline-block");
							inputTip.css("visibility","hidden");
						}
						else
							showInputTip(inputTip,data,"-17px -100px","#ff9911");
					}
				});
			}
		});
		
		/* 当点击按钮的时候，文本框失焦，这是浏览器的默认事件。当你点击按钮的时候，
		会触发按钮的 mousedown 事件，mousedown 事件的默认行为是使除了你点击的对象
		之外的有焦点的对象失去焦点。所以要在 mousedown 事件中阻止默认事件发生,这样
		就可以避免点击事件和失焦事件冲突,失焦事件会先执行,导致将cancel的display设置为none不能触发点击事件*/
		$(".i-cancel").mousedown(function (event) {
			event.preventDefault();
		});
		
		$(".i-cancel").click(function () {
			$(this).prev().val("");
			$(this).css("display","none");
			var inputTip=$(this).parent().next();
			//这里是处理点击屏蔽失焦事件的问题,当本身含有错误信息时,点击清空应该将提示信息改为默认
			if(document.activeElement.id!=$(this).prev().attr("id"))//当焦点不在输入框时要聚焦
				$(this).prev().focus();//这里有可能本身是失去焦点的情况下点击了清除,这时要重新获取输入框焦点
			if(document.activeElement.id=="email")
				$(".email-suggest").css("display","none");
		});
		
		$("#password").focus(function () {
			$(this).prev().css("background-position","-48px -48px");
			if(capsLockKey)//之前按下了大写键
				$(this).parent().find("span").css("display","inline-block");
			if($(this).val()==""){
				var inputTip=$(this).parent().next();
				showInputTip(inputTip,"建议使用字母、数字和符号两种及以上的组合,8-20个字符","0 -100px","#c5c5c5");
			}
		});

		$("#password").bind("input propertychange",function () {
			var numberReg=/^\d+$/;//单一字符种类,字符串中出现的类型必须在正则式里有是或的关系 这里是/^ +$格式,范围:正则式>实际字符串
			var letterReg=/^[a-zA-Z]+$/;
			var speCharReg=/^[-`=\\\[\];',.\/~!@#$%^&*()_+|{}:"<>?]+$/;
			var numberLetterReg=/^(?=.*\d)(?=.*[a-zA-Z]).*$/;//这里表示字符串必须包含数字、字母,但是还可能包含其他特殊字符并不冲突,范围:实际字符串>正则式 这里判断对同时含有数字、字母、特殊字符也能判定会冲突
			var numberSpeCharReg=/^(?=.*\d)(?=.*[-`=\\\[\];',.\/~!@#$%^&*()_+|{}:"<>?]).*$/;
			var letterSpeCharReg=/^(?=.*[a-zA-Z])(?=.*[-`=\\\[\];',.\/~!@#$%^&*()_+|{}:"<>?]).*$/;
			//这里表示字符串必须包含数字、字母、特殊字符三种类型 密码中一般也不能有空格
			/* \s* 表示若干个空格(可以是0个),\s+ 表示一个或多个空格*/
			var numLetterSpeCharReg=/^(?=.*\d)(?=.*[a-zA-Z])(?=.*[-`=\\\[\];',.\/~!@#$%^&*()_+|{}:"<>?]).*$/;
			// /和[]、\都得和 '\'组合才能正确表示
			var reg=/^[a-zA-Z0-9-`=\\\[\];',.\/~!@#$%^&*()_+|{}:"<>?]+$/;
			var inputTip=$(this).parent().next();
			if($(this).val()!=""){
				if($(this).next().css("visibility")=="hidden"){
					$(this).next().css("visibility","visible");
				}
				if(!reg.test($(this).val())){
					if($(this).next().next().css("display")!="none")
						$(this).next().next().css("display","none");
					showInputTip(inputTip,"含有汉字、中文符号或空格,仅支持数字、字母、英文字符的组合","-17px -100px","#ff9911");
					return;
				}
				if($(this).val().length<8){
					if($(this).next().next().css("display")!="none")//三种字符组合时达到8个长度时,密码强度直接达到中,没有弱的级别,此时要将安全对勾取消掉
						$(this).next().next().css("display","none");
					showInputTip(inputTip,"建议使用字母、数字和符号两种及以上的组合,8-20个字符","0 -100px","#c5c5c5");
				}
				else{
					//密码强度规则:1种组合: 8(弱) 12(中),2种组合: 8(弱) 10(中) 12(强) 3种组合: 8(中) 10(强)
					if(numberReg.test($(this).val()) || letterReg.test($(this).val()) || speCharReg.test($(this).val())){
						if($(this).val().length<=11){
							if($(this).next().next().css("display")!="none")//密码强度为弱时,对勾取消
								$(this).next().next().css("display","none");
							showInputTip(inputTip,"有被盗风险,建议增加密码长度或使用字母、数字和符号两种及以上组合!","-17px -134px","#ff9911");
						}
						else if($(this).val().length>=12){
							if($(this).next().next().css("display")=="none")//密码强度为中以上时,对勾显示
								$(this).next().next().css("display","inline-block");
							showInputTip(inputTip,"安全强度适中,可以使用字母、数字和符号两种组合来提高安全强度","-34px -117px","#c5c5c5");
						}
					}
					else if(numLetterSpeCharReg.test($(this).val())){//这里需要先判断同时含数字、字母、特殊字符三种类型,因为下面同时含两种的类型的可以适配同时含三种的
						if($(this).val().length<=9){
							showInputTip(inputTip,"安全强度适中,可以增加密码长度来提高安全强度","-34px -117px","#c5c5c5");
						}
						else if($(this).val().length>=10){
							showInputTip(inputTip,"你的密码很安全","-34px -134px","#c5c5c5");
						}
						if($(this).next().next().css("display")=="none")//这里密码强度有可能从弱变为中或无变为中,也可能弱直接变为强(有两种组合为弱时,加入第三个字母恰为第10个长度时),所以此时也显示对勾
							$(this).next().next().css("display","inline-block");
					}
					else if(numberLetterReg.test($(this).val()) || numberSpeCharReg.test($(this).val()) || letterSpeCharReg.test($(this).val())){
						if($(this).val().length<=9){
							if($(this).next().next().css("display")!="none")
								$(this).next().next().css("display","none");
							showInputTip(inputTip,"有被盗风险,建议增加密码长度使用字母、数字和符号三种组合!","-17px -134px","#ff9911");
						}
						else if($(this).val().length>=10 && $(this).val().length<=11){
							if($(this).next().next().css("display")=="none")
								$(this).next().next().css("display","inline-block");
							showInputTip(inputTip,"安全强度适中,可以增加密码长度或使用字母、数字和符号三种组合来提高安全强度","-34px -117px","#c5c5c5");
						}
						else if($(this).val().length>=12){
							if($(this).next().next().css("display")=="none")
								$(this).next().next().css("display","inline-block");
							showInputTip(inputTip,"你的密码很安全","-34px -134px","#c5c5c5");
						}
					}
				}
			}
			else{
				$(this).next().css("visibility","hidden");
				$(this).attr("type","password");
				$(this).next().css("background-image","url(resources/images/eye.png)");
				$(this).next().attr("title","点击显示密码");
				//这里是应对用户一次性将密码清零的操作,中间没有安全级别的递减因此,安全对勾可能还高亮着
				if($(this).next().next().css("display")!="none")//三种字符组合时达到8个长度时(或者光标选定一次性全部删除),密码强度直接达到中,没有弱的级别
					$(this).next().next().css("display","none");
				showInputTip(inputTip,"建议使用字母、数字和符号两种及以上的组合,8-20个字符","0 -100px","#c5c5c5");//这里是当一次性清空时,修改密码强度提示标语或非法中文标语
			}
			
			if($("#confirm-password").next().next().css("display")!="none")//改变密码时,确认密码的状态也应改变
				$("#confirm-password").next().next().css("display","none");
			
		});
		
		var flag=true;//设置点击显示密码失去焦点是否触发长度判定的标志
		$("#password").blur(function () {
			$(this).prev().css("background-position","-48px 0");
			if(capsLockKey)
				$(".caps-lock").css("display","none");
			var inputTip=$(this).parent().next();
			if($(this).val()==""){//这里无需设置flag,因为内容为空时查看密码图标是隐藏的
				inputTip.css("visibility","hidden");
			}
			else if($(this).val().length<8 && flag)
				showInputTip(inputTip,"长度只能在8-20个字符之间!","-17px -100px","#ff9911");
		});
		
		$("#i-onview").mousedown(function (event) {
			event.preventDefault();
		});
		//这里处理显示密码的问题上,没有采用设置两个input(一个password一个text)标签的做法,因为这会导致在判断密码强度时,dom文档的结构发生变化(在获取眼睛和状态标签时操作有所不同),要修改很多函数模块,最后代码很臃肿
		$(".i-onview").click(function () {
			var input=$(this).prev();
			if(document.activeElement.id=="password" || document.activeElement.id=="confirm-password"){
				flag=false;//不触发失去焦点后的长度判定
				input.blur();
				flag=true;//blur()主动失焦方法调用完毕后,回复正常
			}//如果本身焦点就在password输入框上,应先失去焦点,要不更改type类型的时候光标会出现错误,被重置到起始位置
			if(input.attr("type")=="password"){
				input.attr("type","text");
				$(this).css("background-image","url(resources/images/eye_close.png)");
				$(this).attr("title","点击隐藏密码");
			}
			else{
				input.attr("type","password");
				$(this).css("background-image","url(resources/images/eye.png)");
				$(this).attr("title","点击显示密码");
			}
			//这里mousedown虽然屏蔽了失去焦点事件,但是貌似点击onview在document.activeElement.id判断的时候还是会统一判为失去焦点
			input.focus();//这里重新获取焦点,光标的位置会和之前失去焦点之前的位置保持一致	
			//统一将光标位置移至最右侧
			var $password=input;
			var password=$password[0];
			var len=password.value.length;
			password.selectionStart = password.selectionEnd = len;
		});
		
		$("#confirm-password").focus(function () {
			$(this).prev().css("background-position","-48px -48px");
			if(capsLockKey)//之前按下了大写键
				$(this).parent().find("span").css("display","inline-block");
			if($(this).val()==""){
				var inputTip=$(this).parent().next();
				showInputTip(inputTip,"请再次输入密码","0 -100px","#c5c5c5");
			}
		});
		
		$("#confirm-password").bind("input propertychange",function () {
			var inputTip=$(this).parent().next();
			var reg=/^[a-zA-Z0-9-`=\\\[\];',.\/~!@#$%^&*()_+|{}:"<>?]+$/;
			if($(this).val()!=""){
				if($(this).next().css("visibility")=="hidden"){
					$(this).next().css("visibility","visible");
				}
				if(!reg.test($(this).val())){
					if($(this).next().next().css("display")!="none")
						$(this).next().next().css("display","none");
					showInputTip(inputTip,"含有汉字、中文符号或空格,仅支持数字、字母、英文字符的组合","-17px -100px","#ff9911");
					return;
				}
			}
			else{
				$(this).next().css("visibility","hidden");
				$(this).attr("type","password");
				$(this).next().css("background-image","url(resources/images/eye.png)");
				$(this).next().attr("title","点击显示密码");
			}
			if($(this).next().next().css("display")!="none")
				$(this).next().next().css("display","none");
			if(inputTip.css("visibility")=="hidden"||colorRGBtoHex(inputTip.find("span").css("color"))=="#ff9911")/*用户名刚修改正确或用户名刚失去焦点有错误时 */
				showInputTip(inputTip,"请再次输入密码","0 -100px","#c5c5c5");
		});
		
		$("#confirm-password").blur(function () {
			$(this).prev().css("background-position","-48px 0");
			if(capsLockKey)
				$(".caps-lock").css("display","none");
			var inputTip=$(this).parent().next();
			if($(this).val()==""){
				inputTip.css("visibility","hidden");
			}
			else if($(this).val()!=$("#password").val() && flag)
				showInputTip(inputTip,"两次密码输入不一致!","-17px -100px","#ff9911");
			else if($(this).val()==$("#password").val() && flag){
				inputTip.css("visibility","hidden");
				$(this).next().next().css("display","inline-block");
			}
		});
		
		$("#qq").focus(function () {
			$(this).prev().css("background-image","url(resources/images/qq2.png)");
			if($(this).val()==""){
				var inputTip=$(this).parent().next();
				showInputTip(inputTip,"qq号由5-10位的纯数字组成","0 -100px","#c5c5c5");
			}
		});
		
		$("#qq").bind("input propertychange",function () {
			var inputTip=$(this).parent().next();
			var reg=/^\d+$/;//qq号码由纯数字组成
			if($(this).val()!=""){
				if($(this).next().css("display")=="none"){
					$(this).next().css("display","inline-block");
					$(this).next().next().css("display","none");
				}
				if(!reg.test($(this).val())){
					showInputTip(inputTip,"含有非法字符,qq号仅由数字组成!","-17px -100px","#ff9911");			
					return;
				}
			}
			else{
				$(this).next().css("display","none");
				if($(this).next().next().css("display")!="none")//光标选定一次性全部删除
					$(this).next().next().css("display","none");
			}
			if(inputTip.css("visibility")=="hidden"||colorRGBtoHex(inputTip.find("span").css("color"))=="#ff9911")/*用户名刚修改正确或用户名刚失去焦点有错误时 */
				showInputTip(inputTip,"qq号由5-10位的纯数字组成","0 -100px","#c5c5c5");
		});
		
		$("#qq").blur(function () {
			$(this).prev().css("background-image","url(resources/images/qq1.png)");
			var inputTip=$(this).parent().next();
			var regNumber = /^\d+$/;
			if($(this).val()==""){
				inputTip.css("visibility","hidden");
			}
			else if(inputTip.find("span").html()=="含有非法字符,qq号仅由数字组成!"){
				
			}
			else if(getStringLen($(this).val())<5)
				showInputTip(inputTip,"长度只能在5-10个字符之间!","-17px -100px","#ff9911");
			else{
				var input=$(this);//这里需要把qq的this对象保存,因为在success里调用$(this)会调用成$.ajax
				$.ajax({
					url:"${pageContext.request.contextPath}/qqJudge",
					data:{"qq":$("#qq").val()},
					type:"GET",
					datatype:"html",
					success:function(data){
						if(data=="QQ号码格式符合标准"){
							input.next().css("display","none");
							input.next().next().css("display","inline-block");
							inputTip.css("visibility","hidden");
						}
						else
							showInputTip(inputTip,data,"-17px -100px","#ff9911");
					}
				});
			}
		});
		
		$("#email").focus(function () {
			$(this).prev().css("background-image","url(resources/images/envelope2.png)");
			if($(this).val()==""){
				var inputTip=$(this).parent().next();
				showInputTip(inputTip,"请输入正确的邮箱格式","0 -100px","#c5c5c5");
			}
		});
		
		function initEmailSuggest() {
			var email=$("#email").val();
			var i=1;
			$(".email-suggest li").each(function () {
				switch(i){
					case 1:$(this).text(email+"@qq.com");break;
					case 2:$(this).text(email+"@163.com");break;
					case 3:$(this).text(email+"@126.com");break;
					case 4:$(this).text(email+"@Gmail.com");break;
					case 5:$(this).text(email+"@Sohu.com");break;
					case 6:$(this).text(email+"@Sina.com");break;
				}
				i++;
			});
		}
		
		$(".email-suggest li").mousedown(function (event) {
			event.preventDefault();
		});
		
		//这里单击事件必须屏蔽失焦事件,要不会导致先触发失焦事件,.email-suggest li被设为none,点击事件会失效
		$(".email-suggest li").click(function () {
			$("#email").val($(this).text());
			$(".email-suggest").css("display","none");
		});
		
		$("#email").bind("input propertychange",function () {
			var inputTip=$(this).parent().next();
			if($(this).val()!=""){
				if($(this).next().css("display")=="none"){
					$(this).next().css("display","inline-block");
					$(this).next().next().css("display","none");
				}
				if($(".email-suggest").css("display")=="none"){
					$(".email-suggest").css("display","block");
				}
					initEmailSuggest();
			}
			else{
				$(this).next().css("display","none");
				if($(this).next().next().css("display")!="none")//光标选定一次性全部删除
					$(this).next().next().css("display","none");
				$(".email-suggest").css("display","none");
			}
			if(inputTip.css("visibility")=="hidden"||colorRGBtoHex(inputTip.find("span").css("color"))=="#ff9911")/*用户名刚修改正确或用户名刚失去焦点有错误时 */
				showInputTip(inputTip,"请输入正确的邮箱格式","0 -100px","#c5c5c5");
		});
		
		$("#email").blur(function () {
			$(this).prev().css("background-image","url(resources/images/envelope1.png)");
			var inputTip=$(this).parent().next();
			var reg=/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+.[a-zA-Z0-9_-]+$/;
			$(".email-suggest").css("display","none");
			if($(this).val()==""){
				inputTip.css("visibility","hidden");
			}
			else if(!reg.test($(this).val()))
				showInputTip(inputTip,"邮箱格式错误!","-17px -100px","#ff9911");	
			else{
				var input=$(this);//这里需要把qq的this对象保存,因为在success里调用$(this)会调用成$.ajax
				$.ajax({
					url:"${pageContext.request.contextPath}/emailJudge",
					data:{"email":$("#email").val()},
					type:"GET",
					datatype:"html",
					success:function(data){
						if(data=="邮箱格式正确"){
							input.next().css("display","none");
							input.next().next().css("display","inline-block");
							inputTip.css("visibility","hidden");
						}
						else
							showInputTip(inputTip,data,"-17px -100px","#ff9911");
					}
				});
			}
		});
		
		$('#kaptcha-img').click(function () {
			$('#kaptcha-img').attr('src','kaptchaCode?'+new Date().getTime());
		});
		
		$("#verifyCode").focus(function () {
			$(this).prev().css("background-image","url(resources/images/verifycode2.png)");
			if($(this).val()==""){
				var inputTip=$(this).parent().next();
				showInputTip(inputTip,"支持字母、数字的字符组合,共4个字符","0 -100px","#c5c5c5");
			}
		});
		
		$("#verifyCode").bind("input propertychange",function () {
			var inputTip=$(this).parent().next();
			var reg=/^[a-zA-Z0-9]+$/;//这里是或的关系
			if($(this).val()!=""){
				if($(this).next().css("display")=="none"){//第一次修改完,这时要把状态取消
					$(this).next().css("display","inline-block");
					$(this).next().next().css("display","none");
				}
				if(!reg.test($(this).val())){
					showInputTip(inputTip,"含有非法字符,仅支持字母、数字、的组合!","-17px -100px","#ff9911");			
					return;
				}
			}
			else{
				$(this).next().css("display","none");
				if($(this).next().next().css("display")!="none")//光标选定一次性全部删除
					$(this).next().next().css("display","none");
			}
			if(inputTip.css("visibility")=="hidden"||colorRGBtoHex(inputTip.find("span").css("color"))=="#ff9911")/*用户名刚修改正确或用户名刚失去焦点有错误时 */
				showInputTip(inputTip,"支持字母、数字的字符组合,共4个字符","0 -100px","#c5c5c5");
		});
	
		$("#verifyCode").blur(function () {
			$(this).prev().css("background-image","url(resources/images/verifycode1.png)");
			var inputTip=$(this).parent().next();
			if($(this).val()==""){
				inputTip.css("visibility","hidden");
			}
			else if(inputTip.find("span").html()=="含有非法字符,仅支持字母、数字、的组合!"){
				
			}
			else if(getStringLen($(this).val())<4)
				showInputTip(inputTip,"验证码的长度为4个字符!","-17px -100px","#ff9911");
			else{
				var input=$(this);//这里需要把username的this对象保存,因为在success里调用$(this)会调用成$.ajax
				$.ajax({
					url:"${pageContext.request.contextPath}/verifyCode",
					data:{"verifyCode":$("#verifyCode").val()},
					type:"GET",
					datatype:"html",
					success:function(data){
						if(data=="输入验证码正确"){
							input.next().css("display","none");
							input.next().next().css("display","inline-block");
							inputTip.css("visibility","hidden");
						}
						else{
							$('#kaptcha-img').attr('src','kaptchaCode?'+new Date().getTime());
							showInputTip(inputTip,data,"-17px -100px","#ff9911");
						}
					}
				});
			}
		});
		
		function checkForm() {
			var flag=true;
			$("#register-form .i-status").each(function () {
				if($(this).css("display")=="none"){
					flag=false;
					return;
				}
			});
			if(flag){
				alert("以成功注册该用户信息");
				return true;
			}
			else{
				alert("注册信息有误或不完整,请检查");
				return false;
			}
		}
		
	</script>
</body>
</html>