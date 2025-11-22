UPDATE contingencia_dfe 
SET sincronizacao = 'S'
WHERE sincronizacao IN ('N', 'G');


UPDATE contingencia_dfe 
SET sincronizacao = 'N'
WHERE sincronizacao = 'S'
and inicio_contingencia > CURRENT_TIMESTAMP - INTERVAL '3 days';
