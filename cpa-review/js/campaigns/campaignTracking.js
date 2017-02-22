if ($.cookie("campaign-id") != null) {

	var campaignID = $.cookie("campaign-id");

	ga('send', 'event', 'Campaign', 'click', campaignID);

} 