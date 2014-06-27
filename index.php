<?php
require 'vendor/autoload.php';

$app = new \Slim\Slim();
$app->get('/', function () {
  echo "<b>apiwars</b>: a game of apis";
});

$app->get('/accounts', 'listAccounts');
$app->get('/accounts/:id', 'getAccount');
$app->get('/characters', 'listCharacters');
$app->get('/characters/:id', 'getCharacter');
$app->put('/characters/:id', 'modifyCharacter'); // equip equipment
$app->get('/parties', 'listParties');
$app->post('/parties', 'createParty');  // input character ids
$app->get('/parties/:id', 'getParty');
$app->put('/parties/:id', 'modifyParty'); // change members
$app->get('/equipment', 'listEquipment');
$app->get('/equipment/:id', 'getEquipment');
$app->get('/items', 'listItems');
$app->get('/items/:id', 'getItem');
$app->get('/explorations', 'listExplorations');
$app->post('/explorations', 'createExploration'); // input zoneid & partyid
$app->get('/explorations/:id', 'getExploration');
$app->get('/zones', 'listZones');
$app->get('/zones/:id', 'getZone');
$app->get('/enemies', 'listEnemies'); // filter by dead/alive
$app->get('/enemies/:id', 'getEnemy');
$app->get('/fights', 'listFights');
$app->post('/fights', 'createFight'); //input enemyid & partyid
$app->get('/fights/:id', 'getFight');

$app->run();


function getConnection() {
  $dbhost="apiwars-lab.cb45msfqsg7e.us-east-1.rds.amazonaws.com";
  $dbuser="apiwars";
  $dbpass="motherfucker99";
  $dbname="apiwars";
  $dbh = new PDO("mysql:host=$dbhost;;dbname=$dbname", $dbuser, $dbpass);
  $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  return $dbh;
}

?>
