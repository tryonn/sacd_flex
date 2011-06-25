package controllers
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;
	
	import services.EnderecoService;
	
	import views.endereco.EnderecoView;
	
	import br.com.aliancadeus.vo.EnderecoVO;

	public class EnderecoController extends ControllerBase
	{
		[Bindable]
		public var _enderecoVO:EnderecoVO =  new EnderecoVO();
		[Bindable]
		public var _dataProvider:ArrayList;
		
		[Inject]
		public var _enderecoService:EnderecoService;
		
		[Bindable]
		private var enderevoView:EnderecoView;
		public function EnderecoController()
		{
			//TODO: implement function
			super();
		}
		
		public function getList():void
		{
			//this._enderecoVO = null;
			serviceHelper.executeServiceCall(this._enderecoService.getListar(), onGetList);
		}
		public function onGetList(e:ResultEvent):void
		{
			this._dataProvider = new ArrayList(e.result as Array);
		}
		
		public function save():void
		{
			serviceHelper.executeServiceCall(this._enderecoService.insert(_enderecoVO),onSave);
		}
		public function onSave(e:ResultEvent):void
		{
/*			Alert.show("Registro salvo com Sucesso","Mensagem - simao");*/
			Alert.show(e.result.mensagem,":. Mensagem .:");
			getList();
		}
		public function update():void
		{
			serviceHelper.executeServiceCall(this._enderecoService.update(_enderecoVO),onUpdate);
		}
		public function onUpdate(e:ResultEvent):void
		{
			Alert.show(e.result.mensagem,":. Mensagem .:");			
		}
		
		[Bindable] public var estadosBr:ArrayCollection = new ArrayCollection([
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
	}
}