<%
	ui.decorateWith("kpsystem", "standardPage", [ layout: "sidebar" ])

	ui.includeJavascript("kpsystem", "controllers/report.js")
%>
<div class="ke-page-sidebar">
	${ ui.includeFragment("kpui", "widget/panelMenu", [
			heading: "Reports",
			items: [
					[ iconProvider: "kpui", icon: "buttons/back.png", label: "Back to home", href: ui.pageLink("kpsystem", "admin/adminHome") ]
			]
	]) }
</div>

<div class="ke-page-content" ng-controller="ReportController" ng-init="init('${ currentApp.id }', null)">
	${ ui.includeFragment("kpsystem", "report/reportQueue", [ allowCancel: true ]) }
</div>