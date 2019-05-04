<%
	ui.decorateWith("kpsystem", "standardPage", [ layout: "sidebar" ])

	def menuItems = [
			[ label: "Back to home", iconProvider: "kpui", icon: "buttons/back.png", label: "Back to home", href: ui.pageLink("kpsystem", "registration/registrationHome") ]
	]
%>

<div class="ke-page-sidebar">
	${ ui.includeFragment("kpsystem", "patient/patientSearchForm", [ defaultWhich: "all" ]) }

	${ ui.includeFragment("kpui", "widget/panelMenu", [ heading: "Tasks", items: menuItems ]) }
</div>

<div class="ke-page-content">
	${ ui.includeFragment("kpsystem", "patient/patientSearchResults", [ pageProvider: "kpsystem", page: "chart/chartViewPatient" ]) }
</div>

<script type="text/javascript">
	jQuery(function() {
		jQuery('input[name="query"]').focus();
	});
</script>