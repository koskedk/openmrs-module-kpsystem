<%
	ui.decorateWith("kpsystem", "standardPage", [ patient: currentPatient, visit: currentVisit ])
%>

<div class="ke-page-content">
	${ ui.includeFragment("kpsystem", "patient/editRelationship", [ relationship: relationship, patient: currentPatient, returnUrl: returnUrl ]) }
</div>