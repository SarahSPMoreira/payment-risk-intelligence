-- ============================================================
-- PROJETO DE PREVENÇÃO A FRAUDES E MONITORAMENTO DE RISCO
-- Autora: Sarah Paiva (Especialista em Riscos e Controvérsias)
-- Objetivo: Identificação precoce de padrões de ataque para mitigação de Chargebacks
-- ============================================================

-- ------------------------------------------------------------
-- REGRA 1: DETECÇÃO DE ATAQUE DE TESTE DE CARTÃO (CARD TESTING)
-- Lógica de Negócio: Ataques automatizados (bots) costumam disparar 
-- transações de baixo valor em curtos intervalos de tempo usando cartões variados.
-- ------------------------------------------------------------
SELECT 
    ip_transacao,
    id_cliente,
    COUNT(id_transacao) AS total_tentativas,
    ROUND(SUM(valor), 2) AS valor_total_tentado,
    COUNT(DISTINCT cartao_mascarado) AS qtd_cartoes_diferentes,
    MIN(data_transacao) AS inicio_ataque,
    MAX(data_transacao) AS fim_ataque
FROM transacoes
GROUP BY ip_transacao, id_cliente
HAVING COUNT(id_transacao) >= 5
ORDER BY total_tentativas DESC;

-- ------------------------------------------------------------
-- REGRA 2: DIVERGÊNCIA GEOGRÁFICA DE ALTO VALOR (RISK SCORE ALTO)
-- Lógica de Negócio: Compras de valor elevado fora do país de cadastro do cliente
-- apresentam alto risco de fraude por sequestro de conta (Account Takeover) ou cartão clonado.
-- ------------------------------------------------------------
SELECT 
    id_transacao,
    data_transacao,
    id_cliente,
    valor,
    pais_transacao,
    pais_cadastro,
    status
FROM transacoes
WHERE pais_transacao <> pais_cadastro
  AND valor > 3000.00
ORDER BY valor DESC;

-- ------------------------------------------------------------
-- REGRA 3: RESUMO DE CONVERSÃO E TAXA DE RECUSA OPERACIONAL
-- Lógica de Negócio: Acompanhamento de volumetria por status para balancear 
-- a fricção de segurança com a aprovação de bons clientes.
-- ------------------------------------------------------------
SELECT 
    status,
    COUNT(*) AS total_transacoes,
    ROUND(SUM(valor), 2) AS volume_financeiro,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM transacoes), 2) AS percentual_quantidade
FROM transacoes
GROUP BY status;