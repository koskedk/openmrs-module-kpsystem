<%
	ui.decorateWith("kpsystem", "standardPage", [ layout: "sidebar" ])
%>

<div class="ke-page-sidebar">
	${ ui.includeFragment("kpsystem", "patient/patientSearchForm", [ defaultWhich: "checked-in" ]) }
</div>

<div class="ke-page-content">
	${ ui.includeFragment("kpsystem", "patient/patientSearchResults", [ pageProvider: "kpsystem", page: "intake/intakeViewPatient" ]) }
</div>

<script type="text/javascript">
	jQuery(function() {
		jQuery('input[name="query"]').focus();
	});
</script>
