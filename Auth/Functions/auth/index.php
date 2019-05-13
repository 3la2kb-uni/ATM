<?php
  include('../rate.php');


  $domain = 'https://atmuni.free.beeceptor.com/'; //should be edited to parse api domain
  $dest='';

  $json = file_get_contents('php://input');
  $data = json_decode($json,true);

  if(isset($data['do'])){
    $do = $data['do'];
    if($do==='activate'){
      $dest='activate';
    } elseif($do==='deposit'){
      $dest='deposit';
    } elseif($do==='withdraw'){
      $dest='withdraw';
    } elseif($do==='data'){
      $dest='data';
    } else{
      die('Invalid operation');
    }


  }

  if(strlen($dest)>1){

  $url=$domain.$dest;
  unset($data['do']);

  //$data = array('key1' => 'value1', 'key2' => 'value2'); // WIP should take values from user

  $options = array(
      'http' => array(
          'header'  => "Content-Type: application/json\r\n"."Accept: application/json\r\n"."API-KEY: Sup3rS3cr37K3Y\r\n",
          'method'  => 'POST',
          'content' => json_encode($data)
      )
  );
  $context  = stream_context_create($options);
  $result = file_get_contents($url, false, $context);
  if ($result === FALSE) { die("an error occured"); }

  var_dump($result);
  }else{die("Invalid request");}

  /* Code for authentication WIP*/


?>
