<?php
require 'vendor/autoload.php';

$app = new \Slim\Slim();
$app->get('/', function () {
  echo "apiwars: a game of apis";
});
$app->get('/win/:name', function ($name) {
  echo "congratulations, $name, you've won";
});
$app->run();
