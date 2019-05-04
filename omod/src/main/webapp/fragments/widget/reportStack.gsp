<%
config.require("reports")

if (config.reports && config.reports.size() > 0) {
	config.reports.each { report ->
		def onClick = config.onReportClick instanceof Closure ? config.onReportClick(report) : config.onReportClick

		def iconPath = "reports/" + (report.isIndicator ? "indicator" : "patient_list") + ".png"
%>
<div class="ke-stack-item ke-navigable" onclick="${ onClick }">
	${ ui.includeFragment("kpui", "widget/icon", [ iconProvider: "kpui", icon: iconPath, tooltip: "View report" ]) }
	<b>${ report.name }</b>
	<div class="ke-extra">${ report.description ?: "" }</div>
</div>
<%
		}
	} else {
%>
<i>None</i>
<% } %>