var xmlhttp1;
var browerId;
	var say;
var userId;
	function sendSay() {
		var sendSay = document.getElementById("sendContent").value;
		if(sendSay==""){
			return false;
		}
		if(window.navigator.appName=="Microsoft Internet Explorer"){
			browerId=2;
		}else{
			browerId=1;
		}
		try{
		    // Firefox, Opera 8.0+, Safari
		    xmlhttp1=new XMLHttpRequest();
	    }
	  	catch (e){
	    // Internet Explorer
		    try{
		      xmlhttp1=new ActiveXObject("Msxml2.XMLHTTP");
		    }
		    catch (e)
		    {
		      	xmlhttp1=new ActiveXObject("Microsoft.XMLHTTP");
		    }
	    }

		if (!xmlhttp1) {
			alert("涓嶈兘鍒涘缓XMLHttpRequest瀵硅薄瀹炰緥");
			return false;
		}
		say = document.getElementById("sendContent").value;
		userId = document.getElementById("userId").value;
		xmlhttp1.onreadystatechange = opSay;
		xmlhttp1.open("POST", "sendGroup?say="+say+"&browerId="+browerId+"&userId="+userId,true);
		//xmlhttp1.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp1.setRequestHeader("Content-type", "text/html;charset=utf-8");
		xmlhttp1.send(null);
	
	}
	function opSay() {
		document.title = "WebTalk群聊界面";
		if (xmlhttp1.readyState == 4) {
			if (xmlhttp1.status == 200) {
				//alert("发送成功");
				now=new Date(); 
				year=now.getFullYear(); 
				month=now.getMonth()+1; 
				date=now.getDate(); 
				hours=now.getHours(); 
				minutes=now.getMinutes(); 
				seconds=now.getSeconds(); 
				
				 //document.getElementById("usercontent").innerHTML=document.getElementById("usercontent").innerHTML+"<div id='userme'>我说:&nbsp;&nbsp;&nbsp;"+year+"-"+month+"-"+date+" "+hours+":"+minutes+":"+seconds+"</div><div id='usercontent'>"+say+"</div>";
				 document.getElementById("content").scrollTop = document.getElementById("content").scrollHeight;
				document.getElementById("sendContent").value="";
			}else{
				alert("发送失败");
			}
		}
	}
