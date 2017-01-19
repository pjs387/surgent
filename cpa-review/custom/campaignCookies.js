function getParameterByName(name) {
	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
		results = regex.exec(location.search);
	return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

var source = getParameterByName('utm_source');
var medium = getParameterByName('utm_medium');
var campaign = getParameterByName('utm_campaign');
var term = getParameterByName('utm_term');
var content = getParameterByName('utm_content');
var campaignID = getParameterByName('campaignID');
 
if($.cookie('utm_source') == null || $.cookie('utm_source') == "") {
$.cookie('utm_source');
}
if($.cookie('utm_medium') == null || $.cookie('utm_medium') == "") {
$.cookie('utm_medium');
}
if($.cookie('utm_campaign') == null || $.cookie('utm_campaign') == "") {
$.cookie('utm_campaign');
}
if($.cookie('utm_term') == null || $.cookie('utm_term') == "") {
$.cookie('utm_term');
}
if($.cookie('utm_content') == null || $.cookie('utm_content') == "") {
$.cookie('utm_content');
}
if($.cookie('campaignID') == null || $.cookie('campaignID') == "") {
$.cookie('campaignID');
}