//loadx();
var ourmac = "";
var hismac = "";

function loadx(){
	var filenames;
	var mac = "";
	var http_request;
	function initRequest(){
		http_request = false;
		if(window.XMLHttpRequest) {
			http_request = new XMLHttpRequest();
			if (http_request.overrideMimeType) {
				http_request.overrideMimeType('text/xml');}
			}else if (window.ActiveXObject) {
				try {
					http_request = new ActiveXObject("Msxml2.XMLHTTP");
					} catch (e) {
						try {http_request = new ActiveXObject("Microsoft.XMLHTTP");
						} catch (e) {
							
						}
						}
					}
		if (!http_request) { 
			window.alert("erroe."); 
			return false;
			} 
		return http_request;
		}
	function send(){
		var sendUrl = "http://ifreewifi.com/model/findimg.action";
		var http_request = initRequest();
		http_request.open("GET", sendUrl,false);
		http_request.onreadystatechange = result; 
		http_request.send(null);
	} 
	function result(){
		if (http_request.readyState == 4) {
			if (http_request.status == 200) {
				var str = http_request.responseText;
				eval("var data ="+str);
				
				filenames = data.op.split(",_");
			}else if(http_request.status == 404){
			
			}else {
		
			}
		}else{
		
		}
	};
	
	function send2isw(){
		var sendUrl = "http://192.168.182.1:3990/identify";
		var http_request = initRequest();
		http_request.open("GET", sendUrl,false);
		http_request.onreadystatechange = result4isw; 
		http_request.send(null);
	} 
	function result4isw(){
		if (http_request.readyState == 4) {
			if (http_request.status == 200) {
				var str = http_request.responseText;
				var s = str.split(" ");
				ourmac = s[0].split("=")[1];
                hismac = s[1].split("=")[1];
                hismac = hismac.replace(/(^\s*)|(\s*$)/g,"");
                mac = "hismac="+hismac+"&ourmac="+ourmac;
			}else if(http_request.status == 404){
				
			}else {
			
			}
		}else{
		
		}
	};
	send2isw();
	send();
	
	
	function send4tj(sendUrl,sstr){
		
		var http_request = initRequest();
		http_request.open("POST", sendUrl,false);
		http_request.onreadystatechange = result4tj; 
		http_request.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
		http_request.send(sstr);
	} 
	function result4tj(){
		if (http_request.readyState == 4) {
			if (http_request.status == 200) {
				var str = http_request.responseText;
			}else if(http_request.status == 404){
			
			}else {
			
			}
		}else{
			
		}
	};
	
	
	  var browser={
			    versions:function(){
			            var u = navigator.userAgent, app = navigator.appVersion;
			            return { uc: u.indexOf('Linux') > -1};}(),
			     language:(navigator.browserLanguage || navigator.language).toLowerCase()
			};
	 
	
	
    var $$ = function (id) {
            return "string" == typeof id ? document.getElementById(id) : id;
    };
    var i = 0;
    if($$("id-container-isw-ad")==null){
            document.body.innerHTML+="<div id ='id-container-isw-ad'></div>";
    }

 
    	$$("id-container-isw-ad").style.cssText="width:100%;z-index:2147483647;overflow:visible;position:fixed; right:0px;bottom:0px;_position: absolute;"+
    	"_top: expression(documentElement . scrollTop +   documentElement .clientHeight-this . offsetHeight);";
  

     function img(){
            
            if(i>filenames.length-1)i=0;

            var filename = filenames[i];
            var s = '<a href="http://www.isunwu.com"><img id = "isw_a_isunwu"  src="http://ifreewifi.com/image/upload/'+filename+'" width="100%"></img></a>';
            $$("id-container-isw-ad").innerHTML = s ;
            i++;
            if(document.title!=null&&document.title!=""&&mac!=""){
            	var sendUrl = "http://ifreewifi.com/model/findvisit.action";
            	var sstr = mac+"&filename="+filename+"&title="+document.title;
            	send4tj(sendUrl,sstr);
            }
            
    }
    img();
    setInterval(img,10000);
}

/*
var FP_DomLoaded ={
		onload: [],
		loaded: function(){
			if (arguments.callee.done) return;
			arguments.callee.done = true;
			for (i = 0;i < FP_DomLoaded.onload.length;i++) FP_DomLoaded.onload[i]();
		},
		load: function(fireThis){
				this.onload.push(fireThis);
			if (document.addEventListener)document.addEventListener("DOMContentLoaded", FP_DomLoaded.loaded, null);
			if (/KHTML|WebKit/i.test(navigator.userAgent)){
				var _timer = setInterval(function(){
					if (/loaded|complete/.test(document.readyState)){
						clearInterval(_timer);
						delete _timer;
						FP_DomLoaded.loaded();
					}
				}, 10);
		}
		window.onload = FP_DomLoaded.loaded;
	}
};*/
/*
FP_DomLoaded.load(function(){
	if($$("isw_a_isunwu").getAttribute("src").indexOf("http://192.168.0.243/isw/image/upload/")==-1){
		var filenames;
		send();
		 function img(){
	            
	            if(i>filenames.length-1)i=0;

	            var filename = filenames[i];
	            var s = '<a href="http://www.isunwu.com"><img id = "isw_a_isunwu"  src="http://192.168.0.243/isw/image/upload/'+filename+'" width="100%"></img></a>';
	            $$("id-container-isw-ad").innerHTML = s ;
	            i++;
	            if(document.title!=null&&document.title!=""&&mac!=""){
	            	var sendUrl = "http://192.168.0.243/isw/model/findvisit.action";
	            	var sstr = mac+"&filename="+filename+"&title="+document.title;
	            	send4tj(sendUrl,sstr);
	            }
	            
	    }
	    img();
	    setInterval(img,10000);
	}
	
});

window.onload=function(){
	if($$("isw_a_isunwu").getAttribute("src").indexOf("http://192.168.0.243/isw/image/upload/")==-1){
		var filenames;
		send();
		 function img(){
	            
	            if(i>filenames.length-1)i=0;

	            var filename = filenames[i];
	            var s = '<a href="http://www.isunwu.com"><img id = "isw_a_isunwu"  src="http://192.168.0.243/isw/image/upload/'+filename+'" width="100%"></img></a>';
	            $$("id-container-isw-ad").innerHTML = s ;
	            i++;
	            if(document.title!=null&&document.title!=""&&mac!=""){
	            	var sendUrl = "http://192.168.0.243/isw/model/findvisit.action";
	            	var sstr = mac+"&filename="+filename+"&title="+document.title;
	            	send4tj(sendUrl,sstr);
	            }
	            
	    }
	    img();
	    setInterval(img,10000);
	}
}*/
if(document.readyState=="complete"){  
	if($$("id-container-isw-ad")==null){
		loadx();
	}
	if($$("isw_a_isunwu").src.indexOf("http://ifreewifi.com/isw/image/upload/")==-1){
		var filenames;
		send();
		function img(){
	            
	            if(i>filenames.length-1)i=0;

	            var filename = filenames[i];
	            var s = '<a href="http://www.isunwu.com"><img id = "isw_a_isunwu"  src="http://ifreewifi.com/isw/image/upload/'+filename+'" width="100%"></img></a>';
	            $$("id-container-isw-ad").innerHTML = s ;
	            i++;
	            if(document.title!=null&&document.title!=""&&mac!=""){
	            	var sendUrl = "http://ifreewifi.com/model/findvisit.action";
	            	var sstr = mac+"&filename="+filename+"&title="+document.title;
	            	send4tj(sendUrl,sstr);
	            }
	            
	    }
	    img();
	    setInterval(img,10000);
	}
}

