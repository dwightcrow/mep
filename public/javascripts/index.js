
var sp = location.pathname.split("/");
currPage = sp[sp.length-1];
loadPage(currPage)


function loadPage(page){
    var s = document.createElement('script');
    s.type = "text/javascript";
    s.src = "/javascripts/"+page+".js";
    document.getElementsByTagName('head')[0].appendChild(s);
}

