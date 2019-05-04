<%
	ui.decorateWith("kpsystem", "standardPage", [ layout: "sidebar" ])

	def menuItems = [
			[ label: "Create a new account", iconProvider: "kpui", icon: "buttons/account_add.png", href: ui.pageLink("kpsystem", "admin/createAccount1") ],
			[ label: "Back to home", iconProvider: "kpui", icon: "buttons/back.png", href: ui.pageLink("kpsystem", "admin/adminHome") ]
	]
%>

<div class="ke-page-sidebar">
	${ ui.includeFragment("kpsystem", "account/accountSearchForm", [ defaultWhich: "all" ]) }

	${ ui.includeFragment("kpui", "widget/panelMenu", [ heading: "Tasks", items: menuItems ]) }
</div>

<div class="ke-page-content">
	${ ui.includeFragment("kpsystem", "account/accountSearchResults", [ showUsernames: true, pageProvider: "kpsystem", page: "admin/editAccount" ]) }
</div>

<script type="text/javascript">
	jQuery(function() {
		jQuery('input[name="query"]').focus();
	});
</script>