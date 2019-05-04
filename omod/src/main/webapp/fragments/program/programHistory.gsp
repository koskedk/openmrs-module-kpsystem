<% if (enrollments) { %>
<div class="ke-panel-content">
	<% enrollments.reverse().each { enrollment -> %>

		<% if (enrollment.dateCompleted) { %>
		<div class="ke-stack-item">
			${ ui.includeFragment("kpsystem", "program/programCompletion", [ patientProgram: enrollment, showClinicalData: config.showClinicalData ]) }
		</div>
		<% } else if (patientForms) { %>
		<div class="ke-stack-item">
			<% patientForms.each { form -> %>
				${ ui.includeFragment("kpui", "widget/button", [
						iconProvider: form.iconProvider,
						icon: form.icon,
						label: form.name,
						extra: "Edit form",
						href: ui.pageLink("kpsystem", "editProgramForm", [
								appId: currentApp.id,
								patientProgramId: enrollment.id,
								formUuid: form.formUuid,
								returnUrl: ui.thisUrl()
						])
				]) }
			<% } %>
		</div>
		<% } %>

		<div class="ke-stack-item">
			${ ui.includeFragment("kpsystem", "program/programEnrollment", [ patientProgram: enrollment, showClinicalData: config.showClinicalData ]) }
		</div>
	<% } %>
</div>
<% } %>

<% if (currentEnrollment || patientIsEligible) { %>
<div class="ke-panel-footer">
	<% if (currentEnrollment) { %>

	<button type="button" onclick="ui.navigate('${ ui.pageLink("kpsystem", "enterForm", [ patientId: patient.id, formUuid: defaultCompletionForm.targetUuid, appId: currentApp != null ? currentApp.id : "kenyaemr.medicalEncounter", returnUrl: ui.thisUrl() ]) }')">
		<img src="${ ui.resourceLink("kpui", "images/glyphs/discontinue.png") }" /> Discontinue
	</button>

	<% } else if (patientIsEligible) { %>

	<button type="button" onclick="ui.navigate('${ ui.pageLink("kpsystem", "enterForm", [ patientId: patient.id, formUuid: defaultEnrollmentForm.targetUuid, appId: currentApp != null ? currentApp.id : "kenyaemr.medicalEncounter", returnUrl: ui.thisUrl() ]) }')">
		<img src="${ ui.resourceLink("kpui", "images/glyphs/enroll.png") }" /> Enroll
	</button>

	<% } %>
</div>
<% } %>