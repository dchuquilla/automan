-- Crear funcion de trigger
create or replace function tg_kilometraje_semanal() returns trigger AS
$$
  DECLARE delta_horas numeric;
  DECLARE delta_km numeric;
  DECLARE km_semanal numeric;
begin
  delta_horas NEW.updated_at - time OLD.updated_at;
  delta_km NEW.current_km - time OLD.current_km;
  if (delta_horas > 0) && (NEW.current_km != OLD.current_km)
    km_semanal = (delta_km/delta_horas)*168;
    update cars set week_km = km_semanal where id = OLD.id;
  end if;
  return NEW;
end
$$ language 'plpgsql';


-- Crear triggers con metodo creado
create trigger procesarCambiosKm
  after update on cars
    for each row
      execute procedure tg_kilomentraje_semanal();