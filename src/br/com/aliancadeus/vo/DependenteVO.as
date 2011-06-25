package br.com.aliancadeus.vo
{
	[Bindable]
	[RemoteClass(alias="br.com.aliancadeus.vo.DependenteVO")]
	public class DependenteVO
	{
		public var id:int;
		public var nome:String;
		public var data_nascimento:Date;
		public var membros_id:int;
		public var membro:String;
		
		public function DependenteVO()
		{
		}
	}
}