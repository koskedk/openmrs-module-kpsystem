<%
	ui.decorateWith("kpui", "panel", [ heading: definition.name ])

	def columns = dataSet.metaData.columns
	def nonIdOrNameColumns = columns.findAll { it.label != "id" && it.label != "Name" }

	def formatData = { result -> (result != null) ? result : "-" }
%>

<fieldset>
	<legend>Summary</legend>
	<table>
		<tr>
			<td style="padding-right: 20px">${ ui.includeFragment("kpui", "widget/dataPoint", [ label: "Total", value: summary["total"] ]) }</td>
			<td style="padding-right: 20px">${ ui.includeFragment("kpui", "widget/dataPoint", [ label: "Males", value: summary["males"] ]) }</td>
			<td>${ ui.includeFragment("kpui", "widget/dataPoint", [ label: "Females", value: summary["females"] ]) }</td>
		</tr>
	</table>
</fieldset>

<% if (nonIdOrNameColumns.size() > 0) { %>
<div style="overflow: auto">
	<table class="ke-table-vertical">
		<thead>
		<tr>
			<th>Name</th>
			<% nonIdOrNameColumns.each { col -> %>
			<th>${ col.label }</th>
			<% } %>
		</tr>
		</thead>
		<tbody>
		<%
			dataSet.rows.each { row ->
				def patientId = row.getColumnValue("id")
				def personName = row.getColumnValue("Name")
				def personGender = row.getColumnValue("Sex").toLowerCase()
		%>
			<tr>
				<td>
					<img src="${ ui.resourceLink("kpui", "images/glyphs/patient_" + personGender + ".png") }" class="ke-glyph" />
					<a href="${ ui.pageLink("kpsystem", "chart/chartViewPatient", [ patientId: patientId ]) }">${ personName }</a>
				</td>

			<% nonIdOrNameColumns.each { col -> %>
				<td>${ formatData(row.getColumnValue(col)) }</td>
			<% } %>
			</tr>
		<% } %>
		</tbody>
	</table>
</div>
<% } else {%>
<fieldset>
	None
</fieldset>
<% } %>

