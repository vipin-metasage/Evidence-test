<div style="position: relative">
<div style="display: flex; align-items: center; gap: 16px; position:fixed;top:0;width:100%;margin-top:6.6vh;z-index:1000;background:white;padding-bottom:0.35rem">
  <img 
    src="https://globalgreengroup.com/wp-content/uploads/2015/07/logo.png" 
    alt="Vipin" 
    style="width: 150px; height: auto;">
  <h1 style="font-weight: bold; font-size: 30px; margin: 0;">Geo Analysis</h1>
  <h2 style="font-size: 10px; margin: 0">Data: May 2016 - July 2023</h2>
</div>
</div>

<Dropdown data={material_group} name=material_group value=material_group title="Material Group">
    <DropdownOption value="%" valueLabel="All"/>
</Dropdown>

<Dropdown data={seeds_type} name=seeds_type value=seeds_type title="Seed Type">
    <DropdownOption value="%" valueLabel="All"/>
</Dropdown>

<ButtonGroup name=matric display=tabs>
    <ButtonGroupItem valueLabel="Farmers" value="farmer_count" />
    <ButtonGroupItem valueLabel="Productivity" value="avg_productivity" />
</ButtonGroup>


```sql farmerbystates
SELECT 
    s.seeds_type, 
    l.states,
     
    AVG(f.productivity) AS "avg_productivity",
    COUNT(f.farmer_ID) AS farmer_count
FROM  Farmers f
JOIN 
    Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
JOIN 
    Seed s  -- Join with the Seed table
    ON f.farmer_id = s.farmer_id  -- Join condition on farmer_id
WHERE s.seeds_type LIKE '${inputs.seeds_type.value}' 
  AND f.material_group LIKE '${inputs.material_group.value}'  
GROUP BY s.seeds_type, l.states
ORDER BY s.seeds_type;
```
```sql title_
SELECT 
    CASE 
        WHEN {inputs.matric} = "farmer_count" THEN "FARMERS"
        WHEN {inputs.matric} = "avg_productivity" THEN "PRODUCTIVITY"
        ELSE "NO"
    END
```
<BarChart 
    data={farmerbystates}
    title="{title_} BY STATE"
    x="states"
    y="{inputs.matric}"
    series="seeds_type"
    type="grouped"
    sort="seeds_type"
/>

```sql farmerbyholding
SELECT 
    s.seeds_type, 
    "holding category",
     
    AVG(f.productivity) AS "avg_productivity",
    COUNT(f.farmer_ID) AS farmer_count
FROM  Farmers f
JOIN 
    Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
JOIN 
    Seed s  -- Join with the Seed table
    ON f.farmer_id = s.farmer_id  -- Join condition on farmer_id
WHERE s.seeds_type LIKE '${inputs.seeds_type.value}' 
  AND f.material_group LIKE '${inputs.material_group.value}'  
GROUP BY s.seeds_type, "holding category"
ORDER BY s.seeds_type;
```
<BarChart 
    data={farmerbyholding}
    title="{inputs.matric} BY HOLDING AREA"
    x="holding category"
    y="{inputs.matric}"
    series="seeds_type"
    type="grouped"
    sort="holding category"
/>

```sql farmerbycycle
SELECT 
    s.seeds_type, 
    f.cycle,
     
    AVG(f.productivity) AS "avg_productivity",
    COUNT(f.farmer_ID) AS farmer_count
FROM  Farmers f
JOIN 
    Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
JOIN 
    Seed s  -- Join with the Seed table
    ON f.farmer_id = s.farmer_id  -- Join condition on farmer_id
WHERE s.seeds_type LIKE '${inputs.seeds_type.value}' 
  AND f.material_group LIKE '${inputs.material_group.value}'  
GROUP BY s.seeds_type, f.cycle
ORDER BY f.cycle;
```

<BarChart 
    data={farmerbycycle}
    title="{inputs.matric} BY SEEDS OVERTIME"
    x="seeds_type"
    y="{inputs.matric}"
    series="cycle"
    type="grouped"
    sort="cycle"
/>





```sql material_group
  select
      "material_group"
  from Supabase.Farmers
  group by "material_group"
```
```sql seeds_type
  select
      "seeds_type"
  from Supabase.Seed
  group by "seeds_type"
```