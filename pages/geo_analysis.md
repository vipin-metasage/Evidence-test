<div style="position: relative">
<div style="display: flex; align-items: center; gap: 16px; position:fixed;top:0;width:100%;margin-top:6.6vh;z-index:1000;background:white;padding-bottom:0.35rem">
  <img 
    src="https://globalgreengroup.com/wp-content/uploads/2015/07/logo.png" 
    alt="Vipin" 
    style="width: 150px; height: auto;">
  <h1 style="font-weight: bold; font-size: 30px; margin: 0;">Geo Analysis</h1>
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


<Dropdown name="metric" value="farmer_count" title="Metric">
        <DropdownOption value="farmer_count" valueLabel="Farmer Count" />
        <DropdownOption value="avg_productivity" valueLabel="Average Productivity" />
</Dropdown>


</center>

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


```sql map
select "district","latitude","longitude","states",
            COUNT(f.farmer_ID) AS farmer_count,
            avg(productivity) AS avg_productivity
    from Farmers f
    JOIN Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
    where f.factory LIKE '${inputs.factory.value}'
    AND f.cycle LIKE '${inputs.cycle.value}'
    AND f.season LIKE '${inputs.season.value}'
    AND f.material_group LIKE '${inputs.material_group.value}'
    AND l.states LIKE '${inputs.states.value}'
    group by "district","states","latitude","longitude"
    order by "states";
```
<div id="map" style="width: 100%; height: 100%; position: absolute;"></div>
<div style="position: absolute; top: 187px; left: 37.5%; transform: translateX(-50%); z-index: 1000; border-radius: 1px;">
    
</div>

<BubbleMap 
    data={map} 
    lat=latitude 
    long=longitude
    maxSize=15
    size={inputs.metric.value} 
    value={inputs.metric.value}
    title={`${inputs.metric.label} By State`}
    height=370
    borderWidth=0.3
    borderColor=black
    pointName=district
    colorPalette={['yellow','orange','red','darkred']}
    tooltip={[
        {id: 'district', showColumnName: false, valueClass: 'text-l font-semibold'},
        {id: 'farmer_count', fieldClass: 'text-[grey]', valueClass: 'text-[green]'},
        {id: 'avg_productivity', fieldClass: 'text-[grey]', valueClass: 'text-[green]'}
    ]}
/>

<BarChart 
    data={map}
    title={`${inputs.metric.label} By State`}
    x="states"
    y={inputs.metric.value}
    type="grouped"
    swapXY={true}
    sort="states"
    lables=true
/>
