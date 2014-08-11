// d3.json('/graphs.json', function(error, data) {

//   if(error){alert('could not find data'); }

//   for (var i = 0; i < data.length; i++) {
//     if (data[i] === null) {
//       data[i] = "0";
//     }
//   }

//   var margin = { top: 20, right: 30, bottom: 30, left: 40 };
//   var width = 800 - margin.left - margin.right;
//   var height = 400 - margin.top - margin.bottom;

//   var yScale = d3.scale.linear()
//     .domain([0, d3.max(data)])
//     .range([0, height]);

//   var xScale = d3.scale.linear()
//     .domain([0, data.length -1])
//     .range([0, width]);

//   var xAxis = d3.svg.axis()
//     .scale(xScale)
//     .orient("bottom");

//   var yAxis = d3.svg.axis()
//     .scale(yScale)
//     .orient("left");

//   var line = d3.svg.line()
//     .x(function(d, i) { return xScale(i); })
//     .y(function(d) { return height - yScale(d); });

//   var graph = d3.select('#graph').append("svg")
//     .attr("height", height + margin.left + margin.right)
//     .attr("width", width + margin.top + margin.bottom)
//   .append("g")
//   .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

//   graph.append('g')
//     .attr('class', 'x axis')
//     .attr("transform", "translate(0," + height + ")")
//     .call(xAxis);

//   graph.append('g')
//     .attr('class', 'y axis')
//     .call(yAxis);

//   graph.append("path").attr("d", line(data));

// });



// var enteringGroup = d3.select('#svg-chart')
//   .selectAll('g')
//     .data(data)
//   .enter().append('g');

// enteringGroup.append('rect')
//   .attr('width', function(d) { return xScale(d); })
//   .attr('height', 24)
//   .attr('fill', 'steelblue')
//   .attr('y', function(d, index){ return index * 25; });



// enteringGroup.append('text')
//   .attr('x', 0)
//   .attr('y', function(d, index) { return index * 25 + 20;})
//   .text(function(d) { return d; })
//   .attr('fill', 'white')
//   .transition()
//     .duration(1000)
//     .attr('x', function(d) { return xScale(d) - 30;});
