$(document).ready(function() {
		
	$("form.verify").submit(function() {
	  if ($("form.verify #tail_number").val().match(/^[1-9][0-9]{0,4}$|^[1-9][0-9]{0,3}[A-Z]$|^[1-9][0-9]{0,2}[A-Z]{2}$/i)) {
			$("form.verify").attr("action", "/planes/" + $("form.verify #tail_number").val() + "/edit");
	    return true;
	  }
		return false;
	});

	$("form.claim").submit(function() {
	  if ($("form.claim #tail_number").val().match(/^[1-9][0-9]{0,4}$|^[1-9][0-9]{0,3}[A-Z]$|^[1-9][0-9]{0,2}[A-Z]{2}$/i)) {
			$("form.verify").attr("action", "/planes/" + $("form.verify #tail_number").val() + "/claim");
	    return true;
	  }
		return false;
	});

});
