desc "Enviar correos de mantenimientos pendientes."
task enviar_pendientes: :environment do
  users = User.distinct.joins(owner: {cars: :maintenance_histories}).where("maintenance_histories.status = 'Pendiente'")
  users.each do |user|
    UserNotifierMailer.send_pending_reviews(user).deliver
  end
end