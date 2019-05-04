<%
	ui.includeJavascript("kpsystem", "controllers/account.js")

	ui.decorateWith("kpsystem", "standardPage", [ layout: "sidebar" ])
%>
<div class="ke-page-sidebar">
	${ ui.includeFragment("kpsystem", "account/accountSearchForm", [ defaultWhich: "all" ]) }
</div>

<div class="ke-page-content">
	${ ui.includeFragment("kpsystem", "account/accountSearchResults") }
</div>

<script type="text/javascript">
	jQuery(function() {
		jQuery('input[name="query"]').focus();
	});
</script>
