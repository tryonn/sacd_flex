import br.com.aliancadeus.vo.EnderecoVO;
import br.com.aliancadeus.vo.MembroVO;
import br.com.aliancadeus.vo.Origem_conversaoVO;
import br.com.flexbrasilia.formatters.MySQLDateHelper;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.events.FlexEvent;
import mx.rpc.events.ResultEvent;

import ro.Endereco_ro;
import ro.Membro_ro;
import ro.OrigemConversao_ro;

/**
 * 
 * 
 * **/


	[Bindable]
	private var _membro:MembroVO = new MembroVO();
	[Bindable]
	private var _enderecoVO:EnderecoVO = new EnderecoVO();
	[Bindable]	
	private var _origemConversao:Origem_conversaoVO = new Origem_conversaoVO();
	[Bindable]
	private var _ro_origemConversao:OrigemConversao_ro = OrigemConversao_ro.getInstance();
	[Bindable]
	private var _ro_endereco:Endereco_ro = Endereco_ro.getInstance();
	[Bindable]
	private var _ro_membro:Membro_ro = Membro_ro.getInstance();
	[Bindable]
	private var _registroSelecionado:MembroVO = new MembroVO();
	[Bindable]
	private var _datagridMembro:ArrayCollection;
	[Bindable]
	private var comboCidade:ArrayCollection;
	[Bindable]
	private var comboOrigem:ArrayCollection;
	[Bindable]
	public var _estadoCivil:ArrayCollection = new ArrayCollection([
		{label: "Escolha uma opção"},
		{data:	"solteiro(a)", 		label:	"solteiro(a)"},
		{data:	"casado(a)",		label:	"casado(a)"},
		{data:	"união estável",	label:	"união estável"},
		{data:	"separado",			label:	"separado"},
		{data:	"divorciado",		label:	"divorciado"},
		{data:	"outros",			label:	"outros"}
	]);
	[Bindable]
	public var _batizado:ArrayCollection = new ArrayCollection([
		{label: "Escolha uma opção"},
		{data:	"sim", 		label:	"Sim"},
		{data:	"não",		label:	"Não"}
	]);
/*----------------------- Fim das Variaveis --------------------*/ 

	protected function init(event:FlexEvent):void
	{
		// TODO Auto-generated method stub
		_ro_membro.listMembro(listMembro);
		_ro_endereco.listEndereco(listaRegistroEndereco);
		_ro_origemConversao.listOrigemConversao(listaRegistroOrigem);		
		leituraTxtInput();
	}



/**
 * Aqui estou criando um método para 
 * listar todos os registros do bd na grid
 * **/
	protected function listMembro(e:ResultEvent):void
	{
		_datagridMembro = new ArrayCollection(e.result as Array);
	}
/*------------------ ################# ---------------------*/
public function listaRegistroEndereco(e:ResultEvent):void
{
	comboCidade = new ArrayCollection(e.result as Array);
}
public function listaRegistroOrigem(e:ResultEvent):void
{
	comboOrigem = new ArrayCollection(e.result as Array);
}
/*------------------ ################# ---------------------*/
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
	}
	protected function leituraTxtInput():void
	{
		txtCel.enabled 			= false;
		txtNome.enabled 		= false;
		txtRes.enabled 			= false;
		_cbBatizado.enabled 		= false;
		_cbEstadoCivil.enabled 	= false;
		_cbOrigem.enabled 		= false;
		_cbEndereco.enabled 		= false;
		dtBatismo.enabled		= false;
		dtNasc.enabled			= false;
	}
	
	protected function escritaTxtInput():void
	{
		txtCel.enabled 			= true;
		txtNome.enabled 		= true;
		txtRes.enabled 			= true;
		_cbBatizado.enabled 		= true;
		_cbEstadoCivil.enabled 	= true;
		_cbOrigem.enabled 		= true;
		_cbEndereco.enabled 		= true;
		dtBatismo.enabled		= true;
		dtNasc.enabled			= true;
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
	protected function dgMembro_clickHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		selecaoGridItem();
	}
	/*------------------ ################# ---------------------*/
	protected function registroSelecionado(e:Event):void
	{
		_registroSelecionado 		= MembroVO(e.currentTarget.selectedItem);		
		dtBatismo.text 				= _registroSelecionado.data_batismo;
		dtNasc.text 				= _registroSelecionado.data_nascimento;
		_cbEndereco.text 			= _registroSelecionado.endereco;
		txtCel.text 				= _registroSelecionado.fone_cel;
		txtRes.text 				= _registroSelecionado.fone_resid;
		txtNome.text 				= _registroSelecionado.nome;
		_cbOrigem.text 				= _registroSelecionado.origem_conversao;
		
		setIndexDataCbBatizado(_cbBatizado, _registroSelecionado.batizado);
		setIndexDataCbEstadoCivil(_cbEstadoCivil, _registroSelecionado.estado_civil);
	}
	/*------------------ Evento dos btn's ---------------------*/
	
	protected function btnNovo_clickHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		txtNome.setFocus();
		escritaTxtInput();
	}
	
	protected function btnSalvar_clickHandler(event:MouseEvent):void
	{
		var objEnd:Object = _cbEndereco.selectedItem;
		var objOrigem:Object = _cbOrigem.selectedItem;
		
		if(
			txtCel.text					!= "" &&
			txtNome.text				!= "" &&
			txtRes.text					!= "" &&
			_cbBatizado.selectedItem		!= "" &&
			_cbEstadoCivil.selectedItem	!= "" &&
			_cbOrigem.selectedItem 		!= "" &&
			_cbEndereco.selectedItem 	!= "" &&
			dtBatismo.text				!= "" &&
			dtNasc.text					!= ""
		){
			_membro.batizado = _cbBatizado.selectedItem.data;
			_membro.data_batismo = MySQLDateHelper.formatToMySQL(dtBatismo.selectedDate);
			_membro.data_nascimento = MySQLDateHelper.formatToMySQL(dtNasc.selectedDate);
			_membro.enderecos_id = objEnd.id.toString();
			_membro.estado_civil = _cbEstadoCivil.selectedItem.data;
			_membro.fone_cel = txtCel.text;
			_membro.fone_resid = txtRes.text;
			_membro.nome = txtNome.text;
			_membro.origem_conversao_id = objOrigem.id.toString();
			
			_ro_membro.insert(_membro,onSaveResult);
		} else {
			Alert.show(" Todos os campos são obrigatorios ","Atenção");
		}
	}
	protected function onSaveResult(e:ResultEvent):void
	{
		Alert.show(e.result.mensagem , "Mensagem");
		_datagridMembro.addItem(e.result);
		_ro_membro.listMembro(listMembro);
	}
	
	
	protected function btnAlterar_clickHandler(event:MouseEvent):void
	{
		var objEnd:Object = _cbEndereco.selectedItem;
		var objOrigem:Object = _cbOrigem.selectedItem;
		
		_membro.id 						= _registroSelecionado.id;
		_membro.batizado 				= _cbBatizado.selectedItem.data;
		_membro.data_batismo 			= MySQLDateHelper.formatToMySQL(dtBatismo.selectedDate);
		_membro.data_nascimento 		= MySQLDateHelper.formatToMySQL(dtNasc.selectedDate);
		_membro.enderecos_id 			= objEnd.id.toString();
		_membro.estado_civil 			= _cbEstadoCivil.selectedItem.data;
		_membro.fone_cel 				= txtCel.text;
		_membro.fone_resid 				= txtRes.text;
		_membro.nome 					= txtNome.text;
		_membro.origem_conversao_id 	= objOrigem.id.toString();
	}
	
	
	protected function btnDeleta_clickHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
	}
	
	
	protected function btnCancelar_clickHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
	}

/*--------------------------------------------------------------------------------------------------------------*/
/*	Função utilizada onde quando seleciona o registro do datagrid    											*/
/*	é selecionado tmbem o registro no combobox													     			*/
/*																												*/
/*--------------------------------------------------------------------------------------------------------------*/
public static function setIndexDataCbOrigem(cb:mx.controls.ComboBox, Data:Object, field:String = "data"):void
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
public static function setIndexDataCbEndereco(cb:mx.controls.ComboBox, Data:Object, field:String = "data"):void
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
public static function setIndexDataCbBatizado(cb:mx.controls.ComboBox, Data:Object, field:String = "data"):void
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
public static function setIndexDataCbEstadoCivil(cb:mx.controls.ComboBox, Data:Object, field:String = "data"):void
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
/*--------------------------------------------------------------------------------------------------------------*/