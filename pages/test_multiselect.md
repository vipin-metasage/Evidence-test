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


<center>

<Dropdown data={cycle} name=cycle value=cycle title="cycle">
    <DropdownOption value="%" valueLabel="All"/>
</Dropdown>

<Dropdown
  data={states} 
  name="states"
  value=states 
  multiple={true} 
  title="Select States">
  <DropdownOption value=""/>
</Dropdown>

Selected States: {inputs.states.valueLabel}

    <Dropdown name="metric" value="farmer_count" title="Metric">
        <DropdownOption value="farmer_count" valueLabel="Farmer Count" />
        <DropdownOption value="avg_productivity" valueLabel="Average Productivity" />
    </Dropdown>

</center>


```sql states
  select
      states
  from Supabase.Location
  group by states
```
```sql cycle
  select
      cycle
  from Supabase.Farmers
  group by cycle
```

```sql map
select "district","latitude","longitude","states",
            COUNT(f.farmer_ID) AS farmer_count,
            avg(productivity) AS avg_productivity
    from Farmers f
    JOIN Location l  -- Join with the Location table
    ON f.farmer_id = l.farmer_id  -- Join condition on farmer_id
    where l.states IN ${inputs.states.value}
    AND f.cycle LIKE '${inputs.cycle.value}'
    group by "district","states","latitude","longitude"
    order by "states";
```


<BarChart 
    data={map}
    title="FARMERS BY STATE"
    x="states"
    y={inputs.metric.value}
    type="grouped"
    swapXY={true}
    sort="states"
    lables=true
/>

<BubbleMap 
    data={map} 
    lat=latitude 
    long=longitude
    maxSize=15
    size={inputs.metric.value} 
    value={inputs.metric.value}
    height=450
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
