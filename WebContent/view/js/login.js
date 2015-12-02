function checkForm()
{
	return checkUser()&&checkPwd();
}

function changeTextBorderStyle(text){
	text.style.borderColor="#ff0000";
} 

function checkUser(){
	document.getElementById("loginUser").style.borderColor="#ccc";
	var userObj = document.getElementById("loginUser");
	if(userObj.value==""){
		$("#announce").css("display","block");
		document.getElementById("announce").innerHTML="<div>请输入账号</div>";
		return false;
	}
	$("#announce").css("display","none");
	document.getElementById("announce").innerHTML="<div>&nbsp;</div>";
	return true;
}

function checkPwd(){
	document.getElementById("loginPwd").style.borderColor="#ccc";
	var pwdObj = document.getElementById("loginPwd");
	if(pwdObj.value==""){
		$("#announce").css("display","block");
		document.getElementById("announce").innerHTML="<div>请输入密码</div>";
		return false;
	}
	$("#announce").css("display","none");
	document.getElementById("announce").innerHTML="<div>&nbsp;</div";
	return true;
}

function changeButtonStyle(){
	document.getElementById("loginsubmit").style.background="#fff";
	document.getElementById("loginsubmit").style.color="#000";
}

function resetButtonStyle(){
	document.getElementById("loginsubmit").style.background="#000";
	document.getElementById("loginsubmit").style.color="#fff";
}

