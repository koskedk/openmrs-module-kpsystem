<%
	ui.decorateWith("kpsystem", "standardPage")
%>
${ ui.includeFragment("kpsystem", "report/adxView", [ request: reportRequest.id, returnUrl: returnUrl ]) }