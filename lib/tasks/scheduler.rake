desc "Enviar correos de mantenimientos pendientes."
task enviar_pendientes: :environment do
  users = User.distinct.joins(owner: {cars: :maintenance_histories}).where("maintenance_histories.status = 'Pendiente'")
  users.each do |user|
    UserNotifierMailer.send_pending_reviews(user).deliver
  end
end

desc "Reiniciar dismiss_car_updates en propietarios"
task reset_dismiss_car_updates: :environment do
  Owner.update_all(dismiss_car_updates: false)
end