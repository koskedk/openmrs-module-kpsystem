<%
	ui.decorateWith("kpsystem", "standardPage", [ patient: currentPatient, layout: "sidebar" ])

	def menuItems = [
			[
					label: "Overview",
					href: ui.pageLink("kpsystem", "chart/chartViewPatient", [ patientId: currentPatient.id, section: "overview" ]),
					active: (selection == "section-overview"),
					iconProvider: "kpui",
					icon: "buttons/patient_overview.png"
			],
			[
					label: "Record Previous Visit",
					href: ui.pageLink("kpsystem", "chart/chartViewPatient", [ patientId: currentPatient.id, section: "moh257" ]),
					active: (selection == "section-moh257"),
					iconProvider: "kpui",
					icon: "forms/moh257.png"
			],
			[
					label: "Patient summary",
					href: ui.pageLink("kpsystem", "chart/chartViewPatient", [ patientId: currentPatient.id, section: "summaries" ]),
					active: (selection == "section-summaries"),
					iconProvider: "kpui",
					icon: "buttons/summary.png"
			]

	];

	oneTimeForms.each { form ->
		menuItems << [
				label: form.name,
				href: ui.pageLink("kpsystem", "chart/chartViewPatient", [ patientId: currentPatient.id, formUuid: form.formUuid ]),
				active: (selection == "form-" + form.formUuid),
				iconProvider: form.iconProvider,
				icon: form.icon,
		]
	}

	programs.each { program ->
		menuItems << [
				label: ui.format(program.target),
				extra: programSummaries[program.target],
				href: ui.pageLink("kpsystem", "chart/chartViewPatient", [ patientId: currentPatient.id, programId: program.target.id ]),
				active: (selection == "program-" + program.target.id)
		]
	}
%>
<div class="ke-page-sidebar">

	<div class="ke-panel-frame">
		<% menuItems.each { item -> print ui.includeFragment("kpui", "widget/panelMenuItem", item) } %>
	</div>

	<div class="ke-panel-frame">
		<div class="ke-panel-heading">Visits(${ visitsCount })</div>

		<% if (!visits) {
			print ui.includeFragment("kpui", "widget/panelMenuItem", [
					label: ui.message("general.none"),
			])
		}
		else {
			visits.each { visit ->
				print ui.includeFragment("kpui", "widget/panelMenuItem", [
						label: ui.format(visit.visitType),
						href: ui.pageLink("kpsystem", "chart/chartViewPatient", [ patientId: currentPatient.id, visitId: visit.id ]),
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

	<% } else if (program) { %>

	${ ui.includeFragment("kpsystem", "program/programHistory", [ patient: currentPatient, program: program, showClinicalData: true ]) }

	<% } else if (section == "overview") { %>

	${ ui.includeFragment("kpsystem", "program/programCarePanels", [ patient: currentPatient, complete: true, activeOnly: false ]) }

	<% } else if (section == "moh257") { %>

	${ ui.includeFragment("kpsystem", "moh257", [ patient: currentPatient ]) }

	<% }else if (section == "summaries") { %>

	${ ui.includeFragment("kpsystem", "summaries", [ patient: currentPatient ]) }

	<%} %>

</div>