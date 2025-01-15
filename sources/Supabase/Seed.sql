SELECT *
    ,
    CASE
        WHEN "Description" = 'CHANDINI' THEN 'CHANDINI'
        WHEN "Description" = 'SPARTA' THEN 'SPARTA'
        WHEN "Description" = 'EQ SPEED' THEN 'EQ SPEED'
        WHEN "Description" = 'SECURE' THEN 'SECURE'
        WHEN "Description" = 'AJAX' THEN 'AJAX'
        WHEN "Description" = 'AKSHAYA' THEN 'AKSHAYA'
        WHEN "Description" = 'SIRI' THEN 'SIRI'
        WHEN "Description" = 'KALASH' THEN 'KALASH'
        WHEN "Description" = 'ENSURE' THEN 'ENSURE'
        WHEN "Description" = 'KEERTHI' THEN 'KEERTHI'
        WHEN "Description" = 'VERTINA' THEN 'VERTINA'
        WHEN "Description" = 'ROCKET' THEN 'ROCKET'
        WHEN "Description" = 'ANAXO' THEN 'ANAXO'
        WHEN "Description" = ' CHANDINISEED' THEN 'CHANDINI'
        WHEN "Description" = ' GHERKIN - SPARTA SEED - 1000 NOS' THEN 'SPARTA'
        WHEN "Description" = 'EQ SPEED SEED' THEN 'EQ SPEED'
        WHEN "Description" ilike '%SECURE SEED%' THEN 'SECURE'
        WHEN "Description" = ' AJAXSEED' THEN 'AJAX'
        WHEN "Description" = 'GHERKIN SEED KALASH -1000 SDS ( KIMONI 1' THEN 'KALASH'
        WHEN "Description" ilike '%KEERTHI SEED%' THEN 'KEERTHI'
        WHEN "Description" = 'CRISPINA (GHERKIN)' THEN 'CRISPINA'
        WHEN "Description" = 'GHERKIN - EQ SPEED SEED - 1000NOS' THEN 'EQ SPEED'
        WHEN "Description" = 'GHERKIN - VERTINA -SEED - 1000 NOS.' THEN 'VERTINA'
        WHEN "Description" = 'GHERKIN - AJAX SEED - 1000 NOS' THEN 'AJAX'
        WHEN "Description" = 'GHERKIN - CHANDINI SEEDS - 1000 NOS.' THEN 'CHANDINI'
        WHEN "Description" = 'GHERKIN - SEED - ROCKET' THEN 'ROCKET'
        WHEN "Description" = 'GHERKIN - SEED - ANAXO - 1000 NO.' THEN 'ANAXO'
        WHEN "Description" = 'GHERKIN - KALASH SEEDS - 1000 NOS.' THEN 'KALASH'
        WHEN "Description" = 'GHERKIN - ENSURE F1 SEEDS - 1000 NOS' THEN 'ENSURE'
        ELSE "Description"
    END AS "Seeds_Type"
FROM "Farmers_Seed_Issued_Agri_Dashboard_GlobalGreen"
WHERE "Description" NOT IN (
    'AFRICAN TALL MAIZE - 1KG',
    'BABY CORN SEED- - G5414',
    'GH09',
    'JALAPENO - CHILI PEP 4 - 1 KG',
    'JALAPENO - SEEDLING - 1 NO.',
    'JALAPENO SEED (MAXICANA2F1HYBRID)',
    'JALAPENO UMJI PUT - 1 KG',
    'MAIZE SEEDS - 1 KGS'
);