-- 1. Top 5 most common values in a particular column and their frequency
-- Replace 'column_name' with the actual column you want to analyze, e.g., 'province_state'
SELECT column_name			-- The column for which you want to find the most common values
	, COUNT(*) AS frequency		-- Count how many times each value appears
FROM processed_covid_data		-- The table containing the cleaned and processed data
GROUP BY column_name			-- Group by the selected column to count occurrences
ORDER BY frequency DESC			-- Order by frequency in descending order to get the most common values first
LIMIT 5;				-- Limit the result to the top 5 most common values

-- 2. How does a particular metric change over time?
-- Replace 'metric_column' with the actual metric column you want to analyze, e.g., 'confirmed'
SELECT report_date				-- The date on which the metric was recorded
	, SUM(metric_column) AS total_metric	-- The sum of the metric for each date
FROM processed_covid_data			-- The table containing the cleaned and processed data
GROUP BY report_date				-- Group by the date to see how the metric changes over time
ORDER BY report_date;				-- Order by date to view the trend over time

-- 3. Is there a correlation between two specific columns?
-- Replace `column_x` and `column_y` with the actual columns you want to analyze, e.g., `confirmed` and `deaths`
SELECT corr(column_x::numeric, column_y::numeric) AS correlation	-- Calculate the correlation coefficient between two columns
FROM processed_covid_data;						-- The table containing the cleaned and processed data
