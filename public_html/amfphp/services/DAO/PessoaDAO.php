<?php
include_once '../conexao/PDOConnectionFactory.php';
include_once '../vo/br/com/simao/vo/PessoaVO.php';
class PessoaDAO{
	private $conn;
	
	public function __construct(){
		$this->conn = new PDOConnectionFactory();
	}
	
	public function insert(PessoaVO $pessoa){
		$sqlInsert = "INSERT INTO cliente (nome, endereco, sexo, cargo_id) values (?,?,?,?)";
		
		$stmt = $this->conn->prepare($sqlInsert);
		$stmt->bindParam(1,$pessoa->getNome(), PDO::PARAM_STR);
		$stmt->bindParam(2,$pessoa->getEndereco(), PDO::PARAM_STR);
		$stmt->bindParam(3,$pessoa->getSexo(), PDO::PARAM_STR);
		$stmt->bindParam(4,$pessoa->getCargo_id(), PDO::PARAM_INT);
		$stmt->execute();
		
	}
	public function update(PessoaVO $pessoa){
		$sqlUpdate ="UPDATE cliente set nome=?,endereco=?, sexo=?, cargo_id=? where id =?";
		$stmt = $this->conn->prepare($sqlUpdate);
		$stmt->bindParam(1,$pessoa->getNome(),PDO::PARAM_STR);
		$stmt->bindParam(2,$pessoa->getEndereco(), PDO::PARAM_STR);
		$stmt->bindParam(3,$pessoa->getSexo(),PDO::PARAM_STR);
		$stmt->bindParam(4,$pessoa->getCargo_id(), PDO::PARAM_INT);		
		$stmt->bindParam(5,$pessoa->getId(),PDO::PARAM_INT);
		$stmt->execute();
	}
	
	public function listar(){
//		$sqlLista = "Select * from cliente";
		$sqlLista = "select cliente.*, cargo.id AS id_cargo, cargo.nome AS cargo from cliente
					 inner join cargo on cliente.cargo_id = cargo.id;";
		
    	$rs = $this->conn->query($sqlLista);
    if($rs){
        while($ln = $rs->fetch(PDO::FETCH_OBJ)){
		$pessoa = new PessoaVO();
        $pessoa->setId($ln->id);
        $pessoa->setNome($ln->nome);
        $pessoa->setEndereco($ln->endereco);
        $pessoa->setSexo($ln->sexo);
        $pessoa->setCargo($ln->cargo);
        $pessoa->setCargo_id($ln->id_cargo);
        $pessoas[] = $pessoa;
        }
    }
        return $pessoas;
    }
	public function deleteItem(PessoaVO $pessoa){
		$sqlDelete = 'DELETE FROM cliente WHERE id= ?';
	    
		$stmt = $this->conn->prepare($sqlDelete);
	    $stmt->bindParam(1,$pessoa->getId(),PDO::PARAM_INT);
	    $stmt->execute();
	}
}
?>