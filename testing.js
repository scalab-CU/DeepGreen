servers = {};
servers['p01'] = {name: 'p01', model: 'Dell PowerEdge R610', cpu: '16 x Intel Xeon E5520 @ 2.27GHz', mem: '12GB DDR2', accelerators: 'none in use'};
servers['p02'] = {name: 'p02', model: 'Dell PowerEdge R610', cpu: '16 x Intel Xeon E5520 @ 2.27GHz', mem: '12GB DDR2', accelerators: 'none in use'};
servers['p03'] = {name: 'p03', model: 'Dell PowerEdge 1950', cpu: '8 x Intel Xeon E5345 @ 2.33GHz', mem: '8GB DDR3', accelerators: 'none in use'};
servers['p04'] = {name: 'p04', model: 'Dell PowerEdge R610', cpu: '16 x Intel Xeon E5520 @ 2.27GHz', mem: '12GB DDR2', accelerators: 'none in use'};
servers['p05'] = {name: 'p05', model: 'Dell PowerEdge 1950', cpu: '8 x Intel Xeon E5345 @ 2.33GHz', mem: '8GB DDR3', accelerators: 'none in use'};
servers['p06'] = {name: 'p06', model: 'Dell PowerEdge 2950', cpu: '4 x Intel Xeon 5150 @ 2.66GHz', mem: '32GB DDR2', accelerators: 'none in use'};

additionalHW = ['Nvidia K20 GPUs', 'Mellanox HDR InfiniBand Network Adaptors', 'Intel FPGA Stratix DE10-Pro-GX'];

benchmarks = {};
benchmarks['swim'] = {name: 'swim', suite: 'SPEC OMP2012', reason: ''};
benchmarks['jtr'] = {name: 'john the ripper', suite: 'Phoronix Test Suite', reason: ''};
benchmarks['blender'] = {name: 'blender', suite: 'Phoronix Test Suite', reason: ''};
benchmarks['cray'] = {name: 'c-ray', suite: 'Phoronix Test Suite', reason: ''};
benchmarks['tlkc'] = {name: 'tlkc', suite: 'Phoronix Test Suite', reason: ''};
benchmarks['x265'] = {name: 'x265', suite: 'Phoronix Test Suite', reason: ''};
benchmarks['sng'] = {name: 'stress-ng', suite: '', reason: ''};

function loadServers(){
  clearDiv('servers');
  for (server in servers){
    var a = document.createElement('P');
    a.innerHTML = `<b>${servers[server]['name']}</b>
    <br><br>
    <u>Model</u>: ${servers[server]['model']}
    <br><br>
    <u>CPU Cores</u>: ${servers[server]['cpu']}
    <br><br>
    <u>Memory</u>: ${servers[server]['mem']}
    <br><br>
    <u>Accelerators</u>: ${servers[server]['accelerators']}`;
    a.setAttribute('class', 'server');
    document.getElementById('servers').appendChild(a);
  }
  loadAH();
}

function loadAH(){
  var a = document.createElement('P');
  a.innerHTML = '<b>Additional Hardware</b><br><br>';
  for (ahw in additionalHW){
    a.innerHTML += `${additionalHW[ahw]}<br>`;
  }
  a.setAttribute('class', 'server');
  document.getElementById('servers').appendChild(a);
}

function loadBenchmarks(){
  clearDiv('servers');
  for (benchmark in benchmarks){
    var a = document.createElement('P');
    if (benchmarks[benchmark]['suite'] != ''){
      a.innerHTML = `<b>${benchmarks[benchmark]['name']}</b> - ${benchmarks[benchmark]['suite']}<br><br>`;
    }else{
      a.innerHTML = `<b>${benchmarks[benchmark]['name']}</b>`;
    }
    a.innerHTML += `${benchmarks[benchmark]['reason']}`;
    a.setAttribute('class', 'server')
    document.getElementById('servers').appendChild(a);
  }
}

window.onload = function(){
  createTopNav();
  loadServers();
}
