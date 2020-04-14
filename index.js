function transitionCollapsible(collapsible) {
  console.log(collapsible.checked);

  var content = collapsible.parentElement.nextElementSibling;

  if(collapsible.checked == true){
    content.style.maxHeight = "100vh";
  } else {
    content.style.maxHeight = "0";
  }

}
