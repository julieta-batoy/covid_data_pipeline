-- Select all data from the staging table
WITH raw_data AS (
    SELECT *
    FROM covid_staging
)

-- Handle missing values by using COALESCE to replace NULLs with default values
-- Assuming that 0 is a valid replacement for missing numerical values and 'Unknown' for string types
, filled_data AS (
    SELECT coalesce("Province_State", 'Unknown') AS province_state
        , coalesce("Country_Region", 'Unknown') AS country_region
        , coalesce("Last_Update"::date, '1970-01-01') AS last_update
        , coalesce("Date"::date, '1970-01-01') AS report_date
        , coalesce("Lat"::float, 0.0) AS latitude
        , coalesce("Long_"::float, 0.0) AS longitude
        , coalesce("Confirmed"::int, 0) AS confirmed
        , coalesce("Deaths"::int, 0) AS deaths
        , coalesce("Recovered"::int, 0) AS recovered
        , coalesce("Active"::int, 0) AS active
        , coalesce("Total_Test_Results"::int, 0) AS total_test_results
        , coalesce("People_Tested"::int, 0) AS people_tested
        , coalesce("People_Hospitalized"::int, 0) AS people_hospitalized
        , coalesce("Testing_Rate"::float, 0.0) AS testing_rate
        , coalesce("Hospitalization_Rate"::float, 0.0) AS hospitalization_rate
        , coalesce("Incident_Rate"::float, 0.0) AS incident_rate
        , coalesce("Mortality_Rate"::float, 0.0) AS mortality_rate
        , coalesce("Case_Fatality_Ratio"::float, 0.0) AS case_fatality_ratio
    FROM raw_data
)

-- Deduplicate records by assigning a row number to each record within the same province_state and report_date
, deduplicated_data AS (
    SELECT *
        , row_number() OVER (PARTITION BY province_state, report_date ORDER BY report_date DESC) AS row_num
    FROM filled_data
)

-- Select only the distinct records (keep the latest entry for each province_state and report_date)
SELECT province_state
    , country_region
    , report_date
    , last_update
    , latitude
    , longitude
    , confirmed
    , deaths
    , recovered
    , active
    , total_test_results
    , people_tested
    , people_hospitalized
    , testing_rate
    , hospitalization_rate
    , incident_rate
    , mortality_rate
    , case_fatality_ratio
FROM deduplicated_data
WHERE row_num = 1 -- Keep only the first row for each province_state and report_date
