<%
	ui.decorateWith("kpsystem", "standardPage")
%>
<div class="ke-page-content">
	${ ui.includeFragment("kpsystem", "patient/editPatient", [ patient: currentPatient, returnUrl: returnUrl ]) }
</div>