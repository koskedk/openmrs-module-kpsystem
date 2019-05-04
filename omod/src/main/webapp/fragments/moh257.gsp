<%
	def onFormClick = { form ->
		def opts = [ appId: currentApp.id, patientId: currentPatient.id, formUuid: form.formUuid, returnUrl: ui.thisUrl() ]
		"""ui.navigate('${ ui.pageLink('kpsystem', 'enterForm', opts) }');"""
	}

	def onEncounterClick = { encounter ->
		"""kenyaemr.openEncounterDialog('${ currentApp.id }', ${ encounter.id });"""
	}
%>
<div class="ke-panel-frame">
	<div class="ke-panel-heading">Page 1 (Care Summary)</div>
	<div class="ke-panel-content" style="background-color: #F3F9FF">

		<fieldset>
			<legend>New Forms</legend>

			${ ui.includeFragment("kpui", "widget/formStack", [ forms: page1AvailableForms, onFormClick: onFormClick ]) }
		</fieldset>
		<br />
		<fieldset>
			<legend>Previously Completed Forms</legend>
			${ ui.includeFragment("kpsystem", "widget/encounterStack", [ encounters: page1Encounters, onEncounterClick: onEncounterClick ]) }
		</fieldset>
	</div>
</div>

<div class="ke-panel-frame">
	<div class="ke-panel-heading">Page 2 (Initial and Followup Visits)</div>
	<div class="ke-panel-content" style="background-color: #F3F9FF">
		${ ui.includeFragment("kpsystem", "widget/encounterStack", [ encounters: page2Encounters, onEncounterClick: onEncounterClick ]) }
		<br />
		<% if (inHivProgram) { %>
			<div align="center">
				${ ui.includeFragment("kpui", "widget/button", [
						label: "Add Visit Summary",
						extra: "From column",
						iconProvider: "kpui",
						icon: "buttons/visit_retrospective.png",
						href: ui.pageLink("kpsystem", "enterForm", [ appId: currentApp.id, patientId: currentPatient, formUuid: page2Form.uuid, returnUrl: ui.thisUrl() ])
				]) }
			</div>
		<%}%>
		<% if (!(inHivProgram)) { %>
			<div class="ke-warning" align="center">
				You need to enroll the patient into KP program before completing visit summary
			</div>
		<%}%>
	</div>
</div>

