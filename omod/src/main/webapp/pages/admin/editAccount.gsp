<%
	ui.decorateWith("kpsystem", "standardPage", [ layout: "sidebar" ])

	def menuItems = []

	if (user) {
		if (user.retired) {
			menuItems << [ iconProvider: "kpui", icon: "buttons/enable.png", label: "Enable login", onClick: "ke_onEnableUser(" + user.id + ")" ]
		} else {
			menuItems << [ iconProvider: "kpui", icon: "buttons/disable.png", label: "Disable login", onClick: "ke_onDisableUser(" + user.id + ")" ]
		}
	}

	menuItems << [ iconProvider: "kpui", icon: "buttons/back.png", label: "Back to accounts", href: ui.pageLink("kpsystem", "admin/manageAccounts") ]
%>

<script type="text/javascript">
	function ke_onEnableUser(userId) {
		kenyaui.openConfirmDialog({
			heading: 'User',
			message: '${ ui.message("kpsystem.confirmReenableUser") }',
			okCallback: function() {
				ui.getFragmentActionAsJson('kpsystem', 'account/accountUtils', 'unretireUser', { userId: userId, reason: 'Admin UI' }, function() {
					ui.reloadPage();
				});
			}
		});
	}
	function ke_onDisableUser(userId) {
		kenyaui.openConfirmDialog({
			heading: 'User',
			message: '${ ui.message("kpsystem.confirmDisableUser") }',
			okCallback: function() {
				ui.getFragmentActionAsJson('kpsystem', 'account/accountUtils', 'retireUser', { userId: userId, reason: 'Admin UI' }, function() {
					ui.reloadPage();
				});
			}
		});
	}
</script>

<div class="ke-page-sidebar">
	${ ui.includeFragment("kpui", "widget/panelMenu", [ heading: "Account", items: menuItems ]) }
</div>

<div class="ke-page-content">
<% if (person) { %>
	${ ui.includeFragment("kpsystem", "account/editAccount") }
<% } else { %>
	${ ui.includeFragment("kpsystem", "account/newAccount") }
<% } %>
</div>