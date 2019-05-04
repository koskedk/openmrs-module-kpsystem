<%
	ui.includeCss("kpsystem", "referenceapplication.css", 100)
%>
<%
	def url = "kpsystem/userHome.page"
	ui.decorateWith("kpsystem", "standardPage")
	def onClick = "ui.navigate('/" + contextPath + "/" + url + "')"
%>
<script type="text/javascript" src="./moduleResources/kpsystem/scripts/highcharts.js"></script>
${ ui.includeFragment("kpsystem", "facilityDashboard/facilityDashboard") }
