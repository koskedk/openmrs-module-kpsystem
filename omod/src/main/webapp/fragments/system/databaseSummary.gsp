<%
	ui.decorateWith("kpui", "panel", [ heading: "Database Summary" ])

	ui.includeJavascript("kpsystem", "controllers/system.js")
%>
<div ng-controller="DatabaseSummary" ng-init="init('${ currentApp.id }')">
	<table class="ke-table-vertical">
		<tbody>
			<tr ng-repeat="info in infos">
				<td>{{ info.label }}</td>
				<td>{{ info.value }}</td>
			</tr>
		</tbody>
	</table>
</div>