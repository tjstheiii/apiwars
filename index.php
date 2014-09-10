<?php
require 'vendor/autoload.php';
use Slim\Slim;

$app = new \Slim\Slim();
$app->get('/', function () {
  echo "<b>apiwars</b>: a game of apis";
});

$app->get('/accounts', 'listAccounts');
$app->post('/accounts', 'createAccount');
$app->get('/accounts/:id', 'getAccount');
$app->put('/accounts/:id', 'modifyAccount');
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
  $config = parse_ini_file("conf/apiwars.ini", true);
  $dbhost = $config['db_' . getenv('apploc')]['dbhost'];
  $dbuser = $config['db_' . getenv('apploc')]['dbuser'];
  $dbpass = $config['db_' . getenv('apploc')]['dbpass'];  
  $dbname = "apiwars";
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

function modifyAccount() {
  $request = Slim::getInstance()->request();
  $new_account = json_decode($request->getBody());
  $sql = "select * from Accounts where id=:id";
}

function createAccount() {
  $request = Slim::getInstance()->request();
  $account = json_decode($request->getBody());
  $sql = "insert into Accounts
          (username, email_address, email_validated, email_key, private_key, currency_gold, 
          currency_energy, currency_actionpts, currency_gems, stats_apicalls)
          values (:username, :email_address, :email_validated, :email_key, :private_key, 100, 100, 100, 0, 0)";
  try {
    $db = getConnection();
    $stmt = $db->prepare($sql);
    $account->private_key = hash('sha256', openssl_random_pseudo_bytes(32));
    $account->email_validated = 0;
    $stmt->bindParam("username", $account->username);
    $stmt->bindParam("email_address", $account->email_address);
    $stmt->bindParam("email_validated", $account->email_validated);
    $stmt->bindParam("email_key", hash('sha256', openssl_random_pseudo_bytes(32)));
    $stmt->bindParam("private_key", $account->private_key);
    $stmt->execute();
    $account->id = $db->lastInsertId();
    // email $account->email_address their $account->email_key
    $db=null;
    echo json_encode($account);
  } catch(PDOException $e) {
    echo '{"error": {"text": '. $e->getMessage() .'}}';
  }
}

function getAccount() {
  $sql = "select * from Accounts where id=:id";
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
