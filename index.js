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
  <a href=\"./documents.html\">Documents</a>\
  <a href=\"./results.html\">Results</a>\
  <a href=\"./people.html\">People</a>";
  a.setAttribute("class", "top_navbar");
  document.body.appendChild(a);
}
/*
function createPerson(name, ){
  var a = document.createElement("P");
  a.innerHTML = `<img align=\"left\" alt=\"${name}\" src=\"./images/people/${name}.png\">
  <b>${name}</b>
  <br>
  <u>Involvement</u>
  <br>
  Capstone Spring 2020
  <br>
  Creative Inquiry 19-20`;
  a.setAttribute("class", "person")
  document.getElementById('people').appendChild(a);
}
*/
window.onload = function(){
  createTopNav();
};
