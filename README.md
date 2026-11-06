
# 🛡️ Sistema de Detecção Pró-Ativa de Fraudes e Prevenção de Chargebacks

## 📌 Sobre o Projeto
Este projeto foi desenvolvido com foco na **mitigação pró-ativa de riscos financeiros** em operações de pagamento eletrônico e e-commerce. 

Utilizando a visão estratégica adquirida na gestão de **pós-fraude (análise regressiva de chargebacks e contestação de controvérsias)**, o projeto combina regras analíticas em SQL, visualização executiva e um **pipeline de Machine Learning em Python** para identificar comportamentos maliciosos e antecipar o risco antes da aprovação final da transação.

---

## 💡 Regras de Negócio e Lógica Investigativa

1. **Varredura de *Card Testing* (Ataque por Robôs):**
   - *O Problema:* Golpistas testam listas de cartões vazados fazendo pequenas compras em sequência.
   - *A Solução SQL:* Identificação de IPs e IDs de clientes com rajadas de transações em intervalos curtos e múltiplos cartões.
   
2. **Análise de Divergência Geográfica (Alto Valor):**
   - *O Problema:* Transações de alto valor originadas em locais divergentes do cadastro principal do titular possuem alta correlação com fraudes de *Account Takeover*.
   - *A Solução SQL:* Filtragem condicional apontando transações acima de limites de risco realizadas fora do país de origem do cliente para quarentena/análise manual.

3. **Monitoramento de KPIs Operacionais:**
   - *O Problema:* Regras antifraude excessivamente rígidas podem aumentar os falsos-positivos e barrar bons clientes.
   - *A Solução SQL:* Agrupamento volumétrico e financeiro por status de transação para gestão da taxa de aprovação vs. recusa.

---

## 🤖 Modelo Preditivo de Risco (Machine Learning)
Para evoluir de regras estáticas para uma abordagem preditiva, o projeto conta com um modelo em nuvem utilizando **Python e XGBoost**:
- **Framework & Ferramentas:** `XGBClassifier`, `Scikit-Learn`, `Pandas` e `LabelEncoder`.
- **Ambiente:** Executado de forma escalável em **Kaggle Notebooks**.
- **Objetivo:** Classificar o risco transacional com base em atributos como valor da transação, país de origem e país de cadastro, otimizando a tomada de decisão automatizada.

---

## 🛠️ Tecnologias e Ferramentas
- **SQL:** Agrupamentos, tabelas dinâmicas, filtros temporais e métricas agregadas.
- **Python / Machine Learning:** XGBoost, Scikit-Learn e pré-processamento de dados tabulares.
- **Power BI:** Dashboard executivo para monitoramento de KPIs de risco.
- **Kaggle:** Ambiente em nuvem para modelagem e prototipagem.

---

## 🚀 Como Executar o Projeto
1. Faça o download da base de dados `transacoes_antifraude.csv`.
2. Para a análise descritiva, importe a tabela no seu banco de dados SQL e execute as consultas.
3. Para o modelo preditivo, importe o dataset e execute o script em Python/XGBoost (compatível com Kaggle Notebooks).

---
*Projeto desenvolvido por Sarah Paiva | Foco em Prevenção a Fraudes, Chargeback & Ciência de Dados.*