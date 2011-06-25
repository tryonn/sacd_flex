package br.com.aliancadeus.vo
{
	[Bindable]
	[RemoteClass(alias="br.com.aliancadeus.vo.UsuarioVO")]
	public class UsuarioVO
	{
		public var id:Number;
		public var login:String;
		public var senha:String;
		public var ultimo_login:Date;
		public var perfis_id:Number;
		public var membros_id:Number;
		
		public function UsuarioVO()
		{
		}
	}
}