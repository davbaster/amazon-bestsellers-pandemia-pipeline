/* @bruin
name: analytics.dim_authors
type: bq.sql
depends:
  - analytics.stg_bestsellers

materialization:
  type: table
  strategy: create+replace
  cluster_by:
    - author
@bruin */

SELECT DISTINCT
    author
FROM analytics.stg_bestsellers
WHERE author IS NOT NULL
