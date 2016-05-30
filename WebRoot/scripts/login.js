/**
 * 页面初始化后，绑定函数。
 */
$(function() {
	// 注册
	$("#regist_button").click(function() {
		register();
	});
	$("#regist_username").blur(function() {
		register_username();
	});
	$("#regist_password").blur(function() {
		register_password();
	});
	// 登录
	$("#login").click(function() {
		login();
	});
	// 登出
	$("#logout").click(function() {
		logout();
	});
	// 修改密码
	$("#changePassword").click(function() {
		changepwd();
	})
});
// 注册异步请求
function register_ajax() {
	var username = $("#regist_username").val();
	var password = $("#regist_password").val();
	var nickname = $("#nickname").val();

	$.post(path + "/login/register.do", {
		"cn_user_name" : username,
		"cn_user_password" : password,
		"cn_user_desc" : nickname
	}, function(result) {
		if (result.success) {
			// 程序执行成功。进一步判读是否注册成功
			var data = result.data;
			if (data) {
				alert("注册成功.");
				$("#zc").attr("class", "sig sig_out");
				$("#dl").attr("class", "log log_in");
			} else {
				$("#warning_1 span").text("用户名已存在");
				$("#warning_1").show();
			}
		} else {
			alert(result.message);// 程序执行失败，返回失败消息
		}
	});
}
// -----------------------------注册begin---------------------------------
function register() {
	// 验证用户名
	if (register_username() == false) {
		return;
	}
	// 验证密码
	if (register_password() == false) {
		return;
	}
	// 向服务器发送用户注册信息
	register_ajax();
}
// 注册，失去用户名框焦点的时候触发事件
function register_username() {
	var username = $("#regist_username").val();
	var req = /^\w{3,20}$/;
	if (!req.test(username)) {
		$("#warning_1").show();
		return false;
	} else {
		$("#warning_1").hide();
		return true;
	}
}
// 注册，失去密码框焦点的时候触发事件
function register_password() {
	var password = $("#regist_password").val();
	if (password.length < 6) {
		$("#warning_2").show();
		return false;
	} else {
		$("#warning_2").hide();
		return true;
	}
}
// -----------------------------注册end-----------------------------------
// 登陆
function login() {
	var username = $("#count").val();
	var password = $("#password").val();
	$.post(path + "/login/login.do", {
		"username" : username,
		"password" : password
	}, function(result) {
		if (result.success == true) {
			// 程序运行正确
			var map = result.data;
			if (map.flag == 0) {
				// 登录成功
				// 将登录的用户信息发送给登录后的界面
				var user = map.user;
				addCookie("username", user.cn_user_name, 10);
				addCookie("userid", user.cn_user_id, 10);
				alert("登陆成功.");
				location.href = "edit.html";
			} else if (map.flag == 1) {
				// 用户名错误
				alert("用户名错误");
			} else {
				// 密码错误
				alert("密码错误");
			}
		} else {
			// 程序运行出错
			alert(result.message);
		}
	})
}
/**
 * 退出登录
 */
function logout() {
	$.post(path + "/login/logout.do", {}, function(result) {
		if (result.success) {
			// 程序执行成功跳转到登录界面
			location.href = "login.html";
		} else {
			alert(result.message);
		}
	});
}
/**
 * 修改密码
 */
function changepsw_ajax(new_password,last_password) {
	$.post(path + "/login/changepsw.do", {
		"new_password" : new_password,
		"last_password" : last_password
	}, function(result) {
		if (result.success) {
			var data = result.data;
			if (data == null) {
				alert("请不要提交空值");
			} else if (data==true) {
				$("#warning_1").hide();
				alert("修改成功.");
				logout();
			} else {
				$("#warning_1").show();
			}
		} else {
			alert(result.message);
		}
	})
}
function changepwd() {
	var new_password = $("#new_password").val();
	var last_password = $("#last_password").val();
	var final_password = $("#final_password").val();
	if (new_password.length < 6) {
		$("#warning_2").show();
		return false;
	} else {
		$("#warning_2").hide();
		// 两次输入的密码不一致
		if (final_password != new_password) {
			$("#warning_3").show();
			return false;
		} else {
			$("#warning_3").hide();
			changepsw_ajax(new_password,last_password);
			return true;
		}
	}
}
