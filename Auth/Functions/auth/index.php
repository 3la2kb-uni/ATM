<?php
  include('../rate.php');


  $domain = 'https://parseapi.back4app.com/classes/cardClass'; //should be edited to parse api domain
  $url=$domain;

  $json = file_get_contents('php://input');
  $data = json_decode($json,true);
  // var_dump($data['Action']);
  $method ='';
  if(isset($_GET['where'])){

      $options = array(
        'http' => array(
            'header'  => "Content-type: application/json\r\n"."Accept: application/json\r\n"."X-Parse-Application-Id:z67qtKXnIlsfZLAvW8GTr0f1c6X8z2Iz3WQu3P4G\r\n"."X-Parse-REST-API-Key:krxglR3koefhyGvc4dlSQQhH2n5FKoYTq3FuCRmp\r\n",
            'method'  => 'GET',
        )
    );
    $context  = stream_context_create($options);
      $res = file_get_contents($domain.'?where='.html_entity_decode($_GET['where']), false, $context);
      die($res);
    } elseif($data['Action']==='Deposit'){
      $url=$domain.'/'.$data['objectId'];
    } /*else{
      die('Invalid operation');
    }*/






  $options = array(
      'http' => array(
          'header'  => "Content-Type: application/json\r\n"."Accept: application/json\r\n"."X-Parse-Application-Id:z67qtKXnIlsfZLAvW8GTr0f1c6X8z2Iz3WQu3P4G\r\n"."X-Parse-REST-API-Key:krxglR3koefhyGvc4dlSQQhH2n5FKoYTq3FuCRmp\r\n",
          'method'  => 'PUT',
          'content' => json_encode($data)
      )
  );
  $context  = stream_context_create($options);
  $result = file_get_contents($url, false, $context);
  if ($result === FALSE) { die("an error occured"); }

  die($result);


  /* Code for authentication WIP*/


?>
