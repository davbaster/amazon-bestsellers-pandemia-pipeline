/* @bruin
name: analytics.fct_author_appearances
type: bq.sql
depends:
  - analytics.stg_bestsellers

materialization:
  type: table
  strategy: create+replace
  cluster_by:
    - author
@bruin */

SELECT
    author,
    COUNT(*) AS bestseller_appearances,
    COUNT(DISTINCT name) AS distinct_books,
    MIN(year) AS first_year,
    MAX(year) AS last_year
FROM analytics.stg_bestsellers
GROUP BY author
