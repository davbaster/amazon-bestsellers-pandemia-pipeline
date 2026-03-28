/* @bruin
name: analytics.fct_genre_overall
type: bq.sql
depends:
  - analytics.stg_bestsellers

materialization:
  type: table
  strategy: create+replace
  cluster_by:
    - genre
@bruin */

SELECT
    genre,
    COUNT(*) AS bestseller_rows
FROM analytics.stg_bestsellers
GROUP BY genre
