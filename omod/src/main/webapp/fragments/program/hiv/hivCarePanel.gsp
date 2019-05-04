<%

	def dataPoints = []


%>


<div class="ke-stack-item">
	<% dataPoints.each { print ui.includeFragment("kpui", "widget/dataPoint", it) } %>
</div>
<div class="ke-stack-item">
No Enrollment Data
</div>