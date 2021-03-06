
CREATE OR REPLACE FUNCTION public.run_temporal_allocation_to_month(
  temporal_allocation_id integer,
  input_dataset_id integer,
  input_dataset_version integer,
  monthly_result_dataset_id integer
  ) RETURNS void AS $$
DECLARE
  inventory_table_name varchar(64) := '';
  inventory_dataset_type_name varchar(255) := '';
  
  monthly_profile_dataset_id integer;
  monthly_profile_dataset_version integer;
  monthly_profile_table_name varchar(64);
  
  inv_filter text := '';
  inventory_year smallint;
  start_day date;
  end_day date;

  monthly_result_table_name varchar(64) := '';
  
  is_flat_file_inventory boolean := false;
  inv_fips varchar(64) := 'inv.fips';
  inv_plantid varchar(64) := 'plantid';
  inv_pointid varchar(64) := 'pointid';
  inv_stackid varchar(64) := 'stackid';
  inv_processid varchar(64) := 'segment';
  inv_emissions varchar(64) := 'inv.ann_emis';
  
  orl_inv_month smallint := 0;
  flat_file_monthly boolean := false;
  
  emis_sql text;
  where_sql text;
  
  month_num_sql text := '';
  prof_month_name_sql text := '';
  inv_month_name_sql text := '';
BEGIN
  
  -- get output time period information
  SELECT EXTRACT(YEAR FROM ta.start_day),
         ta.start_day,
         ta.end_day
    INTO inventory_year,
         start_day,
         end_day
    FROM emf.temporal_allocation ta
   WHERE ta.id = temporal_allocation_id;

  -- get the inventory table name
  SELECT LOWER(i.table_name)
    INTO inventory_table_name
    FROM emf.internal_sources i
   WHERE i.dataset_id = input_dataset_id;

  -- get the inventory dataset type
  SELECT dataset_types.name
    INTO inventory_dataset_type_name
    FROM emf.datasets
    JOIN emf.dataset_types
      ON dataset_types.id = datasets.dataset_type
   WHERE datasets.id = input_dataset_id;
  
  -- get inventory filter if specified
  SELECT CASE
           WHEN LENGTH(TRIM(ta.filter)) > 0 THEN 
             '(' || public.alias_inventory_filter(ta.filter, 'inv') || ')' 
           ELSE NULL 
         END
    INTO inv_filter
    FROM emf.temporal_allocation ta
   WHERE ta.id = temporal_allocation_id;
  
  -- build version info into inventory filter
  inv_filter := 
    '(' || public.build_version_where_filter(input_dataset_id, input_dataset_version, 'inv') || ')' || 
    COALESCE(' AND ' || inv_filter, '');

  IF inventory_dataset_type_name = 'Flat File 2010 Point' OR
     inventory_dataset_type_name = 'Flat File 2010 Nonpoint' THEN

    -- set data field names
    is_flat_file_inventory := true;
    inv_fips := 'inv.region_cd';
    inv_plantid := 'facility_id';
    inv_pointid := 'unit_id';
    inv_stackid := 'rel_point_id';
    inv_processid := 'process_id';
    inv_emissions := 'inv.ann_value';
    
    -- check if inventory has monthly values
    EXECUTE '
    SELECT COUNT(*) > 0
      FROM emissions.' || inventory_table_name || ' inv
     WHERE ' || inv_filter || '
       AND COALESCE(jan_value, feb_value, mar_value, apr_value, 
                    may_value, jun_value, jul_value, aug_value, 
                    sep_value, oct_value, nov_value, dec_value) IS NOT NULL'
      INTO flat_file_monthly;
  ELSE

    -- check if ORL inventory is monthly (returns 0 if annual)
    SELECT public.get_dataset_month(input_dataset_id)
      INTO orl_inv_month;
  
    -- if monthly inventory, confirm that it falls in requested time period
    IF orl_inv_month != 0 AND
       (orl_inv_month < EXTRACT(MONTH FROM start_day) OR
        orl_inv_month > EXTRACT(MONTH FROM end_day)) THEN
      RETURN;
    END IF;
  END IF;
  
  -- check if inventory has point source characteristics
  IF (public.check_table_for_columns(inventory_table_name, inv_plantid || ',' || inv_pointid || ',' || inv_stackid || ',' || inv_processid, ',')) THEN
    inv_plantid := 'inv.' || inv_plantid;
    inv_pointid := 'inv.' || inv_pointid;
    inv_stackid := 'inv.' || inv_stackid;
    inv_processid := 'inv.' || inv_processid;
  ELSE
    inv_plantid := 'NULL';
    inv_pointid := 'NULL';
    inv_stackid := 'NULL';
    inv_processid := 'NULL';
  END IF;
  
  -- get the cross-reference and profile dataset ids and versions
  SELECT ta.monthly_profile_dataset_id,
         ta.monthly_profile_dataset_version
    INTO monthly_profile_dataset_id,
         monthly_profile_dataset_version
    FROM emf.temporal_allocation ta
   WHERE ta.id = temporal_allocation_id;
  
  -- get monthly profile table name
  SELECT LOWER(i.table_name)
    INTO monthly_profile_table_name
    FROM emf.internal_sources i
   WHERE i.dataset_id = monthly_profile_dataset_id;
  
  -- get the monthly result dataset info
  SELECT LOWER(i.table_name)
    INTO monthly_result_table_name
    FROM emf.internal_sources i
   WHERE i.dataset_id = monthly_result_dataset_id;

  -- build list of months to process
  FOR month_num IN EXTRACT(MONTH FROM start_day)..EXTRACT(MONTH FROM end_day) LOOP
    IF LENGTH(month_num_sql) > 0 THEN
      month_num_sql := month_num_sql || ',';
      prof_month_name_sql := prof_month_name_sql || ',';
      inv_month_name_sql := inv_month_name_sql || ',';
    END IF;
    month_num_sql := month_num_sql || month_num;
    CASE month_num
      WHEN 1 THEN
        prof_month_name_sql := prof_month_name_sql || 'january';
        inv_month_name_sql := inv_month_name_sql || 'jan_value';
      WHEN 2 THEN
        prof_month_name_sql := prof_month_name_sql || 'february';
        inv_month_name_sql := inv_month_name_sql || 'feb_value';
      WHEN 3 THEN
        prof_month_name_sql := prof_month_name_sql || 'march';
        inv_month_name_sql := inv_month_name_sql || 'mar_value';
      WHEN 4 THEN
        prof_month_name_sql := prof_month_name_sql || 'april';
        inv_month_name_sql := inv_month_name_sql || 'apr_value';
      WHEN 5 THEN
        prof_month_name_sql := prof_month_name_sql || 'may';
        inv_month_name_sql := inv_month_name_sql || 'may_value';
      WHEN 6 THEN
        prof_month_name_sql := prof_month_name_sql || 'june';
        inv_month_name_sql := inv_month_name_sql || 'jun_value';
      WHEN 7 THEN
        prof_month_name_sql := prof_month_name_sql || 'july';
        inv_month_name_sql := inv_month_name_sql || 'jul_value';
      WHEN 8 THEN
        prof_month_name_sql := prof_month_name_sql || 'august';
        inv_month_name_sql := inv_month_name_sql || 'aug_value';
      WHEN 9 THEN
        prof_month_name_sql := prof_month_name_sql || 'september';
        inv_month_name_sql := inv_month_name_sql || 'sep_value';
      WHEN 10 THEN
        prof_month_name_sql := prof_month_name_sql || 'october';
        inv_month_name_sql := inv_month_name_sql || 'oct_value';
      WHEN 11 THEN
        prof_month_name_sql := prof_month_name_sql || 'november';
        inv_month_name_sql := inv_month_name_sql || 'nov_value';
      WHEN 12 THEN
        prof_month_name_sql := prof_month_name_sql || 'december';
        inv_month_name_sql := inv_month_name_sql || 'dec_value';
    END CASE;
  END LOOP;

  IF orl_inv_month = 0 AND NOT flat_file_monthly THEN
    -- calculate monthly totals from annual emissions
    EXECUTE '
    INSERT INTO emissions.' || monthly_result_table_name || ' (
           dataset_id,
           poll,
           scc,
           fips,
           plantid,
           pointid,
           stackid,
           processid,
           profile_id,
           fraction,
           month,
           total_emis,
           days_in_month,
           inv_dataset_id,
           inv_record_id
    )
    SELECT ' || monthly_result_dataset_id || ',
           inv.poll,
           inv.scc,
           ' || inv_fips || ',
           ' || inv_plantid || ',
           ' || inv_pointid || ',
           ' || inv_stackid || ',
           ' || inv_processid || ',
           prof.profile_id,
           unnest(array[' || prof_month_name_sql || ']),
           unnest(array[' || month_num_sql || ']),
           ' || inv_emissions || ' * unnest(array[' || prof_month_name_sql || ']),
           public.get_days_in_month(unnest(array[' || month_num_sql || '])::smallint, ' || inventory_year || '::smallint),
           inv.dataset_id,
           inv.record_id
      FROM emissions.' || inventory_table_name || ' inv
      JOIN temp_alloc_xref xref
        ON xref.record_id = inv.record_id
      JOIN emissions.' || monthly_profile_table_name || ' prof
        ON prof.profile_id = xref.profile_id
     WHERE ' || inv_filter || '
       AND ' || public.build_version_where_filter(monthly_profile_dataset_id, monthly_profile_dataset_version, 'prof');
  
    -- calculate monthly average day emissions
    EXECUTE '
    UPDATE emissions.' || monthly_result_table_name || '
       SET avg_day_emis = total_emis / days_in_month';

  ELSIF flat_file_monthly THEN
    -- populate monthly results from FF10 inventory
    EXECUTE '
    INSERT INTO emissions.' || monthly_result_table_name || ' (
           dataset_id,
           poll,
           scc,
           fips,
           plantid,
           pointid,
           stackid,
           processid,
           profile_id,
           fraction,
           month,
           total_emis,
           days_in_month,
           inv_dataset_id,
           inv_record_id
    )
    SELECT ' || monthly_result_dataset_id || ',
           inv.poll,
           inv.scc,
           ' || inv_fips || ',
           ' || inv_plantid || ',
           ' || inv_pointid || ',
           ' || inv_stackid || ',
           ' || inv_processid || ',
           NULL,
           1,
           unnest(array[' || month_num_sql || ']),
           unnest(array[' || inv_month_name_sql || ']),
           public.get_days_in_month(unnest(array[' || month_num_sql || '])::smallint, ' || inventory_year || '::smallint),
           inv.dataset_id,
           inv.record_id
      FROM emissions.' || inventory_table_name || ' inv
     WHERE ' || inv_filter;
  
    -- calculate monthly average day emissions
    EXECUTE '
    UPDATE emissions.' || monthly_result_table_name || '
       SET avg_day_emis = total_emis / days_in_month';

  ELSE
    -- populate monthly results from ORL inventory
    EXECUTE '
    INSERT INTO emissions.' || monthly_result_table_name || ' (
           dataset_id,
           poll,
           scc,
           fips,
           plantid,
           pointid,
           stackid,
           processid,
           profile_id,
           fraction,
           month,
           total_emis,
           days_in_month,
           avg_day_emis,
           inv_dataset_id,
           inv_record_id
    )
    SELECT ' || monthly_result_dataset_id || ',
           inv.poll,
           inv.scc,
           ' || inv_fips || ',
           ' || inv_plantid || ',
           ' || inv_pointid || ',
           ' || inv_stackid || ',
           ' || inv_processid || ',
           NULL,
           1,
           ' || orl_inv_month || ',
           inv.avd_emis * public.get_days_in_month(' || orl_inv_month || '::smallint, ' || inventory_year || '::smallint),
           public.get_days_in_month(' || orl_inv_month || '::smallint, ' || inventory_year || '::smallint),
           inv.avd_emis,
           inv.dataset_id,
           inv.record_id
      FROM emissions.' || inventory_table_name || ' inv
     WHERE ' || inv_filter;
  END IF;
  
  EXECUTE '
  ANALYZE emissions.' || monthly_result_table_name;
  
END;
$$ LANGUAGE plpgsql;
