package ro
{	
	import br.com.aliancadeus.vo.MembroVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class Membro_ro
	{
		private var _ro_membro:RemoteObject;
		private var _async:AsyncToken;
		private static var instance:Membro_ro;
		
		public static function getInstance():Membro_ro{
			if(instance == null){
				instance = new Membro_ro();
			}
			return instance;
		}
		
		public function listMembro(result:Function):void{
			_async = _ro_membro.getListar();
			_async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function insert(_membroVO:MembroVO, result:Function):void{
			_async = _ro_membro.insert(_membroVO);
			_async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function update(_membroVO:MembroVO, result:Function):void
		{
			_async = _ro_membro.update(_membroVO);
			_async.addResponder(new Responder(result,defaultFaultHandler));
		}
		public function deleta(_membroVO:MembroVO, result:Function):void
		{
			_async = _ro_membro.excluir(_membroVO.id);
			_async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		private function defaultFaultHandler(e:FaultEvent):void{
			Alert.show(e.fault.faultDetail, e.fault.message);
		}
		public function Membro_ro()
		{
			_ro_membro = new RemoteObject();
			_ro_membro.showBusyCursor = true;
			_ro_membro.destination = 'amfphp';
			_ro_membro.source = 'DAO.MembroDAO';
		}
	}
}