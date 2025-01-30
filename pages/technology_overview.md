<div style="position: relative">
<div style="display: flex; align-items: center; gap: 16px; position:fixed;top:0;width:100%;margin-top:6.6vh;z-index:1000;background:white;padding-bottom:0.35rem">
  <img 
    src="https://globalgreengroup.com/wp-content/uploads/2015/07/logo.png" 
    alt="Vipin" 
    style="width: 150px; height: auto;">
  <h1 style="font-weight: bold; font-size: 30px; margin: 0;">Technology Overview</h1>
  <h2 style="font-size: 10px; margin: 0">Data: May 2016 - July 2023</h2>
</div>
</div>

<style>
    .custom-flex {
        display: flex;
        gap: 35px; /* Adjust this value to control spacing between items */
        margin-bottom: 1px; /* Adjust this value to control spacing between rows */
    }
    .custom-flex > * {
        flex: 1; /* Ensures equal width for all items */
    }
</style>

<div class="custom-flex">
    <Dropdown data={cycle} name=cycle value=cycle title="Date">
        <DropdownOption value="%" valueLabel="All"/>
    </Dropdown>

      <Dropdown data={seeds_type} name=seeds_type value=seeds_type title="Seed Type">
        <DropdownOption value="%" valueLabel="All"/>
    </Dropdown>

    <Dropdown data={factory} name=factory value=factory title="Factory">
        <DropdownOption value="%" valueLabel="All"/>
    </Dropdown>

  
</div>

<div class="custom-flex">
    <Dropdown data={states} name=states value=states title="States">
        <DropdownOption value="%" valueLabel="All"/>
    </Dropdown>
    <Dropdown data={season} name=season value=season title="Season">
        <DropdownOption value="%" valueLabel="All"/>
    </Dropdown>

    <Dropdown data={material_group} name=material_group value=material_group title="Material Group">
        <DropdownOption value="%" valueLabel="All"/>
    </Dropdown>

</div>

<ButtonGroup name=matric display=tabs>
    <ButtonGroupItem valueLabel="Farmers" value="FARMERS" default />
    <ButtonGroupItem valueLabel="Productivity" value="PRODUCTIVITY" />
</ButtonGroup>

<ButtonGroup name=tech display=tabs>
    <ButtonGroupItem valueLabel="Drip" value="irrigation_facility" default />
    <ButtonGroupItem valueLabel="Mulching" value="mulching_sheet" />
    <ButtonGroupItem valueLabel="Treselling" value="treselling" />
</ButtonGroup>

```sql techbystates
SELECT  
    l.states,
    CASE 
        WHEN '${inputs.tech}' = 'irrigation_facility' THEN t.irrigation_facility
        WHEN '${inputs.tech}' = 'mulching_sheet' THEN t.mulching_sheet
        WHEN '${inputs.tech}' = 'treselling' THEN t.treselling
        ELSE NULL
    END AS "TECHNOLOGY",
    AVG(f.productivity) AS "PRODUCTIVITY",
    COUNT(f.farmer_ID) AS FARMERS
FROM  Farmers f
JOIN 
    Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
JOIN 
    Seed s  -- Join with the Seed table
    ON f.farmer_id = s.farmer_id  -- Join condition on farmer_id
JOIN 
    Technology t  -- Join with the Seed table
    ON f.farmer_id = t.farmer_id  -- Join condition on farmer_id
WHERE s.seeds_type LIKE '${inputs.seeds_type.value}'
  AND s.seeds_type NOT IN ('ANAXO', 'ROCKET', 'KALASH', 'VERTINA', 'ENSURE')
  AND f.material_group LIKE '${inputs.material_group.value}'
  AND factory LIKE '${inputs.factory.value}'
  AND cycle LIKE '${inputs.cycle.value}'
  AND season LIKE '${inputs.season.value}'
  AND l.states LIKE '${inputs.states.value}'
GROUP BY l.states,TECHNOLOGY
ORDER BY l.states;
```
```sql techbyholding
SELECT 
    f."holding category",
    CASE 
        WHEN '${inputs.tech}' = 'irrigation_facility' THEN t.irrigation_facility
        WHEN '${inputs.tech}' = 'mulching_sheet' THEN t.mulching_sheet
        WHEN '${inputs.tech}' = 'treselling' THEN t.treselling
        ELSE NULL
    END AS "TECHNOLOGY",
    AVG(f.productivity) AS "PRODUCTIVITY",
    COUNT(f.farmer_ID) AS FARMERS

FROM  Farmers f
JOIN 
    Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
JOIN 
    Seed s  -- Join with the Seed table
    ON f.farmer_id = s.farmer_id  -- Join condition on farmer_id
JOIN 
    Technology t  -- Join with the Seed table
    ON f.farmer_id = t.farmer_id  -- Join condition on farmer_id
WHERE s.seeds_type LIKE '${inputs.seeds_type.value}'
  AND s.seeds_type NOT IN ('ANAXO', 'ROCKET', 'KALASH', 'VERTINA', 'ENSURE') 
  AND f.material_group LIKE '${inputs.material_group.value}'
  AND factory LIKE '${inputs.factory.value}'
  AND cycle LIKE '${inputs.cycle.value}'
  AND season LIKE '${inputs.season.value}'
  AND l.states LIKE '${inputs.states.value}'
GROUP BY TECHNOLOGY, "holding category"
ORDER BY "holding category";
```

<Grid cols=2>

<BarChart 
    data={techbystates}
    title="{inputs.matric} BY STATE"
    x="states"
    y="{inputs.matric}"
    series=TECHNOLOGY
    sort=TECHNOLOGY
/>


<BarChart 
    data={techbyholding}
    title="{inputs.matric} BY HOLDING AREA"
    x="holding category"
    y="{inputs.matric}"
    series=TECHNOLOGY
    type="grouped"
    sort=TECHNOLOGY
/>
</Grid>

```sql techbymaterial
SELECT 
   f.material_group,
    CASE 
        WHEN '${inputs.tech}' = 'irrigation_facility' THEN t.irrigation_facility
        WHEN '${inputs.tech}' = 'mulching_sheet' THEN t.mulching_sheet
        WHEN '${inputs.tech}' = 'treselling' THEN t.treselling
        ELSE NULL
    END AS "TECHNOLOGY",
    AVG(f.productivity) AS "PRODUCTIVITY",
    COUNT(f.farmer_ID) AS FARMERS
FROM  Farmers f
JOIN 
    Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
JOIN 
    Seed s  -- Join with the Seed table
    ON f.farmer_id = s.farmer_id  -- Join condition on farmer_id
JOIN 
    Technology t  -- Join with the Seed table
    ON f.farmer_id = t.farmer_id  -- Join condition on farmer_id
WHERE s.seeds_type LIKE '${inputs.seeds_type.value}'
  AND s.seeds_type NOT IN ('ANAXO', 'ROCKET', 'KALASH', 'VERTINA', 'ENSURE') 
  AND f.material_group LIKE '${inputs.material_group.value}'
  AND factory LIKE '${inputs.factory.value}'
  AND cycle LIKE '${inputs.cycle.value}'
  AND season LIKE '${inputs.season.value}'
  AND l.states LIKE '${inputs.states.value}'
GROUP BY TECHNOLOGY, f.material_group
ORDER BY f.material_group;
```


<BarChart 
    data={techbymaterial}
    title="{inputs.matric} BY MATERIAL GROUP"
    x="material_group"
    y="{inputs.matric}"
    series=TECHNOLOGY
    type="grouped"
    sort=TECHNOLOGY
/>

<BarChart 
    data={techbycycle}
    title="{inputs.matric} BY SEEDS OVERTIME"
    x="TECHNOLOGY"
    y="{inputs.matric}"
    series="cycle"
    type="grouped"
    sort="cycle"
/>

**<span style="font-size: smaller;">Note:</span>** <span style="font-size: smaller;">Farmers with sowing areas less than *0.61 acre* are **Small**, between *0.61 and 0.95 acre* are **Medium**, and larger than *0.95 acre* are **Large**.</span>

```sql techbycycle
SELECT 
   f.cycle,
    CASE 
        WHEN '${inputs.tech}' = 'irrigation_facility' THEN t.irrigation_facility
        WHEN '${inputs.tech}' = 'mulching_sheet' THEN t.mulching_sheet
        WHEN '${inputs.tech}' = 'treselling' THEN t.treselling
        ELSE NULL
    END AS "TECHNOLOGY",
    AVG(f.productivity) AS "PRODUCTIVITY",
    COUNT(f.farmer_ID) AS FARMERS
FROM  Farmers f
JOIN 
    Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
JOIN 
    Seed s  -- Join with the Seed table
    ON f.farmer_id = s.farmer_id  -- Join condition on farmer_id
JOIN 
    Technology t  -- Join with the Seed table
    ON f.farmer_id = t.farmer_id  -- Join condition on farmer_id
WHERE s.seeds_type LIKE '${inputs.seeds_type.value}'
  AND s.seeds_type NOT IN ('ANAXO', 'ROCKET', 'KALASH', 'VERTINA', 'ENSURE') 
  AND f.material_group LIKE '${inputs.material_group.value}'
  AND factory LIKE '${inputs.factory.value}'
  AND cycle LIKE '${inputs.cycle.value}'
  AND season LIKE '${inputs.season.value}'
  AND l.states LIKE '${inputs.states.value}'
GROUP BY TECHNOLOGY, f.cycle
ORDER BY f.cycle;
```






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

```sql factory
  select
      factory
  from Supabase.Farmers
  group by factory
```
```sql cycle
  select
      cycle
  from Supabase.Farmers
  group by cycle
```
```sql season
  select
      season
  from Supabase.Farmers
  group by season
```
```sql states
  select
      states
  from Supabase.Location
  group by states
```