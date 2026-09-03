{{ config(materialized='metric_view') }}

version: 1.1
source: {{ ref('f_result') }}
comment: "Formula 1 race result KPIs per driver, constructor, circuit and season, from 1950 to today. One source row is one driver's result in one race. Query measures with MEASURE()."

joins:
  # Join names must not collide with dimension names (e.g. a join named
  # `driver` breaks resolution of the `Driver` dimension).
  - name: dim_driver
    source: {{ ref('d_driver') }}
    on: source.driver_ref = dim_driver.driver_ref
  - name: dim_race
    source: {{ ref('d_race') }}
    on: source.race_ref = dim_race.race_ref

dimensions:
  - name: Race Date
    expr: race_date
    comment: "Calendar date of the race."
  - name: Race Season
    expr: dim_race.race_season
    comment: "Championship year of the race, e.g. 2021."
    synonyms: ["year", "season"]
  - name: Race Name
    expr: dim_race.race_name
    comment: "Grand prix name, e.g. 'Monaco Grand Prix'."
    synonyms: ["grand prix", "gp"]
  - name: Circuit
    expr: circuit_ref
    comment: "Circuit identifier, e.g. 'monza', 'silverstone'."
    synonyms: ["track"]
  - name: Constructor
    expr: constructor_ref
    comment: "Constructor identifier, e.g. 'ferrari', 'red_bull'."
    synonyms: ["team"]
  - name: Driver
    expr: dim_driver.driver_full_name
    comment: "Driver full name, e.g. 'Lewis Hamilton'."
  - name: Driver Nationality
    expr: dim_driver.driver_nationality
    comment: "Driver nationality, e.g. 'British', 'German'."
  - name: Result Status
    expr: result_status
    comment: "Race outcome, e.g. 'Finished', '+1 Lap', or a retirement reason like 'Engine'."
    synonyms: ["dnf reason", "finish status"]

measures:
  - name: Entries
    expr: COUNT(1)
    comment: "Number of race entries (driver/race combinations)."
    synonyms: ["starts", "participations"]
  - name: Races
    expr: COUNT(DISTINCT race_ref)
    comment: "Number of distinct races."
    synonyms: ["race count", "grands prix"]
  - name: Total Points
    expr: SUM(result_points)
    comment: "Championship points scored in races (excludes sprint/other points)."
    synonyms: ["points"]
  - name: Wins
    expr: COUNT_IF(result_position = 1)
    comment: "Race victories (finished first)."
    synonyms: ["victories", "first places"]
  - name: Podiums
    expr: COUNT_IF(result_position <= 3)
    comment: "Top-3 race finishes, including wins."
    synonyms: ["top 3 finishes"]
  - name: Pole Positions
    expr: COUNT_IF(qualifying_position = 1)
    comment: "First places in qualifying."
    synonyms: ["poles"]
  - name: Fastest Laps
    expr: COUNT_IF(has_fastest_lap)
    comment: "Races with the fastest race lap."
  - name: Points per Race
    expr: SUM(result_points) / COUNT(DISTINCT race_ref)
    comment: "Average points scored per race. Safe ratio: re-aggregates correctly at any grouping level."
  - name: Average Starting Position
    expr: AVG(NULLIF(starting_position, 0))
    comment: "Average grid position at race start. Grid position 0 (pit-lane start) is excluded."
    synonyms: ["average grid position"]
