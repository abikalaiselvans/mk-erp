<!DOCTYPE html>
<html>
<head>
	 
	<title>jQuery UI Dialog: Modal Dialog with Buttons</title>
	<link href="jquery-ui.css" rel="stylesheet">
	<script src="jquery.min.js"></script>
	<script src="jquery-ui.min.js"></script>
</head>
<body>
	<div id="dialog" >
		<p>Hey, me just met you, and this is crazy<br>
			But you got cookie, so share it maybe?</p>
	</div>
	<script>
		/*
		 * jQuery UI Dialog: Modal Dialog with Buttons
		 * http://salman-w.blogspot.com/2013/05/jquery-ui-dialog-examples.html
		 */
		$(function() {
			$("#dialog").dialog({
				modal: true,
				resizable: false,
				buttons: {
					"Yes": function() {
						$(this).dialog("close");
					},
					"No": function() {
						$(this).dialog("close");
					}
				}
			});
		});
	</script>
</body>
</html>
