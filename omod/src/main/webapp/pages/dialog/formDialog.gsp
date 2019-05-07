<div class="ke-panel-content">
	<script type="text/javascript">
		function onEncounterEdit() {
			ui.navigate('kpsystem', 'editForm', { appId: '${ currentApp.id }', encounterId: ${ encounter.id }, returnUrl: '${ currentUrl }' });
		}
		function onEncounterDelete(encounterId) {
			if (confirm('Are you sure you want to delete this encounter?')) {
				ui.getFragmentActionAsJson('kpsystem', 'form/formUtils', 'deleteEncounter', { appId: '${ currentApp.id }', encounterId: encounterId }, function() {
					ui.reloadPage();
				});
			}
		}
	</script>

	${ ui.includeFragment("kpsystem", "form/viewHtmlForm", [ encounter: encounter ]) }
</div>
<div class="ke-panel-controls">
	<button type="button" onclick="onEncounterEdit(${ encounter.id })"><img src="${ ui.resourceLink("kpui", "images/glyphs/edit.png") }" /> Edit</button>
	<button type="button" onclick="onEncounterDelete(${ encounter.id })"><img src="${ ui.resourceLink("kpui", "images/glyphs/trash.png") }" /> Delete</button>
	<button type="button" onclick="kenyaui.closeDialog()"><img src="${ ui.resourceLink("kpui", "images/glyphs/close.png") }" /> Close</button>
</div>