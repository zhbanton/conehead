// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require cocoon
var i = 1;
function addLine()
{
    i++;
    var div = document.createElement('div');
    div.innerHTML = '<input type="text" name="quantity'+i+'"><input type = "text" name= "measurement'+i+'"><input type="text" name="ingredient'+i+'">'
    div.innerHTML +='<input type="button" id="add_line()" onClick="addLine()" value="+"><input type="button" value="-" onClick="removeLine(this)">';
    document.getElementById('lines').appendChild(div);
}

function removeLine(div)
{
    document.getElementById('lines').removeChild(div.parentNode);
}
