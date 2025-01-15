SELECT * 
FROM "Farmers_detail_Agri_Dashboard_GlobalGreen" 
WHERE "Material_Group" IS NOT NULL 
AND "Material_Group" NOT IN ('OTHERS', 'REDPAPRIK', 'JALAPENO');