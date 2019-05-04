<%
	ui.decorateWith("kpsystem", "standardPage", [ layout: "sidebar" ])

	def menuItemsNew = [
			[ label: "Seen Clients", iconProvider: "kpui", icon: "buttons/patients.png", href: ui.pageLink("kpsystem", "clinician/clinicianSearchSeen") ]
	]
%>

<div class="ke-page-sidebar">
	${ ui.includeFragment("kpsystem", "patient/patientSearchForm", [ defaultWhich: "checked-in" ]) }
	${ ui.includeFragment("kpui", "widget/panelMenu", [ heading: "", items: menuItemsNew ]) }
</div>

<div class="ke-page-content">
	${ ui.includeFragment("kpsystem", "patient/patientSearchResults", [ pageProvider: "kpsystem", page: "clinicianfacing/patient" ]) }
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery('input[name="query"]').focus();
    });
</script>