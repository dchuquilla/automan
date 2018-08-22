-- Crear funcion de trigger
CREATE OR REPLACE FUNCTION tg_kilometraje_semanal() RETURNS trigger AS
$$
  DECLARE delta_horas numeric;
  DECLARE delta_km numeric;
  DECLARE km_semanal numeric;
  DECLARE nuevo_update Timestamp Without Time Zone;
  DECLARE antiguo_update Timestamp Without Time Zone;
  DECLARE nuevo_km_actual numeric;
  DECLARE antiguo_km_actual numeric;
BEGIN
  nuevo_update = NEW.updated_at;
  antiguo_update = OLD.updated_at;
  nuevo_km_actual = NEW.current_km;
  antiguo_km_actual = OLD.current_km;
  SELECT EXTRACT(EPOCH FROM nuevo_update-antiguo_update)/3600 INTO delta_horas;
  delta_km = nuevo_km_actual - antiguo_km_actual;
  if (delta_horas > 0) && (NEW.current_km != OLD.current_km) then
    km_semanal = (delta_km/delta_horas)*168;
    update cars set week_km = km_semanal where id = OLD.id;
  end if;
  return NEW;
END
$$ language 'plpgsql';


-- Crear triggers con metodo creado
CREATE TRIGGER "procesarCambiosKmActual" 
  AFTER UPDATE ON cars 
    FOR EACH ROW 
      EXECUTE PROCEDURE tg_kilometraje_semanal();

-- Insertos de prueba
-- Insercion en Propietarios
INSERT INTO "owners" ( "agreement_terms", "cel_phone", "created_at", "last_name", "name", "updated_at") 
VALUES (TRUE , '0992582045', now(), 'Dario', 'Chuquilla', now() );
-- Isercion en autos
INSERT INTO "cars" ( "brand", "car_type", "created_at", "current_km", "model", "owner_id", "plate", "updated_at", "week_km", "year") 
VALUES ( 'BMW', 'auto', now(), 149756, 'CX350', 1, 'PMN0876', now(), 250, 2005);
-- Actualizar Km, permita que pasen al menos un par de horas
UPDATE "cars" SET "current_km" = 149793, "updated_at" = now()  + interval '1.9 hour'  WHERE "id" = 1;