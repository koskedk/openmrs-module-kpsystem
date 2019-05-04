<%
	ui.decorateWith("kpui", "panel", [ heading: "Loaded Modules" ])

	def stateImage = { state ->
		state ? """<img src="${ ui.resourceLink("kpui", "images/success.png") }" />""" : ""
	}
%>
<table class="ke-table-vertical">
	<thead>
		<tr>
			<th>${ ui.message("general.name") }</th>
			<th>Version</th>
			<th>Started</th>
			<th>UIFR</th>
			<th>Dev mode</th>
		</tr>
	</thead>
	<tbody>
	<% modules.each { module -> %>
		<tr>
			<td>${ module.name } <small>(${ module.id })</small></td>
			<td>${ module.version }</td>
			<td style="text-align: center">${ stateImage(module.started) }</td>
			<td style="text-align: center">${ stateImage(module.uiFrConfigured) }</td>
			<td style="text-align: center">${ stateImage(module.uiFrDevEnabled) }</td>
		</tr>
	<% } %>
	</tbody>
</table>