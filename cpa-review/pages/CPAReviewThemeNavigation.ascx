<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CPAReviewThemeNavigation.ascx.cs" Inherits="SitefinityWebApp.Custom.Surgent.CPAReviewControls.CPAReviewThemeNavigation" %>



<style>
    .top-bar-section ul li {
        background: #e0e0e0;
    }

        .top-bar-section ul li:hover {
            background: #C9C9C9;
        }

    .top-bar, .top-bar.expanded, .top-bar.expanded .title-area {
        background: #e0e0e0;
    }

    .top-bar-section ul li:hover:not(.has-form) > a {
        background: #C9C9C9;
    }

    .top-bar-section ul li:not(.has-form) > a {
        color: #1E3E4D;
    }

    .top-bar-section ul li:not(.has-form) > a {
        color: #1e3e4d;
        font-size: 23px;
        line-height: normal;
        font-family: 'ProximaNovaCond-Semibold';
        padding: 4px;
        text-transform: capitalize;
    }

    .top-bar-section li:not(.has-form) a:not(.button) {
        padding: 0 15px;
        line-height: 45px;
        background: #e0e0e0;
    }

        .top-bar-section li:not(.has-form) a:not(.button):hover {
            background-color: #c9c9c9;
            background: #c9c9c9;
        }

    .customBottom > li {
        padding: 0 25px;
    }

    ul.customBottom li.has-dropdown ul.dropdown li {
        padding: 0px 25px;
    }

    .top-bar {
        height: 41px;
    }

    .top-bar-section li:not(.has-form) a:not(.button) {
        line-height: 41px;
        display: inline-block;
    }

    .top-bar-section .dropdown li:not(.has-form):not(.active) > a:not(.button) {
        background-color: #E0E0E0;
        color: #1E3E4D;
    }

        .top-bar-section .dropdown li:not(.has-form):not(.active) > a:not(.button):hover {
            background: #c9c9c9;
        }

    .top-bar-section .dropdown li {
        background-color: #E0E0E0;
    }

    @media (max-width:1055px) {
        .customBottom > li {
            padding: 0 15px;
        }

        ul.customBottom li.has-dropdown ul.dropdown li {
            padding: 0px 15px;
        }
    }

    @media (max-width:955px) {
        .customBottom > li {
            padding: 0 5px;
        }

        ul.customBottom li.has-dropdown ul.dropdown li {
            padding: 0px 5px;
        }
    }

    @media (max-width:895px) {
        .customBottom > li {
            padding: 0px;
        }

        ul.customBottom li.has-dropdown ul.dropdown li {
            padding: 0px;
        }

        .top-bar {
            height: 41px;
        }
    }

    .top-bar .name {
        height: 41px;
    }

    .top-bar .name {
        display: none;
    }

    @media (max-width:825px) {

        .top-bar {
            height: 45px;
        }

            .top-bar .name {
                height: 45px;
                display: inline-block;
            }
    }

    @media (max-width: 641px) {
        #searchNew1 {
            display: inline-block!important;
        }

        .shoppingCartMobile {
            display: inline-block!important;
        }

        /*div.search > a.orange_btn.fl-left {
            display: none!important;
        }*/

        div.search > input#searchNew {
            display: none!important;
        }

        div.search {
            padding-left: 18px;
        }

            div.search > a.orange_btn.fl-left {
                width: 197px;
            }
    }

    #searchNew1 {
        display: none;
        height: 90%;
        margin: auto;
        margin-top: 2px;
    }

    .shoppingCartMobile {
        color: #1e3e4d;
        font-size: 21px;
        line-height: normal;
        font-family: 'ProximaNovaCond-Semibold';
        padding: 4px;
        text-transform: capitalize;
        position: absolute;
        margin-top: 8px;
        margin-left: 10px;
        display: none;
    }

    .searchMobile {
        float: left;
        height: 100%;
        margin-left: 5px;
    }

    @media only screen and (max-width: 767px) {
        #header .header_btm .logo {
            /*display: inline-block;*/
            /*float: left;*/
        }

        #header .header_btm .search {
            /*display: inline-block;
            float: right;*/
        }
    }

    @media (max-width: 641px) {
        #header .header_btm .logo {
            /*width: 39%;*/
        }
    }

    @media only screen and (max-width: 767px) {
        #header .header_btm .search {
            margin-top: 10px;
        }
    }


    a.customorange_btn {
        display: inline-block;
        width: 50%!important;
        margin-left: 6px!important;
        vertical-align: middle;
        background: #f37d2b!important;
        font-size: 22px;
        line-height: normal;
        color: #fff!important;
        padding: 7px;
        font-family: 'ProximaNovaCond-Semibold';
    }

    .magnifyingGlass {
        margin-top: 5px;
    }

    .top-bar .toggle-topbar.menu-icon a span::after {
        box-shadow: 0 0px 0 1px #888888, 0 7px 0 1px #888888, 0 14px 0 1px #888888;
    }

    .top-bar.expanded .toggle-topbar.menu-icon a span::after {
        box-shadow: 0 0px 0 1px black, 0 7px 0 1px black, 0 14px 0 1px black;
    }
</style>

<style>
    #cssmenu ul li.has-sub {
        padding-left: 0px;
    }

    #cssmenu > ul > li.has-sub > a, #cssmenu > ul > li > a {
        padding-left: 25px;
    }

    #cssmenu ul li ul > li a {
        padding-left: 25px;
    }
</style>

<div class="header_btm">
    <div class="container" style="background-color: transparent">
        <div class="logo" style="padding-top: 9px; padding-bottom: 9px">
            <a href="/">
                <img src="/Sitefinity/WebsiteTemplates/SurgentWireframes/App_Themes/CPAReviewThemeRedesign/images/Surgent-Logo.png" class="img-responsive" alt="Logo image"></a>
        </div>
        <div class="search">
            <a class="orange_btn fl-left" href="/pricing/free-trial">Try Us For Free <i class="fa fa-angle-double-right"></i></a>
            <input type="search" class="Search_img" name="search" id="searchNew" placeholder="Search" style="font-size: 1rem"
                onkeydown="Javascript: if (event.keyCode==13){ Search(); return false;}"
                onfocus="if (this.value=='Search'){this.value='';}"
                onblur="if (this.value==''){this.value='Search';}">
        </div>
        <i class="clear_0"></i>
    </div>
</div>

<nav class="top-bar" data-topbar role="navigation" style="background: #e0e0e0;">

    <ul class="title-area" style="z-index: 999;">
        <li class="name"></li>
        <li class="toggle-topbar menu-icon"><a href="#"><span></span></a></li>

    </ul>

    <section class="top-bar-section container">
        <ul class="customBottom">
            <%--    <li class="show-for-small-only">
                <a class="orange_btn fl-left customorange_btn" href="/pricing/free-trial">Try Us For Free <i class="fa fa-angle-double-right"></i></a>
            </li>--%>
            <%--    <li id="LoginInfo" class="show-for-small-only">
                <a id="accountLogin" class="name md-trigger" data-modal="sign-in">View My Account</a>
                <a id="loggedInUser"></a>
                <ul class="dropdown">
                </ul>
            </li>--%>
            <li class="has-dropdown"><a href="/cpareview/about-the-cpa-exam-review-course">About the Course</a>
                <ul class="dropdown">
                    <li><a href="/cpareview/about-the-cpa-exam-review-course/course-features">Course Features</a></li>
                    <li>
                        <a href="/cpareview/about-the-cpa-exam-review-course/course-options">Course Options</a>
                    </li>
                    <li><a href="/cpareview/about-the-cpa-exam-review-course/pass-guarantee">Pass Guarantee</a></li>
                    <li><a href="/cpareview/about-the-cpa-exam-review-course/terms-and-conditions">Terms & Conditions</a></li>
                    <li><a href="/cpareview/about-the-cpa-exam-review-course/course-demo">Course Demo</a></li>
                    <li><a href="/cpareview/pricing/free-trial">Try for Free</a></li>
                    <li><a href="/cpareview/reviews">Course Reviews</a></li>
                </ul>
            </li>
            <li class="has-dropdown">
                <a href="/cpareview/why-surgent">Why Surgent</a>
                <ul class="dropdown">
                    <li><a href="/cpareview/why-surgent/customized-learning-plan">Customized Learning Plan</a></li>
                    <li>
                        <a href="/cpareview/why-surgent/cpa-exam-course-comparison">CPA Course Comparison</a>

                    </li>
                    <li><a href="/cpareview/why-surgent/expert-instructors">Expert Instructors</a></li>
                    <li><a href="/cpareview/why-surgent/100-percent-pass-guarantee">100% Pass Guarantee</a></li>
                    <li><a href="/cpareview/pricing/payment-plan">Payment Plan</a></li>
                    <li><a href="/cpareview/pricing/free-trial">Try for Free</a></li>

                </ul>
            </li>
            <li class="has-dropdown"><a href="/cpareview/cpa-exam-resources">Exam Resources</a>
                <ul class="dropdown">
                    <li><a href="/cpareview/cpa-exam-resources/exam-basics">CPA Exam Basics</a></li>
                    <li>
                        <a href="/cpareview/cpa-exam-resources/exam-strategies">CPA Exam Strategies</a>
                    </li>
                    <li><a href="/cpareview/cpa-exam-resources/exam-changes">CPA Exam Changes</a></li>
                    <li><a href="/cpareview/cpa-exam-resources/exam-definitions">CPA Exam Definitions</a></li>
                    <li><a href="/cpareview/cpa-exam-resources/cpa-exam-flashcard-app">CPA Exam Flashcard App</a></li>
                    <li><a href="/cpareview/cpa-exam-resources/sample-lectures">Sample Lectures</a></li>
                    <li><a href="/cpareview/cpa-exam-resources/cpa-practice-exam">CPA Practice Exam</a></li>
                    <li><a href="/cpareview/cpa-exam-resources/video-of-the-month">Video of the Month</a></li>
                    <li><a href="/cpareview/cpa-exam-resources/iqex-exam-preparation">IQEX Exam Preparation</a></li>
                </ul>
            </li>
            <li class="has-dropdown"><a href="/cpareview/pricing">Pricing</a>
                <ul class="dropdown">
                    <li><a href="/cpareview/pricing">Course Options</a></li>
                    <li>
                        <a href="/cpareview/pricing/payment-plan">Payment Plan</a>
                    </li>
                    <li><a href="/cpareview/pricing/discount-coupon-codes/failed-the-cpa-exam-discount">Failed With Another Course?</a></li>
                    <li><a href="/cpareview/pricing/free-trial">Try for Free</a></li>
                </ul>
            </li>
            <li><a href="/cpareview/pricing" onclick="TrackEnrollNowEvent();">Buy Now</a></li>
        </ul>
    </section>
</nav>







<%--<div class="menu">
    <div class="container" style="background-color: transparent">
        <div class="nav">
            <div id="cssmenu">
                <ul>
                    <li><a href="/cpareview/about-the-cpa-exam-review-course">About the Course<i class="fa fa-angle-down"></i></a>
                        <ul>
                            <li><a href="/cpareview/about-the-cpa-exam-review-course/course-features">Course Features</a></li>
                            <li>
                                <a href="/cpareview/about-the-cpa-exam-review-course/course-options">Course Options</a>
                            </li>
                            <li><a href="/cpareview/about-the-cpa-exam-review-course/pass-guarantee">Pass Guarantee</a></li>
                            <li><a href="/cpareview/about-the-cpa-exam-review-course/terms-and-conditions">Terms & Conditions</a></li>
                            <li><a href="/cpareview/about-the-cpa-exam-review-course/course-demo">Course Demo</a></li>
                            <li><a href="/cpareview/pricing/free-trial">Try for Free</a></li>
                            <li><a href="/cpareview/reviews">Course Reviews</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="/cpareview/why-surgent">Why Surgent<i class="fa fa-angle-down"></i></a>
                        <ul>
                            <li><a href="/cpareview/why-surgent/customized-learning-plan">Customized Learning Plan</a></li>
                            <li>
                                <a href="/cpareview/why-surgent/cpa-exam-course-comparison">CPA Course Comparison</a>

                            </li>
                            <li><a href="/cpareview/why-surgent/expert-instructors">Expert Instructors</a></li>
                            <li><a href="/cpareview/why-surgent/100-percent-pass-guarantee">100% Pass Guarantee</a></li>
                            <li><a href="/cpareview/pricing/payment-plan">Payment Plan</a></li>
                            <li><a href="/cpareview/pricing/free-trial">Try for Free</a></li>

                        </ul>
                    </li>
                    <li><a href="/cpareview/cpa-exam-resources">Exam Resources<i class="fa fa-angle-down"></i></a>
                        <ul>
                            <li><a href="/cpareview/cpa-exam-resources/exam-basics">CPA Exam Basics</a></li>
                            <li>
                                <a href="/cpareview/cpa-exam-resources/exam-strategies">CPA Exam Strategies</a>
                            </li>
                            <li><a href="/cpareview/cpa-exam-resources/exam-changes">CPA Exam Changes</a></li>
                            <li><a href="/cpareview/cpa-exam-resources/exam-definitions">CPA Exam Definitions</a></li>
                            <li><a href="/cpareview/cpa-exam-resources/cpa-exam-flashcard-app">CPA Exam Flashcard App</a></li>
                            <li><a href="/cpareview/cpa-exam-resources/sample-lectures">Sample Lectures</a></li>
                            <li><a href="/cpareview/cpa-exam-resources/practice-tests">CPA Exam Practice Tests</a></li>
                            <li><a href="/cpareview/cpa-exam-resources/video-of-the-month">Video of the Month</a></li>
                            <li><a href="/cpareview/cpa-exam-resources/iqex-exam-preparation">IQEX Exam Preparation</a></li>
                        </ul>
                    </li>
                    <li><a href="/cpareview/pricing">Pricing<i class="fa fa-angle-down"></i></a>
                        <ul>
                            <li><a href="/cpareview/pricing">Course Options</a></li>
                            <li>
                                <a href="/cpareview/pricing/payment-plan">Payment Plan</a>
                            </li>
                            <li><a href="/cpareview/pricing/discount-coupon-codes/failed-the-cpa-exam-discount">Failed With Another Course?</a></li>
                            <li><a href="/cpareview/pricing/free-trial">Try for Free</a></li>
                        </ul>
                    </li>
                    <li><a href="/cpareview/pricing" onclick="TrackEnrollNowEvent();">Buy Now</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>--%>

<script>
    function Search() {
        var value = $('#searchNew').val().trim();
        window.location.href = '/cpareview/searchresults?indexCatalogue='
                   + 'cpareview' + '&searchQuery='
                   + value + '&wordsMode=0';
        return false;
    }

    function TrackEnrollNowEvent() {
        if (typeof (_gaq) !== "undefined") {
            _gaq.push(['_trackEvent', 'View', 'On Click', 'CPA Review Enroll Now', 1]);
        } else if (typeof (ga) !== "undefined") {
            ga('send', 'event', 'View', 'On Click', 'CPA Review Enroll Now', 1);
        }
    }
</script>
