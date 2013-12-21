$(document).ready(function() {

    $("#live_feed_container").mCustomScrollbar({
        scrollButtons:{
            enable:true
        },
        advanced:{
            updateOnContentResize: true
        },
        autoHideScrollbar:true,
        theme:"light-thin"
    });

    $("#recent_ops_container").mCustomScrollbar({
        scrollButtons:{
            enable:true
        },
        advanced:{
            updateOnContentResize: true
        },
        autoHideScrollbar:true,
        theme:"light-thin"
    });

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        var target = $(e.target);
        if(target.attr('href') == '#two'){
            $(window).resize();
        }
    })

});

function getServerDetails(ipaddr) {
    var url = 'http://zeus-community.net/query/armaquery.php?server=' + ipaddr +':2302&lang=en';
    var serverName = $("<div/>'").load(url, function() {
        $("*:contains(Hostname)").closest("td").next().text();
    });

    return serverName;
}

function counter(element, end) {
    var	$text	= element,
        endVal	= 0,
        currVal	= 0,
        obj	= {};

    obj.getTextVal = function() {
        return parseInt(currVal, 10);
    };

    obj.setTextVal = function(val) {
        currVal = parseInt(val, 10);
        $text.text(currVal);
    };

    obj.setTextVal(0);


    currVal = 0; // Reset this every time
    endVal = end;

    TweenLite.to(obj, 7, {setTextVal: endVal, ease: Power2.easeInOut});
};


function parseArmaDate(input) {
    var system_date = new Date(input);
    var user_date = new Date();
    var diff = Math.floor((user_date - system_date) / 1000);
    if (diff <= 1) {return "just now";}
    if (diff < 20) {return diff + " seconds ago";}
    if (diff < 40) {return "half a minute ago";}
    if (diff < 60) {return "less than a minute ago";}
    if (diff <= 90) {return "one minute ago";}
    if (diff <= 3540) {return Math.round(diff / 60) + " minutes ago";}
    if (diff <= 5400) {return "1 hour ago";}
    if (diff <= 86400) {return Math.round(diff / 3600) + " hours ago";}
    if (diff <= 129600) {return "1 day ago";}
    if (diff < 604800) {return Math.round(diff / 86400) + " days ago";}
    if (diff <= 777600) {return "1 week ago";}
		if (diff > 777600) {return "Over a week ago";}
    return "on " + system_date;
}

// AO Edit/Create
function FindPosition(oElement)
{
  if(typeof( oElement.offsetParent ) != "undefined")
  {
    for(var posX = 0, posY = 0; oElement; oElement = oElement.offsetParent)
    {
      posX += oElement.offsetLeft;
      posY += oElement.offsetTop;
    }
      return [ posX, posY ];
    }
    else
    {
      return [ oElement.x, oElement.y ];
    }
}

function GetCoordinates(e)
{
  var PosX = 0;
  var PosY = 0;
  var ImgPos;
  var width = 2200 / myImg.clientWidth;
  var height = 900/ myImg.clientHeight;
  ImgPos = FindPosition(myImg);
  
  if (!e) var e = window.event;
  if (e.pageX || e.pageY)
  {
    PosX = e.pageX;
    PosY = e.pageY;
  }
  else if (e.clientX || e.clientY)
    {
      PosX = e.clientX + document.body.scrollLeft
        + document.documentElement.scrollLeft;
      PosY = e.clientY + document.body.scrollTop
        + document.documentElement.scrollTop;
    }
  PosX = PosX - ImgPos[0];
  PosY = PosY - ImgPos[1];
  document.getElementById("imageMapX").value = PosX*width;
  document.getElementById("imageMapY").value = PosY*height;
}

// Open Layers
function overlay_getTileURL(bounds) {
	var res = this.map.getResolution();
	var x = Math.round((bounds.left - this.maxExtent.left) / (res * this.tileSize.w));
	var y = Math.round((bounds.bottom - this.maxExtent.bottom) / (res * this.tileSize.h));
	var z = this.map.getZoom();
	if (x >= 0 && y >= 0) {
		return this.url + z + "/" + x + "/" + y + "." + this.type;				
	} else {
		return "http://www.maptiler.org/img/none.png";
	}
}

function getWindowHeight() {
	if (self.innerHeight) return self.innerHeight;
	if (document.documentElement && document.documentElement.clientHeight)
		return document.documentElement.clientHeight;
	if (document.body) return document.body.clientHeight;
		return 0;
}

function getWindowWidth() {
	if (self.innerWidth) return self.innerWidth;
	if (document.documentElement && document.documentElement.clientWidth)
		return document.documentElement.clientWidth;
	if (document.body) return document.body.clientWidth;
		return 0;
}

function resize() {  
	var map = document.getElementById("map");  
	map.style.height = (getWindowHeight()-80) + "px";
	map.style.width = (getWindowWidth()-20) + "px";
	if (map.updateSize) { map.updateSize(); };
} 