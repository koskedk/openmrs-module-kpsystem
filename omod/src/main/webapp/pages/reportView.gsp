<%
	ui.decorateWith("kpsystem", "standardPage", [ layout: "sidebar" ])

	def menuItems = [
			[ iconProvider: "kpui", icon: "buttons/back.png", label: "Back", href: returnUrl ]
	]
%>
<div class="ke-page-sidebar">

	<div class="ke-panel-frame" id="end-of-day">
		<div class="ke-panel-heading">Tasks</div>
		<% menuItems.each { item -> %>
			${ ui.includeFragment("kpui", "widget/panelMenuItem", item) }
		<% } %>
	</div>
</div>

<div class="ke-page-content">
	<% if (isIndicator) { %>
	${ ui.includeFragment("kpsystem", "report/indicatorReportData", [ reportRequest: reportRequest, reportData: reportData ]) }
	<% } else { %>
	${ ui.includeFragment("kpsystem", "report/patientListReportData", [ reportData: reportData ]) }
	<% } %>
</div>