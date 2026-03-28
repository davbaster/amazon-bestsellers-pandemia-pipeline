/* @bruin
name: analytics.dim_author_nationality
type: bq.sql
depends:
  - analytics.dim_authors
  - raw.raw_author_nationality

materialization:
  type: table
  strategy: create+replace
  cluster_by:
    - nationality
    - author
@bruin */

SELECT
    a.author,
    COALESCE(n.nationality, 'Unknown') AS nationality
FROM analytics.dim_authors AS a
LEFT JOIN raw.raw_author_nationality AS n
    ON a.author = n.author
