function setCampaign() {

	if ($.cookie("campaign-id") != null) { // if a value is set for the cookie, then use it

		var campaignID = $.cookie("campaign-id");

	} else { // if no value is set for the cookie, then use default

		var campaignID = '6837B540-1D84-E611-8105-000D3A10837B';

}

	if (window.location.hostname == 'qa.surgentcpareview.com') {

		$('#ContentPlaceHolder1_C006_ctl00_ctl00_ctl00_C028_ctl00_ctl00_txtHiddenStatic').val(campaignID) // input field in QA

	} else {

		$('#ContentPlaceHolder1_C006_ctl00_ctl00_ctl00_C026_ctl00_ctl00_txtHiddenStatic').val(campaignID) // input field in Prod

	}

}