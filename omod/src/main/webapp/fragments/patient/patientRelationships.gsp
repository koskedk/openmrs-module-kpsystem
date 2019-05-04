<%
	ui.decorateWith("kpui", "panel", [ heading: "Relationships", frameOnly: true ])
%>
<script type="text/javascript">
	function onVoidRelationship(relId) {
		kenyaui.openConfirmDialog({
			heading: 'Void Relationship',
			message: '${ ui.message("kpsystem.confirmVoidRelationship") }',
			okCallback: function() { doRelationshipVoid(relId); }
		});
	}

	function doRelationshipVoid(relId) {
		ui.getFragmentActionAsJson('kpsystem', 'emrUtils', 'voidRelationship', { relationshipId: relId, reason: 'Data entry error' }, function() {
			ui.reloadPage();
		});
	}
</script>

<% if (relationships) { %>
<div class="ke-panel-content">

	<% relationships.each { rel -> %>
	<div class="ke-stack-item">
		<button type="button" class="ke-compact" onclick="onVoidRelationship(${ rel.relationshipId })"><img src="${ ui.resourceLink("kpui", "images/glyphs/void.png") }" /></button>

		<button type="button" class="ke-compact" onclick="ui.navigate('${ ui.pageLink("kpsystem", "registration/editRelationship", [ patientId: patient.id, relationshipId: rel.relationshipId, appId: currentApp.id, returnUrl: ui.thisUrl() ]) }')">
			<img src="${ ui.resourceLink("kpui", "images/glyphs/edit.png") }" />
		</button>

		${ ui.includeFragment("kpui", "widget/dataPoint", [ label: ui.format(rel.type), value: rel.personLink ]) }
		<% if (rel.startDate) { %>
		${ ui.includeFragment("kpui", "widget/dataPoint", [ label: "Started", value: rel.startDate ]) }
		<% } %>
		<% if (rel.endDate) { %>
		${ ui.includeFragment("kpui", "widget/dataPoint", [ label: "Ended", value: rel.endDate ]) }
		<% } %>

		<div style="clear: both"></div>
	</div>
	<% } %>
</div>
<% } %>

<div class="ke-panel-footer">
	<button type="button" onclick="ui.navigate('${ ui.pageLink("kpsystem", "registration/editRelationship", [ patientId: patient.id, appId: currentApp.id, returnUrl: ui.thisUrl() ])}')">
		<img src="${ ui.resourceLink("kpui", "images/glyphs/add.png") }" /> Add Relationship
	</button>

	<button type="button" onclick="ui.navigate('${ ui.pageLink("hivtestingservices", "familyAndPartnerTesting", [ patientId: patient.id, appId: currentApp.id, returnUrl: ui.thisUrl() ])}')">
		<img src="${ ui.resourceLink("kpui", "images/glyphs/edit.png") }" /> Family/Partner Tree
	</button>
</div>