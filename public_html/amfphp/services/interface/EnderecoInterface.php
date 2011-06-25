<?php
include_once '../vo/br/com/aliancadeus/vo/EnderecoVO.php';
/**
 *
 * @author simao
 */
interface EnderecoInterface {
    
    public function inserir(EnderecoVO $endereco);
    public function getListar();
    public function atualizar(EnderecoVO $endereco);
    public function excluir($id);
    
}

?>
