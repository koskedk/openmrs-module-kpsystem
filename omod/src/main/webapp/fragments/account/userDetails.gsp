<div class="ke-panel-frame">
	<div class="ke-panel-heading">Login Details</div>

	<% if (user) { %>
	<div class="ke-panel-content">
		<% if (user.retired) { %>
		<div class="ke-warning" style="margin-bottom: 5px">${ ui.message("kpsystem.loginIsDisabled") }</div>
		<% } %>

		${ ui.includeFragment("kpui", "widget/dataPoint", [ label: "Username", value: user.username ]) }
		${ ui.includeFragment("kpui", "widget/dataPoint", [ label: "Roles", value: user.roles.join(", ") ]) }

		<%
			def inheritedRoles = user.allRoles
			inheritedRoles.removeAll(user.roles)
		%>

		<% if (inheritedRoles) { %>
		${ ui.includeFragment("kpui", "widget/dataPoint", [ label: "Inherited", value: inheritedRoles.join(", ") ]) }
		<% } %>
	</div>
	<% } %>

	<div class="ke-panel-footer">
	<% if (user && !user.retired) { %>

		<%= ui.includeFragment("kpui", "widget/dialogForm", [
				buttonConfig: [
						label: "Edit",
						iconProvider: "kpui",
						icon: "glyphs/edit.png"
				],
				dialogConfig: [ heading: "Edit login details for ${ kenyaui.formatPersonName(person) }", width: 90, height: 90 ],
				fragment: "account/userDetails",
				fragmentProvider: "kpsystem",
				action: "submit",
				prefix: "user",
				commandObject: form,
				hiddenProperties: [ "userId" ],
				properties: [ "username", "password", "confirmPassword", "secretQuestion", "secretAnswer", "roles" ],
				propConfig: [
						password: [ type: "password" ],
						confirmPassword: [ type: "password" ],
						secretAnswer: [ type: "password" ]
				],
				fieldConfig: [
						roles: [ fieldFragment: "field/RoleCollection", hideRoles: disallowedRoles ]
				],
				extraFields: [
						[ hiddenInputName: "personId", value: person.id ]
				],
				submitLabel: "Save Changes",
				cancelLabel: "Cancel",
				onSuccessCallback: "ui.reloadPage();"
		]) %>

	<% } else if (!user) { %>

		<%= ui.includeFragment("kpui", "widget/dialogForm", [
				buttonConfig: [
						label: "Create login",
						iconProvider: "kpui",
						icon: "buttons/user_enable.png"
				],
				dialogConfig: [ heading: "New Login Account for ${ kenyaui.formatPersonName(person) }", width: 90, height: 90 ],
				fragment: "account/userDetails",
				fragmentProvider: "kpsystem",
				action: "submit",
				prefix: "user",
				commandObject: form,
				properties: [ "username", "password", "confirmPassword", "secretQuestion", "secretAnswer", "roles" ],
				propConfig: [
						password: [ type: "password" ],
						confirmPassword: [ type: "password" ],
						secretAnswer: [ type: "password" ]
				],
				fieldConfig: [
						roles: [ fieldFragment: "field/RoleCollection", hideRoles: disallowedRoles ]
				],
				extraFields: [
						[ hiddenInputName: "personId", value: person.id ]
				],
				submitLabel: "Save Changes",
				cancelLabel: "Cancel",
				onSuccessCallback: "ui.reloadPage();"
		]) %>

	<% } %>
	</div>
</div>