$("#submit_new_item").on("click",function(event) {
	var new_item = $("input:last").val();
	if (new_item == "" ){ 
		alert("Item can't be blank");
		event.preventDefault();
	};
	
	$.get("/groceries.json", function(groceries) {
		for(var i = 0; i < groceries.length; i++) {
			if (new_item === groceries[i].item) {
				alert("this item is already there!");
			};
		};
	});
});
