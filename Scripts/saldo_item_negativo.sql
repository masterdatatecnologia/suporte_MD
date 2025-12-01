WITH cte_saldo AS (
SELECT
    COALESCE(SUM(rme.quantidade_entrada - rme.quantidade_saida), 0)
    -
    COALESCE((
        SELECT SUM(me.quantidade *
                   CASE WHEN tme.entrada_saida = 1 THEN 1 ELSE -1 END)
        FROM movimento_estoque me
        INNER JOIN tipo_movimento_estoque tme
            ON tme.id_tipo_movimento_estoque = me.id_tipo_movimento_estoque
        WHERE me.id_item = rme.id_item
          AND me.id_local_estoque = :id_local_estoque
          AND me.data_movimento > CURRENT_DATE
          AND me.data_movimento < DATE_TRUNC('MONTH', CURRENT_DATE + INTERVAL '1 month')
    ), 0) AS saldo_quantidade,
    COALESCE(SUM(rme.valor_entrada - rme.valor_saida), 0)
    -
    COALESCE((
        SELECT SUM(me.valor *
                   CASE WHEN tme.entrada_saida = 1 THEN 1 ELSE -1 END)
        FROM movimento_estoque me
        INNER JOIN tipo_movimento_estoque tme
            ON tme.id_tipo_movimento_estoque = me.id_tipo_movimento_estoque
        WHERE me.id_item = rme.id_item
          AND me.id_local_estoque = :id_local_estoque
          AND me.data_movimento > CURRENT_DATE
          AND me.data_movimento < DATE_TRUNC('MONTH', CURRENT_DATE + INTERVAL '1 month')
    ), 0) AS saldo_valor,
    rme.id_item,
    i.codigo,
    i.denominacao
FROM resumo_movimento_estoque rme
	INNER JOIN item as i on i.id_item = rme.id_item
WHERE rme.ano_mes <= EXTRACT(YEAR FROM CURRENT_DATE) * 100
                      + EXTRACT(MONTH FROM CURRENT_DATE)
  AND rme.id_local_estoque = :id_local_estoque
GROUP BY rme.id_item,
    i.codigo,
    i.denominacao
)
SELECT * FROM cte_saldo WHERE saldo_quantidade < 0