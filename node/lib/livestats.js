// Require http library and assign it to the http variable 
// Require sys library and assign it to the sys variable
// Require the node-static library and assign it to the nodeStatic variable
var http = require('http'),
    sys =  require('sys'),
    nodeStatic = require('node-static/lib/node-static');

function LiveStats(options) {
  // Makes sure LiveStats function is called with options
  if ( ! (this instanceof arguments.callee)) {
    return new arguments.callee(arguments);
  }
  // Assigns the variable self to the current LiveStats object
  var self = this;
  // Create a hash for the self object (settings) that contains config options and defaults
  self.settings = {
    port: options.port,
    geoipServer: {
        hostname: options.geoipServer.hostname
      , port: options.geoipServer.port || 80
    }
  };
  self.init();
};

LiveStats.prototype.init = function() {
  var self = this;
  
  self.httpServer = self.createHTTPServer();
  // Listen on the port specified by self.setting.port
  self.httpServer.listen(self.settings.port);
  sys.log('Node server started on PORT ' + self.settings.port);
};

LiveStats.prototype.createHTTPServer = function() {
  var self = this;
  
  // Create a server using the http object and assign it to the server variable 
  var server = http.createServer(function(request, response) {
    var file = new nodeStatic.Server('./public', {
      cache: false
    });
    request.addListener('end', function() {
      if (request.url == '/config.json' && request.method == "GET") {
        response.writeHead(200, {
          'Content-Type': 'application/x-javascript'
        });
        var jsonString = JSON.stringify({
          port: self.settings.port
        });
        response.end(jsonString);
      } else {
        file.serve(request, response);
      }
    });
  });
  
  return server;
};

module.exports = LiveStats;