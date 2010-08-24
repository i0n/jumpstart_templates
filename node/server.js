// Add the apps vendor directory to the paths searched when requiring libraries 
require.paths.unshift(__dirname + "/vendor");

// Displays errors in the console    
process.addListener('uncaughtException', function (err, stack) {
  console.log('------------------------');
  console.log('Exception: ' + err);
  console.log(err.stack);
  console.log('------------------------');
});
    
// Moved basic server functions out into a module
var LiveStats = require('./lib/livestats');
    
// Create a new LiveStats object from the module, starting the server
new LiveStats({
  port: 8000,
  geoipServer: {
      hostname: 'geoip.peepcode.com'
    , port: 80
  }
});