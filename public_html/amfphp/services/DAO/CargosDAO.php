<?php
include_once '../conexao/PDOConnectionFactory.php';
include_once '../vo/br/com/simao/vo/CargosVO.php';
class CargosDAO{
	private $conn;
	
	public function __construct(){
		$this->conn = new PDOConnectionFactory();
	}
	
	public function insert(CargosVO $cargosVO){
		$sqlInsert = "INSERT INTO cargo (nome) values (?)";
		
		$stmt = $this->conn->prepare($sqlInsert);
		$stmt->bindParam(1,$cargosVO->getNome(), PDO::PARAM_STR);
		$stmt->execute();
		
	}
	public function update(CargosVO $cargosVO){
		$sqlUpdate ="UPDATE cargos set nome=? where id =?";
		$stmt = $this->conn->prepare($sqlUpdate);
		$stmt->bindParam(1,$cargosVO->getNome(),PDO::PARAM_STR);
		$stmt->execute();
	}
	
	public function listar(){
	$sqlLista = "Select * from cargo";
    	$rs = $this->conn->query($sqlLista);
    if($rs){
        while($ln = $rs->fetch(PDO::FETCH_OBJ)){
		$cargoVO = new CargosVO();
		$cargoVO->setId($ln->id);
        $cargoVO->setNome($ln->nome);
        $cargos[] = $cargoVO;
        }
    }
    return $cargos;
	}
	public function deleteItem(CargosVO  $cargoVO){
		$sqlDelete = 'DELETE FROM cargos WHERE id = ?';
	    
		$stmt = $this->conn->prepare($sqlDelete);
	    $stmt->bindParam(1,$cargoVO->getId(),PDO::PARAM_INT);
	    $stmt->execute();
	}
}
?>