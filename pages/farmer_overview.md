<div style="position: relative">
<div style="display: flex; align-items: center; gap: 16px; position:fixed;top:0;width:100%;margin-top:6.6vh;z-index:1000;background:white;padding-bottom:0.35rem">
  <img 
    src="https://globalgreengroup.com/wp-content/uploads/2015/07/logo.png" 
    alt="Vipin" 
    style="width: 150px; height: auto;">
  <h1 style="font-weight: bold; font-size: 30px; margin: 0;">Farmer Profile Overview</h1>
  <h2 style="font-size: 12px; margin: 0">Data: May 2016 - July 2023</h2>
</div>
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
  value="FARMERS VKP"
  title="🏭Farmer VKP"
  fmt="none"
/>
<BigValue 
  data={KPI2} 
  value="FARMERS OBL"
  title="🏗️Farmer OBL"
  fmt="none"
/>

</center>

<BarChart 
    data={farmerbymaterialgroup}
    title="FARMERS BY MATERIAL GROUP"
    x="cycle"
    y="farmer_count"
    series="material_group"
    type="stacked100"
    swapXY={true}
    sort="cycle"
    lables=true
/>


<BarChart 
    data={farmerbyholding}
    title="FARMERS BY HOLDING AREA"
    x=cycle
    y=farmer_count
    series="holding category"
    type=grouped
    sort="cycle"
    colorPalette={[
    '#FFC4A3', // Soft Peach
    '#E8A990', // Muted Coral
    '#D39B85' // Muted Sunflower Yellow
]}
/>

<BarChart 
    data={farmerbystates}
    title="FARMERS BY STATE"
    x=states
    y=farmer_count
    series="cycle"
    type=grouped
    sort="cycle"
    colorPalette={[
        '#FFE7C2', // Very Light Amber
    '#FFD9A1', // Light Amber
    '#FFCA80', // Softer Amber
    '#FFBB60', // Medium Amber
    '#FFAC40', // Slightly Darker Amber
    '#FF9D20', // Rich Amber
    '#FF8E00', // Vibrant Amber
    '#FF8000'  // Dark Amber (deepest tone)
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
SELECT COUNT(f.farmer_id) AS "FARMERS VKP"  -- Count the number of rows
FROM Farmers f
JOIN Location l  -- Join with the Location table
  ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
WHERE f."material_group" IS NOT NULL  -- Exclude NULL values
  AND f."material_group" NOT IN ('OTHERS', 'REDPAPRIK', 'JALAPENO')  -- Exclude specific material groups
  AND f.factory = 'VKP'  -- Filter for factory = 'VKP'
  AND f.cycle LIKE '${inputs.cycle.value}'  -- Filter by cycle input
  AND f.season LIKE '${inputs.season.value}'  -- Filter by season input
  AND l.states LIKE '${inputs.states.value}'
  AND f.material_group like '${inputs.material_group.value}';  -- Filter by state input
```
```sql KPI2
SELECT COUNT(f.farmer_id) AS "FARMERS OBL"  -- Count the number of rows
FROM Farmers f
JOIN Location l  -- Join with the Location table
  ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
WHERE f."material_group" IS NOT NULL  -- Exclude NULL values
  AND f."material_group" NOT IN ('OTHERS', 'REDPAPRIK', 'JALAPENO')  -- Exclude specific material groups
  AND f.factory = 'OBL'  -- Filter for factory = 'OBL'
  AND f.cycle LIKE '${inputs.cycle.value}'  -- Filter by cycle input
  AND f.season LIKE '${inputs.season.value}'  -- Filter by season input
  AND l.states LIKE '${inputs.states.value}'
  AND f.material_group like '${inputs.material_group.value}';  -- Filter by state input from Location table
```
```sql farmerbyholding
    select "holding category","cycle",
            COUNT(f.farmer_ID) AS farmer_count
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
            COUNT(f.farmer_ID) AS farmer_count
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
            COUNT(f.farmer_ID) AS farmer_count
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
