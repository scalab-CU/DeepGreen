function transitionCollapsible(collapsible){
  console.log(collapsible.checked);

  var content = collapsible.parentElement.nextElementSibling;

  if(collapsible.checked == true){
    content.style.maxHeight = "100vh";
  }else{
    content.style.maxHeight = "0";
  }

}

function createTopNav(){
  var a = document.createElement("DIV")
  a.innerHTML = "<a href=\"./index.html\">Home</a>\
  <a href=\"https://github.com/scalab-CU/DeepGreen/tree/master/Resources\">Resources</a>\
  <a href=\"./testing.html\">Testing</a>\
  <a href=\"./results.html\">Results</a>\
  <a href=\"./people.html\">People</a>";
  a.setAttribute("class", "top_navbar");
  document.body.appendChild(a);
}

function clearDiv(div){
  document.getElementById(div).innerHTML = '';
}

window.onload = function(){
  createTopNav();
}
