<% programs.each { descriptor -> %>
${ ui.includeFragment("kpsystem", "program/programHistory", [ patient: patient, program: descriptor.target, showClinicalData: showClinicalData ]) }
<% } %>