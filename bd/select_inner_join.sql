select * from membros
select * from enderecos
select * from origem_conversao
-- DATE_FORMAT(dtConversao,'%d/%m/%Y')
select membros.id, membros.nome,
        DATE_FORMAT(data_nascimento,'%d/%m/%Y') as dtNasc,
        DATE_FORMAT(data_conversao,'%d/%m/%Y') as dtConvers,
        membros.fone_cel,
        membros.fone_resid,
        membros.estado_civil,
        membros.enderecos_id,
        membros.origem_conversao_id,
        membros.batizado, 
        DATE_FORMAT(membros.data_batismo,'%d/%m/%Y') as dtBatismo,
        origem_conversao.id as origem_conversao_id,
        origem_conversao.descricao as origem_conversao_descricao,
        origem_conversao.nome_igreja as origem_conversao_nome_igreja, 
        origem_conversao.dtConversao as origem_conversao_dt_conversao,
        origem_conversao.ano as origem_conversao_ano,
        enderecos.id as enderecosId,
        enderecos.bairro as enderecos_bairro,
        enderecos.cidade as enderecos_cidade,
        enderecos.uf as enderecos_uf,
        enderecos.numero as enderecos_numero,
        enderecos.complemento as enderecos_complemento,
        enderecos.cep as enderecos_cep,
        enderecos.logradouro as enderecos_logradouro
from membros
inner join enderecos on enderecos.id = membros.enderecos_id
inner join origem_conversao on origem_conversao.id = membros.origem_conversao_id