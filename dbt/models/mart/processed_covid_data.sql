WITH staged_data AS (
    SELECT *
    FROM {{ ref('staging_covid_data') }}
)

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
FROM staged_data
