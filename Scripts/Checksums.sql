
SELECT * FROM venda WHERE situacao IN (5,6,7,1)

SELECT * FROM abastecimento where situacao = 1

UPDATE abastecimento set data_abastecimento = data_captura where situacao in (1,7)

SELECT * FROM abastecimento where situacao = 1

-----------------------CHECKSUMS--------------------------------------------------

--Abastecimentos
UPDATE	abastecimento AS a
SET	checksum = UPPER(MD5(a.guid_abastecimento
|| TO_CHAR(a.data_abastecimento, 'yyyyMMddhh24miss')
|| a.id_bico_combustivel
|| REPLACE(CAST(a.encerrante_inicial AS TEXT), '.', '') 
|| REPLACE(CAST(a.encerrante AS TEXT), '.', '')
|| CAST(a.situacao AS TEXT)
|| REPLACE(CAST(a.quantidade AS TEXT), '.', '')
|| REPLACE(CAST(a.preco AS TEXT), '.', '')
|| TRIM(a.retorno_automacao)
|| COALESCE(NULL, '')
|| '90FF5985D57C42389D631AE4F25C026E'))
WHERE	a.situacao NOT IN (2,3,4,5,6)
AND	a.checksum != UPPER(MD5(a.guid_abastecimento
|| TO_CHAR(a.data_abastecimento, 'yyyyMMddhh24miss')
|| a.id_bico_combustivel
|| REPLACE(CAST(a.encerrante_inicial AS TEXT), '.', '') 
|| REPLACE(CAST(a.encerrante AS TEXT), '.', '')
|| CAST(a.situacao AS TEXT)
|| REPLACE(CAST(a.quantidade AS TEXT), '.', '')
|| REPLACE(CAST(a.preco AS TEXT), '.', '')
|| TRIM(a.retorno_automacao)
|| COALESCE(NULL, '')
|| '90FF5985D57C42389D631AE4F25C026E'));

--Vendas
UPDATE    venda AS v
SET    checksum = UPPER(MD5(CAST(v.tipo_venda AS TEXT) 
|| v.id_cliente 
|| COALESCE(v.numero_serie_ecf, '') 
|| v.numero_cupom
|| TO_CHAR(v.data_cupom, 'yyyyMMddhh24miss') 
|| v.numero_ccf 
|| REPLACE(v.total_item::TEXT, '.', '') 
|| REPLACE((v.desconto + v.desconto_ajuste + v.desconto_automatico + v.desconto_fidelidade)::TEXT, '.', '') 
|| REPLACE((v.acrescimo + v.acrescimo_ajuste + v.acrescimo_automatico)::TEXT, '.', '') 
|| REPLACE(v.total_venda::TEXT, '.', '') 
|| v.cliente_rodape 
|| v.cnpj_cpf_rodape
|| (CASE WHEN situacao = 4 THEN 'S' ELSE 'N' END) 
|| v.chave_acesso_nfce 
|| v.numero_protocolo_nfce 
|| v.contingencia_offline 
|| '90FF5985D57C42389D631AE4F25C026E'))
WHERE v.checksum != UPPER(MD5(CAST(v.tipo_venda AS TEXT) 
|| v.id_cliente 
|| COALESCE(v.numero_serie_ecf, '') 
|| v.numero_cupom
|| TO_CHAR(v.data_cupom, 'yyyyMMddhh24miss') 
|| v.numero_ccf 
|| REPLACE(v.total_item::TEXT, '.', '') 
|| REPLACE((v.desconto + v.desconto_ajuste + v.desconto_automatico + v.desconto_fidelidade)::TEXT, '.', '') 
|| REPLACE((v.acrescimo + v.acrescimo_ajuste + v.acrescimo_automatico)::TEXT, '.', '') 
|| REPLACE(v.total_venda::TEXT, '.', '') 
|| v.cliente_rodape 
|| v.cnpj_cpf_rodape
|| (CASE WHEN situacao = 4 THEN 'S' ELSE 'N' END) 
|| v.chave_acesso_nfce 
|| v.numero_protocolo_nfce 
|| v.contingencia_offline 
|| '90FF5985D57C42389D631AE4F25C026E'));

--Pacote Frente Caixa
UPDATE pacote_frente_caixa
SET checksum = UPPER(MD5('' ||
id_pacote_frente_caixa ||
COALESCE(TO_CHAR(geracao, 'yyyy-MM-dd hh24:mi:ss'), '') ||
pacote ||
versao_leiaute ||
COALESCE(TO_CHAR(envio, 'yyyy-MM-dd hh24:mi:ss'), '')||
COALESCE(TO_CHAR(processamento, 'yyyy-MM-dd hh24:mi:ss'), '') ||
COALESCE(TO_CHAR(cancelamento, 'yyyy-MM-dd hh24:mi:ss'), '')))
WHERE checksum != UPPER(MD5('' ||
id_pacote_frente_caixa ||
COALESCE(TO_CHAR(geracao, 'yyyy-MM-dd hh24:mi:ss'), '') ||
pacote ||
versao_leiaute ||
COALESCE(TO_CHAR(envio, 'yyyy-MM-dd hh24:mi:ss'), '')||
COALESCE(TO_CHAR(processamento, 'yyyy-MM-dd hh24:mi:ss'), '') ||
COALESCE(TO_CHAR(cancelamento, 'yyyy-MM-dd hh24:mi:ss'), ''))) AND processamento IS NULL AND cancelamento IS NULL;

