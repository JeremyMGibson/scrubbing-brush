$(document).ready(function() {
	var client = new ZeroClipboard($(".copy-button"));

	client.on( "ready", function( readyEvent ) {
	  // alert( "ZeroClipboard SWF is ready!" );

	  client.on( "aftercopy", function( event ) {
	    event.target.style.display = "none";
	  } );
	} );
});