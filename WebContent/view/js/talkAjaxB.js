var xmlhttp;
var maxid=0;
	function searchSuggest() {
	
		try
	    {
	    // Firefox, Opera 8.0+, Safari
	    xmlhttp=new XMLHttpRequest();
	    }
	  catch (e)
	    {
	    // Internet Explorer
	    try
	      {
	      xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
	      }
	    catch (e)
	      {
	      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }
	    }

		if (!xmlhttp) {
			alert("涓嶈兘鍒涘缓XMLHttpRequest瀵硅薄瀹炰緥");
			return false;
		}

		xmlhttp.onreadystatechange = processReuqest;
		xmlhttp.open("POST", "talkB?search=",true);
		xmlhttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		xmlhttp.setRequestHeader("Content-type", "text/html;charset=utf-8");
		xmlhttp.send(null);
	
	}
	function processReuqest() {
		
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				var content = document.getElementById("content");
				var sendtimeObj = document.getElementById("sendTime");
				var userinfoObj = document.getElementById("userinfo");
				var usercontentObj = document.getElementById("usercontent");
				var str = xmlhttp.responseText;
				//alert(str);
				var sendtime = str.substring(0,19);
				sendtimeObj.innerHTML = "最后一则消息发送于:&nbsp;"+sendtime;
				userinfoObj.innerHTML = "用户B:&nbsp;&nbsp;&nbsp;"+sendtime;
				var a = str.substring(21,str.indexOf("☆"));
				if(parseInt(maxid)<parseInt(str.substring(str.indexOf("☆")+1))&&parseInt(maxid)!=0){
					changeTitle();
					usercontentObj.innerHTML=usercontentObj.innerHTML+"<div id='userinfo'>用户B:&nbsp;&nbsp;&nbsp;"+sendtime+"</div><div id='usercontent'><li>"+str.substring(21,str.indexOf("☆"))+"</li></div>";
					document.getElementById("content").scrollTop = document.getElementById("content").scrollHeight;
				}else if(parseInt(maxid)==0){
					usercontentObj.innerHTML= a;
				}
				maxid = str.substring(str.indexOf("☆")+1);
				
			}
		}
	}
	function stopChangeTitle()
	{
		document.title ="用户B聊天界面";
		
	} 
	function changeTitle(){
		document.title = "您有新消息";
		var player = document.getElementById("sound");
		if(player==null){
			
			var embedObj = document.createElement("embed");
			embedObj.src="vedio/msg.wav";
			embedObj.id="sound";

			embedObj.hidden = "true";
			embedObj.autostart = "true";
			document.getElementById("sss").appendChild(embedObj);
		}else{
			//alert("已经存在播放器");
			document.getElementById("sss").removeChild(player);
			var embedObj = document.createElement("embed");
			embedObj.src="vedio/msg.wav";
			embedObj.id="sound";

			embedObj.hidden = "true";
			embedObj.autostart = "true";
			document.getElementById("sss").appendChild(embedObj);
		}
	}
	window.onload = function(){
		setInterval("searchSuggest()",500);
	}