<%
	ui.decorateWith("kpsystem", "standardPage", [ patient: currentPatient ])
%>

<div class="ke-page-content">
	<table cellpadding="0" cellspacing="0" border="0" width="100%">
		<tr>
			<td width="30%" valign="top">
				${ ui.includeFragment("kpsystem", "patient/patientSummary", [ patient: currentPatient ]) }
				${ ui.includeFragment("kpsystem", "program/programHistories", [ patient: currentPatient, showClinicalData: true ]) }
			</td>
			<td width="55%" valign="top" style="padding-left: 5px">
				${ ui.includeFragment("kpsystem", "visitMenu", [ patient: currentPatient, visit: activeVisit ]) }

				<% if (activeVisit) { %>
				${ ui.includeFragment("kpsystem", "visitAvailableForms", [ visit: activeVisit ]) }
				${ ui.includeFragment("kpsystem", "visitCompletedForms", [ visit: activeVisit ]) }
				<% } %>
			</td>
			<td width="15%" valign="top" style="padding-left: 5px">
				${ ui.includeFragment("kpsystem", "providerAction/providerActions") }
			</td>
		</tr>
	</table>
</div>