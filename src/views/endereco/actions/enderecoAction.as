import br.com.aliancadeus.vo.EnderecoVO;

import flash.events.Event;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import mx.rpc.events.ResultEvent;

import ro.Endereco_ro;

	private var _enderecoVO:EnderecoVO = new EnderecoVO();
	private var _ro_endereco:Endereco_ro = Endereco_ro.getInstance();
	private var _registroSelecionado:EnderecoVO = new EnderecoVO();
	[Bindable]
	private var _datagridEndereco:ArrayCollection;
	[Bindable]
	public var _estadosBr:ArrayCollection = new ArrayCollection([
		{label: "Escolha um Estado"},
		{data: "AC", label: "AC"},
		{data: "AL", label: "AL"},
		{data: "AP", label: "AP"},
		{data: "AM", label: "AM"},
		{data: "BA", label: "BA"},
		{data: "CE", label: "CE"},
		{data: "DF", label: "DF"},
		{data: "ES", label: "ES"},
		{data: "GO", label: "GO"},
		{data: "MA", label: "MA"},
		{data: "MG", label: "MG"},
		{data: "MT", label: "MT"},
		{data: "MS", label: "MS"},
		{data: "PA", label: "PA"},
		{data: "PB", label: "PB"},
		{data: "PR", label: "PR"},
		{data: "PE", label: "PE"},
		{data: "PI", label: "PI"},
		{data: "RJ", label: "RJ"},
		{data: "RN", label: "RN"},
		{data: "RS", label: "RS"},
		{data: "RO", label: "RO"},
		{data: "RR", label: "RR"},
		{data: "SC", label: "SC"},
		{data: "SP", label: "SP"},
		{data: "SE", label: "SE"},	
		{data: "TO", label: "TO"}	
	]);
	public function listaRegistroEndereco(e:ResultEvent):void
	{
		_datagridEndereco = new ArrayCollection(e.result as Array);
	}
	public function init(event:FlexEvent):void
	{
		// TODO Auto-generated method stub
		leituraBtn();
		leituraTxtInput();
		_ro_endereco.listEndereco(listaRegistroEndereco);
	}

	protected function btnSalvar_clickHandler(event:MouseEvent):void
	{		
		if(
			txtBairro.text 		!= "" 		||
			txtBairro.text 		!= "" 		||
			txtCep.text 		!= ""		||
			txtCidade.text 		!= ""		||
			txtComplemento.text != ""		||
			txtNumero.text 		!= "")
		{
			_enderecoVO.bairro = txtBairro.text;
			_enderecoVO.cep = txtCep.text;
			_enderecoVO.cidade = txtCidade.text;
			_enderecoVO.complemento = txtComplemento.text;
			_enderecoVO.uf = _cbEstado.selectedItem.data;
			_enderecoVO.numero = parseInt(txtNumero.text);
			
			_ro_endereco.inserir(_enderecoVO,insertResult);
		}else {
			Alert.show("Campos com * Obrigatorio", "Atenção!");
		}
	}
	protected function btnAlterar_clickHandler(event:MouseEvent):void
	{
		_enderecoVO.id 				= _registroSelecionado.id;
		_enderecoVO.bairro 			= txtBairro.text;
		_enderecoVO.cep 			= txtCep.text;
		_enderecoVO.cidade 			= txtCidade.text;
		_enderecoVO.complemento 	= txtComplemento.text;
		_enderecoVO.uf 				= _cbEstado.selectedItem.data;
		_enderecoVO.numero 			= parseInt(txtNumero.text);
		
		_ro_endereco.atualizar(_enderecoVO,atualizarResult);
	}
	private function atualizarResult(e:ResultEvent):void
	{
		_datagridEndereco.setItemAt(e.result, dgEndereco.selectedIndex);
		_ro_endereco.listEndereco(listaRegistroEndereco);
		Alert.show(e.result.mensagem, " Aviso! ");
		clearRecord();
		leituraTxtInput();
	}

	protected function registroSelecionado(e:Event):void
	{
		_registroSelecionado = EnderecoVO(e.currentTarget.selectedItem);
		txtBairro.text = _registroSelecionado.bairro;
		txtCep.text = _registroSelecionado.cep;
		txtCidade.text = _registroSelecionado.cidade;
		txtComplemento.text = _registroSelecionado.complemento;
		txtNumero.text = _registroSelecionado.numero.toString();
		setIndexDataCb(_cbEstado, _registroSelecionado.uf);
		
	}

	public function insertResult(e:ResultEvent):void
	{
		Alert.show(e.result.mensagem , "Mensagem");
		_datagridEndereco.addItem(e.result);
		_ro_endereco.listEndereco(listaRegistroEndereco);	
		leituraTxtInput();
		
	}
	protected function clearRecord():void
	{
		txtBairro.text = "";
		txtCep.text = "";
		txtCidade.text = "";
		txtComplemento.text = "";
		_cbEstado.selectedIndex = 0;
		txtNumero.text = "";
	}

	protected function btnNovo_clickHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		escritaBtn();
		txtCidade.setFocus();
		escritaTxtInput();
	}
	
	protected function btnDeleta_clickHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		Alert.noLabel = ".:Não:.";
		Alert.yesLabel = ".:Sim:.";
		Alert.show('Deseja realmente excluir o registro?', 'Atenção', Alert.YES|Alert.NO, null, excluirRegistro);
	}
	protected function excluirRegistro(e:CloseEvent):void
	{
		if(e.detail == Alert.YES){
			_registroSelecionado = dgEndereco.selectedItem as EnderecoVO;
			_ro_endereco.deleta(_registroSelecionado, excluirRecord);
			leituraTxtInput();
		}
	}
	protected function excluirRecord(e:ResultEvent):void
	{
		Alert.show(e.result.mensagem , "Mensagem");
		_datagridEndereco.removeItemAt(dgEndereco.selectedIndex);
		btnDeleta.enabled = false;
		clearRecord();
		_ro_endereco.listEndereco(listaRegistroEndereco);
	}
	
	
	protected function btnCancelar_clickHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		clearRecord();
		leituraBtn();
		leituraTxtInput();
	}
	public static function setIndexDataCb(cb:mx.controls.ComboBox, Data:Object, field:String = "data"):void
	{
		for(var k:int = 0; k<cb.dataProvider.length; k++)
		{
			if(cb.dataProvider.source[k][field] == Data)
			{
				cb.selectedIndex = k;
				break;
			}
		}
	}
	protected function leituraBtn():void
	{
		btnAlterar.enabled= false;
		btnCancelar.enabled= false;
		btnDeleta.enabled= false;
		btnNovo.enabled= true;
		btnSalvar.enabled= false;
	}
	
	protected function escritaBtn():void
	{
		btnAlterar.enabled= false;
		btnCancelar.enabled= true;
		btnDeleta.enabled= false;
		btnNovo.enabled= false;
		btnSalvar.enabled= true;
		_cbEstado.enabled = true;
	}
	protected function leituraTxtInput():void
	{
		txtBairro.enabled = false;
		txtBairro.enabled = false;
		txtCep.enabled = false;
		txtCidade.enabled = false;
		txtComplemento.enabled = false;
		txtNumero.enabled = false;
		_cbEstado.enabled = false;
	}

	protected function escritaTxtInput():void
	{
		txtBairro.enabled = true;
		txtBairro.enabled = true;
		txtCep.enabled = true;
		txtCidade.enabled = true;
		txtComplemento.enabled = true;
		txtNumero.enabled = true;
		_cbEstado.enabled = true;
	}
	protected function selecaoGridItem():void
	{
		btnAlterar.enabled= true;
		btnCancelar.enabled= true;
		btnDeleta.enabled= true;
		btnNovo.enabled= false;
		btnSalvar.enabled= false;
		escritaTxtInput();
	}
	protected function dgEndereco_clickHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		selecaoGridItem();
	}