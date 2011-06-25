<?php
include_once '../vo/br/com/aliancadeus/vo/DependenteVO.php';
/**
 *
 * @author simao
 */
interface DependenteInterface {
    public function inserir(DependenteVO $dependente);
    public function getListar();
    public function atualizar(DependenteVO $dependente);
    public function excluir($id);
}

?>
