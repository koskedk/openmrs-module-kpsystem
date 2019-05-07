<% if (encounter) { %>
<button type="button" class="ke-compact" onclick="ui.navigate('${ ui.pageLink("kpsystem", "editForm", [ encounterId: encounter.id, appId: "kpsystem.medicalEncounter", returnUrl: ui.thisUrl() ]) }')">
	<img src="${ ui.resourceLink("kpui", "images/glyphs/edit.png") }" />
</button>
<% } %>
${ ui.includeFragment(summaryFragment.provider, summaryFragment.path, [ patientProgram: enrollment, encounter: encounter, showClinicalData: showClinicalData ] )}