// ActionScript file

import events.MDIEvent;

import views.dependente.DependenteView;
import views.endereco.EnderecoView;
import views.origem_conversao.OrigemConversaoView;

public function janelaUser():void
{
	dispatchEvent(new MDIEvent(MDIEvent.OPEN_WINDOW,new EnderecoView()));
}
public function janelaMembros():void
{
	dispatchEvent(new MDIEvent(MDIEvent.OPEN_WINDOW,new DependenteView()));
}
public function janelaEndereroView():void
{
	dispatchEvent(new MDIEvent(MDIEvent.OPEN_WINDOW, new EnderecoView()));
}
public function janelaOrigemConversaoView():void
{
	dispatchEvent(new MDIEvent(MDIEvent.OPEN_WINDOW, new OrigemConversaoView()));
}