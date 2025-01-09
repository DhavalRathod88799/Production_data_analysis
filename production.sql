USE manufacturing_analysis;
SELECT * FROM production;
 Analysis
	1.	Identify factors affecting the number of units produced per shift.;
    SELECT Shift,Product_Type,AVG(ProductionTimeHours) AS Avg_Production_Time_Hours,
    AVG(Defects) AS Avg_Defects,
    AVG(Down_TimeHours) AS Avg_Down_Time_Hours,
    AVG(Maintenance_Hours) AS Avg_Maintenance_Hours,
    AVG(Materialcostperunit) AS Avg_Material_Cost_Per_Unit,
    AVG(Labour_Cost_Per_Hour) AS Avg_Labour_Cost_Per_Hour,
    AVG(Energy_Consumption_kWh) AS Avg_Energy_Consumption_kWh,
    AVG(Average_Tmperature_C) AS Avg_Temperature,
    AVG(Average_Humidity_Percent) AS Avg_Humidity,
    COUNT(*) AS Record_Count
    FROM production GROUP BY Shift,Product_Type,Machine_Id;
    The number of units produced per shift can be affected by several factors, including production time, defects, downtime, maintenance hours, material and labor costs, energy consumption, and environmental conditions like temperature and humidity. Analyzing these factors across different shifts, product types, and machines can help identify areas for improvement in production efficiency.
	2.	Analyze the relationship between machine type and production efficiency.;
    SELECT Machine_ID,AVG(ProductionTimeHours) AS Avg_Production_Time_Hours,
    AVG(Units_Produced / NULLIF(ProductionTimeHours, 0)) AS Avg_Efficiency,
    MAX(Defects) AS Max_Defects,
    AVG(Down_TimeHours) AS Avg_Down_Time_Hours,
    AVG(Maintenance_Hours) AS Avg_Maintenance_Hours,
    AVG(Materialcostperunit) AS Avg_Material_Cost_Per_Unit,
    AVG(Labour_Cost_Per_Hour) AS Avg_Labour_Cost_Per_Hour,
    AVG(Energy_Consumption_kWh) AS Avg_Energy_Consumption_kWh,
    AVG(Average_Tmperature_C) AS Avg_Temperature,
    AVG(Average_Humidity_Percent) AS Avg_Humidity FROM production GROUP BY Machine_ID ORDER BY Max_Defects DESC;
    For the specific query regarding machine type and production efficiency, the analysis reveals key performance indicators for each machine, including production efficiency, defect rates, downtime, maintenance requirements, operating costs, and environmental sensitivities. By identifying top-performing and underperforming machines, this analysis enables data-driven decisions on maintenance, resource allocation, process improvement, and machine replacement, ultimately optimizing production efficiency and minimizing costs.
	3.	Determine the impact of operator count on production time.;
SELECT 
    Operator_Count, 
    AVG(ProductionTimeHours) AS Avg_Production_Time 
FROM 
    production 
GROUP BY 
	4.	Predict units produced based on input variables such as shift, machine ID, and product type.;
    SELECT Shift,Machine_ID,Product_Type,Units_Produced FROM production GROUP BY Product_Type,Shift,Machine_ID,Units_Produced ORDER BY Units_Produced DESC,Machine_ID DESC;
In this query shift and machine_id 2,3,4,5,6,7,8,9,10,12,13,14,,15,,18 and 20 in diffrent Shifts producing highest 199 unites in all the Product types
	5.	Analyze trends in material cost per unit across different product types.;
    SELECT Product_Type,AVG(Materialcostperunit) AS avgmaterialcostperunit,MAX(Materialcostperunit) AS maxmaterialcostperunit,MIN(Materialcostperunit) AS minmaterialcostperunit FROM production GROUP BY Product_Type ORDER BY avgmaterialcostperunit DESC;
    The provided SQL query analyzes material cost trends across different product types. It calculates the average, maximum, and minimum material cost per unit for each Product_Type and orders the results by descending average material cost. This analysis helps identify product types with the highest and lowest material costs, highlighting potential areas for cost optimization. Product type furniture ,Electronics and Automotive With highest 31.19,30.85,30.11 average material cost per unit and also with highest Material cost per unit with 60,60,65 is making costly production and also defects the cost efficiency
	
    6.	Evaluate the relationship between labor costs and defects.;
    SELECT Product_Type,AVG(Labour_Cost_Per_Hour),AVG(Defects) ,COUNT(*) AS total_recods FROM production GROUP BY Product_type;
	6. Labor Costs and Defects: This query investigates the potential correlation between labor costs and defect rates. A average labour cost and average defects are almost same in all product types but appliancec have highest record .

	7.	Identify energy consumption patterns and suggest cost-saving measuresl;
    SELECT Product_Type,SUM(Energy_Consumption_kWh),AVG(Energy_Consumption_kWh),MAX(Energy_Consumption_kWh),MIN(Energy_Consumption_kWh)FROM production GROUP BY Product_Type;
    7. Energy Consumption Patterns: This query analyzes energy consumption across different product types, identifying high-energy-consuming products. This information can guide energy-saving initiatives, such as process optimization, equipment upgrades, or the implementation of more energy-efficient technologies for specific product lines.

    
	8.	Predict material and labor costs based on production volume.;
    SELECT  Production_Volume_Cubic_Meters,SUM(Units_Produced * Materialcostperunit) AS total_material_cost,SUM(ProductionTimeHours * Labour_Cost_Per_Hour) AS total_labour_cost FROM production GROUP BY Production_Volume_Cubic_Meters ORDER BY Production_Volume_Cubic_Meters;
    8. Material and Labor Costs vs. Production Volume: These queries explore the relationship between production volume and associated costs. Analyzing how material and labor costs change with varying production volumes helps in understanding cost structures and predicting future expenses based on production targets.

    

	9.	Explore factors contributing to the number of d	efects in production.;
    SELECT Product_Type,Machine_ID,Shift,SUM(Defects),AVG(Defects) FROM production GROUP BY Product_type,Machine_ID,Shift ORDER BY SUM(Defects) DESC;
    9. Factors Contributing to Defects: This query identifies specific combinations of product types, machines, and shifts with high defect rates, pinpointing areas for targeted improvement efforts, such as operator training, machine maintenance, or process adjustments.

	10.	Assess the impact of maintenance hours on defect rates.;
    SELECT ROUND(Maintenance_Hours,2) AS Maintenece_range ,COUNT(*) AS Count,SUm(Defects) AS total_defects,AVG(Defects) AS average_defects FROM production GROUP BY Maintenece_range ORDER BY Maintenece_range;
    10. Maintenance Impact on Defects: This query assesses the impact of maintenance hours on defect rates. Regular maintenance is crucial for preventing equipment failures and ensuring consistent product quality. Analyzing this relationship helps determine the optimal maintenance frequency for different machines.

	11.	Build a predictive model to estimate the likelihood of defects in a batch.;
    SELECT Production_ID,CASE WHEN Defects>0 THEN 1 ELSE 0 END AS Defects_present FROM production;
	11. Defect Prediction Model: This query sets the foundation for a predictive model to identify potential defect occurrences. By classifying production batches as "defective" or "non-defective," machine learning models can be trained to predict the likelihood of defects based on various production parameters.

	12.	Identify shifts with the highest defect rates and suggest improvements.;
    SELECT Shift ,MAX(Defects) AS highest_defect_rate FROM production GROUP BY Shift;
    12. Shift-Wise Defect Rates: This query identifies shifts with the highest defect rates. This information can guide scheduling and workforce management decisions, potentially reallocating resources or implementing additional quality checks during high-risk shifts.



	13.	Analyze downtime trends across machines and shifts.;
    SELECT Machine_ID,Shift,ROUND(SUM(Down_timeHours),2) AS total_downtime ,ROUND(AVG(Down_timeHours),2) AS Avg_downtime ,Max(Down_timeHours) AS max_downtime FROM production GROUP BY Machine_ID,Shift ORDER BY Machine_ID;
    13. Downtime Trends: This query analyzes downtime across machines and shifts, identifying areas with significant downtime. This information is crucial for optimizing equipment maintenance schedules, identifying potential root causes of downtime, and implementing preventive measures.

	14.	Correlate rework hours with production time and defects.;
    SELECT Shift,Rework_Hours,ProductionTimeHours,Defects FROM production ORDER BY rework_Hours DESC;
    14. Rework and Production: This query explores the relationship between rework hours, production time, and defects. High rework hours often indicate production inefficiencies and quality issues. Analyzing this data can help identify bottlenecks and improve overall production flow.x

	15.	Predict downtime hours based on maintenance schedules.;
	SELECT Maintenance_Hours, Machine_ID, ProductionTimeHours, Units_Produced, Average_Tmperature_C, Average_Humidity_Percent, Shift, Operator_Count, Down_timeHours FROM production;
    15. Downtime Prediction: This query aims to predict downtime based on factors like maintenance schedules, machine usage, and environmental conditions. Accurate downtime predictions enable proactive maintenance planning and minimize production disruptions.

	16.	Evaluate the efficiency of production shifts.;
    SELECT Shift,ROUND(SUM(Units_Produced)/SUM(ProductionTimeHours),2) production_efficiency,AVG(Units_Produced) average_unitsproduced FROM production GROUP BY Shift;    
    16. Shift Efficiency: This query evaluates the efficiency of different shifts by comparing unit production per hour. This analysis helps optimize shift schedules and resource allocation to maximize output across different shifts.

    

	17.	Explore the relationship between average temperature and energy consumption.;
    SELECT Product_Type,AVG(Average_Tmperature_C),AVG(Energy_Consumption_kWh) FROM production GROUP BY Product_Type;
    17. Temperature and Energy Consumption: This query investigates the relationship between temperature and energy consumption, providing insights into potential energy-saving measures, such as optimizing production schedules based on ambient temperature.

	18.	Assess the impact of humidity on production efficiency.;
    SELECT ROUND(SUM(Units_Produced)/SUM(ProductionTimeHours),2) AS efficiency FROM production ;
    18. Humidity and Production Efficiency: This query explores the impact of humidity on production efficiency. High humidity levels can adversely affect certain production processes, leading to increased downtime, defects, and energy consumption.

	19.	Correlate environmental factors with defect rates.;
    SELECT Defects,Units_Produced,(Defects*100.0/Units_Produced) AS defect_rate,Average_Tmperature_C,Average_Humidity_Percent FROM production;
    19. Environmental Factors and Defects: This query analyzes the correlation between environmental factors (temperature and humidity) and defect rates, providing valuable insights for optimizing production environments.

	20.	Suggest optimized environmental conditions for production.;
    SELECT Product_Type,(Units_Produced/ProductionTimeHours) AS Efficiency ,(Defects*100/Units_Produced) AS Defect_Rate ,(Down_timeHours*100/ProductionTimeHours) AS downtime_percentage ,Average_Tmperature_C,Average_Humidity_Percent FROM production ;
    20. Optimized Environmental Conditions: This query aims to identify optimal environmental conditions for each product type by analyzing the relationship between environmental factors, efficiency, defect rates, and downtime.


	21.	Compare production metrics across machines.;
    SELECT Machine_ID,SUM(Units_Produced) AS total_units,SUM(Defects) AS total_defects,SUM(ProductionTimeHours) AS total_productionhour,SUM(Energy_Consumption_kWh) AS total_energy,SUM(Down_timeHours) AS total_downtime,(SUM(Defects)*100/SUM(Units_Produced)) AS Defect_Rate,(SUM(Down_timeHours)*100/SUM(ProductionTimeHours)) AS downtime_percentage,(SUM(Units_Produced)/SUM( ProductionTimeHours)) AS Units_per_hour FROM production GROUP BY Machine_ID; 
    21. Machine Comparison: This query compares production metrics across different machines, identifying top performers and underperformers. This information is crucial for equipment selection, maintenance prioritization, and overall production optimization.

	22.	Identify underperforming machines based on downtime and maintenance hours.;
    SELECT Machine_ID,SUM(Units_Produced) AS total_units,SUM(Defects) AS total_defects,SUM(ProductionTimeHours) AS total_productionhour,SUM(Energy_Consumption_kWh) AS total_energy,SUM(Down_timeHours) AS total_downtime,(SUM(Defects)*100/SUM(Units_Produced)) AS Defect_Rate,(SUM(Down_timeHours)*100/SUM(ProductionTimeHours)) AS downtime_percentage,(SUM(Units_Produced)/SUM( ProductionTimeHours)) AS Units_per_hour FROM production GROUP BY Machine_ID; 
    22. Underperforming Machines: This query identifies underperforming machines based on downtime and maintenance hours, allowing for targeted maintenance efforts and potential equipment upgrades.

	23.	Predict machine efficiency based on past production data.;
    SELECT Machine_ID,(Units_Produced/ProductionTimeHours) FROM production;
    23. Machine Efficiency Prediction: This query sets the foundation for predicting machine efficiency based on historical production data, which can be used for predictive maintenance and capacity planning.


	24.	Analyze the lifecycle of machines based on maintenance history.;
    SELECT Machine_ID,Date,SUM(Maintenance_Hours) AS total_Maintenance_Hours,SUM(Down_timeHours) AS total_Down_timeHours,AVG(ROUND(SUM(Units_Produced)/SUM(ProductionTimeHours),2)) AS efficiency,COUNT(Maintenance_Hours) AS Maintenance_Hours_count FROM production GROUP BY Machine_ID,YEAR(Date);
    24. Machine Lifecycle Analysis: This query analyzes the lifecycle of machines by tracking maintenance history, downtime, and efficiency over time. This information is valuable for equipment replacement decisions and long-term maintenance planning.


	25.	Compare production output across different shifts.;
    SELECT Shift,ROUND(AVG(ProductionTimeHours),2) AS Avg_Production_Time_Hours,
	SUM(Units_Produced),
    (SUM(Units_Produced)/SUM(ProductionTimeHours)) AS efficiency ,
    COUNT(*) AS Record_Count
    FROM production GROUP BY Shift;
    25. Shift Comparison: This query compares production output, efficiency, and other key metrics across different shifts, providing insights for optimizing shift schedules and resource allocation.

	26.	Identify the most productive shifts for each product type.;
    SELECT Product_Type,Shift,ROUND(AVG(ProductionTimeHours),2) AS Avg_Production_Time_Hours,
	SUM(Units_Produced),
    AVG(Units_Produced/ProductionTimeHours) AS efficiency FROM production GROUP BY Product_type,Shift;
    26. Most Productive Shifts: This query identifies the most productive shifts for each product type, allowing for optimized production scheduling and workforce allocation.

	27.	Assess labor cost variations between shifts.;
    SELECT Shift,AVG(Labour_Cost_Per_Hour),SUM(Labour_Cost_Per_Hour*ProductionTimeHours)total_labour_cost,AVG(ProductionTimeHours) ASavg_labour_cost_per_hour,(SUM(ProductionTimeHours*ProductionTimeHours)/SUM(Units_Produced)) AS labourcostperunit FROM production GROUP BY Shift;
    27. Labor Cost Variations: This query analyzes labor cost variations between shifts, considering factors like labor rates, production time, and output. This information can help optimize labor costs and improve overall shift efficiency.

	28.	Suggest optimized shift allocations to improve productivity.;
    SELECT Shift,SUM(Units_Produced) AS total_units_produced,AVG(Units_Produced/ProductionTimeHours),SUM(Defects)*100/SUM(Units_Produced),AVG(Labour_Cost_Per_Hour) AS Avg_Labor_Cost_Per_Hour,
       (SUM(Labour_Cost_Per_Hour * ProductionTimeHours) / SUM(Units_Produced)) AS Labor_Cost_Per_Unit,
       AVG(Energy_Consumption_kWh / Units_Produced) AS Energy_Cost_Per_Unit,
       SUM(Down_timeHours) AS Total_Downtime
	FROM production GROUP BY Shift,Product_Type;
	28. Shift Optimization: This query provides a comprehensive overview of shift performance, considering factors such as production output, efficiency, defect rates, labor costs, energy consumption, and downtime. This information can be used to optimize shift allocations and improve overall production performance.


	29.	Analyze the correlation between quality check failures and defect rates.;
    SELECT Shift,Product_Type,SUM(Units_Produced) AS total_units_produced,SUM(Defects) AS total_defectd,SUM(Quality_Checks_Failed) AS total_faills,(SUM(Defects)*100/SUM(Units_Produced)) AS defect_rate FROM production GROUP BY Shift,Product_Type;
    29. Quality Check Analysis: This query analyzes the correlation between quality check failures and defect rates, providing insights into the effectiveness of current quality control measures.

	30.	Predict the likelihood of failing quality checks based on production metrics.;
    SELECT Shift,Product_Type,Units_Produced,ProductionTimeHours,Defects,Labour_Cost_Per_Hour,Energy_Consumption_kWh,CASE WHEN Quality_Checks_Failed>0 THEN 1 ELSE 0 END AS Quality_Checks_Failed FROM production;
    30. Quality Check Prediction: This query sets the foundation for a predictive model to estimate the likelihood of quality check failures based on various production parameters.

	31.	Evaluate the effectiveness of quality checks over time.;
    SELECT Date,SUM(Quality_Checks_Failed) AS total_Quality_Checks_Failed ,SUM(defects) AS total_defects,SUM(Units_Produced) AS total_units_produced ,(SUM(Quality_Checks_Failed)*100/SUM(Units_Produced)) AS Quality_Checks_Failed_rate FROM production GROUP BY Date Order BY Date;
    31. Quality Check Effectiveness: This query evaluates the effectiveness of quality checks over time, identifying trends in quality check failures and their impact on overall product quality.

	32.	Explore trends in scrap rates across product types.;
    SELECT Product_Type,MONTH(Date),SUM(Scrap_Rate),SUM(Defects),SUM(Units_Produced),(SUM(Units_Produced)*100/SUM(ProductionTimeHours)) FROM production GROUP BY Product_Type,MONTH(Date) ORDER BY Product_Type,MONTH(Date);
    32. Scrap Rate Trends: This query analyzes scrap rate trends across product types, identifying areas for improvement in material utilization and waste reduction.



	33.	Forecast energy consumption for future production.;
    SELECT Date,SUM(Energy_Consumption_kWh) AS total_energy_consuption,AVG(SUM(Energy_Consumption_kWh)) OVER (ORDER BY Date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS Avg_energy_consuption FROM production Group by Date ORDER BY Date;
    33. Energy Consumption Forecasting: This query forecasts future energy consumption based on historical data, allowing for proactive energy management and cost optimization.

    
	34.	Forecast defect rates based on seasonal patterns.;
    SELECT CASE WHEN MONTH(Date)=(3,4,5) THEN "Spring" WHEN MONTH(Date)=(6,7,8) THEN "Summer" WHEN MONTH(Date)=(9,10,11) THEN "Fall" ELSE "Winter" END AS Season,AVG(SUM(Defects)/SUM(Units_Produced)*100) AS Defect_rate FROM production GROUP BY Season ORDER BY FIELD(Season, 'Spring', 'Summer', 'Fall', 'Winter');
    34. Defect Rate Forecasting: This query forecasts defect rates based on seasonal patterns, enabling proactive quality control measures during periods of higher defect risk.

	35.	Predict labor costs for upcoming shifts.;
    SELECT Date,Shift,SUM(Operator_Count*Labour_Cost_Per_Hour*ProductionTimeHours) AS total_labor_cost FROM production GROUP BY Date,Shift ORDER BY Date,Shift;
    35. Labor Cost Forecasting: This query forecasts labor costs for upcoming shifts based on historical data, enabling better budgeting and workforce planning.


	36.	Identify machines with the highest energy consumption.;
    SELECT Machine_ID ,MAX(Energy_Consumption_kWh) AS highest_energy_consumption FROM production GROUP BY machine_ID ORDER BY highest_energy_consumption DESC;
    36. Machine Energy Consumption: This query identifies machines with the highest energy consumption, allowing for targeted energy-saving measures, such as equipment upgrades or process optimization.

	37.	Explore correlations between production time and energy consumption.;
    SELECT Product_Type,AVG(ProductionTimeHours),AVG(Energy_Consumption_kWh) from production GROUP BY Product_Type;
    37. Production Time and Energy Consumption: This query explores the relationship between production time and energy consumption, providing insights into potential areas for energy reduction.

	38.	Suggest energy-saving measures based on production data.;
    SELECT Product_Type,SUM(Energy_Consumption_kWh)/SUM(Units_Produced) AS energy_per_unit,AVG(Energy_Consumption_kWh) AS avg_energy_consuption,COUNT(DISTINCT Shift) FROM production GROUP BY Product_Type ORDER BY energy_per_unit DESC;
    38. Energy-Saving Measures: This query identifies product types with high energy consumption per unit, guiding the implementation of energy-saving measures for specific product lines.

    

	39.	Optimize operator allocation to minimize downtime.;
    SELECT Operator_Count ,AVG(Down_timeHours),AVG(Units_Produced)  FROM Production GROUP BY Operator_Count ORDER BY AVG(Units_Produced) ASC;
	39.	Suggest maintenance schedules based on downtime trends.;
    SELECT Machine_ID,AVG(Down_timeHours) AS Avg_downtime,COUNT(*) AS total_records,SUM(Down_timeHours) AS total_downtime FROM production GROUP BY Machine_ID ORDER BY Avg_downtime DESC;
    40. Maintenance Schedule Optimization: This query identifies machines with high downtime and suggests optimized maintenance schedules to minimize production disruptions.

	
	41.	Analyze trends in scrap rates by product type.;
    SELECT Product_Type,SUM(Scrap_Rate) AS total_Scrap_Rate,AVG(Scrap_Rate) AS avg_Scrap_Rate,(SUM(Scrap_Rate)/SUM(Units_Produced)) AS Scrape_rate_per_unit FROM production GROUP BY product_type;
    41. Scrap Rate Trends: This query analyzes scrap rate trends by product type, identifying areas for improvement in material utilization and waste reduction.

	42.	Explore the impact of environmental factors on scrap rates.;
    SELECT MONTH(Date) AS Month,Average_Tmperature_C,Average_Humidity_Percent,AVG(Scrap_Rate) AS avg_scrape_rate FROM production GROUP BY Month ORDER BY avg_scrape_rate DESC;
    42. Environmental Factors and Scrap Rates: This query explores the impact of environmental factors (temperature and humidity) on scrap rates, providing insights for optimizing production environments and minimizing waste.

	

	43.	Correlate temperature and humidity with rework hours.;
    SELECT Average_Tmperature_C,Average_Humidity_Percent,AVG(Rework_Hours) ,COUNT(*)  FROM production GROUP BY Average_Tmperature_C,Average_Humidity_Percent ORDER BY AVG(Rework_Hours);

    43. Temperature, Humidity, and Rework: This query analyzes the correlation between temperature, humidity, and rework hours, providing insights into optimal environmental conditions for minimizing rework and improving production quality.

	

	44.	Analyze material cost trends over time.;
    SELECT MONTH(Date) AS Month,SUM(Materialcostperunit) AS total_Materialcostperunit , AVG(Materialcostperunit) AS avg_Materialcostperunit FROM production GROUP BY Month;    
    44. Material Cost Trends: This query analyzes material cost trends over time, providing insights into potential cost fluctuations and allowing for proactive cost management strategies.

	45.	Explore the relationship between production volume and material costs.;
    SELECT SUM(Units_Produced) AS total_production_volume,SUM(Materialcostperunit),AVG(Materialcostperunit),(SUM(Materialcostperunit*Units_Produced)/SUM(Units_Produced)) AS weighted_material_cost  FROM production GROUP BY total_production_volume ORDER BY total_production_volume;
	45. Production Volume and Material Costs: This query explores the relationship between production volume and material costs, helping to understand and predict material costs based on production targets.



	46.	Analyze operator performance metrics across shifts.;
    SELECT Shift,Operator_Count,SUM(Units_Produced) AS total_unitsproduced,SUM(ProductionTimeHours) AS total_productionhourtime ,(SUM(Units_Produced) / SUM(ProductionTimeHours)) AS Units_Per_Hour_Per_Operator FROM production GROUP BY Shift, Operator_Count ORDER BY Units_Per_Hour_Per_Operator DESC;
    46. Operator Performance: This query analyzes operator performance across shifts, considering factors like production output and efficiency. This information can be used to identify top-performing operators, provide targeted training, and optimize workforce allocation.

 
	

