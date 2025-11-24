DO $$
DECLARE

VIdDescontinuidade INTEGER;
VIdBico	VARCHAR(32);
VCasaMilhao INTEGER;

BEGIN

/* ************* PARA O SERVIÇO DE AUTOMAÇÃO E O SINCRONIZADOR ANTES *********** */
/* ************* PREENCHER O BICO E A CASA DO MILHÃO *********** */
VIdBico := '705DEE9D78F44F70A60239DD7DABEDD4';
VCasaMilhao := 2;

VIdDescontinuidade := NEXTVAL('SEQ_CHAVE_PRIMARIA');

INSERT INTO descontinuidade_encerrante (
id_descontinuidade_encerrante, 
guid_descontinuidade_encerrante, 
id_bico_combustivel, 
data_descontinuidade, 
motivo, 
justificativa, medida_adotada, tipo_decisao, cnpj_empresa, cpf_tecnico, 
nome_tecnico_interventor, numero_lacre_removido, numero_lacre_aplicado, 
hora_substituicao,
encerrante_anterior, 
encerrante_atual, 
encerrante_apos_confirmacao, 
checksum, 
sincronizacao)
SELECT 
VIdDescontinuidade, 
UPPER(MD5(random()::text)), 
VIdBico AS id_bico_combustivel, 
CURRENT_TIMESTAMP as data_descontinuidade, 
'O Encerrante no Retorno da Comunicação é maior que o encerrante do último abastecimento.', 
'', '', 0, '', '', '', '', '', '',
a.encerrante AS encerrante_anterior, 

(VCasaMilhao * 1000000.00) + (	
CASE WHEN (TRUNC(a.encerrante / 1000000) > 0)
THEN a.encerrante - (TRUNC(a.encerrante / 1000000) * 1000000) 
ELSE a.encerrante END) AS encerrante_atual, 

(VCasaMilhao * 1000000.00) + (	
CASE WHEN (TRUNC(a.encerrante / 1000000) > 0)
THEN a.encerrante - (TRUNC(a.encerrante / 1000000) * 1000000)
ELSE a.encerrante END) AS encerrante_apos_confirmacao, 

'' AS checksum, 'N'
FROM abastecimento a	
WHERE id_bico_combustivel = VIdBico
ORDER BY a.ordem DESC, a.id_abastecimento DESC
LIMIT 1;

UPDATE descontinuidade_encerrante SET checksum = UPPER(MD5(to_char(data_descontinuidade, 'YYYYMMDDHH24MISS') || trim(motivo)
|| tipo_decisao || COALESCE(to_char(data_substituicao, 'YYYYMMDD'), '00000000') ||
COALESCE(REPLACE(hora_substituicao, ':', ''), '0000') || '00' || cnpj_empresa || cpf_tecnico ||
numero_lacre_removido || numero_lacre_aplicado
|| REPLACE(REPLACE(to_char(encerrante_anterior, '999999999.999'), '.', ''), ' ', '') || REPLACE(REPLACE(to_char(encerrante_atual, '999999999.999'), '.', ''), ' ', '')
|| REPLACE(REPLACE(to_char(encerrante_apos_confirmacao, '999999999.999'), '.', ''), ' ', '') || '90FF5985D57C42389D631AE4F25C026E'))
WHERE id_descontinuidade_encerrante = VIdDescontinuidade;

END
$$ LANGUAGE plpgsql;