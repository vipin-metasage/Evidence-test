<div style="position: relative">
<div style="display: flex; align-items: center; gap: 16px; position:fixed;top:0;width:100%;margin-top:6.6vh;z-index:1000;background:white;padding-bottom:0.35rem">
  <img 
    src="https://globalgreengroup.com/wp-content/uploads/2015/07/logo.png" 
    alt="Vipin" 
    style="width: 150px; height: auto;">
  <h1 style="font-weight: bold; font-size: 30px; margin: 0;">Seeds Analysis</h1>
  <h2 style="font-size: 12px; margin: 0">Data: May 2016 - July 2023</h2>
</div>
</div>


<style>
    .custom-flex {
        display: flex;
        gap: 1px; /* Adjust this value to control spacing between items */
        margin-bottom: 2px; /* Adjust this value to control spacing between rows */
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
    <ButtonGroupItem valueLabel="Avg Seeds Used" value="Avg Seeds Used" />
</ButtonGroup>


```sql farmerbystates
SELECT 
    s.seeds_type, 
    l.states,
    AVG(f.productivity) AS "PRODUCTIVITY",
    COUNT(f.farmer_ID) AS FARMERS,
    AVG(CAST(REPLACE(quantity, ',', '') AS DECIMAL)) AS "Avg Seeds Used"

FROM  Farmers f
JOIN 
    Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
JOIN 
    Seed s  -- Join with the Seed table
    ON f.farmer_id = s.farmer_id  -- Join condition on farmer_id
WHERE s.seeds_type LIKE '${inputs.seeds_type.value}'
  AND s.seeds_type NOT IN ('ANAXO', 'ROCKET', 'KALASH', 'VERTINA', 'ENSURE')
  AND f.material_group LIKE '${inputs.material_group.value}'
  AND factory LIKE '${inputs.factory.value}'
  AND cycle LIKE '${inputs.cycle.value}'
  AND season LIKE '${inputs.season.value}'
  AND l.states LIKE '${inputs.states.value}'
GROUP BY s.seeds_type, l.states
ORDER BY s.seeds_type;
```

    <BarChart 
    data={farmerbystates}
    title="{inputs.matric} BY STATE"
    x="states"
    y="{inputs.matric}"
    swapXY=true
    series="seeds_type"
    sort="seeds_type"
    />


    <BarChart 
    data={farmerbyholding}
    title="{inputs.matric} BY HOLDING AREA"
    x="holding category"
    y="{inputs.matric}"
    series="seeds_type"
    type="grouped"
    sort="holding category"
    />

```sql farmerbyholding
SELECT 
    s.seeds_type, 
    "holding category",
    AVG(f.productivity) AS "PRODUCTIVITY",
    COUNT(f.farmer_ID) AS FARMERS,
    AVG(CAST(REPLACE(quantity, ',', '') AS DECIMAL)) AS "Avg Seeds Used"

FROM  Farmers f
JOIN 
    Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
JOIN 
    Seed s  -- Join with the Seed table
    ON f.farmer_id = s.farmer_id  -- Join condition on farmer_id
WHERE s.seeds_type LIKE '${inputs.seeds_type.value}'
  AND s.seeds_type NOT IN ('ANAXO', 'ROCKET', 'KALASH', 'VERTINA', 'ENSURE') 
  AND f.material_group LIKE '${inputs.material_group.value}'
  AND factory LIKE '${inputs.factory.value}'
  AND cycle LIKE '${inputs.cycle.value}'
  AND season LIKE '${inputs.season.value}'
  AND l.states LIKE '${inputs.states.value}'
GROUP BY s.seeds_type, "holding category"
ORDER BY s.seeds_type;
```

```sql farmerbycycle
SELECT 
    s.seeds_type, 
    f.cycle,
    AVG(f.productivity) AS "PRODUCTIVITY",
    COUNT(f.farmer_ID) AS FARMERS,
    AVG(CAST(REPLACE(quantity, ',', '') AS DECIMAL)) AS "Avg Seeds Used"

FROM  Farmers f
JOIN 
    Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
JOIN 
    Seed s  -- Join with the Seed table
    ON f.farmer_id = s.farmer_id  -- Join condition on farmer_id
WHERE s.seeds_type LIKE '${inputs.seeds_type.value}'
  AND s.seeds_type NOT IN ('ANAXO', 'ROCKET', 'KALASH', 'VERTINA', 'ENSURE') 
  AND f.material_group LIKE '${inputs.material_group.value}'
  AND factory LIKE '${inputs.factory.value}'
  AND cycle LIKE '${inputs.cycle.value}'
  AND season LIKE '${inputs.season.value}'
  AND l.states LIKE '${inputs.states.value}'
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