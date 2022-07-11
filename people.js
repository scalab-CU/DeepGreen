people = {};
people['Tyler Allen'] = {name: 'Tyler Allen', image: './images/people/blank.jpg', groups: 'SCALab', email: 'tnallen@clemson.edu', status: 'Past Member, now Assit Prof. UNCC'};
people['Naman Kulshreshtha'] = {name: 'Naman Kulshreshtha', image: './images/people/blank.jpg', groups: 'SCALab', email: 'nkulshr@g.clemson.edu', status: 'Active Member'};
people['Trip Bastian'] = {name: 'Trip Bastian', image: './images/people/blank.jpg', groups: 'Creative Inquiry Spring 2020, SCALab', email: 'rtbasti@clemson.edu', status: 'Past Member'};
people['Jesse Brown'] = {name: 'Jesse Brown', image: './images/people/Jesse\ Brown.jpg', groups: 'Capstone Spring 2020', email: 'jlb4@clemson.edu', status: 'Past Member'};
people['Bennett Cooper'] = {name: 'Bennett Cooper', image: './images/people/Bennett\ Cooper.png', groups: 'Capstone Spring 2020, Creative Inquiry 19-20, SCALab', email: 'bwc@clemson.edu', status: 'Active Member'};
people['Rong Ge'] = {name: 'Rong Ge', image: './images/people/blank.jpg', groups: 'Faculty Advisor', email: 'rge@clemson.edu', status: 'Active Member'};
people['Justin McCabe'] = {name: 'Justin McCabe', image: './images/people/Justin\ McCabe.jpg', groups: 'Capstone Spring 2020', email: 'jmmccab@clemson.edu', status: 'Past Member'};
people['Cameron Ogle'] = {name: 'Cameron Ogle', image: './images/people/Cameron\ Ogle.jpg', groups: 'Capstone Spring 2020', email: 'cmogle@clemson.edu', status: 'Past Member'};
people['Charles Ritter'] = {name: 'Charles Ritter', image: './images/people/Charles\ Ritter.jpg', groups: 'Capstone Spring 2020', email: 'crritte@clemson.edu', status: 'Past Member'};

cap = [];
ci = [];
lab = ['Bennett Cooper', 'Rong Ge', 'Naman Kulshreshtha'];

function createPerson(name){
  var a = document.createElement('P');
  a.innerHTML = `<img align=\"left\" alt=\"${people[name]['name']}\" src=\"${people[name]['image']}\">
  <b>${people[name]['name']}</b>
  <br><br>
  ${people[name]['groups']}
  <br><br>
  <a href=\"mailto:${people[name]['email']}\">${people[name]['email']}</a>
  <br><br>
  ${people[name]['status']}`
  a.setAttribute('class', 'person')
  document.getElementById('people').appendChild(a);
}

function allPeople(){
  clearDiv('people');
  for (person in people){
    createPerson(person);
  }
}

function capstonePeople(){
  clearDiv('people');
  for (person in people){
    if (cap.includes(person)){
      createPerson(person);
    }
  }
  if (document.getElementById('people').innerHTML == ''){
    var a = document.createElement('P');
    a.innerHTML = "No people currently in the Capstone.";
    document.getElementById('people').appendChild(a);
  }
}

function ciPeople(){
  clearDiv('people');
  for (person in people){
    if (ci.includes(person)){
      createPerson(person);
    }
  }
  if (document.getElementById('people').innerHTML == ''){
    var a = document.createElement('P');
    a.innerHTML = "No people currently in the Creative Inquiry.";
    document.getElementById('people').appendChild(a);
  }
}

function labPeople(){
  clearDiv('people');
  for (person in people){
    if (lab.includes(person)){
      createPerson(person);
    }
  }
}

function pastPeople(){
  clearDiv('people');
  for (person in people){
    if(people[person]['status'] == 'Past Member'){
      createPerson(person);
    }
  }
}


window.onload = function(){
  createTopNav();
  allPeople();
}
