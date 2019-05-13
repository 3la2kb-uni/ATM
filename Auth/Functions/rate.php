<?php

session_start();
include("ratelimiter.php");
// in this sample, we are using the originating IP, but you can modify to use API keys, or tokens or what-have-you.
$memcache = new Memcache;
$memcache->addServer('127.0.0.1', 11211);
$rateLimiter = new RateLimiter($memcache, $_SERVER["REMOTE_ADDR"]);
try {
	// allow a maximum of 20 requests for the IP in 5 minutes
	$rateLimiter->limitRequestsInMinutes(20, 5);
} catch (RateExceededException $e) {
	header("HTTP/1.0 529 Too Many Requests");
	exit;
}

if (isset($_SESSION['LAST_CALL'])) {
    $last = strtotime($_SESSION['LAST_CALL']);
    $curr = strtotime(date("Y-m-d h:i:s"));
	$sec =  abs($last - $curr);
    if ($sec < 1) {
		header("HTTP/1.0 529 Too Many Requests");
		exit;      
    }
  }
  $_SESSION['LAST_CALL'] = date("Y-m-d h:i:s");




//   session_start();
//   if (isset($_SESSION['LAST_CALL'])) {
//     $last = strtotime($_SESSION['LAST_CALL']);
//     $curr = strtotime(date("Y-m-d h:i:s"));
//     $sec =  abs($last - $curr);
//     if ($sec <= 1) {
//       $data = 'Rate Limit Exceeded';  // rate limit
//       die ($data);        
//     }
//   }
//   $_SESSION['LAST_CALL'] = date("Y-m-d h:i:s");
?>
