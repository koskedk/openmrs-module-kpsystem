<%
	ui.decorateWith("kpsystem", "standardPage", [ patient: currentPatient, layout: "sidebar" ])

	def menuItems = [
			[label: "Back to home", iconProvider: "kpui", icon: "buttons/back.png", label: "Back to home", href: ui.pageLink("kpsystem", "clinician/clinicianViewPatient", [patient: currentPatient, patientId: currentPatient.patientId])]
			,
			[
					label: "MOH 257",
					href: ui.pageLink("kpsystem", "visit/viewPatientPastVisits", [ patientId: currentPatient.id, section: "moh257" ]),
					active: (selection == "section-moh257"),
					iconProvider: "kpui",
					icon: "forms/moh257.png"
			]
	]
%>
<div class="ke-page-sidebar">

	<div class="ke-panel-frame">
		<% menuItems.each { item -> print ui.includeFragment("kpui", "widget/panelMenuItem", item) } %>
	</div>

	<div class="ke-panel-frame">
		<div class="ke-panel-heading">Total Visits(${ visitsCount })</div>

		<% if (!visits) {
			print ui.includeFragment("kpui", "widget/panelMenuItem", [
					label: ui.message("general.none"),
			])
		}
		else {
			visits.each { visit ->
				print ui.includeFragment("kpui", "widget/panelMenuItem", [
						label: ui.format(visit.visitType),
						href: ui.pageLink("kpsystem", "visit/viewPatientPastVisits", [ patientId: currentPatient.id, visitId: visit.id ]),
						extra: kenyaui.formatVisitDates(visit),
						active: (selection == "visit-" + visit.id)
				])
			}
		} %>
	</div>

</div>

<div class="ke-page-content">

	<% if (visit) { %>

	${ ui.includeFragment("kpsystem", "visitSummary", [ visit: visit ]) }
	<% if (!visit.voided) { %>
	${ ui.includeFragment("kpsystem", "visitCompletedForms", [ visit: visit ]) }
	${ ui.includeFragment("kpsystem", "visitAvailableForms", [ visit: visit ]) }
	<% } %>

	<% } else if (form) { %>

	<div class="ke-panel-frame">
		<div class="ke-panel-heading">${ ui.format(form) }</div>
		<div class="ke-panel-content">

			<% if (encounter) { %>
			${ ui.includeFragment("kpsystem", "form/viewHtmlForm", [ encounter: encounter ]) }
			<% } else { %>
			<em>Not filled out</em>
			<% } %>

		</div>
	</div>

	<% } else if (section == "moh257") { %>

	${ ui.includeFragment("kpsystem", "moh257", [ patient: currentPatient ]) }

	<%} %>

</div>