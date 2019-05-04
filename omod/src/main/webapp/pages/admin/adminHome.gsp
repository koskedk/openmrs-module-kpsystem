<%
	ui.decorateWith("kpsystem", "standardPage", [ layout: "sidebar" ])
%>
<div class="ke-page-sidebar">
	${ ui.includeFragment("kpui", "widget/panelMenu", [
			heading: "Tasks",
			items: [
					[ iconProvider: "kpui", icon: "buttons/users_manage.png", label: "Manage accounts", href: ui.pageLink("kpsystem", "admin/manageAccounts") ],
					[ iconProvider: "kpui", icon: "buttons/report_queue.png", label: "Manage report queue", href: ui.pageLink("kpsystem", "admin/manageReportQueue") ],
					[ iconProvider: "kpui", icon: "buttons/admin_setup.png", label: "Redo first-time setup", href: ui.pageLink("kpsystem", "admin/firstTimeSetup") ]
			]
	]) }
</div>

<div class="ke-page-content">
	${ ui.includeFragment("kpsystem", "system/serverInformation") }
	${ ui.includeFragment("kpsystem", "system/databaseSummary") }
	${ ui.includeFragment("kpsystem", "system/externalRequirements") }
</div>