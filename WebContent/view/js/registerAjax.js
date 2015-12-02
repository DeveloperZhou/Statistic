var xmlhttp;
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
			alert("Your browser does not support XMLHTTP");
			return false;
		}

		xmlhttp.onreadystatechange = processReuqest;
		var name = document.getElementById("username").value;
		xmlhttp.open("POST", "http://localhost:8080/vote/register?search="+name,true);
		xmlhttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		xmlhttp.setRequestHeader("Content-type", "text/html;charset=utf-8");
		xmlhttp.send(null);
	
	}
	function processReuqest() {
		
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				
				var str = xmlhttp.responseText;
				if(str==1){
					document.getElementById("announce").style.color="#ff0000";
					document.getElementById("announce").innerHTML="！该用户名已存在!";
				}else if(str!=1&&document.getElementById("username").value!=""){
					document.getElementById("announce").innerHTML="该用户名可以注册!";
					//document.getElementById("announce").innerHTML=str;
					document.getElementById("announce").style.color="green";
				}
				
			}
		}
	}
	function clearAnnounce(){
		document.getElementById("announce").innerHTML="";
		
	}
	
