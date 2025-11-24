WITH temp_mapa_bico AS (
WITH temp_padrao_company AS(
SELECT * FROM (
VALUES 
	(1, 1, 1, '04'), (1, 1, 1, '44'), (1, 1, 1, '84'), (1, 1, 1, 'C4'), (1, 1, 2, '05'), (1, 1, 2, '45'), (1, 1, 2, '85'), (1, 1, 2, 'C5'),
	(1, 2, 3, '06'), (1, 2, 3, '46'), (1, 2, 3, '86'), (1, 2, 3, 'C6'), (1, 2, 4, '07'), (1, 2, 4, '47'), (1, 2, 4, '87'), (1, 2, 4, 'C7'),
	(2, 3, 1, '08'), (2, 3, 1, '48'), (2, 3, 1, '88'), (2, 3, 1, 'C8'), (2, 3, 2, '09'), (2, 3, 2, '49'), (2, 3, 2, '89'), (2, 3, 2, 'C9'),
	(2, 4, 3, '0A'), (2, 4, 3, '4A'), (2, 4, 3, '8A'), (2, 4, 3, 'CA'), (2, 4, 4, '0B'), (2, 4, 4, '4B'), (2, 4, 4, '8B'), (2, 4, 4, 'CB'),
	(3, 5, 1, '0C'), (3, 5, 1, '4C'), (3, 5, 1, '8C'), (3, 5, 1, 'CC'),	(3, 5, 2, '0D'), (3, 5, 2, '4D'), (3, 5, 2, '8D'), (3, 5, 2, 'CD'),
	(3, 6, 3, '0E'), (3, 6, 3, '4E'), (3, 6, 3, '8E'), (3, 6, 3, 'CE'), (3, 6, 4, '0F'), (3, 6, 4, '4F'), (3, 6, 4, '8F'), (3, 6, 4, 'CF'),
	(4, 7, 1, '10'), (4, 7, 1, '50'), (4, 7, 1, '90'), (4, 7, 1, 'D0'), (4, 7, 2, '11'), (4, 7, 2, '51'), (4, 7, 2, '91'), (4, 7, 2, 'D1'),
	(4, 8, 3, '12'), (4, 8, 3, '52'), (4, 8, 3, '92'), (4, 8, 3, 'D2'), (4, 8, 4, '13'), (4, 8, 4, '53'), (4, 8, 4, '93'), (4, 8, 4, 'D3'),
	(5, 9, 1, '14'), (5, 9, 1, '54'), (5, 9, 1, '94'), (5, 9, 1, 'D4'), (5, 9, 2, '15'), (5, 9, 2, '55'), (5, 9, 2, '95'), (5, 9, 2, 'D5'),
	(5, 10, 3, '16'), (5, 10, 3, '56'), (5, 10, 3, '96'), (5, 10, 3, 'D6'), (5, 10, 4, '17'), (5, 10, 4, '57'), (5, 10, 4, '97'), (5, 10, 4, 'D7'),
	(6, 11, 1, '18'), (6, 11, 1, '58'), (6, 11, 1, '98'), (6, 11, 1, 'D8'), (6, 11, 2, '19'), (6, 11, 2, '59'), (6, 11, 2, '99'), (6, 11, 2, 'D9'),
	(6, 12, 3, '1A'), (6, 12, 3, '5A'), (6, 12, 3, '9A'), (6, 12, 3, 'DA'), (6, 12, 4, '1B'), (6, 12, 4, '5B'), (6, 12, 4, '9B'), (6, 12, 4, 'DB'),
	(7, 13, 1, '1C'), (7, 13, 1, '5C'), (7, 13, 1, '9C'), (7, 13, 1, 'DC'), (7, 13, 2, '1D'), (7, 13, 2, '5D'), (7, 13, 2, '9D'), (7, 13, 2, 'DD'),
	(7, 14, 3, '1E'), (7, 14, 3, '5E'), (7, 14, 3, '9E'), (7, 14, 3, 'DE'), (7, 14, 4, '1F'), (7, 14, 4, '5F'), (7, 14, 4, '9F'), (7, 14, 4, 'DF'),
	(8, 15, 1, '20'), (8, 15, 1, '60'), (8, 15, 1, 'A0'), (8, 15, 1, 'E0'), (8, 15, 2, '21'), (8, 15, 2, '61'), (8, 15, 2, 'A1'), (8, 15, 2, 'E1'),
	(8, 16, 3, '22'), (8, 16, 3, '62'), (8, 16, 3, 'A2'), (8, 16, 3, 'E2'), (8, 16, 4, '23'), (8, 16, 4, '63'), (8, 16, 4, 'A3'), (8, 16, 4, 'E3'),
	(9, 17, 1, '24'), (9, 17, 1, '64'), (9, 17, 1, 'A4'), (9, 17, 1, 'E4'), (9, 17, 2, '25'), (9, 17, 2, '65'), (9, 17, 2, 'A5'), (9, 17, 2, 'E5'),
	(9, 18, 3, '26'), (9, 18, 3, '66'), (9, 18, 3, 'A6'), (9, 18, 3, 'E6'), (9, 18, 4, '27'), (9, 18, 4, '67'), (9, 18, 4, 'A7'), (9, 18, 4, 'E7'),
	(10, 19, 1, '28'), (10, 19, 1, '68'), (10, 19, 1, 'A8'), (10, 19, 1, 'E8'), (10, 19, 2, '29'), (10, 19, 2, '69'), (10, 19, 2, 'A9'), (10, 19, 2, 'E9'),
	(10, 20, 3, '2A'), (10, 20, 3, '6A'), (10, 20, 3, 'AA'), (10, 20, 3, 'EA'), (10, 20, 4, '2B'), (10, 20, 4, '6B'), (10, 20, 4, 'AB'), (10, 20, 4, 'EB'), 
	(11, 21, 1, '2C'), (11, 21, 1, '6C'), (11, 21, 1, 'AC'), (11, 21, 1, 'EC'), (11, 21, 2, '2D'), (11, 21, 2, '6D'), (11, 21, 2, 'AD'), (11, 21, 2, 'ED'),
	(11, 22, 3, '2E'), (11, 22, 3, '6E'), (11, 22, 3, 'AE'), (11, 22, 3, 'EE'), (11, 22, 4, '2F'), (11, 22, 4, '6F'), (11, 22, 4, 'AF'), (11, 22, 4, 'EF'),
	(12, 23, 1, '30'), (12, 23, 1, '70'), (12, 23, 1, 'B0'), (12, 23, 1, 'F0'), (12, 23, 2, '31'), (12, 23, 2, '71'), (12, 23, 2, 'B1'), (12, 23, 2, 'F1'),
	(12, 24, 3, '32'), (12, 24, 3, '72'), (12, 24, 3, 'B2'), (12, 24, 3, 'F2'), (12, 24, 4, '33'), (12, 24, 4, '73'), (12, 24, 4, 'B3'), (12, 24, 4, 'F3')
) AS t (canal, bomba, lado, numero_logico))
SELECT	bc.guid_bico_combustivel,
		se.nome || ' - ' || ab.denominacao AS automacao,
		bc.numero,
		bc.denominacao,
		bc.codigo_bico_automacao,
		bc.canal_automacao AS canal_automacao_petros,
		tpc.canal AS canal_company,
		bomba.numero AS numero_bomba_petros,
		tpc.bomba AS bomba_company,
		bc.lado_bomba AS lado_bomba_petros,
		tpc.lado AS lado_company
FROM	bico_combustivel AS bc
		INNER JOIN bomba_combustivel AS bomba ON (bomba.id_bomba_combustivel = bc.id_bomba_combustivel)
		INNER JOIN automacao_bomba AS ab ON (ab.id_automacao_bomba = bc.id_automacao_bomba)
		INNER JOIN sis_empresa AS se ON (se.id_empresa = ab.id_empresa)
		INNER JOIN temp_padrao_company AS tpc ON (tpc.numero_logico = bc.codigo_bico_automacao)
WHERE	bc.registro_ativo = 'S')
SELECT	CASE WHEN EXISTS (SELECT 1 
			  FROM temp_mapa_bico AS tmbi 
			  WHERE tmbi.automacao = tmb.automacao
		  	  AND	tmbi.canal_company = tmb.canal_company
			  AND	tmbi.bomba_company = tmb.bomba_company 
			  AND	tmbi.lado_company = tmb.lado_company
			  AND	((COALESCE(tmbi.canal_automacao_petros, '') != COALESCE(tmb.canal_automacao_petros, ''))
					OR (tmbi.numero_bomba_petros != tmb.numero_bomba_petros)
					OR (tmbi.lado_bomba_petros != tmb.lado_bomba_petros)))
			OR EXISTS (SELECT 1 
			  FROM temp_mapa_bico AS tmbi 
			  WHERE tmbi.automacao = tmb.automacao
		  	  AND	((tmbi.canal_company != tmb.canal_company)
			  		OR (tmbi.bomba_company != tmb.bomba_company)
					OR (tmbi.lado_company != tmb.lado_company))
			  AND	COALESCE(tmbi.canal_automacao_petros, '') = COALESCE(tmb.canal_automacao_petros, '')
			  AND	tmbi.numero_bomba_petros = tmb.numero_bomba_petros
			  AND	tmbi.lado_bomba_petros = tmb.lado_bomba_petros) THEN
			'Inconsistente'
		ELSE
			'OK'
		END Observacao,
		tmb.*
FROM	temp_mapa_bico AS tmb
ORDER BY tmb.automacao,
		tmb.canal_company,
		tmb.bomba_company,
		tmb.lado_company;