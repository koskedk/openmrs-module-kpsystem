<%
	ui.decorateWith("kpsystem", "standardPage", [ layout: "sidebar" ])

	def menuItems = [
			[ label: "Back to previous step", iconProvider: "kpui", icon: "buttons/back.png", href: ui.pageLink("kpsystem", "admin/createAccount1") ]
	]
%>

<div class="ke-page-sidebar">
	${ ui.includeFragment("kpui", "widget/panelMenu", [ heading: "Create Account", items: menuItems ]) }

	<div class="ke-panel-frame">
		<div class="ke-panel-heading">Help</div>
		<div class="ke-panel-content">
			If the account is for a user who will login into the system, you must specify login details. If the account
			is for someone who can provide care to patients, then you must specify a provider ID.
		</div>
	</div>
</div>

<div class="ke-page-content">
	${ ui.includeFragment("kpsystem", "account/newAccount", [ person: patient ]) }
</div>