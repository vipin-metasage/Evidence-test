<div style="display: flex; align-items: center; gap: 16px;">
  <img 
    src="https://globalgreengroup.com/wp-content/uploads/2015/07/logo.png" 
    alt="Vipin" 
    style="width: 170px; height: auto;">
  <h1 style="font-weight: bold; font-size: 30px; margin: 0;">Productivity Overview</h1>
  <h2 style="font-size: 10px; margin: 0">Data: May 2016 - July 2023</h2>
</div>

<center>

<Dropdown data={cycle} name=cycle value=cycle title="Date">
    <DropdownOption value="%" valueLabel="All"/>
</Dropdown>

<Dropdown data={states} name=states value=states title="States">
    <DropdownOption value="%" valueLabel="All"/>
</Dropdown>

<Dropdown data={factory} name=factory value=factory title="Factory">
    <DropdownOption value="%" valueLabel="All"/>
</Dropdown>

<Dropdown data={season} name=season value=season title="Season">
    <DropdownOption value="%" valueLabel="All"/>
</Dropdown>

<Dropdown data={material_group} name=material_group value=material_group title="Material Group">
    <DropdownOption value="%" valueLabel="All"/>
</Dropdown>

</center>


<center>

<BigValue 
  data={KPI1} 
  value="AVERAGE PRODUCTIVITY"
  title="📊AVG PRODUCTIVITY"
  fmt="none"
/>
<BigValue 
  data={KPI2} 
  value="AVERAGE PRODUCTIVITY(2023-24)"
  title="📈AVG PRODUCTIVITY(2023-24)"
  fmt="none"
/>

</center>


<BarChart 
    data={farmerbymaterialgroup}
    title="PRODUCTIVITY BY MATERIAL GROUP"
    x="material_group"
    y="avg_productivity"
    series="cycle"
    type="grouped"
    sort="cycle"
    lables=true
/>


<BarChart 
    data={farmerbyholding}
    title="PRODUCTIVITY BY HOLDING AREA"
    x=cycle
    y=avg_productivity
    series="holding category"
    type=grouped
    sort="cycle"
    colorPalette={[
    '#F4A261', // Warm Apricot
    '#E76F51', // Soft Coral
    '#F4D06F'  // Muted Sunflower Yellow
]}
/>

<BarChart 
    data={farmerbystates}
    title="PRODUCTIVITY BY STATE"
    x=states
    y=avg_productivity
    series="cycle"
    type=grouped
    sort="cycle"
    colorPalette={[
        '#ffa600',
        '#58508d',
        '#ff6361',
        '#bc5090',
        ]}
/>


**<span style="font-size: smaller;">Note:</span>** <span style="font-size: smaller;">Farmers with sowing areas less than *0.61 acre* are **Small**, between *0.61 and 0.95 acre* are **Medium**, and larger than *0.95 acre* are **Large**.</span>


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
```sql material_group
  select
      "material_group"
  from Supabase.Farmers
  group by "material_group"
```

```sql KPI1
SELECT avg(productivity) AS "AVERAGE PRODUCTIVITY" 
FROM Farmers f
JOIN Location l  -- Join with the Location table
  ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
WHERE f.factory LIKE '${inputs.factory.value}' 
  AND f.cycle LIKE '${inputs.cycle.value}'  
  AND f.season LIKE '${inputs.season.value}'  -- Filter by season input
  AND l.states LIKE '${inputs.states.value}'
  AND f.material_group like '${inputs.material_group.value}';  -- Filter by state input
```
```sql KPI2
SELECT avg(productivity) AS "AVERAGE PRODUCTIVITY(2023-24)" 
FROM Farmers f
JOIN Location l  -- Join with the Location table
  ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
WHERE f.cycle = '2023-24' 
  AND f.factory LIKE '${inputs.factory.value}'  
  AND f.season LIKE '${inputs.season.value}'  -- Filter by season input
  AND l.states LIKE '${inputs.states.value}'
  AND f.material_group like '${inputs.material_group.value}';  -- Filter by state input from Location table
```

```sql farmerbyholding
    select "holding category","cycle",
            avg(productivity) AS "avg_productivity"
    from Farmers f
    JOIN Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
    where factory LIKE '${inputs.factory.value}'
    AND cycle LIKE '${inputs.cycle.value}'
    AND season LIKE '${inputs.season.value}'
    AND l.states LIKE '${inputs.states.value}'
    AND f.material_group like '${inputs.material_group.value}'
    group by "holding category","cycle"
    order by "cycle";
```
```sql farmerbystates
select "states","cycle",
            avg(productivity) AS "avg_productivity"
    from Farmers f
    JOIN Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
    where factory LIKE '${inputs.factory.value}'
    AND cycle LIKE '${inputs.cycle.value}'
    AND season LIKE '${inputs.season.value}'
    AND l.states LIKE '${inputs.states.value}'
    AND f.material_group like '${inputs.material_group.value}'
    group by "states","cycle"
    order by "cycle";
```


```sql farmerbymaterialgroup
select "material_group","cycle",
            avg(productivity) AS "avg_productivity"
    from Farmers f
    JOIN Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
    where factory LIKE '${inputs.factory.value}'
    AND cycle LIKE '${inputs.cycle.value}'
    AND season LIKE '${inputs.season.value}'
    AND material_group LIKE '${inputs.material_group.value}'
    AND l.states LIKE '${inputs.states.value}'
    group by "material_group","cycle"
    order by "cycle";
```