/**
 * @author jrawcliffe
 */
/*
 * Using the turbolinks gem with Rails 4 can cause problems with jquery
 * http://stackoverflow.com/questions/17600093/rails-javascript-not-loading-after-clicking-through-link-to-helper
 * A slightly different construct for JQuery calls is required.
 */
//$(function () { 
//  $('#phone_room_ids').tokenInput('/rooms.json', { crossDomain: false, prePopulate: $('#phone_room_ids').data('pre'), theme: 'facebook' });
//});
var ready = function() {
	
  // when the #sub_department field changes
  $("#phone_sub_department_id").change(function() {
  	//console.log("DEBUG: Get ready for this.");
  	var sdept = $("#phone_sub_department_id option:selected").val();
    if (!sdept) {
  	  sdept = 1;
    };
	var c = $("#phone_extension_id option:selected").val();
	var t = $("#phone_extension_id option:selected").text();
	// Blank the extension select dropdown
    $("#phone_extension_id").html('');
	// make a GET call and replace the content
	$.getJSON( '/phones/' + sdept + '/free_extensions.json', function(data) {
      if(c) {
	  	$("#phone_extension_id").append($('<option></option>').val(c).html(t));
	  };
	  for (var x in data) {
	  	//console.log(x + ':' + data[x].id);
	  	$("#phone_extension_id").append($('<option></option>').val(data[x].id).html(data[x].extension));
	  };
	  $("#phone_extension_id").val(c).attr("selected", "selected");
	  // or, $("#phone_extension_id option[value='"+c+"']")).attr("selected", "selected");
	  $("#phone_extension_id").append($('<option></option>').val(0).html("None"));
    });
	$.getJSON( '/sub_departments/' + sdept + '/default_policies.json', function(data) {
		$("#phone_voice_policy_id").attr('selected','');
		for (var x in data) {
			//console.log("Found archiving policy "+data[x].df_archiving_policy_id+".");
			//console.log("Found voice policy "+data[x].df_voice_policy_id+".");
			// Two ways to dynamically update a select form element
			//$("#phone_archiving_policy_id option[value='"+data[x].archiving_policy_id+"']").attr('selected', 'selected');
			//$("#phone_archiving_policy_id").val(data[x].archiving_policy_id).attr('selected', 'selected');
			//$("#phone_client_policy_id option[value='"+data[x].client_policy_id+"']").attr('selected', 'selected');
			//$("#phone_client_version_policy_id option[value='"+data[x].client_version_policy_id+"']").attr('selected', 'selected');
			//$("#phone_conferencing_policy_id option[value='"+data[x].conferencing_policy_id+"']").attr('selected', 'selected');
			//$("#phone_dial_plan_policy_id option[value='"+data[x].dial_plan_policy_id+"']").attr('selected', 'selected');
			//$("#phone_external_access_policy_id option[value='"+data[x].external_access_policy_id+"']").attr('selected', 'selected');
			//$("#phone_location_policy_id option[value='"+data[x].location_policy_id+"']").attr('selected', 'selected');
			//$("#phone_mobility_policy_id option[value='"+data[x].mobility_policy_id+"']").attr('selected', 'selected');
			//$("#phone_persist_chat_policy_id option[value='"+data[x].persist_chat_policy_id+"']").attr('selected', 'selected');
			//$("#phone_pin_policy_id option[value='"+data[x].pin_policy_id+"']").attr('selected', 'selected');
			//$("#phone_voice_policy_id option[value='"+data[x].voice_policy_id+"']").attr('selected', 'selected');
			$("#phone_archiving_policy_id_"+data[x].archiving_policy_id).prop('checked', 'true');
			$("#phone_client_policy_id_"+data[x].client_policy_id).prop('checked', 'true');
			$("#phone_client_version_policy_id_"+data[x].client_version_policy_id).prop('checked', 'true');
			$("#phone_conferencing_policy_id_"+data[x].conferencing_policy_id).prop('checked', 'true');
			$("#phone_dial_plan_policy_id_"+data[x].dial_plan_policy_id).prop('checked', 'true');
			$("#phone_external_access_policy_id_"+data[x].external_access_policy_id).prop('checked', 'true');
			$("#phone_location_policy_id_"+data[x].location_policy_id).prop('checked', 'true');
			$("#phone_mobility_policy_id_"+data[x].mobility_policy_id).prop('checked', 'true');
			$("#phone_persist_chat_policy_id_"+data[x].persist_chat_policy_id).prop('checked', 'true');
			$("#phone_pin_policy_id_"+data[x].pin_policy_id).prop('checked', 'true');
			$("#phone_voice_policy_id_"+data[x].voice_policy_id).prop('checked', 'true');
		};
	});
  });
  $('#phone_room_id').tokenInput('/rooms.json', { crossDomain: false, prePopulate: $('#phone_room_id').data('pre'), theme: 'facebook' });

  setTimeout(initOverLabels, 50);
  initOverLabels();
}; // Used with var ready = function() {
//console.log("DEBUG: Get ready for this.");
$(document).ready(ready);
$(document).on('page:load', ready);
//
// Functions for cute form appearance
// Lifted from http://www.alistapart.com/articles/makingcompactformsmoreaccessible
//
function initOverLabels () {
  if (!document.getElementById) return;

  var labels, id, field;

  // Set focus and blur handlers to hide and show
  // labels with 'overlabel' class names.
  labels = document.getElementsByTagName('label');
  for (var i = 0; i < labels.length; i++) {

    if (labels[i].className == 'overlabel') {

      // Skip labels that do not have a named association
      // with another field.
      id = labels[i].htmlFor || labels[i].getAttribute ('for');
      if (!id || !(field = document.getElementById(id))) {
        continue;
      }

      // Change the applied class to hover the label
      // over the form field.
      labels[i].className = 'overlabel-apply';

      // Hide any fields having an initial value.
      if (field.value !== '') {
        hideLabel(field.getAttribute('id'), true);
      }

      // Set handlers to show and hide labels.
      field.onfocus = function () {
        hideLabel(this.getAttribute('id'), true);
      };
      field.onblur = function () {
        if (this.value === '') {
          hideLabel(this.getAttribute('id'), false);
        }
      }

      // Handle clicks to label elements (for Safari).
      labels[i].onclick = function () {
        var id, field;
        id = this.getAttribute('for');
        if (id && (field = document.getElementById(id))) {
          field.focus();
        }
      }

    }
  }
}

function hideLabel (field_id, hide) {
  var field_for;
  var labels = document.getElementsByTagName('label');
  for (var i = 0; i < labels.length; i++) {
    field_for = labels[i].htmlFor || labels[i]. getAttribute('for');
    if (field_for == field_id) {
      labels[i].style.textIndent = (hide) ? '-1000px' : '0px';
      return true;
    }
  }
}