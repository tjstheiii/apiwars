<?php
require 'vendor/autoload.php';

$app = new \Slim\Slim();
$app->get('/', function () {
  echo "<b>apiwars</b>: a game of apis";
});

$app->get('/accounts', 'listAccounts');
$app->post('/accounts', 'createAccount');
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
  $dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);
  $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  return $dbh;
}

function listAccounts() {
  $sql = "select `id`,`email_address`, `created_at` FROM Accounts ORDER BY created_at desc";
  try {
    $db = getConnection();
    $stmt = $db->query($sql);
    $accounts = $stmt->fetchAll(PDO::FETCH_OBJ);
    $db = null;
    echo '{"accounts": ' . json_encode($accounts) . '}';
  }
  catch(PDOException $e){
    echo '{"error": {"text": '. $e->getMessage() .'}}';
  }
}

function createAccount() {
  $request = Slim::getInstance()->request();
  $account = json_decode($request->getBody());
  $sql = "insert into accounts (email_address, password, currency_gold, currency_energy, currency_actionpts, currency_gems, stats_apicalls) values (:email_address, :password, :gold, :energy, :actionpts, :gems, :apicalls)";
  try {
    $db = getConnection();
    $stmt = $db->prepare($sql);
    $stmt->bindParam("email_address", $account->email_address);
    $stmt->bindParam("password", $account->password);
    $stmt->bindParam("gold", 100);
    $stmt->bindParam("energy", 100);
    $stmt->bindParam("actionpts", 1000);
    $stmt->bindParam("gems", 0);
    $stmt->bindParam("apicalls", 0);
    $stmt->execute();
    $account->id = $db->lastInsertId();
    $db=null;
    echo json_encode($account);    
  } catch(PDOException $e) {
    echo '{"error": {"text": '. $e->getMessage() .'}}';
  }
}

function getAccount() {
  $sql = "select * from accounts where id=:id";
  try {
    $db = getConnection();
    $stmt = $db->prepare($sql);
    $stmt->bindParam("id", $id);
    $stmt->execute();
    $account = $stmt->fetchObject();
    $db = null;
    echo json_encode($account);
  } catch(PDOException $e) {
    echo '{"error": {"text": ' . $e->getMessage() . '}}';
  }
}

function listCharacters(){}
function getCharacter(){}
function modifyCharacter(){}
function listParties(){}
function createParty(){}
function getParty(){}
function modifyParty(){}
function listEquipment(){}
function getEquipment(){}
function listItems(){}
function getItem(){}
function listExplorations(){}
function createExploration(){}
function getExploration(){}
function listZones(){}
function getZone(){}
function listEnemies(){}
function getEnemy(){}
function listFights(){}
function createFight(){}
function getFight(){}

?>
