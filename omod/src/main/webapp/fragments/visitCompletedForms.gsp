<%
	ui.decorateWith("kpui", "panel", [ heading: "Completed Visit Forms" ])

	def onEncounterClick = { encounter ->
		"""kenyaemr.openEncounterDialog('${ currentApp.id }', ${ encounter.id });"""
	}
%>

${ ui.includeFragment("kpsystem", "widget/encounterStack", [ encounters: encounters, onEncounterClick: onEncounterClick ]) }