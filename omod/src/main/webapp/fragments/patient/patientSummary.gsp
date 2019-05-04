
<div class="ke-panel-content">
	<div class="ke-stack-item">
		<% if (recordedAsDeceased) { %>
		<div class="ke-warning" style="margin-bottom: 5px">
			Patient has been recorded as deceased in a program form. Please update the registration form.
		</div>
		<% } %>

		<button type="button" class="ke-compact" onclick="ui.navigate('${ ui.pageLink("kpsystem", "registration/editPatient", [ patientId: patient.id, returnUrl: ui.thisUrl() ]) }')">
			<img src="${ ui.resourceLink("kpui", "images/glyphs/edit.png") }" />
		</button>

		<% patient.activeAttributes.each { %>
		${ ui.includeFragment("kpui", "widget/dataPoint", [ label: ui.format(it.attributeType), value: it ]) }
		<% } %>
	</div>
</div>
