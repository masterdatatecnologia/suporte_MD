-- SELECT f_gera_abastecimento(numero_bico,litragem)
-- DROP FUNCTION f_gera_abastecimento(integer, numeric);
CREATE OR REPLACE FUNCTION f_gera_abastecimento(
		PNumeroBico integer,
		PQuantidade numeric)
	RETURNS integer AS
 $BODY$
 DECLARE 
	PIdAbastecimento integer;
	rec RECORD;
 BEGIN
	PIdAbastecimento := NEXTVAL('SEQ_CHAVE_PRIMARIA');
	
	FOR rec IN
		SELECT	bc.id_bico_combustivel,
			bc.id_automacao_bomba,
			bc.ultimo_encerrante_capturado,
			i.preco
		FROM	bico_combustivel AS bc
		INNER JOIN local_estoque AS le ON (le.id_local_estoque = bc.id_tanque)
		INNER JOIN item AS i ON (i.id_item = le.id_item_tanque)
		WHERE bc.numero = PNumeroBico 
		AND bc.registro_excluido = 'N'
	LOOP
		INSERT INTO public.abastecimento (
    id_abastecimento,
    guid_abastecimento,
    tipo_abastecimento,
    data_abastecimento,
    data_captura,
    id_bico_combustivel,
    id_automacao_bomba,
    quantidade,
    preco,
    total,
    encerrante,
    encerrante_inicial,
    duracao_abastecimento,
    retorno_automacao,
    id_atendente,
    id_veiculo_cliente,
    id_forma_recebimento,
    id_terminal,
    id_movimento_venda,
    situacao,
    marcador,
    sincronizacao,
    versao_registro,
    checksum,
    id_terminal_pos_wireless,
    nsu,
    quantidade_parcela,
    situacao_transacao_semparar,
    quebra_continuidade_verificada,
    odometro,
    placa,
    id_tipo_concentrador_tef,
    codigo_rede_tef,
    codigo_bandeira_tef,
    codigo_tipo_transacao_tef,
    cnpj_cpf,
    ordem,
    id_cliente,
    comprovante_loja,
    comprovante_cliente,
    email_cliente,
    emitir_venda,
    id_forma_recebimento_tef,
    preco_original,
    acrescimo,
    desconto,
    id_abastecimento_origem,
    valor_recebido,
    data_transacao_sitef,
    id_prevenda,
    preco_tabela,
    id_chave_integracao
)
SELECT
    PIdAbastecimento,                                                     -- id_abastecimento
    UPPER(MD5('' || NOW() || RANDOM())),                                  -- guid_abastecimento
    2,                                                                    -- tipo_abastecimento
    CURRENT_TIMESTAMP,                                                    -- data_abastecimento
    CURRENT_TIMESTAMP,                                                    -- data_captura
    rec.id_bico_combustivel,                                              -- id_bico_combustivel
    rec.id_automacao_bomba,                                               -- id_automacao_bomba
    PQuantidade,                                                          -- quantidade
    rec.preco,                                                            -- preco
    ROUND(PQuantidade * rec.preco, 3),                                    -- total
    rec.ultimo_encerrante_capturado,                                      -- encerrante
    rec.ultimo_encerrante_capturado - PQuantidade,                        -- encerrante_inicial
    0,                                                                    -- duracao_abastecimento
    'GERADO MANUAL',                                                      -- retorno_automacao
    NULL,                                                                 -- id_atendente
    NULL,                                                                 -- id_veiculo_cliente
    NULL,                                                                 -- id_forma_recebimento
    NULL,                                                                 -- id_terminal
    NULL,                                                                 -- id_movimento_venda
    1,                                                                    -- situacao
    'N',                                                                  -- marcador
    'N',                                                                  -- sincronizacao
    NEXTVAL('seq_versao_registro'),                                       -- versao_registro
    UPPER(MD5(RANDOM()::TEXT)),                                           -- checksum
    NULL,                                                                 -- id_terminal_pos_wireless
    '',                                                                   -- nsu
    0,                                                                    -- quantidade_parcela
    4,                                                                    -- situacao_transacao_semparar
    'S',                                                                  -- quebra_continuidade_verificada
    0.00,                                                                 -- odometro
    '',                                                                   -- placa
    NULL,                                                                 -- id_tipo_concentrador_tef
    '',                                                                   -- codigo_rede_tef
    '',                                                                   -- codigo_bandeira_tef
    '',                                                                   -- codigo_tipo_transacao_tef
    '',                                                                   -- cnpj_cpf
    0,                                                                    -- ordem
    NULL,                                                                 -- id_cliente
    NULL,                                                                 -- comprovante_loja
    NULL,                                                                 -- comprovante_cliente
    NULL,                                                                 -- email_cliente
    'N',                                                                  -- emitir_venda
    NULL,                                                                 -- id_forma_recebimento_tef
    rec.preco,                                                            -- preco_original
    '0.000',                                                              -- acrescimo
    '0.000',                                                              -- desconto
    NULL,                                                                 -- id_abastecimento_origem
    0.00,                                                                 -- valor_recebido
    CURRENT_TIMESTAMP,                                                    -- data_transacao_sitef
    NULL,                                                                 -- id_prevenda
    rec.preco,                                                            -- preco_tabela
    UPPER(MD5(RANDOM()::TEXT))                                            -- id_chave_integracao
WHERE NOT EXISTS (
    SELECT 1 
    FROM public.abastecimento a 
    WHERE a.id_abastecimento = PIdAbastecimento
);
	END LOOP;
	RETURN PIdAbastecimento;
 END;
 $BODY$
	LANGUAGE plpgsql VOLATILE
	COST 100;
 ALTER FUNCTION f_gera_abastecimento(integer, numeric)
	OWNER TO postgres;