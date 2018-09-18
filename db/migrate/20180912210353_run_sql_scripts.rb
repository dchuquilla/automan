class RunSqlScripts < ActiveRecord::Migration[5.2]
  def change
    raw_sql_1 = " CREATE OR REPLACE FUNCTION tg_kilometraje_semanal() \n"\
              "  RETURNS trigger \n"\
              "  LANGUAGE plpgsql \n"\
              " AS $function$ \n"\
              "   DECLARE delta_horas numeric; \n"\
              "   DECLARE delta_km numeric; \n"\
              "   DECLARE km_semanal numeric; \n"\
              "   DECLARE nuevo_update Timestamp Without Time Zone; \n"\
              "   DECLARE antiguo_update Timestamp Without Time Zone; \n"\
              "   DECLARE nuevo_km_actual numeric; \n"\
              "   DECLARE antiguo_km_actual numeric; \n"\
              " BEGIN \n"\
              "   nuevo_update = NEW.updated_at; \n"\
              "   antiguo_update = OLD.updated_at; \n"\
              "   nuevo_km_actual = NEW.current_km; \n"\
              "   antiguo_km_actual = OLD.current_km; \n"\
              "   SELECT EXTRACT(EPOCH FROM nuevo_update-antiguo_update)/3600 INTO delta_horas; \n"\
              "   delta_km = nuevo_km_actual - antiguo_km_actual; \n"\
              "   if (delta_horas > 0) AND (NEW.current_km <> OLD.current_km) then \n"\
              "     km_semanal = (delta_km/delta_horas)*168; \n"\
              "     update cars set week_km = km_semanal where id = OLD.id; \n"\
              "   end if; \n"\
              "   return NEW; \n"\
              " END \n"\
              " $function$; "
    execute raw_sql_1
    
    raw_sql_2 = " CREATE TRIGGER procesarCambiosKmActual  \n"\
              "   AFTER UPDATE ON cars  \n"\
              "     FOR EACH ROW  \n"\
              "       EXECUTE PROCEDURE tg_kilometraje_semanal();"
    execute raw_sql_2
    
    raw_sql_3 = " CREATE OR REPLACE FUNCTION tg_mantenimientos_basicos() \n"\
              "  RETURNS trigger \n"\
              "  LANGUAGE plpgsql \n"\
              " AS $function$ \n"\
              "   DECLARE i settings%rowtype; \n"\
              "   DECLARE setting_id integer; \n"\
              "   DECLARE contador integer; \n"\
              "   DECLARE edad integer; \n"\
              "   DECLARE calculated_km integer; \n"\
              "   DECLARE km_estimado integer; \n"\
              "   DECLARE mes_estimado integer; \n"\
              "   DECLARE fecha_estimada Timestamp Without Time Zone; \n"\
              "   DECLARE tipo varchar(255); \n"\
              " BEGIN \n"\
              "   SELECT date_part('year', now()) - NEW.year INTO edad; \n"\
              "   FOR i IN SELECT * FROM settings WHERE car_age = edad AND car_type = NEW.car_type LOOP \n"\
              "     SELECT floor(random() * (i.km_max-i.km_min+1) + i.km_min)::int INTO calculated_km; \n"\
              "     SELECT calculated_km + NEW.current_km INTO km_estimado; \n"\
              "     SELECT floor(random() * (i.month_max-i.month_min+1) + i.month_min)::int INTO mes_estimado; \n"\
              "     SELECT now() + mes_estimado * interval '1 month' into fecha_estimada; \n"\
              "     INSERT INTO user_car_settings (car_id, maintenance_type, km_estimated, month_estimated, created_at, updated_at) VALUES (NEW.id, i.maintenance_type, calculated_km, mes_estimado, now(), now()); \n"\
              "     SELECT id FROM user_car_settings WHERE car_id = NEW.id AND maintenance_type = i.maintenance_type AND km_estimated = calculated_km AND month_estimated = mes_estimado INTO setting_id; \n"\
              "     INSERT INTO maintenance_histories (car_id, maintenance_type, estimated_km, notified, scheduled_date, status, user_car_setting_id, created_at, updated_at) VALUES (NEW.id, i.maintenance_type, km_estimado, FALSE, fecha_estimada, 'Pendiente', setting_id, now(), now()); \n"\
              "   END LOOP; \n"\
              "   return NEW; \n"\
              " END \n"\
              " $function$; "
    execute raw_sql_3
    
    raw_sql_4 = " CREATE TRIGGER crearMantenimientoBasicos AFTER INSERT ON cars FOR EACH ROW EXECUTE PROCEDURE tg_mantenimientos_basicos(); "
    execute raw_sql_4
    
    raw_sql_5 = " CREATE OR REPLACE FUNCTION tg_mantenimientos_recurrentes() \n"\
              "  RETURNS trigger \n"\
              "  LANGUAGE plpgsql \n"\
              " AS $function$ \n"\
              "   DECLARE i user_car_settings%rowtype; \n"\
              "   DECLARE contador integer; \n"\
              "   DECLARE edad integer; \n"\
              "   DECLARE km_estimado integer; \n"\
              "   DECLARE mes_estimado integer; \n"\
              "   DECLARE fecha_estimada Timestamp Without Time Zone; \n"\
              "   DECLARE tipo varchar(255); \n"\
              " BEGIN \n"\
              "   if NEW.status = 'Completado' AND NEW.status <> OLD.status then \n"\
              "     SELECT * FROM user_car_settings where id = NEW.user_car_setting_id INTO i; \n"\
              "     SELECT NEW.review_km + i.km_estimated INTO km_estimado; \n"\
              "     SELECT NEW.review_date + i.month_estimated * interval '1 month' into fecha_estimada; \n"\
              "     INSERT INTO maintenance_histories ( car_id, maintenance_type, estimated_km, notified, scheduled_date, status, created_at, updated_at) VALUES ( NEW.car_id, NEW.maintenance_type, km_estimado, FALSE, fecha_estimada, 'Pendiente', now(), now()); \n"\
              "   end if; \n"\
              "   return NEW; \n"\
              " END \n"\
              " $function$; "
    execute raw_sql_5
    
    raw_sql_6 = " CREATE TRIGGER crearMantenimientoRecurrentes AFTER UPDATE ON maintenance_histories FOR EACH ROW EXECUTE PROCEDURE tg_mantenimientos_recurrentes(); "
    execute raw_sql_6
  end

end
