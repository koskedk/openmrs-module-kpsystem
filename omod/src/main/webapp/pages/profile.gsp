<%
	ui.decorateWith("kpsystem", "standardPage", [ layout: "sidebar" ])
%>
<script type="text/javascript">
	function showChangePasswordDialog() {
		kenyaui.openPanelDialog({ templateId: 'change_password_form' });
	}
	function showSecretQuestionDialog() {
		kenyaui.openPanelDialog({ templateId: 'change_secret_question_form' });
	}

	<% if (tempPassword) { %>
	jq(function() {
		showChangePasswordDialog();
	});
	<% } %>
</script>

<div class="ke-page-sidebar">
	${ ui.includeFragment("kpui", "widget/panelMenu", [
			heading: "My Profile",
			items: [
					[ label: "Change Password", iconProvider: "kpui", icon: "buttons/profile_password.png", onClick: "showChangePasswordDialog()" ],
					[ label: "Change Secret Question", iconProvider: "kpui", icon: "buttons/profile_secret_question.png", onClick: "showSecretQuestionDialog()" ]
			]
	]) }
</div>

<div class="ke-page-content">
	${ ui.includeFragment("kpsystem", "account/personDetails", [ person: person ]) }

	${ ui.includeFragment("kpsystem", "profileLoginDetails", [ tempPassword: tempPassword ]) }
</div>