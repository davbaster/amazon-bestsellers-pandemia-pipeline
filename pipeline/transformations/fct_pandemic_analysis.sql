SELECT
    name,
    author,
    genre,
    year,
    CASE
        WHEN year < 2020 THEN 'Pre-Pandemic'
        WHEN year BETWEEN 2020 AND 2021 THEN 'During Pandemic'
        ELSE 'Post-Pandemic'
    END AS pandemic_era,
    reviews,
    user_rating
FROM {{ ref('stg_bestsellers') }}
